<?php


namespace app\controller\cms;


use app\model\AuthGroupAccess;
use ruhua\exceptions\BaseException;
use app\model\Admins as AdminsModel;
use app\service\CmsTokenService;
use app\service\TokenService;
use app\validate\AdminsValidate;
use app\validate\IDPostiveInt;
use app\validate\LoginValidate;
use app\validate\PassWordValidate;
use ruhua\bases\BaseController;
use think\facade\Db;
use think\facade\Log;
use Uedit\controller as Contro;

class Admins extends BaseController
{
    //获取所有管理员
    public function getAdmin_all()
    {
        $data=AdminsModel::select()->toArray();
        return app('json')->go($data);
    }

    //注册管理员
    public function add_admin()
    {
        (new AdminsValidate)->goCheck();
        $data=AdminsModel::createAdmin(input('post.'));
        return app('json')->go($data);
    }

    //删除管理员
    public function del_admin($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=AdminsModel::deleteAdmin($id);
        return app('json')->go($data);
    }

    //更新管理员信息
    public function up_admin($form)
    {
        $data=AdminsModel::updateAdmin($form);
        if($form['gid'])
            AuthGroupAccess::update(['group_id'=>$form['gid']],['aid'=>$form['id']]);
        return app('json')->go($data);
    }
    //登陆
    public function login($username='',$password='')
    {
        (new LoginValidate)->goCheck();
        $res = (new CmsTokenService)->loginService($username,$password);
        return app('json')->go($res);
    }

    //检查是否登陆
    public function check_login()
    {
        $res = TokenService::getCurrentAid();
        if($res){
            return app('json')->success('已登陆');
        }else{
            return app('json')->fail('你没有登录');
        }
    }

    //修改密码
    public function updatePassWord()
    {
        (new PassWordValidate)->goCheck();
        $post=input('post.');
        $aid = TokenService::getCurrentAid();
        $admin=AdminsModel::where('id',$aid)->find();
        if (!$aid){
            throw new BaseException(['msg'=>'用户信息错误']);
        }
        if($admin['password'] != password($post['old_password'])){
            throw new BaseException(['msg'=>'原密码错误']);
        }
        if($post['password']!=$post['password2'])
            throw new BaseException(['msg'=>'两次密码不一致']);
        $admin['password']=password($post['password']);
        $res = $admin->save();
        if(!$res){
            throw new BaseException(['msg'=>'修改密码失败']);
        }
        return app('json')->success();
    }

    //更新不同模型的布尔字段
    public function on_off($id,$db,$field)
    {
        switch ($db)
        {
            case 'article':
                $where['id']=$id; break;
            case 'admins':
                $where['id']=$id; break;
            case 'category':
                $where['category_id']=$id; break;
            case 'sys_config':
                $where['id']=$id; break;
            default:
                throw new BaseException(['msg'=>'找不到模型']);
        }
        if($db!='sys_config')
        {
            $vs=Db::name($db)->where($where)->value($field);
            if($vs == 0 ){
                $res = Db::name($db)->where($where)->update([$field=>1]);
                Log::error($res);
            }else{
                $res =  Db::name($db)->where($where)->update([$field=>0]);
            }
        }
        else
        {
            $vs=Db::name($db)->where($where)->value($field);
            if($vs == 0 ){
                $res = Db::name($db)->where($where)->update([$field=>1]);
            }else{
                $res =  Db::name($db)->where($where)->update([$field=>0]);
            }
        }
        return app('json')->go($res);
    }

    /**
     *
     * @return mixed
     */
    public function ue_uploads()
    {
        $ue = new Contro;
        $res = $ue->show();
        return $res;
    }

}