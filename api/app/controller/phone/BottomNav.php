<?php


namespace app\controller\phone;


use app\model\Category;
use ruhua\bases\BaseController;
use ruhua\exceptions\BaseException;
use app\model\BottomNavigation;

class BottomNav extends BaseController
{
    //修改底部导航栏
    public function up_bottomNavigation()
    {
        $form=input('post.');
        for($i=0;$i<count($form);$i++){
            if($form[$i]['category_type']=='list'){
                $form[$i]['type']=Category::where('category_id',$form[$i]['category_id'])->value('type');
                //unset($form[$i]['category_type']);
            }
            else
                $form[$i]['type']=$form[$i]['category_type'];
            unset($form[$i]['category_type']);
        }
        $data=(new BottomNavigation())->saveAll($form);
        if(!$data)
            throw new BaseException(['msg'=>'更新失败！']);
        return app('json')->success();
    }

    //获取所有底部导航数据
    public function get_bottomNavigationAll()
    {
        $data=BottomNavigation::order('bottom_sort','asc')->select();
        return app('json')->success($data);
    }
}