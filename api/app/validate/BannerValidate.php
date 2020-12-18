<?php


namespace app\validate;


class BannerValidate extends BaseValidate
{
    protected $rule = [
        'img_id'  => 'require',
        'banner_id' => 'require|number',
    ];
}