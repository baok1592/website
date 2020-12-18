<?php


namespace app\controller\common;


use app\model\SysConfig;
use ruhua\bases\BaseController;

class Config extends BaseController
{
    //电脑端正在使用的模板
    public function getPCNowTep(){
        $data=SysConfig::with('tep')->where('key','pc_tmp')->field('id,key,value,desc')->find();
        return app('json')->go($data);
    }
    //手机端正在使用的模板
    public function getPhoneNowTep(){
        $data=SysConfig::with('tep')->where('key','phone_tmp')->field('id,key,value,desc')->find();
        return app('json')->go($data);
    }
    //修改正在使用的模板
    public function editNowTep($type,$value){
        $res=SysConfig::where('key',$type)->update(['value'=>$value]);
        return app('json')->go($res);
    }
}