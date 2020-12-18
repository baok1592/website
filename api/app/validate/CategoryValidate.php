<?php


namespace app\validate;


use think\Validate;

class CategoryValidate extends BaseValidate
{
    protected $rule = [
        'category_name'=> 'require|min:2',
        'pid'=> 'require|number'
    ];
}