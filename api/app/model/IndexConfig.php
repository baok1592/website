<?php


namespace app\model;


use ruhua\exceptions\BaseException;
use think\facade\Db;
use app\model\SysConfig as SysConfigModel;

class IndexConfig
{
    public function getConfig()
    {
        $data=SysConfigModel::where('key','index_json')->select()->toArray();
        if(!$data){
            throw new BaseException(['msg'=>'获取失败']);
        }
        $data[0]['values']=json_decode($data[0]['value'],true);
        unset($data[0]['value']);
        return $data;
    }

    public function updateConfig()
    {
        $post = input('post.');
        $post['value']=json_encode($post['value']);
        SysConfigModel::where('key',$post['key'])->update($post);
        return 1;
    }

}