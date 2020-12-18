<?php


namespace app\validate;


class AdminsValidate extends BaseValidate
{
    protected $rule=[
        'username'=>'require|max:30',
        'password'=>'require|min:6',
    ];
}