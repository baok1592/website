<?php


namespace app\controller\cms;
use app\model\Category as CategoryModel;
use app\validate\IDPostiveInt;
use app\validate\CategoryValidate;
use ruhua\bases\BaseController;

class Category extends BaseController
{
    //获取所有栏目并排好序，包括隐藏
    public function get_categorySort()
    {
        $data=CategoryModel::getCategoryAll();
        return app('json')->go($data);
    }

    //删除栏目
    public function del_category($id)
    {
        (new IDPostiveInt)->goCheck();
        $result = CategoryModel::deleteCategory($id);
        return app('json')->go($result);
    }

    //更新栏目
    public function up_category($form)
    {
        (new CategoryValidate)->goCheckArray();
        $data=CategoryModel::updateCategory($form);
        return app('json')->go($data);
    }

    //新增栏目
    public function add_category($form)
    {
        (new CategoryValidate)->goCheckArray();
        $data = CategoryModel::createCategory($form);
        return app('json')->go($data);
    }

    //更新栏目排序
    public function up_category_sort()
    {
        $data=CategoryModel::upCategorySort();
        return app('json')->go($data);
    }

    //CMS获取发文章的所有栏目
    public function article_category_list(){
        $list=CategoryModel::where(['pid'=>0,'type'=>[0,1]])->select();
        return app('json')->go($list);
    }
    //根据id获取栏目信息
    public function getCategory($id){
        $data=CategoryModel::where('category_id',$id)->find();
        return app('json')->go($data);
    }


}