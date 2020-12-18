<?php


namespace app\controller\cms;


use ruhua\exceptions\BaseException;
use app\model\Image as ImageModel;
use ruhua\bases\BaseController;

class Image extends BaseController
{
    //获取所有图片
    public function get_img_all()
    {
        $res=ImageModel::select()->toArray();
        return app('json')->go($res);
    }
    //上传图片
    public function uploadImg($cid = 0)
    {
        $image = \think\Image::open(request()->file('img'));
        if (!$image) {
            return app('json')->fail('请上传文件img');
        }
        $name = uniqid(). '.'. $image->type();
        $dir=ROOT.'/uploads/imgs/'.date('Ym');
        if(!is_dir($dir))
            mkdir ($dir,0777,true);
        $image->save($dir.'/'.$name);
        $data['url']='/uploads/imgs/'.date('Ym').'/'.$name;
        $data['cid']=$cid;
        $res=ImageModel::create($data);
        if(!$res)
        {
            throw new BaseException(['msg'=>'上传失败']);
        }
        return app('json')->success();
    }
    //删除图片
    public function delImage($ids){
        $res=ImageModel::destroy($ids);
        if(!$res)
        {
            throw new BaseException(['msg'=>'上传失败']);
        }
        return app('json')->success();
    }

}