<?php


namespace app\model;


use ruhua\exceptions\BaseException;
use ruhua\bases\BaseModel;

class AuthGroup extends BaseModel
{
    public static function getGroupAll()
    {
        $res=self::select();
        if(!$res){
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $res;
    }

    public static function createGroup($form)
    {
        $data['title']=$form['title'];
        $data['rules']=implode(',',$form['rules']);
        $res=self::create($data);
        if (!$res)
        {
            throw new BaseException(['msg'=>'添加失败']);
        }
        return 1;
    }

    public static function updateGroup($form)
    {
        $form['rules']=implode(',',$form['rules']);
        $group=self::find($form['id']);
        if(!$group)
            throw new BaseException(['msg'=>'没有这个组！']);
        $res=$group->save($form);
        if (!$res)
        {
            throw new BaseException(['msg'=>'更新失败']);
        }
        return 1;
    }

}