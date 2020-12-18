<?php


namespace app\service;


use app\model\Admins as AdminsModel;
use app\model\Group as GroupModel;
use ruhua\enum\ScopeEnum;
use ruhua\exceptions\BaseException;

class CmsTokenService extends TokenService
{
    //登陆，并返回token
    public function loginService($user,$pwd){
        $password = password($pwd);    //common文件的函数
        $where['username']=$user;
        $where['password']=$password;
        $user = AdminsModel::where($where)->find();
        if(!$user){
            throw new BaseException(['msg'=>$password]);
            throw new BaseException(['msg'=>'账号或密码错误！']);
        }
        if($user->state == 1){
            throw new BaseException(['msg'=>'已禁用']);
        }
        $cachedValue = $this->setWxCache($user);
        $res['token'] = $this->saveCache($cachedValue);
        $res['nickname']=$user->nickname;
        return $res;
    }

    //组合uid，username，权限
    private function setWxCache($user){
        $cache['admin_id'] = $user['id'];
        $cache['username'] = $user['username'];
        $cache['uniacid'] = $user['uniacid'];
        $cache['scope'] = ScopeEnum::Root;  // scope=16 代表App用户的权限数值
        return $cache;
    }
}