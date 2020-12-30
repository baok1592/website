<?php
declare (strict_types = 1);

namespace ruhua\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\facade\Config;
use think\facade\Console;
use think\facade\Db;
use think\facade\Env;
use think\facade\Log;

class CreateModel extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('createmodel')
            ->setDescription('the createmodel command');        
    }

    protected function execute(Input $input, Output $output)
    {
        $f=Config::get('database.connections.mysql.prefix');
        $tables=Db::query("show tables");
        $databases=Config::get('database.connections.mysql.database');
        $tb_name="Tables_in_$databases";
        foreach ($tables as $item){
            $a=ucwords(str_ireplace('_',' ',$item[$tb_name]));//去掉表名下横线和把单词首字母大写
            $b=substr($a,strlen($f));//去掉表前缀
            $d=str_ireplace(' ','',$b);//去掉空格
//            if(!file_exists(__DIR__.'/../app/model/'.$d.'.php'))
//            {
//                Console::call('make:model',[$d]);
//            }
            Console::call('make:model',[$d]);//调用tp内部命令
        }
        // 指令输出
    	$output->writeln('一键创建模型成功');
    }
}
