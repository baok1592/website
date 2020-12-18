<?php


namespace app\service;


use app\model\Admins as AdminsModel;
use app\model\AuthRule;
use think\facade\Cache;
use think\facade\Request;

class GroupService
{
    /**
     * 检查是否有权限
     * @param $id
     * @return bool
     */
    public function checkRule($id)
    {
        $rule = $this->getGroupRule();//获取缓存规则数据
        $rule = explode(',', $rule);
        $admin = AdminsModel::with(['groups'])->where('id', $id)->find();
        if (!$admin) {
            return false;
        }
        $con = Request::controller();
        $con = str_ireplace('cms.', '', $con);
        $action = Request::action();
        $action = $con . '/' . $action;
        if (!in_array($con, $rule) && !in_array($action, $rule)) {
            return true;
        }
        $admin_rule = explode(',', $admin['groups']['oauth']);
        if (!$admin_rule[0]) {
            return false;
        }
        $group = new AuthRule();
        foreach ($admin_rule as $k => $v) {
            $name = $group->where('id', $v)->value('name');
            if ($v == 1) {
                $name = explode(',', $name);
                if (in_array($con, $name)) {
                    return true;
                }
            }
            if ($con == $name) {
                return true;
            }
            if ($action == $name) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取权限规则
     * @return mixed|string
     */
    private function getGroupRule()
    {
        $res = Cache::get('AuthRule');
        if (!$res) {
            $str = '';
            $rule = AuthRule::select();
            foreach ($rule as $k => $v) {
                if ($v['id'] == 1) {
                    $str = $v['name'];
                } else {
                    $str = $str . ',' . $v['name'];
                }
            }
            Cache::set('AuthRule', $str);
            $res = $str;
        }
        return $res;
    }
}