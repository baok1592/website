<?php


namespace app\controller\cms;


use app\model\Article as ArticleModel;
use app\model\BannerItem;
use app\model\BottomNavigation;
use app\model\Category as CategoryModel;
use app\model\Banner as BannerModel;
use ruhua\bases\BaseController;
use think\facade\Db;

class SoftDeletion extends BaseController
{
    //将article全部添加到回收站
    public function add_articleTrashedAll()
    {
        $data=ArticleModel::select();
        foreach($data as $v)
        {
            $v->delete();
        }
        return app('json')->success();
    }

    //将category全部添加到回收站
    public function add_categoryTrashedAll()
    {
        $data=CategoryModel::select();
        foreach($data as $v)
        {
            $v->delete();
        }
        return app('json')->go();
    }

    //将article添加到回收站
    public function add_articleTrashed()
    {
        $id=input('post.id');
        foreach($id as $v)
        {
            $user = ArticleModel::find($v);
            if(!$user){
                return app('json')->fail();
            }
            $user->delete();
        }
        return app('json')->success();
    }

    //将category添加到回收站
    public function add_categoryTrashed()
    {
        $id=input('post.category_id');
        foreach($id as $v)
        {
            $user = CategoryModel::where(['category_id'=>$v])->find();
            if(!$user){
                return app('json')->fail();
            }
            $user->delete();
        }
        return app('json')->success();

    }

    //获取回收站里的所有数据
    public function get_trashed()
    {
        $data['category']=CategoryModel::onlyTrashed()->select();
        $data['article']=ArticleModel::onlyTrashed()->select();
        return app('json')->go($data);
    }

    //恢复回收站里的所有数据
    public function recovery_trashed()
    {
        $category=CategoryModel::onlyTrashed()->select();
        $article=ArticleModel::onlyTrashed()->select();
        foreach ($category as $v)
        {
            $v->update('delete_time',Null);
        }
        foreach ($article as $v)
        {
            $v->restore();
        }
        return app('json')->success();
    }

    //批量恢复回收站里的数据
    public function recovery_trashedBatch()
    {
        $id=input('post.id');
        $db=new Db();
        foreach ($id as $k=>$v)
        {
            if($k=='category')
            {
                foreach ($v as $value)
                {
                    $db::name('category')->where('category_id',$value)->update(['delete_time'=>null]);
                    //$category = CategoryModel::onlyTrashed()->where('category_id',$value)->find();
                    //$category->restore();
                }
            }
            if($k=='article')
            {
                foreach ($v as $value)
                {
                    $article = ArticleModel::onlyTrashed()->find($value);
                    $article->restore();
                }
            }
        }
        return app('json')->success();
    }

    //一键清空回收站数据
    public function del_trashedAll()
    {
        $category=CategoryModel::onlyTrashed()->select();
        $article=ArticleModel::onlyTrashed()->select();
        foreach ($category as $v)
        {
            $v->force()->delete();
        }
        foreach ($article as $v)
        {
            $v->force()->delete();
        }
        return app('json')->go();

    }

    //批量清空回收站数据
    public function del_trashedBatch()
    {
        $id=input('post.id');
        $db=new Db();
        foreach ($id as $k=>$v)
        {
            if($k=='category')
            {
                foreach ($v as $value)
                {
                    $db::name('category')->where('category_id',$value)->delete(true);
                }
            }
            if($k=='article')
            {
                foreach ($v as $value)
                {
                    $category = ArticleModel::onlyTrashed()->find($value);
                    $category->force()->delete();
                }
            }
        }
        return app('json')->success();
    }

    //将banner清空
    public function add_bannerTrashedAll()
    {
        $data=BannerModel::select();
        foreach($data as $v)
        {
            $v->delete();
        }
        return app('json')->go();
    }

    //将bannerItem清空
    public function add_bannerItemTrashedAll()
    {
        $data=BannerItem::select();
        foreach($data as $v)
        {
            $v->delete();
        }
        return app('json')->go();
    }

    //清空BottomNavigation
    public function del_bottomNavigationAll()
    {
        $data=BottomNavigation::select();
        foreach($data as $v)
        {
            $v->delete();
        }
        return app('json')->go();
    }
}