<?php


namespace app\controller\auth;

use app\lib\exception\BaseException;
use app\model\SysConfig as SysConfigModel;
use app\model\User as UserModel;

class Xcx extends Token
{
    protected $code;
    protected $wxAppID;
    protected $wxAppSecret;
    protected $wxLoginUrl;

    function __construct($code)
    {
        $appid = SysConfigModel::where('key','wx_app_id')->value('value');
        $secret = SysConfigModel::where('key','wx_app_secret')->value('value');
        if(!$appid || !$secret){
            throw new BaseException(['msg'=>'未配置数据']);
        }

        $this->code = $code;
        $this->wxAppID = $appid ;
        $this->wxAppSecret = $secret;
        //sprintf函数是把百分号（%）符号替换成一个作为参数进行传递的变量：%s=字符串,%u=正整数
        $login_url='https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code';
        $this->wxLoginUrl = sprintf($login_url,$this->wxAppID,$this->wxAppSecret, $this->code);
    }

    //获取token，openid，session_key
    public function getToken()
    {

        //注意code是临时的，所以向微信服务器提交只能使用一次
        $result = curl_get($this->wxLoginUrl);
        $wxResult = json_decode($result, true);
        if (empty($wxResult))
        {
            throw new BaseException(['msg'=>'获取session_key及openID时异常，微信内部错误']);
        }else{
            $loginFail = array_key_exists('errcode', $wxResult);
            if ($loginFail) {
                $this->WxError($wxResult);
            } else {
                return $this->grantToken($wxResult);
            }
        }
    }

    //openid，uid放入缓存，$token做缓存键名;
    private function grantToken($wxResult){
        $openid = $wxResult['openid'];
        $user_id = UserModel::where('openid',$openid)->value('id');
        if($user_id){
            $uid = $user_id;
        } else{
            $uid = $this->newUser($openid);
        }
        $cachedValue = $this->setWxCache($wxResult,$uid);
        $token = $this->saveCache($cachedValue);
        return $token;
    }

    //组合uid，openid，权限
    private function setWxCache($wxResult,$uid){
        $cache = $wxResult; //微信的3个返回值
        $cache['uid'] = $uid;
        $cache['scope'] = 9;
        return $cache;
    }

    private function newUser($openid){
        $user = UserModel::create([
            'openid' => $openid
        ]);
        return $user->id;
    }

    //微信错误信息解析后抛出
    private function WxError($wxResult)
    {
        throw new BaseException(
            [
                'msg' => $wxResult['errmsg'],
                'errorCode' => $wxResult['errcode']
            ]);
    }
}