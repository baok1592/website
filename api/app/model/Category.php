<?php


namespace app\model;


use ruhua\exceptions\BaseException;
use app\model\Category as CategoryModel;
use ruhua\bases\BaseModel;
use think\model\concern\SoftDelete;

class Category extends BaseModel
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    public function setImgAttr($v)
    {
        return $v['url'];
    }
    public function Article()
    {
        return $this->hasMany('Article','category_id','category_id')->field('id,short_title,category_id,title,img_id,author,summary,source,create_time');
    }
    public static function getCategoryAll()
    {
        $data=self::order('sort desc')->select()->toArray();
        if(!$data || count($data)<1){
            return [];
        }
        return $data;
    }

    public static function deleteCategory($id)
    {
        $category=self::where('category_id',$id)->find();
        if(!$category)
            throw new BaseException(['msg'=>'无该栏目！']);
        $category->delete();
        return 1;
    }

    public static function updateCategory($form)
    {
        if($form['pid']==0){
            $form['level']=1;
        }else{
            $form['level']=2;
        }
        $form['json']=json_encode($form['json'],true);
        $res =self::update($form,['category_id'=>$form['category_id']]);
        if($res){
            return 1;
        }
        return 0;
    }

    public static function createCategory($form)
    {
        if($form['pid']==0){
            $form['level']=1;
        }else{
            $form['level']=2;
        }
        $form['sort']=0;
        $form['json']=json_encode($form['json'],true);
        $res = self::create($form);
        if($res){
            return 1;
        }else{
            return 0;
        }
    }

    public static function upCategorySort()
    {
        $arr=input('post.');
        if(!is_array($arr)){
            return 0;
        }
        $cate=new CategoryModel;
        foreach ($arr as $k=>$v){
            $cate->where('category_id',$k)->update(['sort' => $v]);
        }
        return 1;
    }

}