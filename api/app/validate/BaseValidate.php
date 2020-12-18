<?php


namespace app\validate;


use ruhua\exceptions\BaseException;
use think\facade\Request;
use think\Validate;

class BaseValidate extends Validate
{
    public function goCheck()
    {
        $params = Request::param();
        $result = $this->batch()->check($params);
        if (!$result) {
            throw new BaseException(['msg' => $this->error]);
        } else {
            return true;
        }
    }

    public function goCheckArray()
    {
        $params = Request::param();
        $result = $this->batch()->check($params['form']);
        if (!$result) {
            throw new BaseException(['msg' => $this->error]);
        } else {
            return true;
        }
    }

    //验证是否正整数
    protected function isPositiveInteger($value)
    {
        if (is_numeric($value) && is_int($value + 0) && ($value + 0) > 0) {
            return true;
        } else {
            return false;
        }
    }
}