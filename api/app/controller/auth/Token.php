<?php


namespace app\controller\auth;


use app\controller\BaseController;
use app\lib\exception\BaseException;
use think\facade\Cache;
use think\facade\Request;
use app\model\User as UserModel;

class Token extends BaseController
{
    //放入缓存
    public function saveCache($cachedValue)
    {
        $key = self::generateToken();//生成token
        $value = json_encode($cachedValue);
//        $request = cache($key, $value, $this->tokenExpire);//第三参数是时效期
        $request = cache($key, $value);//第三参数是时效期
        if (!$request) {
            throw new BaseException(['msg' => '服务器缓存异常']);
        }
        return $key;
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

    //生成token函数中调用的，生成随机字符串
    private static function getRandChar($length)
    {
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol) - 1;
        for ($i = 0;
             $i < $length;
             $i++) {
            $str .= $strPol[rand(0, $max)];
        }
        return $str;
    }

    //通过token获取uid
    public static function getCurrentUid()
    {
        $uid = self::getCurrentTokenVar('uid');
        $user = UserModel::find($uid);
        if (!$user) {
            throw new BaseException(['msg' => '无该用户信息']);
        }
        return $uid;
    }

    //通过token获取该条缓存数据中指定的字段
    public static function getCurrentTokenVar($key)
    {
        $token = Request::header('token');
        if (!$token) {
            throw new BaseException();
        }
        $vars = Cache::get($token);
        if (!$vars) {
            throw new BaseException();
        } else {
            if (!is_array($vars)) {
                $vars = json_decode($vars, true);
            }
            if (array_key_exists($key, $vars)) {
                return $vars[$key];
            } else {
                throw new BaseException(['msg' => '尝试获取的变量并不存在']);
            }
        }
    }

    //验证toen
    public static function verifyToken($token)
    {
        $exist = Cache::get($token);
        if ($exist) {
            return true;
        } else {
            return false;
        }
    }
}