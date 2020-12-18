<?php


namespace app\controller\common;


use app\model\Article;
use app\model\Category;
use app\model\WebTemplate;
use app\validate\IDPostiveInt;
use ruhua\bases\BaseController;

class Common extends BaseController
{
    //获取网站所有模板
    public function getALLTep(){
        $data=WebTemplate::select()->toArray();
        return app('json')->go($data);
    }
    //获取网站所有手机模板
    public function getALLMTep(){
        $data=WebTemplate::where('template_type',1)->select()->toArray();
        return app('json')->go($data);
    }
    //获取网站所有pc模板
    public function getALLPCTep(){
        $data=WebTemplate::where('template_type',0)->select()->toArray();
        return app('json')->go($data);
    }
    //获取子类所有数据
    public function getsuBclassList($id=''){
        (new IDPostiveInt)->goCheck();
        $column= Category::where('category_id', $id)->select()->toArray();
        $data['info']=$column;
        $data['list']=Article::where(['is_hidden'=>0,'category_id'=>$id])->field('id,title,short_title,author,create_time')->select()->toArray();
        return app('json')->go($data);

    }
    //获取大类所有数据
    public function getPclassList($id=''){
        (new IDPostiveInt)->goCheck();
        $column= Category::where('category_id', $id)->field('category_id,pid,category_name,type,category_pic,template,content')->select()->toArray();
        $data['info']=$column;
        $data['data']=Category::with('Article')->where('pid', $id)->field('category_id,pid,category_name,type,category_pic,template,content')->select()->toArray();
        return app('json')->go($data);
    }

}