<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/10/17 0017
 * Time: 9:03
 */

namespace app\controller;


use ruhua\API\userManage\QYUser;
use ruhua\bases\BaseController;
use ruhua\services\TokenService;

class User extends BaseController
{
    /**
     * 模拟用户登录获取TOKEN
     * @return mixed
     */
    public function userLogin()
    {
        return (new TokenService())->saveCache(['id' => 15,'openid' => 'oq_jb4mLWx97WOEn7x38yM0YkFhs']);
    }
    
    /**
     * 获取用户基础信息
     */
    public function getInfo()
    {
        $res=(new QYUser())->getInfo();
        return app('json')->success($res);
    }

    /**
     * 微信授权绑定手机号
     * @return mixed
     */
    public function getWxMobile(){
        $post=input('post.');
        return (new QYUser())->getWxMobile($post);
    }
    //绑定手机
    public function bind_phone()
    {
        $post=input('post.');
        $res = (new QYUser())->bind_phone($post);
        return app("json")->go($res);
    }
    //获取验证码
    public function getYzm()
    {
        $post=input('post.');
        (new QYUser())->getYzm($post);
        return app("json")->go(true);
    }

    /**
     * 手机登录获取token
     * @return string
     */
    public function getMobileToken()
    {
        $post = input('post.');
        $res=(new QYUser())->getMobileToken($post);
        return app("json")->go($res);
    }
    //小程序登录获取token
    public function getXcxToken($code)
    {
        $res['token']=(new QYUser())->getXcxToken($code);
        return app("json")->go($res);
    }
    //小程序更新头像
    public function xcx_upinfo($nickname, $headpic, $keys, $iv)
    {
        $res=(new QYUser())->xcx_upinfo($nickname, $headpic, $keys, $iv);
        return app("json")->go($res);
    }

    /********************  微信 + 小程序 共用  ************************/
    //验证token，返回false,true
    public function verifyToken($token)
    {
        $res=(new QYUser())->verifyToken($token);
        return app("json")->go($res);
    }
    //修改绑定的手机号
    public function editMobile(){
        $post=input('post.');
        $res=(new QYUser())->editMobile($post);
        return app("json")->go($res);
    }
    //验证验证码是否正确
    public function verifyYzm(){
        $post=input('post.');
        $res=(new QYUser())->verifyYzm($post);
        return app("json")->go($res);
    }
    /********************  公众号  ************************/
    //请求公众号code
    public function wxcodeUrl($url, $type = '')
    {
        $res=(new QYUser())->wxcodeUrl($url, $type);
        return app("json")->go($res);
    }

    public function getToken($code)
    {
        $res=(new QYUser())->getToken($code);
        return app("json")->go($res);
    }

}