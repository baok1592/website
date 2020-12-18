<?php


namespace app\controller\cms;

use app\model\Article as ArticleModel;
use app\validate\ArticleValidate;
use app\validate\IDPostiveInt;
use ruhua\exceptions\BaseException;
use ruhua\bases\BaseController;

class Article extends BaseController
{
    //获取所有文章
    public function get_article_list()
    {
        $data=ArticleModel::select()->toArray();
        return app('json')->go($data);
    }

    //添加文章
    public function add_article($form)
    {
        (new ArticleValidate)->goCheckArray();

        $data=ArticleModel::createArticle($form);
        return app('json')->go($data);
    }

    //删除文章
    public function del_article($id)
    {
        (new IDPostiveInt)->goCheck();
        $article = ArticleModel::where('id',$id)->find();
        if(!$article){
            throw new BaseException(['msg'=>'无该文章！']);
        }
        $article->delete();
        return app('json')->success();
    }

    //更新文章
    public function up_article($form)
    {
        (new ArticleValidate)->goCheckArray();
        $data=ArticleModel::updateArticle($form);
        return app('json')->go($data);
    }

    //获取某文章详细
    public function get_article_content($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=ArticleModel::getArticleContent($id);
        return app('json')->go($data);
    }

    //更新文章排序
    public function up_article_sort()
    {
        $data=ArticleModel::upArticleSort();
        return app('json')->go($data);
    }

    //标签推荐
    public function label_recommendation($cher)
    {
        $data=ArticleModel::labelRecommendation($cher);
        return app('json')->go($data);
    }
    //推送文章
    public function push_article($id,$field){
        $vs=ArticleModel::where('id',$id)->value($field);
        if($vs == 0 ){
            $res = ArticleModel::where('id',$id)->update([$field=>1]);
        }else{
            $res =  ArticleModel::where('id',$id)->update([$field=>0]);
        }
        return app('json')->go($res);
    }
}