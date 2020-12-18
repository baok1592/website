<?php


namespace app\model;


use ruhua\bases\BaseModel;

class BottomNavigation extends BaseModel
{
    public function img()
    {
        return $this->belongsTo('Image','img_id','id');
    }

}