<?php


namespace ruhua\fileManage;


use ruhua\fileManage\FileManage as File;
use ruhua\file_admin\oss\OSS;

class DomeFile
{
    //获取所有本地文件
    public function get_load_file($dirname=''){
        $data=(new File())->get_load_file($dirname);
        return app('json')->go($data);
    }
    //删除文件
    public function del_file($url,$type){
        $res=(new File())->delFile1($url,$type);
        return app('json')->go($res);
    }
    //获取所有oss
    public function get_oss_file($path){
        $res=(new OSS())->getFile($path);
        return app('json')->go($res);
    }
    //测试oss链接
    public function cs_oss(){
        $res=(new OSS())->BucketExist();
        return app('json')->go($res);
    }

}