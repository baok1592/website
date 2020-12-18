<?php


namespace app\model;


use ruhua\bases\BaseModel;
use think\model\concern\SoftDelete;

class WebTemplate extends BaseModel
{
    protected $hidden=['uniacid','delete_time'];
    use SoftDelete;
    protected $deleteTime = 'delete_time';
}