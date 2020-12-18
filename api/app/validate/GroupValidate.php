<?php


namespace app\validate;


class GroupValidate extends BaseValidate
{
    protected $rule = [
        'title'  => 'require|max:255',
        'rules' => 'require'
    ];
}