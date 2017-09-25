<?php
namespace Admin\Controller;
 

class IndexController extends BaseController {
/**
    * 系统主页
    */
    public function index(){
        /* 统计信息获取 */
        $this->user=M("user")->where("isShow=1")->count();
        $order1=M("direction_sale")->count();
        $order2=M("commission_sale")->count();
        $this->order=$order1+$order2;
        $num1=M("direction_sale")->sum("realNum");
        $num2=M("commission_sale")->sum("realNum");
        $this->num=$num1+$num2;
        $this->houseFruit=M("user_garden")->sum("houseFruit");
        // 默认获取30天内的数据
        $got = $this->select(1,1);
       // 更改返回数据的格式
        $data['date'] = json_encode(array_get_column($got, 'day'));
        $data['gotUser'] = json_encode(array_get_column($got, 'num'));
        $this->data = $data;
        $this->display();
    }

    /**
     * 列表示例
     */
    public function getData($status){
        $got = $this->select($status,1);
        // 更改返回数据的格式
        $dateArr = array(1=>'day', 2=>'month', '3'=>'year');
        $data['date'] = json_encode(array_get_column($got, $dateArr[$status]));
        $data['gotUser'] = json_encode(array_get_column($got, 'num'));
        $res = array('status'=>1, 'data'=>$data);
        $this->ajaxReturn($res);
    }

    public function select($dayStatus, $status){
        switch($status){
            case 1://玩家统计
                $sql="select count(*) as num,FROM_UNIXTIME(createTime, '%y年%m月%d日' ) as day, FROM_UNIXTIME(createTime, '%y年%m月' ) as month,FROM_UNIXTIME(createTime, '%y年' ) as year FROM farm_user where isShow=1";
                break;
            case 2://定向出售订单统计
                $sql="select sum(realNum) as totalNum,count(*) as num,FROM_UNIXTIME(createTime, '%y年%m月%d日' ) as day, FROM_UNIXTIME(createTime, '%y年%m月' ) as month,FROM_UNIXTIME(createTime, '%y年' ) as year FROM farm_direction_sale where 1=1";
                break;
            case 3://委托出售订单统计
                $sql="select sum(realNum) as totalNum,count(*) as num,FROM_UNIXTIME(createTime, '%y年%m月%d日' ) as day, FROM_UNIXTIME(createTime, '%y年%m月' ) as month,FROM_UNIXTIME(createTime, '%y年' ) as year FROM farm_commission_sale where 1=1";
                break;
        }
        switch($dayStatus){
            case 2:
                $now = time();
                $str = date('Y-m-d');
                $ago = strtotime($str.' -12 month');
                $sql .= ' and createTime BETWEEN ' . $ago . ' and '.$now;
                $sql .= ' GROUP BY month';
                $sql .= ' ORDER BY month';
                break;
            case 3:
                $sql .= ' GROUP BY year';
                $sql .= ' ORDER BY year';
                break;
            default:
                $now = time();
                $str = date('Y-m-d');
                $ago = strtotime($str.' -30 day');
                $sql .= ' and createTime BETWEEN ' . $ago . ' and '.$now;
                $sql .= ' GROUP BY day';
                $sql .= ' ORDER BY day';
        }

        $Model = new \Think\Model();
        $results =  $Model->query($sql);
        return $results;
    }
}