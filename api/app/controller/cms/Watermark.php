<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2020/10/15 0015
 * Time: 9:09
 */

namespace app\controller\cms;


use app\model\Image;
use ruhua\bases\BaseController;
use app\model\SysConfig;
use ruhua\exceptions\BaseException;
use think\facade\Log;

class Watermark
{

    /**
     * 生成文字水印
     */
    public function text($data)
    {

       // $post=input('post.');

        /*打开图片*/
        //1.配置图片路径
        $src = ROOT.$data['url'];

        //2.获取图片的信息（得到图片的基本信息）
        $info = getimagesize($src);
        $with=$info[0];
        $heigh=$info[1];

    //    return app('json')->go(['info'=>$info]);
        //3.通过获取图片类型
        $type = image_type_to_extension($info[2],false);
        //4.在内存中创建一个图片类型一样的图像
        $fun = "imagecreatefrom{$type}";
        //5.图片复制到内存中
        $image = $fun($src);
        /*操作图片*/
        //1.设置字体的路径
        $font = ROOT."/static/verify/assets/sy/FZYTK.TTF";//c盘windows/fonts
        //2.填写水印内容
        $content =SysConfig::where('key','watermark_text')->value('value');
        $lenth=mb_strlen($content);
        //3.设置字体的颜色rgb和透明度alpha
        $col = imagecolorallocatealpha($image,220,220,220,10);
        //4.写入文字
        imagettftext($image,11,0,$with-11*($lenth+2),$heigh-10,$col,$font,$content);
        /*输出图片*/
        //浏览器输出
       // header("Content-type:{$info['mime']}");
        $func = "image{$type}";
        // $func($image);
        //保存图片
        $name='newimage.'.$type;
        $func($image,ROOT.$data['url']);
      //  Log::error($data['url']);
        /*销毁图片*/
        imagedestroy($image);
        $res=Image::create($data);
        return $res;

    }

    /**
     * 生成图片水印
     */
    public function picture()
    {
        $dst_path = '4.jpg';
        $src_path = '1.png';
        //创建图片的实例
        $dst = imagecreatefromstring(file_get_contents($dst_path));
        $src = imagecreatefromstring(file_get_contents($src_path));
        //获取水印图片的宽高
        list($src_w, $src_h) = getimagesize($src_path);
        //将水印图片复制到目标图片上，最后个参数80是设置透明度，这里实现半透明效果
        imagecopymerge($dst, $src, 10, 10, 0, 0, $src_w, $src_h, 80);
        //如果水印图片本身带透明色，则使用imagecopy方法
        //imagecopy($dst, $src, 10, 10, 0, 0, $src_w, $src_h);
        //输出图片
        list($dst_w, $dst_h, $dst_type) = getimagesize($dst_path);
        switch ($dst_type) {
            case 1://GIF
                header('Content-Type: image/gif');
                imagegif($dst);
                break;
            case 2://JPG
                header('Content-Type: image/jpeg');
                imagejpeg($dst);
                break;
            case 3://PNG
                header('Content-Type: image/png');
                imagepng($dst);
                break;
            default:
                break;
        }
        imagedestroy($dst);
        imagedestroy($src);
    }


}