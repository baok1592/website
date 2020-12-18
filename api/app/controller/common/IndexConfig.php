<?php


namespace app\controller\common;

use app\model\IndexConfig as IndexConfigModel;
use ruhua\bases\BaseController;

class IndexConfig extends BaseController
{
    //获取首页配置信息
    public function getConfig()
    {
        $data=(new IndexConfigModel())->getConfig();
        return app('json')->go($data);
    }

    //修改首页配置信息
    public function up_config()
    {
        $data=(new IndexConfigModel())->updateConfig();
        return app('json')->go($data);
    }

}