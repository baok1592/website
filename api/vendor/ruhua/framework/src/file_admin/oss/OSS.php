<?php


namespace ruhua\file_admin\oss;

use ruhua\model\SysConfig;
use OSS\OssClient;
use OSS\Core\OssException;
use ruhua\exceptions\BaseException;
use ruhua\exceptions\UserException;
use think\Exception;

class OSS
{
    private $oss;
    private $bucket;
    public function __construct()
    {
        $arr=SysConfig::select()->toArray();
        foreach ($arr as $k=>$v){
            $config[$v['key']]=$v['value'];
        }
        $accessKeyId=$config['accessKeyId'];
        $accessKeySecret=$config['accessKeySecret'];
        $endpoint=$config['endpoint'];
        $this->bucket=$config['bucket'];
        $this->oss=(new OssClient($accessKeyId,$accessKeySecret,$endpoint));

    }
    //检查文件是否存在
    public function checkDir($path){
        try {
            $exist = $this->oss->doesObjectExist($this->bucket, $path);
        }catch (OssException $e)
        {
          throw new OssException(['message'=>$e->getMessage()]);
        }
        return $exist;
    }
    /**上传文件
     * object  oss的文件路径+文件名
     * filePath  本地的文件路径
    */
    public function upFile($object,$filePath){
        try {
            $res=$this->oss->uploadFile($this->bucket, $object, $filePath);
        }catch (OssException $e)
        {
            throw new Exception($e->getMessage());
        }
        return $res['info']['url'];
    }
    //设置文件管理权限
    public function setACL($object,$acl){
        try {
            $res=$this->oss->putObjectAcl($this->bucket, $object, $acl);
        }catch (OssException $e)
        {
            throw new OssException(['message'=>$e->getMessage()]);
        }
        return $res;
    }
    //删除文件
    public function delFile($path){
        $path=substr($path,stripos($path,'com/')+4,strlen($path));
        try {
            $res=$this->oss->deleteObject($this->bucket, $path);
        }catch (OssException $e)
        {
            throw new OssException(['message'=>$e->getMessage()]);
        }
        return $res;
    }
    //下载文件到本地内存
    public function dwnFile($object){
        try {
            $content = $this->oss->getObject($this->bucket, $object);
        }catch (OssException $e)
        {
            throw new OssException(['mgs'=>$e->getMessage()]);
        }
        return $content;
    }
    //列举oss某文件夹下所有文件
    public function getFile($path=''){
        $nextMarker = 'uploads/'.$path;
        while (true) {
            try {
                $options = array(
                    'delimiter' => "",
                    'max-keys' => 200,
                    'marker' => $nextMarker,
                );
                $listObjectInfo = $this->oss->listObjects($this->bucket, $options);
            } catch (OssException $e) {
                throw new OssException(['msg'=>$e->getMessage()]);
            }
            // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表。
            $nextMarker = $listObjectInfo->getNextMarker();
            $listObject = $listObjectInfo->getObjectList();
            $listPrefix = $listObjectInfo->getPrefixList();

            if (!empty($listObject)) {
                foreach ($listObject as $objectInfo) {
                    $data['List'][]=$objectInfo->getKey();
                }
            }
            if (!empty($listPrefix)) {
                foreach ($listPrefix as $prefixInfo) {
                    $data['prefixList'][]=$prefixInfo->getPrefix();
                }
            }
            if ($listObjectInfo->getIsTruncated() !== "true") {
                break;
            }
        }
        return $data;
    }
    public function BucketExist(){
        try {
            $content = $this->oss->doesBucketExist($this->bucket);
        }catch (OssException $e)
        {
            throw new OssException(['mgs'=>$e->getMessage()]);
        }
        return $content;
    }

}