<?php


namespace app\controller\common;


use app\model\Category;
use ruhua\bases\BaseController;
use app\model\Article as ArticleModel;

class Article extends BaseController
{
    //获取所有文章
    public function getAllArticle(){
        $data=ArticleModel::where('is_hidden',0)->order('sort desc')->select()->toArray();
        return app('json')->go($data);
    }
    //获取某栏目列表下的文章列表
    public function getColumnArticle($id=''){
        $data['column']= Category::where(['category_id'=>$id,'is_visible'=>1])->select()->toArray();
        $data['article']=ArticleModel::where(['is_hidden'=>0,'category_id'=>$id])->order('sort desc')->field('id,title,short_title,summary,img_id,author,source,create_time,reading_volume')->select()->toArray();
        return app('json')->go($data);
    }

}