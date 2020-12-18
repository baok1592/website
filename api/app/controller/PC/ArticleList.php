<?php


namespace app\controller\PC;


use app\model\Article;
use app\model\Category;
use app\validate\IDPostiveInt;
use ruhua\bases\BaseController;

class ArticleList extends BaseController
{
    //获取新闻列表页左面栏目块
    public function getColumn($id='')
    {
        (new IDPostiveInt)->goCheck();
        $data=[];
        $data['pcolumn'] = Category::where('category_id', $id)->select()->toArray();
        $data['column']= Category::where(['pid'=> $id,'is_visible'=>1])->select()->toArray();
        return app('json')->go($data);
    }
    //获取右侧内容页
    public function getList($id=''){
        (new IDPostiveInt)->goCheck();
        $column= Category::where('category_id', $id)->select()->toArray();
        if($column[0]['type']=='cover'){
            return app('json')->go($column);
        }
        $data['info']=$column;
        $data['list']=Article::where(['is_hidden'=>0,'category_id'=>$id])->field('id,title,author,img_id,create_time')->select()->toArray();
        return app('json')->go($data);

    }
}