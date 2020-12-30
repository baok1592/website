<?php


namespace app\controller\cms;

use qy\backup\Backsql;
use qy\Log\LogManage;


class Backup
{
    //备份
    public function data_backup(){
        //$res=Config::get('database.connections.mysql');
        $res =(new Backsql())->backup();
        return app('json')->go($res);
    }
    //还原
    public function data_restore(string $file){
        $res =(new Backsql())->restore($file);
        return app('json')->go($res);
    }
    //备份文件列表
    public function backup_list(){
        $res=(new Backsql())->get_filelist();
        return app('json')->go($res);
    }
    //删除备份文件
    public function delete(string $file){
        $res =(new Backsql())->delfilename($file);
        return app('json')->go($res);
    }
    //下载备份
    public function downloadFile($file)
    {
        //$file="bedfbb70a637d0bfc3fa0a39eefc036f.sql";
        (new Backsql())->downloadFile($file);
    }

}