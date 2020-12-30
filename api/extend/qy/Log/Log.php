<?php


namespace app\controller\cms;


use qy\Log\LogManage;
use think\facade\Cache;

class Log
{
    //查看所有日志
    public function getLog(){
        $res=LogManage::get_log();
        return app('json')->go($res);
    }
    //清空日志
    public function clear(){
        $res=LogManage::clear();
        return app('json')->go($res);
    }
    //清除缓存
    public function clear_cache(){
        $res=Cache::clear();
        return app('json')->go($res);
    }

}