<?php


namespace app\controller\common;


use ruhua\bases\BaseController;
use app\model\Link as LinkModel;

class Link extends BaseController
{
    //获取友情链接
    public function getLink(){
        $data=LinkModel::order('sort desc')->select()->toArray();
        return app('json')->go($data);
    }
}