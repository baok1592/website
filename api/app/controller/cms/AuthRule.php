<?php


namespace app\controller\cms;

use ruhua\exceptions\BaseException;
use ruhua\bases\BaseController;
use qy\auth\Auth;
use app\model\AuthRule as AuthRuleModel;

class AuthRule extends BaseController
{

    //获取接口
    public function get_interfaceAll()
    {
        $res=AuthRuleModel::select()->toArray();
        return app('json')->go($res);
    }
}