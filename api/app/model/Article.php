<?php


namespace app\model;


use app\service\TokenService;
use ruhua\bases\BaseModel;
use ruhua\exceptions\BaseException;
use think\model\concern\SoftDelete;

class Article extends BaseModel
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    protected $hidden=['type'];

    public function category(){
        return $this->belongsTo('Category','category_id','category_id');
    }

    public function setImgAttr($v)
    {
        return $v['url'];
    }

    public function getCreateTimeAttr($v)
    {
        $data=date("Y-m-d",$v);
        return $data;
    }

    public function getIsHiddenAttr($v)
    {
        return $v==1 ? true : false;
    }

    public static function getListAll($show='')
    {
        if($show=='') {
            $data = self::where('is_hidden', 0)->order('sort', 'desc')->select();
        }else{
            $data = self::order('id', 'desc')->all();
        }
        if(!$data){
            throw new BaseException(['msg'=>'获取文章失败']);
        }
        return $data;
    }

    public static function createArticle($form)
    {
        $author=TokenService::getCurrentTokenVar('username');
        $form['author']=$author;
        $res = self::create($form);
        if(!$res){
            throw new BaseException(['msg'=>'添加失败']);
        }
        return 1;
    }

    public static function updateArticle($form)
    {
        $res = self::update($form);
        if($res){
            return 1;
        }
        return 0;
    }

    public static function getArticleContent($id)
    {
        $data=self::where('id',$id)->select();
        if(!$data)
        {
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $data;
    }

    public static function upArticleSort()
    {
        $arr=input('post.');
        if(!is_array($arr)){
            return 0;
        }
        $cate=new self();
        foreach ($arr as $k=>$v){
            $cate->where('id',$k)->update(['sort' => $v]);
        }
        return 1;
    }

    public static function labelRecommendation($cher)
    {
        $data=self::where('label','like','%'.$cher.'%')->select();
        return json($data);
    }
}