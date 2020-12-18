<?php


namespace app\controller\cms;


use app\model\WebTemplate;
use ruhua\bases\BaseController;

class Temp extends BaseController
{
    //获取所有模板
    public function getAllTemp(){
        $data=WebTemplate::select();
        return app('json')->go($data);
    }
    //添加模板
    public function addTemp(){
        $post=input('post.form');
        $res=WebTemplate::create($post);
        return app('json')->go($res);
    }
    //修改模板
    public function editTemp(){
        $post=input('post.form');
        $post['index_json']=json_encode($post['index_json'],true);
        $res=WebTemplate::update($post,['id'=>$post['id']]);
        return app('json')->go($res);
    }

}