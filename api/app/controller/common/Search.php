<?php


namespace app\controller\common;


use app\model\Article;
use ruhua\bases\BaseController;

class Search extends BaseController
{
    //搜索文章
    public function SearchArticle($title=''){
        $data=Article::with('img')->where('is_hidden',0)->where('title|content','like','%'.$title.'%')->select()->toArray();
        return app('json')->go($data);
    }

}