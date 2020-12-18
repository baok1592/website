<?php


namespace app\controller\cms;


use app\model\Banner as BannerModel;
use app\validate\BannerValidate;
use app\validate\IDPostiveInt;
use ruhua\bases\BaseController;

class Banner extends BaseController
{
    //获取所有广告并排序
    public function bannerItems_all()
    {
        $data = BannerModel::bannerItemsAll();
        return app('json')->go($data);
    }

    //添加广告
    public function add_banner($form)
    {
        (new BannerValidate)->goCheckArray();
        $data=BannerModel::createBanner($form);
        return app('json')->go($data);
    }

    //删除广告
    public function del_banner($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=BannerModel::deleteBanner($id);
        return app('json')->go($data);
    }

    //更新广告
    public function up_banner($form)
    {
        (new BannerValidate)->goCheckArray();
        $data=BannerModel::updateBanner($form);
        return app('json')->go($data);
    }

    //更新排序
    public function up_banner_sort()
    {
        $data=BannerModel::upBannerSort();
        return app('json')->go($data);
    }

    //获取广告详细
    public function get_banner_content($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=BannerModel::getBannerContent($id);
        return app('json')->go($data);
    }
}