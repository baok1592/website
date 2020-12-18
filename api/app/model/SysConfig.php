<?php


namespace app\model;

use ruhua\bases\BaseModel;
use ruhua\exceptions\BaseException;

class SysConfig extends BaseModel
{
    protected $hidden = ['uniacid'];

    public function getConfig()
    {
        $data=self::select()->toArray();
        if(!$data){
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $data;
    }

    public function updateConfig()
    {
        $post = input('post.');
        $res = (new SysConfig)->allowField($post)->saveAll($post);
        if(!$res){
            throw new BaseException(['msg'=>'修改失败']);
        }
        return 1;
    }
    public function tep()
    {
        return $this->belongsTo('WebTemplate','value','id');
    }
//    public function getValueAttr($value)
//    {
//        return json_decode($value,true);
//    }
}