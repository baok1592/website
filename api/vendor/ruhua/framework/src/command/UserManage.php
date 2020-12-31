<?php
declare (strict_types = 1);

namespace ruhua\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\facade\Console;
use think\facade\Db;

class UserManage extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('usermange')
            ->setDescription('一键创建用户管理');
    }

    protected function execute(Input $input, Output $output)
    {
        //copy(__DIR__. '\..\data\User.php',__DIR__.'/../../../../../app/controller/User.php');
        if(file_exists(__DIR__.'/../../../../../app/controller/User.php')){
            $output->writeln('文件已经存在');
        }
        else {
            if (Db::name('sys_config')->select()) {
                copy(__DIR__ . '\..\data\Pay.php', __DIR__ . '/../../../../../app/controller/Pay.php');
                $output->writeln('支付演示');
            }
            else {
                $vaethink_sql = file_get_contents(__DIR__ . '\..\data\rh.sql');
                $sql_array = preg_split("/;[\r\n]+/", $vaethink_sql);
                foreach ($sql_array as $k => $v) {
                    if (!empty($v)) {
                        Db::execute($v);
                    }
                }
                if (Db::name('sys_config')->select()) {
                    copy(__DIR__ . '\..\data\User.php', __DIR__ . '/../../../../../app/controller/User.php');
                    $output->writeln('一键创建用户管理');
                } else
                    $output->writeln('导入数据表错误');
            }
        }
    }
}
