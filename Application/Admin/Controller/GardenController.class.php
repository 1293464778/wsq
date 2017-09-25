<?php
/**
 * Created by PhpStorm.
 * User: xiaolei
 * Date: 2017/3/10
 * Time: 14:27
 */

namespace Admin\Controller;


class GardenController extends BaseController
{
    public $db;
    public function __construct()
    {
        parent::__construct();
        $this->db=M("user_garden");
    }
    public function index(){
//        $where['isShow']=array('eq',1);
//        $total_num=$this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where($where)->count();
        if (!IS_AJAX) {
//            $this->page_num=ceil($total_num/50);
            $this->display();
            return ;
        }

        // AJAX请求
        //搜索
        $search = I('search', '');
        $where['isShow']=array('eq',1);
        if (!empty($search['value'])) {
            $searchStr = html_entity_decode($search['value']);
            parse_str($searchStr,$search);
            $num = $search['num'];
            if ($num != '') {
                $where['userName'] = array('like', '%'.$num.'%');
            }
            $level=$search['level'];
            if($level!=0){
                $where['level']=array('eq',$level);
            }
        }
        $draw = I('draw',1,'intval');
        $start = I('start',0,'intval');
        $length = I('length',10,'intval');
        //排序设置
        $mycolumns = I('mycolumns','');
        $myorder = I('order','');
        $order='';
        if (empty($myorder) || empty($mycolumns)) {
            $order = 'id desc';
        } else {
            foreach ($myorder as $key => $v) {
                $order .= $mycolumns[$v['column']].' '.$v['dir'].' ,';
            }
            $order = rtrim($order , ',');
        }
        $level=array('贫农','中农','中上农','富农','农场主','庄园主','地产主');
//        var_dump($where);
        $lists = $this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where($where)->limit($start,$length)->order($order)->field("farm_user_garden.*,u.userName,u.level,u.friendNum")->select();
        foreach($lists as $k=>$v){
            $i=$v['level']-1;
            $lists[$k]['level']=$level[$i];
        }

        $result['draw'] = $draw;
        $result['recordsTotal'] = $this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where($where)->count();
        $result['recordsFiltered'] = $this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where($where)->count();
        $result['data'] = $lists;

        $this->ajaxReturn($result);
    }

    /**
     * @param $id 果园id
     * 编辑果园
     */
    public function edit($id){
        $garden=$this->db->where("id=$id")->find();
        $this->data=$garden;
        $this->display();
    }

    /**
     * 编辑保存
     */
    public function save(){
        $data=I("post.");
        $res=$this->db->save($data);
        if ($res === false) {
            $this->wrong('编辑失败');
        }
        $this->ok('编辑成功');
    }
    /**
     * 衰减率配置
     */
    public function sys(){
        $this->data=M("config")->where("type=5")->order("id asc")->select();
        $this->display();
    }
    /**
     * 添加衰减率配置
     */
    public function addSys(){
        $data=I("post.");
        if($data){
            $data['type']=5;//类型
            $res=M("config")->add($data);
            if ($res === false) {
                $this->wrong('添加失败');
            }
            $this->ok('添加成功');
        }else{
            $this->display();
        }
    }
    /**
     * 编辑衰减率配置
     */
    public function editSys(){
        if(IS_POST){
            $data=I("post.");
            $res=M("config")->save($data);
            if ($res === false) {
                $this->wrong('编辑失败');
            }
            $this->ok('编辑成功');
        }else{
            $id=I("get.id");
            $this->data=M("config")->where("id=$id")->find();
            $this->display();
        }
    }
    /**
     * 删除衰减率配置
     */
    public function delSys($id){
        $res=M("config")->delete($id);
        if ($res === false) {
            $this->error('删除失败');
        }
        $this->success('删除成功');
    }
    /**
     * 计算每个果园的今日收益率
     */
    public function todayProfit(){
        $model=M();
        $i=I("post.i");
        $admin=session('admin_auth');
        $admin_id=$admin['uid'];
        $start_time=strtotime(date('Y-m-d'));
        $end_time=$start_time+24*3600;
        $where['clickTime']=array(array('gt',$start_time),array('lt',$end_time));
        $commit_profit=M("commit_profit");
        if($data=$commit_profit->where($where)->find()){
            $this->ok("今天收益已发放");
            return false;
        }
        $config=M("config");
        $dog_fee=$config->where("id=16")->getField("value");
        $scarecrow_fee=$config->where("id=17")->getField("value");
        $sys_fee=$config->where("id=13")->getField("value");
        $level_fee=$config->where("type=1")->order("id asc")->select();
        $decay=$config->where("type=5")->order("id asc")->select();
        $garden=$this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where("isShow=1")->order("farm_user_garden.id asc")->limit($i,50)->select();
        $count=$this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where("isShow=1")->order("farm_user_garden.id asc")->limit($i,50)->count();


        $user_profit=M("user_profit");
        $user_land=M("user_land");
        $model->startTrans();
        foreach($garden as $k=>$v){
            $dog=$v['dog'];
            $scarecrow=$v['scarecrow'];
            $fruitNum=$user_land->where("userId=".$v['userId'])->sum("fruitNum");
            $decay_fee=getDecay($decay,$fruitNum,$v['landNum']);
            $profit=$sys_fee+$dog_fee*$dog+$scarecrow_fee*$scarecrow+$level_fee[$v['level']-1]['value']-$decay_fee;//每天的收益率
            $map['userId']=array("eq",$v['userId']);
            $map['dateTime']=array(array('gt',$start_time),array('lt',$end_time));
            if($user_profit1=$user_profit->where($map)->find()){
            }else{
                //2、计算用户土地增长量
                $res1=$this->landProfit($v['userId'],$profit);
                if($res1){

                }else{
                    $model->rollback();
                    $this->wrong(($i*50+$k)."计算失败1");
                }
            }
        }
        $res2=$commit_profit->add(array('adminId'=>$admin_id,'clickTime'=>time()));
        if(!$res2){
            $model->rollback();
            $this->wrong("计算失败2");
        }else{
            $model->commit();

            $str=($count+$i*50).'条数据计算完毕';
            $this->ok($str);
        }

    }
    /**
     * 计算用户土地增长量
     */
    public function landProfit($uid,$profit){
        $db=M("user_land");
        $land=$db->where("userId=$uid")->order("id asc")->select();
        $total_add=0;
        $fee=M("config")->where("id=15")->getField("value");
        $ordinary=M("config")->where("id=8")->getField('value');
        $notordinary=M("config")->where("id=9")->getField('value');
        foreach($land as $k=>$v){
            $addNum=$v['fruitNum']*$profit;
            //判断是否增益  若达到基数的4倍不会收益
            if($v['landId']<11){
                if($fee*$ordinary<=($v['fruitNum']+$addNum)){
                    $addNum=$fee*$ordinary-$v['fruitNum'];
                }
            }else{
                if($fee*$notordinary<=($v['fruitNum']+$addNum)){
                    $addNum=$fee*$notordinary-$v['fruitNum'];
                }
            }
            if($addNum<0){
                $addNum=0;
            }
            $total_add+=$addNum;
            //增加每块土地的增长量
            $res1=1;$res2=1;
            if($addNum>0){
                $res1=$db->where("id=".$v['id'])->setInc('fruitNum',$addNum);
                $res2=$db->where("id=".$v['id'])->setInc('totalNum',$addNum);
            }

            if($res1&&$res2){

            }else{
                return false;
            }
        }
        //果园总量、生长总量相应增加
        $res3=1;$res4=1;
        if($total_add>0){
            $res3=M("user_garden")->where("userId=".$uid)->setInc('totalNum',$total_add);
            $res4=M("user_garden")->where("userId=".$uid)->setInc('totalGrow',$total_add);
        }

        //插入每天的收益表
        $res5=M("user_profit")->add(array('userId'=>$uid,'profitRate'=>$profit,'profitNum'=>$total_add,'dateTime'=>time()));
        if($res3&&$res4&&$res5){
            return true;
        }else{
            return false;
        }
    }
    /**
     * @param $id 用户id
     * 查看用户果园
     */
    public function land($id){
        $data=M("user_land")->where("userId=$id")->order("id asc")->select();
        $this->data=$data;
        $this->display();
    }
    public function statis(){
        layout(false);
        $where['isShow']=array('eq',1);
        $total_num=$this->db->join("farm_user as u on u.id=farm_user_garden.userId")->where($where)->count();
        $this->page_num=ceil($total_num/50);
        $this->display();
    }
}