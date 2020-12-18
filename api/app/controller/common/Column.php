<?php


namespace app\controller\common;


use app\model\Category;
use ruhua\bases\BaseController;

class Column extends BaseController
{
    //获取所有一级封面
    public function getALLCover(){
        $data= Category::where(['level'=>1,"is_visible"=>1,'type'=>'cover'])->field('category_id,category_name,type,category_pic,template,content')->select()->toArray();
        return app('json')->go($data);
    }
    //获取所有一级列表
    public function getALLList(){
        $data= Category::where(['level'=>1,"is_visible"=>1,'type'=>'list'])->field('category_id,category_name,type,category_pic,template,content')->select()->toArray();
        return app('json')->go($data);
    }
    //获取某一个封面
    public function getOneCover($id=''){
        $data= Category::where(["is_visible"=>1,'type'=>"cover",'category_id'=>$id])->field('category_id,category_name,type,category_pic,template,content')->select()->toArray();
        return app('json')->go($data);
    }
    //获取所有列表
    public function getALL(){
        $data= Category::where(["is_visible"=>1])->whereNotIn('type','cover')->field('category_id,category_name,type,category_pic,template,content')->select()->toArray();
        return app('json')->go($data);
    }

}