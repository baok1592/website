<?php


namespace app\model;


use ruhua\exceptions\BaseException;
use app\model\BannerItem as BannerItemModel;
use ruhua\bases\BaseModel;

class Banner extends BaseModel
{
    protected $hidden = ['delete_time','update_time'];

    public static function bannerItemsAll()
    {
        $res = BannerItemModel::with(['banner'])->order('sort desc')->select();
        if(!$res){
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $res;
    }

    public static function createBanner($form)
    {
        $res = BannerItemModel::create($form);
        if(!$res){
            throw new BaseException(['msg'=>'添加失败']);
        }
        return 1;
    }

    public static function deleteBanner($id)
    {
        $res = BannerItemModel::destroy($id);
        if(!$res){
            throw new BaseException(['msg'=>'删除失败']);
        }else{
            return 1;
        }
    }

    public static function updateBanner($form)
    {
        $res = BannerItemModel::update($form);
        if($res){
            return 1;
        }
        return 0;
    }

    public static function upBannerSort()
    {
        $arr=input('post.');
        if(!is_array($arr)){
            return 0;
        }
        $cate=new BannerItemModel;
        foreach ($arr as $k=>$v){
            $cate->where('id',$k)->update(['sort' => $v]);
        }
        return 1;
    }

    public static function getBannerContent($id)
    {
        $data=BannerItemModel::find($id);
        if(!$data)
        {
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $data;
    }
}