<?php


namespace app\model;


use ruhua\bases\BaseModel;

class BannerItem extends BaseModel
{
    protected $hidden = ['update_time','delete_time'];

    public function img()
    {
        return $this->belongsTo('Image','img_id','id');
    }

    public function banner()
    {
        return $this->belongsTo('Banner','banner_id','id');
    }

    public function setImgAttr($v)
    {
        return $v['url'];
    }
}