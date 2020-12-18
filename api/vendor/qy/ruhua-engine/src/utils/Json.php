<?php

namespace ruhua\utils;

use think\Response;

class Json
{
    private $code = 200;    //明显是http状态的code，而非status

    public function code(int $code): self
    {
        $this->code = $code;
        return $this;
    }

    //创建响应
    public function make(int $status, string $msg, $data = null): Response
    {
        $res = compact('status', 'msg');
        //if (!is_null($data)){ }
        $res['data'] = $data;

        return Response::create($res, 'json', $this->code);
    }

    public function go($data): Response
    {
        if(is_array($data)){
            return $this->success('操作成功', $data);
        }
        if (is_string($data) || !$data) {
            return $this->fail('操作失败');
        } else{
            return $this->success('操作成功', $data);
        }
    }

    //操作成功
    public function success($obj = '操作成功', $data = 1): Response
    {
        if (!is_string($obj) || is_numeric($obj)) {
            $data = $obj;
            $obj = '操作成功';
        }
        return $this->make(200, $obj, $data);
    }

    //操作错误
    public function fail($msg = '操作失败', $data = null): Response
    {
        if (is_array($msg)) {
            $data = $msg;
            $msg = '操作失败';
        }

        return $this->make(400, $msg, $data);
    }

    //权限错误
    public function auth_err($msg = '权限错误', $data = null): Response
    {
        $this->code = 401;
        if (is_array($msg)) {
            $data = $msg;
            $msg = 'ok';
        }

        return $this->make(400, $msg, $data);
    }

}