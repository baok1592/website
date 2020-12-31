<?php


namespace ruhua\fileManage;


use ruhua\model\File as FileModel;
use ruhua\model\SysConfig;
use ruhua\file_admin\oss\OSS;
use ruhua\exceptions\BaseException;
use think\facade\Filesystem;
use think\facade\Log;

class FileManage
{
    private $file_type;//文件存储类型：0 本地 1 oss
    public function __construct()
    {
        $this->file_type=$this->getFileType();
    }
    /**
     * 上传文件
    */
    public function upFile(){
        $file = request()->file('file');
        if($this->file_type){
            $FilePath='uploads/file/'.date('Ymd').'/';
            $name = uniqid() . '.'.$file->getOriginalExtension();
            $osspath=(new OSS())->upFile($FilePath.$name,$file->getLinkTarget());
            //(new OSS())->setACL($osspath['info']['url'],'public-read');
            $saveName=$osspath;
            $data['file_type']='oss';
        }
        else
        {
            $saveName = Filesystem::disk('public')->putFile( 'file', $file);
            $data['file_type']='load';
        }
        $data['url']=$saveName;
        $data['file_name']=$file->getOriginalName();
        //$res=FileModel::create($data);
        return $data;
    }
    /**
     * 删除文件
     */
    public function delFile($id){
        $file=FileModel::find($id);
        if(!$file){
            throw new BaseException(['msg'=>'没有这个文件']);
        }
        if($file['file_type']=='oss'){
            $d=(new OSS())->delFile($file['url']);
        }else{
            unlink(uploads.$file['url']);
        }
        $res=$file->delete();
        return $res;
    }
    /**
     * 删除文件
     */
    public function delFile1($url,$type){
        if($type=='oss'){
            $d=(new OSS())->delFile($url);
        }else{
            $res=unlink(uploads.$url);
            return $res;
        }
    }
    /**
     * 获取存储类型
     */
    public function getFileType(){
        $type=SysConfig::where(['key'=>'file_type'])->value('value');
        if($type){
            new OSS();
            return 1;
        }
        return 0;
    }
    //获取所有本地文件

    /**
     * @param string $dirname
     * @return array|bool
     */
    public function get_load_file($dirname=''){
        $path=uploads.$dirname;
        if(!is_dir($path)){
            return false;
        }
        $arr = array();
        $data = scandir($path);
        Log::error($data);
        foreach ($data as $value){
            if($value != '.' && $value != '..'){
                $arr[] = $value;
            }
        }
        return $arr;
    }

}