<?php


namespace app\model;


use ruhua\bases\BaseModel;
use ruhua\exceptions\BaseException;

class Admins extends BaseModel
{
    protected $updateTime=false;

    public function getStateAttr($v)
    {
        return $v==1 ? true : false;
    }
    public static function createAdmin($form)
    {
        $user = self::where('username',$form['username'])->find();
        if($user){
            throw new BaseException(['msg'=>'用户名已存在']);
        }
        $form['password'] = password($form['password']);
        $res = self::create($form);
        if($res){
            AuthGroupAccess::create(['aid'=>$res['id'],'group_id'=>$form['gid']]);
            return 1;
        }else{
            throw new BaseException(['msg'=>'注册失败']);
        }
    }

    public static function deleteAdmin($id)
    {
        if($id<=1){
            throw new BaseException(['msg'=>'不能删除最高管理员']);
        }
        $res = self::destroy($id);
        if(!$res){
            throw new BaseException(['msg'=>'删除失败']);
        }else{
            return 1;
        }
    }

    public static function updateAdmin($form)
    {
        $res=self::update($form);
        return $res?1:0;
    }

}