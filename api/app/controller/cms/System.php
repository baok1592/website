<?php


namespace app\controller\cms;

use app\model\SysConfig as SysConfigModel;
use ruhua\bases\BaseController;


class System extends BaseController
{
    //获取商城配置信息
    public function getConfig()
    {
        $data=(new SysConfigModel())->getConfig();
        $data[24]['value']=json_decode($data[24]['value'],true);
        return app('json')->go($data);
    }

    //修改配置信息
    public function up_config()
    {
        $data=(new SysConfigModel())->updateConfig();
        return app('json')->go($data);
    }
}