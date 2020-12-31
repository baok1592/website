<?php


namespace ruhua\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\facade\Console;
use think\facade\Db;

class PayDemo extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('paydemo')
            ->setDescription('创建支付演示');
    }

    protected function execute(Input $input, Output $output)
    {
        if(file_exists(__DIR__.'/../../../../../app/controller/Pay.php')){
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
                    copy(__DIR__ . '\..\data\Pay.php', __DIR__ . '/../../../../../app/controller/Pay.php');
                    $output->writeln('支付演示');
                } else
                    $output->writeln('导入数据表错误');
            }
        }
    }

}