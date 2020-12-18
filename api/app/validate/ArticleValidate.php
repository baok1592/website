<?php


namespace app\validate;


class ArticleValidate extends BaseValidate
{
    protected $rule = [
        'title'  => 'require',
        'category_id'  => 'require',
        'content' => 'require',
        'img_id' => 'min:0'
    ];
}