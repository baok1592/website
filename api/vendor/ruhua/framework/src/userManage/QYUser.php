<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/10/17 0017
 * Time: 9:03
 */

namespace ruhua\API\userManage;


use Aliyun\api_demo\SmsDemo;
use ruhua\API\userManage\Gzh;
use ruhua\API\userManage\Xcx;
use ruhua\model\SysConfig;
use ruhua\model\User as UserModel;
use ruhua\services\TokenService;
use ruhua\exceptions\BaseException;
use think\exception\ValidateException;
use think\facade\Cache;
use think\Validate;
use WxCode\demoWxCode;

class QYUser
{
    /**
     * 模拟用户登录获取TOKEN
     * @return mixed
     */
    public function userLogin()
    {
        return (new TokenService())->saveCache(['uid' => 15,'openid' => 'oq_jb4mLWx97WOEn7x38yM0YkFhs']);
    }
    
    /**
     * 获取用户基础信息
     */
    public function getInfo()
    {
        $uid = TokenService::getCurrentUid();
        $res=UserModel::field('id,nickname,headpic,mobile',true)->find($uid);
        return $res;
    }

    /**
     * 微信授权绑定手机号
     * @return mixed
     */
    public function getWxMobile($post){
        $this->validate($post,['encryptedData'=>'require','iv'=>'require']);
        $uid=TokenService::getCurrentUid();
        return UserModel::addWxMobile($uid,$post);
    }
    //绑定手机
    public function bind_phone($post)
    {
        $this->validate($post,['code'=>'require','mobile'=>'require|length:11']);
        $uid = TokenService::getCurrentUid();
        $res = UserModel::bindMobile($uid,$post['mobile'],$post['code']);
        return $res;
    }
    //获取验证码
    public function getYzm($post)
    {
        $yzm_tmp_id=SysConfig::where('key','yzm_tmp_id')->value('value');
        if(!$yzm_tmp_id){
            throw new BaseException(['msg'=>"未配置短信接口"]);
        }
        $this->validate($post,['mobile'=>'require|length:11']);
        TokenService::getCurrentUid();
        $code = rand(10000, 999999);
        $time = time() + (60 * 5);
        Cache::set($post['mobile'],$code,$time);
        SmsDemo::sendSms($post['mobile'],$code,$yzm_tmp_id);
        return true;
    }

    /**
     * 手机登录获取token
     * @return string
     */
    public function getMobileToken($post)
    {
        if (app('system')->getValue('merge_mode') == 3) {
            $this->validate($post, ['mobile' => 'require|length:11','code'=>'require']);
            $cache_code=Cache::get($post['mobile']);
            if ($cache_code!=$post['code']) {
                throw new BaseException(['msg'=>'验证码错误']);
            }
            $res=UserModel::where('mobile',$post['mobile'])->find();
            $token = (new TokenService())->saveCache($res);
            $data['token']=$token;
            return $data;
        } else {
            throw new BaseException(['msg'=>'未开启手机登录']);
        }
    }
    //小程序登录获取token
    public function getXcxToken($code)
    {
        $usertoken = new Xcx($code);
        return $usertoken->getToken();
    }
    //小程序更新头像
    public function xcx_upinfo($nickname, $headpic, $keys, $iv)
    {
        $uid = TokenService::getCurrentUid();
        $session_key = TokenService::getCurrentTokenVar('session_key');
        $nickname = base64_encode($nickname);
        $user = UserModel::where('id', $uid)->find();
        $mergeMode = app('system')->getValue('merge_mode');
        if (!$user['unionid'] && $mergeMode == 1) {
            $unionid = (new demoWxCode())->getUnionId($keys, $iv, $session_key);
            if ($unionid < 0) {
            } else {
                $data['unionid'] = $unionid;
            }

        }
        $data['nickname'] = $nickname;
        $data['headpic'] = $headpic;
        $user->save($data);
        return $user;
    }

    /********************  微信 + 小程序 共用  ************************/
    //验证token，返回false,true
    public function verifyToken($token)
    {
        if (!$token) {
            throw new BaseException(['msg' => 'token不允许为空']);
        }
        $valid = TokenService::verifyToken($token);
        $arr = ['isValid' => $valid];
        return $arr;
    }
    //修改绑定的手机号
    public function editMobile($post){
        $this->validate($post,['code'=>'require','mobile'=>'require|length:11']);
        $uid = TokenService::getCurrentUid();
        $res = UserModel::editMobile($uid,$post['mobile'],$post['code']);
        return $res;
    }
    //验证验证码是否正确
    public function verifyYzm($post){
        $cache_code=Cache::get($post['mobile']);
        if ($cache_code != $post['code']) {
            throw new BaseException(['msg'=> '验证码错误']);
        }
        return true;
    }
    /********************  公众号  ************************/
    //请求公众号code
    public function wxcodeUrl($url, $type = '')
    {
        $gzh_service = new Gzh();
        $res = $gzh_service->getCodeUrl($url, $type);
        return $res;
    }

    public function getToken($code)
    {
        $usertoken = new Gzh;
        $token = $usertoken->getToken($code);
        $data = ['token' => $token];
        return $data;
    }
    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;
    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate(array $data, $validate, array $message = [], bool $batch = false)
    {


        if (is_array($validate)) {
            $v = new Validate();
            $v->rule($validate);
        } else {
            if (strpos($validate, '.')) {
                // 支持场景
                list($validate, $scene) = explode('.', $validate);
            }
            $class = false !== strpos($validate, '\\') ? $validate : $this->app->parseClass('validate', $validate);
            $v     = new $class();
            if (!empty($scene)) {
                $v->scene($scene);
            }
        }
        $v->message($message);


        // 是否批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        $result=$v->check($data);
        if (!$result){

            throw new BaseException(['msg' => $v->getError()]);
        }else{
            return true;
        }
    }

}