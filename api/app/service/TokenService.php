<?php


namespace app\service;


//API的token文件，用于：生成token、
use ruhua\enum\ScopeEnum;
use ruhua\exceptions\BaseException;
use app\model\Admins as AdminsModel;
use think\facade\Cache;
use think\facade\Request;

class TokenService
{
    protected $tokenExpire;

    function __construct()
    {
        $this->tokenExpire = config('setting.token_expire_in'); //token缓存有效时间
    }

    //生成token函数中调用的，生成随机字符串
    private static function getRandChar($length)
    {
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol) - 1;
        for ($i = 0; $i < $length; $i++) {
            $str .= $strPol[rand(0, $max)];
        }
        return $str;
    }

    //生成随机token
    public static function generateToken()
    {
        //32个字符组成一组随机字符串
        $randChars = self::getRandChar(32);
        //用三组字符串，进行md5加密
        $timestamp = $_SERVER['REQUEST_TIME_FLOAT'];
        //salt 盐
        $salt = config('secure.token_salt');
        return md5($randChars . $timestamp . $salt);
    }

    //放入缓存
    public function saveCache($cachedValue)
    {
        $key = self::generateToken();//生成token
        $value = json_encode($cachedValue);
        $request = cache($key, $value, $this->tokenExpire);//第三参数是时效期
        if (!$request) {
            throw new BaseException([
                'msg' => '服务器缓存异常'
            ]);
        }
        return $key;
    }

    //通过token获取cms的admin_id
    public static function getCurrentAid()
    {
        $aid = self::getCurrentTokenVar('admin_id');
        $user = $aid;
        if (!$user) {
            throw new BaseException(['msg' => '无该用户信息']);
        }
        return $aid;
    }

    //通过token获取cms的scope
    public static function getCurrentScope()
    {
        $aid = self::getCurrentTokenVar('scope');
        if (!$aid) {
            throw new BaseException(['msg' => '无该信息']);
        }
        return $aid;
    }

    //通过token获取cms的username
    public static function getAdminName()
    {
        $uid = self::getCurrentTokenVar('admin_id');
        $user = AdminsModel::where('id',$uid)->value('username');
        if (!$user) {
            throw new BaseException(['msg' => '无该用户信息']);
        }
        return $user;
    }

    //通过token获取该条缓存数据中指定的字段
    public static function getCurrentTokenVar($key)
    {
        $token = Request::header('token');
        if(!$token)
        {
            throw new BaseException(['msg' => '未登陆', 'code' => 401]);
        }
        $vars = Cache::get($token);
        if (!is_array($vars)) {
            $vars = json_decode($vars, true);
        }
        if(!$vars)
        {
            throw new BaseException(['msg'=>'token无效！','code'=>401]);
        }
        if (array_key_exists($key, $vars)) {
            return $vars[$key];
        } else {
            throw new BaseException(['msg'=>'尝试获取的变量并不存在']);
        }
    }

    //判断权限，仅管理员可访问
    public static function GTadmimScope()
    {
        $scope = self::getCurrentScope();
        if ($scope >= ScopeEnum::Root) { //判断权限值是否大于最低的用户权限
            return true;
        } else {
            throw new BaseException();
        }
    }
}