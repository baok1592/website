<?php


namespace qy\Log;

use think\facade\Log;

class LogManage
{
    //写入日志
    public static function Write($aid,$user,$msg){
        $data="{\"aid\":\"".$aid."\",\"user\":\"".$user."\",\"msg\":\"".$msg."\"}";
        return Log::channel('mergeLog')->write($data);
    }
    //写入错误日志
    public static function error($msg,array $context = []){
        Log::channel('mergeLog')->error($msg,$context);
        return 1;
    }
    //获取通道内所有日志
    public static function get_log(){
        $Channel=Log::getChannelConfig('mergeLog');
        $file=file_get_contents($Channel['path'].'/single.log');
        $array = explode("\r\n", $file);
        $i=0;
        foreach ($array as $v){
            if($v=='')
                continue;
            $data[$i]=json_decode($v,true);
            if(json_decode($data[$i]['msg'],true))
                $data[$i]['msg']=json_decode($data[$i]['msg'],true);
            $i++;
        }
        return $data;
    }
    //清空日志
    public static function clear(){
        $Channel=Log::getChannelConfig('mergeLog');
        $res=unlink($Channel['path'].'/single.log');
        return $res;
    }

}