<?php


namespace app\controller\PC;


use app\model\Category;
use app\validate\IDPostiveInt;
use ruhua\bases\BaseController;
use app\model\Article as ArticleModel;

class Article extends BaseController
{
    //获取文章内容
    public function getArticle($id){
        (new IDPostiveInt)->goCheck();
        $data= ArticleModel::where(['id'=>$id,'is_hidden'=>0])->select()->toArray();
        return app('json')->go($data);
    }
    //根据文章id获取左侧栏目块
    public function getColumn($id){
        (new IDPostiveInt)->goCheck();
        $category=new Category();
        $cid=ArticleModel::where(['id'=>$id,'is_hidden'=>0])->field('category_id')->find();
        $pid=$category->where('category_id',$cid['category_id'])->field('pid')->find();
        $data['pcolumn'] = $category->with('img')->where('category_id', $pid['pid'])->select()->toArray();
        $data['column']= $category->with('img')->where(['pid'=> $pid['pid'],'is_visible'=>1])->select()->toArray();
        return app('json')->go($data);
    }

}