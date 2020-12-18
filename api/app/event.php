<?php
// 事件定义文件
return [

    'listen' => [
        'AppInit' => ['app\\behavior\\CORS'],
        'HttpRun' => [],
        'HttpEnd' => [],
        'LogLevel' => [],
        'LogWrite' => [],
    ],
];
