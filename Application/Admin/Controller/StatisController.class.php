<?php
/**
 * Created by PhpStorm.
 * User: xiaolei
 * Date: 2017/3/14
 * Time: 10:58
 */

namespace Admin\Controller;


class StatisController extends BaseController
{
    /**
     * 定向订单统计
     */
    public function index(){
        $base=new IndexController();
        $got = $base->select(1,2);
        // 更改返回数据的格式
        $data['date'] = json_encode(array_get_column($got, 'day'));
        $data['gotNum'] = json_encode(array_get_column($got, 'num'));
        $data['gotTotal'] = json_encode(array_get_column($got, 'totalNum'));
        $this->data = $data;
        $this->display();
    }
    public function getDirection($status){
        $base=new IndexController();
        $got = $base->select($status,2);
        // 更改返回数据的格式
        $dateArr = array(1=>'day', 2=>'month', '3'=>'year');
        $data['date'] = json_encode(array_get_column($got, $dateArr[$status]));
        $data['gotNum'] = json_encode(array_get_column($got, 'num'));
        $data['gotTotal'] = json_encode(array_get_column($got, 'totalNum'));
        $res = array('status'=>1, 'data'=>$data);
        $this->ajaxReturn($res);
    }
    /**
     * 委托订单统计
     */
    public function commission(){
        $base=new IndexController();
        $got = $base->select(1,3);
        // 更改返回数据的格式
        $data['date'] = json_encode(array_get_column($got, 'day'));
        $data['gotNum'] = json_encode(array_get_column($got, 'num'));
        $data['gotTotal'] = json_encode(array_get_column($got, 'totalNum'));
        $this->data = $data;
        $this->display();
    }
    public function getCommission($status){
        $base=new IndexController();
        $got = $base->select($status,3);
        // 更改返回数据的格式
        $dateArr = array(1=>'day', 2=>'month', '3'=>'year');
        $data['date'] = json_encode(array_get_column($got, $dateArr[$status]));
        $data['gotNum'] = json_encode(array_get_column($got, 'num'));
        $data['gotTotal'] = json_encode(array_get_column($got, 'totalNum'));
        $res = array('status'=>1, 'data'=>$data);
        $this->ajaxReturn($res);
    }
}