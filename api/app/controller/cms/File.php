<?php


namespace app\controller\cms;

use qy\fileManage\FileManage;
use qy\Log\LogManage;
use ruhua\exceptions\BaseException;
use ruhua\bases\BaseController;
use app\model\File as FileModel;

class File extends BaseController
{
    //获取所有文件
    public function get_file_all()
    {
        $res=FileModel::select()->toArray();
        if($res!=null)
        {
            return app('json')->go($res);
        }
        return app('json')->fail();
    }

    //上传文件
    public function upload_file()
    {
       $data=(new FileManage())->upFile();
        $res=FileModel::create($data);
        if(!$res)
        {
            throw new BaseException(['msg'=>'上传失败']);
        }
        return app('json')->success();
    }
    public function del_file($id){
        //$res=LogManage::get_log();
        //LogManage::error('删除了文件！');
        $res=(new FileManage())->delFile($id);
        return app("json")->go($res);
    }
}