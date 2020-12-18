<?php


namespace app\controller\PC;


use app\model\Article;
use app\model\BannerItem;
use app\model\Category;
use app\model\SysConfig;
use ruhua\bases\BaseController;

class Index extends BaseController
{
    //获取首页导航栏
    public function GetNav(){
        $data= Category::where(['level'=>1,"is_visible"=>1])->order('sort desc')->field('category_id,category_name,type,sort,category_pic,template,short_name')->select()->toArray();
        return app('json')->go($data);
    }
    //获取轮播图
    public function getBannerItem(){
        $data=BannerItem::where('banner_id',1)->select()->toArray();
        return app('json')->go($data);
    }
    //获取首页中间部分
    public function getConter(){
        $Article=new Article();
        $res=[];
        $i=0;
        $data= Category::where(['is_pc_index'=>1,"is_visible"=>1])->order('sort desc')->field('category_id,category_name,type,category_pic,template,short_name')->select()->toArray();
        foreach ($data as $v){
            if($v['type']!='cover'){
                $a=$Article->where(['category_id'=>$v['category_id'],'is_index'=>1])->field('id,title,short_title,summary,img_id,author,source,create_time,reading_volume')->select()->toArray();
                $res[$i]=$v;
                $res[$i]['article']=$a;
            }
            else
                $res[$i]=$v;
            $i++;
        }
        return app('json')->go($res);
    }
    //获取底部备案信息
    public function getRecord(){
        $data=SysConfig::where('type',3)->select()->toArray();
        return app('json')->go($data);
    }

}