<?php


namespace app\model;


use ruhua\bases\BaseModel;
use think\model\concern\SoftDelete;

class Image extends BaseModel
{
    use SoftDelete;
    protected $hidden = ['update_time','delete_time','from','use_name'];


}