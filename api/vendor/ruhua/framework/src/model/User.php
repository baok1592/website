<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/10/17 0017
 * Time: 9:03
 */

namespace ruhua\model;


use ruhua\services\TokenService;
use ruhua\bases\BaseModel;
use ruhua\exceptions\BaseException;
use think\facade\Cache;
use WxCode\demoWxCode;

class User extends BaseModel
{

    /**
     * 获取所有用户信息
     * @return mixed
     */
    public static function getAllUser()
    {
        $res = self::field('id,nickname,headpic,points,create_time')->select();
        return $res;
    }

    /**
     * 微信获取手机号并绑定
     * @param $uid
     * @param $post
     * @return mixed
     */
    public static function addWxMobile($uid, $post)
    {
        $session_key = TokenService::getCurrentTokenVar('session_key');
        $data = (new demoWxCode())->decryptData($post['encryptedData'], $post['iv'], $session_key);
        if (isset($data['phoneNumber'])) {
            self::where(['id' => $uid])->update(['mobile' => $data['phoneNumber']]);
            return true;
        }
        return true;
    }

    public function getNicknameAttr($v)
    {
        return base64_decode($v);
    }
    //绑定手机号
    public static function bindMobile($uid, $mobile, $code)
    {
        $user = self::where(['id' => $uid])->find();
        if (!empty($user->mobile)) {
            throw new BaseException(  ['msg'=>'已经绑定过了']);
        }
        $cache_code=Cache::get($mobile);
        if ($cache_code != $code) {
            throw new BaseException(['msg'=> '验证码错误']);
        }
        $res=$user->save(['mobile' => $mobile]);
        return $res;
    }
    //修改绑定的手机号
    public static function editMobile($uid, $mobile, $code)
    {
        $user = self::where(['id' => $uid])->find();
        $cache_code=Cache::get($mobile);
        if ($cache_code != $code) {
            throw new BaseException(['msg'=> '验证码错误']);
        }
        $res=$user->save(['mobile' => $mobile]);
        return $res;
    }

}