<?php


namespace app\controller\auth;

use app\controller\BaseController;
use app\lib\exception\BaseException;
use app\model\SysConfig as SysConfigModel;
use app\model\User as UserModel;

class Auth extends BaseController
{
    /********************  公众号  ************************/
    //请求公众号code
    public function wxcodeUrl($url, $type = '')
    {
        $gzh_service = new Gzh();
        $res = $gzh_service->getCodeUrl($url, $type);
        return $res;
    }

    public function getToken($code)
    {
        $usertoken = new Gzh;
        $token = $usertoken->getToken($code);
        $data = ['token' => $token];
        return json($data);
    }

    /********************  小程序 ↓  ************************/
    /*
        * 用途：将“openid，uid，权限”存入缓存value，生成一个token做缓存的key并返回
        * 1、获取code
        * 2、组合code,Appid与Secret生成URL，
        * 3、curl方式向微信服务器提交，获取openid;注意一个code只能使用一次
        * 4、判断openid，数据库不存在则写入；从数据库获取该openid的用户UID
        * 5、生成token，token是一个随机字符串，它是缓存的key；将“openid，uid，权限”存入缓存value
        * 6、返回token
        */
    public function getXcxToken($code)
    {
        $usertoken = new Xcx($code);
        $token = $usertoken->getToken();
        $data = ['token' => $token];
        return json($data);
    }

    public function xcx_upinfo($nickname, $headpic)
    {
        $uid = Token::getCurrentUid();
        UserModel::where('id', $uid)->update(['nickname' => $nickname, 'headpic' => $headpic]);
    }

    //验证token，返回false,true
    public function verifyToken($token)
    {
        if (!$token) {
            throw new BaseException(['msg' => 'token不允许为空']);
        }
        $valid = Token::verifyToken($token);
        $arr = ['isValid' => $valid];
        return json($arr);
    }

    //解密获取手机号
    public function decryptToGetMobile($iv,$encryptedData)
    {
        $appid=SysConfigModel::where('key','wx_app_id')->value('value');
        $sessionKey = Token::getCurrentTokenVar('session_key');


//        $appid='wx4f4bc4dec97d474b';
//        $sessionKey = 'tiihtNczf5v6AKRyjwEUhQ==';
//        $encryptedData="CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZMQmRzooG2xrDcvSnxIMXFufNstNGTyaGS9uT5geRa0W4oTOb1
//        WT7fJlAC+oNPdbB+3hVbJSRgv+4lGOETKUQz6OYStslQ142d
//        NCuabNPGBzlooOmB231qMM85d2/fV6ChevvXvQP8Hkue1poOFtnEtpyxVLW1zAo6/1Xx1COxFvrc2d7UL/lmHInNlxuacJXw
//        u0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn/Hz7saL8xz+W//FRAUid1OksQaQx4CMs8LOddcQhULW4ucetDf96JcR3g0gfRK4P
//        C7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns/8wR2SiRS7MNACwTyrGvt9ts8p12PKFd
//        lqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYVoKlaRv85IfVunYzO0IKXsyl7JCUjCpoG20f0a04COwfneQAGGwd5oa+T8yO5hzuy
//        Db/XcxxmK01EpqOyuxINew==";
//
//        $iv='r7BXXKkLb8qrSNn05n0qiA==';

        $pc = new wxBizDataCrypt($appid, $sessionKey);
        $errCode = $pc->decryptData($encryptedData, $iv, $data );
        if ($errCode == 0) {
            $data=json_decode($data);
            $uid=Token::getCurrentTokenVar('uid');
            UserModel::where('id',$uid)->update(['mobile'=>$data->phoneNumber]);
            return app('json')->success($data);
        } else {
            return $errCode;
        }
    }
}