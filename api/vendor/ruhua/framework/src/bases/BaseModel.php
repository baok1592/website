<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace  ruhua\bases;

use app\model\SysConfig;
use think\Model;

class  BaseModel extends Model
{
    protected $globalScope = ['page'];

    public function scopePage($query){
        $post=input('get.');
        $page=-1;
        $num=10;
        if(isset($post['page'])&&isset($post['num'])){
            $page=$post['page'];
            $num=$post['num'];

        }
        $get=input('get.');
        if(isset($get['page'])&&isset($get['num'])){
            $page=$get['page'];
            $num=$get['num'];
        }
        if($page>=0)
            $query->limit($page*$num,$num);

    }


    protected function baseSetImgUrl ($value,$data){
        $finalUrl = $value;
        if($data['from'] == 1){
            $api_url = SysConfig::where('key','api_url')->value('value');
            $value=str_replace("\\","/",$value);
            $finalUrl = $api_url.$value;
        }
        return $finalUrl;
    }

    public function getCreateTimeAttr($v)
    {
        return date("Y-m-d",$v);
    }
    
}