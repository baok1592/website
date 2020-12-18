<?php


namespace app\controller\PC;


use app\model\Admins;
use app\model\Article as ArticleModel;
use app\model\Article;
use app\model\BannerItem;
use app\model\Category;
use app\model\SysConfig;
use ruhua\bases\BaseCommon;
use ruhua\bases\BaseController;
use think\Exception;
use think\facade\Log;
use think\facade\View;

class PcView extends BaseController
{
    public function initialize()
    {
        if (!(new BaseCommon())->vae_is_installed()) {
            header('Location:/install');
            exit;
        }
        $this->getConfig();
        $this->Category();
        $this->banner();
    }
    public function index(){
        //判断是不是微信浏览器
        if ( strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false ) {
            header('Location:/h5');
            exit;
        }
        // 检测是否安装过
        if ((new BaseCommon())->vae_is_installed()) {
            $data=$this->getConter();
            View::assign('data',$data);
            return View::fetch('pc/index');
        }
        else{
            header('Location:/install');
            exit;
        }


    }
    public function Category(){
        $data= Category::where(['level'=>1,"is_visible"=>1])->order('sort desc')->field('category_id,category_name,type,sort,category_pic,template,short_name')->select()->toArray();
        View::assign('category',$data);
    }
    public function getConfig(){
        $sys = SysConfig::where('type', 3)->field('desc,value,key')->select()->toArray();
        $res = [];
        foreach ($sys as $k => $v) {
            $key = $v['key'];
            $res[$key] = $v['value'];
        }
        View::assign('config',$res);
    }
    public function banner(){
        $data=BannerItem::where('banner_id',1)->select()->toArray();
        View::assign('banner',$data);
    }
    public function article_list($cid = '',$page=1,$limt=10)
    {
        $fl=Category::where('category_id', $cid)->find();
        if($fl['pid']!=0){
            //$cid=$fl['pid'];
            $data['left']['pcolumn'] = Category::where('category_id', $fl['pid'])->select()->toArray();
            $data['left']['column']= Category::where(['pid'=> $fl['pid'],'is_visible'=>1])->select()->toArray();
            $data['right']=$this->getList($cid,$page);
        }
        else{
            $data['left']['pcolumn'] = Category::where('category_id', $cid)->select()->toArray();
            $data['left']['column']= Category::where(['pid'=> $cid,'is_visible'=>1])->select()->toArray();
            $data['right']=$this->getList($cid,$page,$limt);
        }
        View::assign('list', $data);
        return View::fetch('pc/list_news');
    }
    public function pic_list($cid = '',$page=1,$limt=10)
    {
        $fl=Category::where('category_id', $cid)->find();
        if($fl['pid']!=0){
            //$cid=$fl['pid'];
            $data['left']['pcolumn'] = Category::where('category_id', $fl['pid'])->select()->toArray();
            $data['left']['column']= Category::where(['pid'=> $fl['pid'],'is_visible'=>1])->select()->toArray();
            $data['right']=$this->getList($cid,$page,$limt);
        }
        else{
            $data['left']['pcolumn'] = Category::where('category_id', $cid)->select()->toArray();
            $data['left']['column']= Category::where(['pid'=> $cid,'is_visible'=>1])->select()->toArray();
            $data['right']=$this->getList($cid,$page,$limt);
        }
        View::assign('list', $data);
        return View::fetch('pc/pic_list');
    }

    public function cover($cid = '')
    {
        $nav['pcolumn'] = Category::where('category_id', $cid)->select()->toArray();
        $nav['column']= Category::where(['pid'=> $cid,'is_visible'=>1])->select()->toArray();
        $cate = Category::where(['category_id' => $cid,"is_visible"=>1,'type'=>"cover"])->find();
        $cate['json']=json_decode($cate['json'],true);
        View::assign('cate',$cate);
        View::assign('nav',$nav);
        return View::fetch('pc/cover');
    }

    public function article($id)
    {
        $article= ArticleModel::where(['id'=>$id,'is_hidden'=>0])->find();
        $rlist=$this->getColumn($id);
        View::assign('rlist',$rlist);
        View::assign('article',$article);
        return View::fetch('pc/article');
    }
    //获取右侧内容页
    public function getList($cid,$page,$limt){
        $column= Category::where('category_id', $cid)->find();
        if(!$column){
            return $column;
        }
        if($column['type']=='cover'){
            return $column;
        }
        $data['info']=$column->toArray();
        $data['count']=Article::where(['is_hidden'=>0,'category_id'=>$cid])->count()/$limt;
        $data['list']=Article::where(['is_hidden'=>0,'category_id'=>$cid])->field('id,title,short_title,reading_volume,author,img_id,create_time')->limit(($page-1)*$limt,($page-1)*$limt+$limt)->select()->toArray();
        $data['page']=$page;
        return $data;

    }
    //获取首页中间部分
    public function getConter(){
        $Article=new Article();
        $res=[];
        $i=0;
        $data= Category::where(['is_pc_index'=>1,"is_visible"=>1])->order('sort desc')->field('category_id,category_name,type,category_pic,template,short_name,content')->select()->toArray();
        foreach ($data as $v){
            if($v['type']!='cover'){
                $a=$Article->where(['category_id'=>$v['category_id'],'is_index'=>1])->field('id,title,short_title,summary,img_id,author,source,create_time,reading_volume')->select()->toArray();
                $res[$i]=$v;
                $res[$i]['article']=$a;
            }
            else
                $res[$i]=$v;
            $i++;
        }
        return $res;
    }


    //根据文章id获取左侧栏目块
    public function getColumn($id){
        $category=new Category();
        $cid=ArticleModel::where(['id'=>$id,'is_hidden'=>0])->field('category_id')->find();
        $Articles=Article::where('category_id',$cid['category_id'])->select()->toArray();
        $data['article']=[];
        for ($i=0; $i<count($Articles);$i++){
            if($Articles[$i]['id']==$id)
            {
                if($i!=0){
                    $data['article']['previous']=$Articles[$i-1];
                }
                if($i!=count($Articles)-1){
                    $data['article']['next']=$Articles[$i+1];
                }
                break;
            }
        }
        $pid=$category->where('category_id',$cid['category_id'])->find();
        $data['pcolumn'] = $pid;
        $data['column']= $category->where(['pid'=> $pid['pid'],'is_visible'=>1])->select()->toArray();
        return $data;
    }

}