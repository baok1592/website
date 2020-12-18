<?php


namespace app\controller\cms;


use ruhua\bases\BaseController;
use think\facade\Db;
use ruhua\exceptions\BaseException;

class Common extends BaseController
{
    //更新不同模型的布尔值
    public function on_off(){
        $get=input('put.');
        $id=$get['id'];
        $db=$get['db'];
        $field=$get['field'];
        switch ($db)
        {
            case 'article':
                $where['id']=$id; break;
            case 'admins':
                $where['id']=$id; break;
            case 'category':
                $where['category_id']=$id; break;
            case 'sys_config':
                $where['id']=$id; break;
            default:
                throw new BaseException(['msg'=>'找不到模型']);
        }
        $vs=Db::name($db)->where($where)->value($field);
        if($vs == 0 ){
            $res = Db::name($db)->where($where)->update([$field=>1]);
        }else{
            $res =  Db::name($db)->where($where)->update([$field=>0]);
        }
        return app('json')->go($res);
    }

}