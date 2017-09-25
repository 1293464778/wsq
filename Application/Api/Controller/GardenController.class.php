<?php
/**
 * Created by PhpStorm.
 * User: xiaolei
 * Date: 2017/3/16
 * Time: 16:01
 */

namespace Api\Controller;
use Common\Util\AuthUtil;
use Common\CommonConstant;

class GardenController extends BaseController
{
    public $user;
    public $db;
    public $fee;
    public $ordinary;
    public $notordinary;
    public function __construct()
    {
        parent::__construct();
        //用户身份验证
        $result = AuthUtil::checkIdentity();
        if (!$result['status']){
            ajax_return_error(null,$result['code']);
        }
        $this->user=session(C("SESSION_NAME_CUR_HOME"));
        $this->db=M("user_garden");
        $this->fee=M("config")->where("id=15")->getField("value"); //果实不生长的基数
        $this->ordinary=M("config")->where("id=8")->getField('value'); //普通土地果实的基数
        $this->notordinary=M("config")->where("id=9")->getField('value'); //金土地果实的基数
    }
    /**
     * 获取果树基数
     */
    public function getFee(){

    }

    /**
     * 获取果园信息
     */
    public function index(){
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
        }

        $start_time=strtotime(date('Y-m-d'));
        $end_time=$start_time+24*3600;


        //系统派送化肥
        //判断该用户今天是否领取过
        $is_get=M("fertilizer")->where("userId=$uid and dateTime>=$start_time and dateTime<=$end_time")->find();
        if(!$is_get){
            $this->getAddFertilizer($uid);
        }
        
        $garden=$this->db->where("userId=".$uid)->find();
        $level=M("user")->where("id=$uid")->find();
        $garden['level']=$level['level'];
        $garden['friendNum']=$level['friendNum'];
        $user_land=M("user_land")->where("userId=$uid")->order("id asc")->select();
        $garden['ord_fee']=$this->getConfig(8);
        $garden['gold_fee']=$this->getConfig(9);
        $garden['full_fee']=$this->getConfig(15);
        foreach($user_land as $k=>$v){
            $total_num=$v['totalNum'];
            if($v['landId']<11){
                if($total_num<$garden['ord_fee']*$garden['full_fee']){
                    $user_land[$k]['is_full']=0;//未达到生长极限
                }else{
                    $user_land[$k]['is_full']=1;//达到生长极限
                }
            }else{
                if($total_num<$garden['gold_fee']*$garden['full_fee']){
                    $user_land[$k]['is_full']=0;//未达到生长极限
                }else{
                    $user_land[$k]['is_full']=1;//达到生长极限
                }
            }
        }
        $garden['user_land']=$user_land;
        ajax_return_ok($garden);
    }
    /**
     * 计算用户土地增长量
     */
    public function landProfit($uid,$profit){
//        $model=M();
//        $model->startTrans();
        $db=M("user_land");
        $land=$db->where("userId=$uid")->order("id asc")->select();
        $total_add=0;
        $fee=$this->fee;
        $ordinary=$this->ordinary;
        $notordinary=$this->notordinary;
        foreach($land as $k=>$v){
            $addNum=$v['fruitNum']*$profit;
            //判断是否增益  若达到基数的4倍不会收益
            if($v['landId']<11){
                if($fee*$ordinary<=($v['totalNum']+$addNum)){
                    $addNum=$fee*$ordinary-$v['totalNum'];
                }
            }else{
                if($fee*$notordinary<=($v['totalNum']+$addNum)){
                    $addNum=$fee*$notordinary-$v['totalNum'];
                }
            }
            if($addNum<0){
                $addNum=0;
            }
            $total_add+=$addNum;
            //增加每块土地的增长量
            if($addNum>0){
                $res4=$db->where("id=".$v['id'])->setInc('fruitNum',$addNum);
                $res5=$db->where("id=".$v['id'])->setInc('totalNum',$addNum);
            }else{
                $res4=1;$res5=1;
            }

            if(!$res4||!$res5){
//                $model->rollback();
                return false;
            }
        }
        //果园总量、生长总量相应增加
        if($total_add>0){
            $res2=M("user_garden")->where("userId=".$uid)->setInc('totalGrow',$total_add);
            $res1=M("user_garden")->where("userId=".$uid)->setInc('totalNum',$total_add);

        }else{
            $res1=1;$res2=1;
        }
        //插入每天的收益表
        $res3=M("user_profit")->add(array('userId'=>$uid,'profitRate'=>$profit,'profitNum'=>$total_add,'dateTime'=>time()));
        if($res1&&$res2&&$res3){
//            $model->commit();
            return true;
        }else{
//            $model->rollback();
            return false;
        }
    }
    /**
     * 开垦
     */
    public function open(){
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
//            $uid=4;
        }
        $garden=$this->db->where("userId=$uid")->find();
        if($garden['landNum']<10){
            $pay_fruit=$this->getConfig(8);
        }else{
            $pay_fruit=$this->getConfig(9);
        }
        if($pay_fruit>$garden['houseFruit']){
            ajax_return_error("你的仓库果实数量不足");
        }else{
            $model=M();
            $model->startTrans();
            //1 扣掉仓库的果实
            $res1=$this->db->where("userId=$uid")->setDec('houseFruit',$pay_fruit);
            //2 加入一块土地
            $res2=M("user_land")->add(array('userId'=>$uid,'landId'=>$garden['landNum']+1,'fruitNum'=>$pay_fruit,'totalNum'=>$pay_fruit,'createTime'=>time(),'updateTime'=>time()));
            //3 增加土地数量
            $res3=$this->db->where("userId=$uid")->setInc('landNum',1);
            //4 增加果园总量  生长总量
            $res4=$this->db->where("userId=$uid")->setInc('totalNum',$pay_fruit);
            $res5=$this->db->where("userId=$uid")->setInc('totalGrow',$pay_fruit);
            //5  根据土地数量 是否增加等级
            if($garden['landNum']>=9){
                //获取用户当前的等级
                $level=M("user")->where("id=$uid")->getField("level");
                if($level+8>=$garden['landNum']+1){
                    $res6=1;
                }else{
                    $res6=M("user")->where("id=$uid")->setInc("level",1);
                }

            }else{
                $res6=1;
            }
            if($res1&&$res2&&$res3&&$res4&&$res5&&$res6){
                $model->commit();
                ajax_return_ok('',"开垦成功");
            }else{
                $model->rollback();
                ajax_return_error("开垦失败");
            }
        }
    }
    /**
     * 播种  植果
     */
    public function sow(){
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
//            $uid=4;
        }
        $land_id=I("post.land_id");//土地编号
        $fruit_num=I("post.fruit_num");//植果数量
        if(empty($land_id)){
            ajax_return_error("土地编号参数为空");
        }
        if(empty($fruit_num)){
            ajax_return_error("植果数量不能为空");
        }
        $garden=$this->db->where("userId=$uid")->find();
        $fee=$this->fee;
        $ordinary=$this->ordinary;
        $notordinary=$this->notordinary;
        if($fruit_num>$garden['houseFruit']){
            ajax_return_error("你的仓库果实数量不足");
        }else{
            $user_land=M("user_land")->where("userId=$uid and landId=$land_id")->find();
            if($land_id<11){
                if($fee*$ordinary<=$user_land['totalNum']+$fruit_num){
                    $fruit_num=$fee*$ordinary-$user_land['totalNum'];
                }
            }else{
                if($fee*$notordinary<=$user_land['totalNum']+$fruit_num){
                    $fruit_num=$fee*$notordinary-$user_land['totalNum'];
                }
            }
            if($fruit_num<=0){
                ajax_return_error("该果树已达到生长上限");
            }
            $model=M();
            $model->startTrans();
            //1  扣掉仓库果实数量
            $res1=$this->db->where("userId=$uid")->setDec("houseFruit",$fruit_num);
            //2  加上植果数量
            $res2=M("user_land")->where("id=".$user_land['id'])->setInc('fruitNum',$fruit_num);
//            $res3=M("user_land")->where("id=".$user_land['id'])->setInc('totalNum',$fruit_num);
            //3 果园总量  生长总量增加
            $res4=$this->db->where("userId=$uid")->setInc('totalNum',$fruit_num);
//            $res5=$this->db->where("userId=$uid")->setInc('totalGrow',$fruit_num);
            if($res1&&$res2&&$res4){
                $model->commit();
                ajax_return_ok('',"植果成功");
            }else{
                $model->rollback();
                ajax_return_error("植果失败");
            }
        }
    }
    /**
     * 增加果实收益
     */
    public function add_profit($uid){
        //计算用户今天的收益
        $start_time=strtotime(date('Y-m-d'));
        $end_time=$start_time+24*3600;
        $garden1=$this->db->where("userId=".$uid)->find();
        $level=M("user")->where("id=$uid")->find();
        $map['userId']=array("eq",$garden1['userId']);
        $map['dateTime']=array(array('gt',$start_time),array('lt',$end_time));
        if($user_profit1=M("user_profit")->where($map)->find()){
            return true;
        }else{
            $config=M("config");
            $dog_fee=$this->getConfig(16);
            $scarecrow_fee=$this->getConfig(17);
//            $sys_fee=$this->getConfig(13);
            $level_fee=$config->where("type=1")->order("id asc")->select();
            $decay=$config->where("type=5")->order("id asc")->select();
            $dog=$garden1['dog'];
            $scarecrow=$garden1['scarecrow'];
            $decay_fee=getDecay($decay,$garden1['totalGrow'],$garden1['landNum']);
            $profit=$dog_fee*$dog+$scarecrow_fee*$scarecrow+$level_fee[$level['level']-1]['value']-$decay_fee;//每天的收益率
            //2、计算用户土地增长量
            return $this->landProfit($uid,$profit);
        }
    }
    /**
     * 施肥
     */
    public function fertilize(){
        $fee=$this->fee;
        $ordinary=$this->ordinary;
        $notordinary=$this->notordinary;
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
//            $uid=4;
        }

        //施肥增加
        $garden=$this->db->where("userId=$uid")->find();
        if($garden['landNum']<=0){
            ajax_return_error("请先去开垦土地");
        }
        $dog=$garden['dog'];
        $totalFertilizer=$garden['totalFertilizer'];//化肥总量
        if($totalFertilizer<=0){
            ajax_return_error("你的化肥数量不足");
        }
        $do_fee=M("config")->where("id=12")->getField('value');
        $add=round($totalFertilizer*$do_fee,2);
        $user_land=M("user_land")->where("userId=$uid")->order("id asc")->select();

        $real_total_add=0;//实际增加的果实收益
        //循环施肥
        $model=M();
        $model->startTrans();
        foreach($user_land as $k=>$v){
            if($add>0){
                //普通土地的计算
                $real_add=0;
                if($v['landId']<11&&$v['totalNum']<$fee*$ordinary){
                    if($v['totalNum']+$add>$fee*$ordinary){
                        $real_add=$fee*$ordinary-$v['totalNum'];//实际增加的收益
                    }else{
                        $real_add=$add;
                    }

                }

                //金土地的计算
                if($v['landId']>10&&$v['totalNum']<$fee*$notordinary){
                    if($v['totalNum']+$add>$fee*$notordinary){
                        $real_add=$fee*$notordinary-$v['totalNum'];//实际增加的收益
                    }else{
                        $real_add=$add;
                    }
                }
                if($real_add==0){
                    $res4=1;$res5=1;
                }else{
                    $res4=M("user_land")->where("id=".$v['id'])->setInc('fruitNum',$real_add);
                    $res5=M("user_land")->where("id=".$v['id'])->setInc('totalNum',$real_add);
                }


                if(!$res4||!$res5){
                    $model->rollback();
                    ajax_return_error("施肥失败");
                }
                $add=$add-$real_add;
                $real_total_add+=$real_add;
                
            }


        }
        //1 扣掉用户化肥数量
        if($real_total_add>0){
            $res1=$this->db->where("userId=$uid")->setDec('totalFertilizer',round($real_total_add/$do_fee,2));
            //2 果园增加总收益量
            $res2=$this->db->where("userId=$uid")->setInc("totalNum",$real_total_add);
            $res3=$this->db->where("userId=$uid")->setInc("totalGrow",$real_total_add);
            //3 增加施肥数量
            $res6=$this->db->where("userId=$uid")->setInc('doFertilizer',round($real_total_add/$do_fee,2));
        }else{
            $res1=1;
            $res2=1;
            $res3=1;
            $res6=1;
            ajax_return_error("果园已达到最大收益值");
        }

        $add_dog=$this->getConfig(19);//增加一条狗需要施肥的数量
        $max_dog=$this->getConfig(21);
        $doFertilizer=$this->db->where("userId=$uid")->getField("doFertilizer");//施肥总量
        $res7=1;
        if($dog<$max_dog){
            if($doFertilizer>($dog+1)*$add_dog){
                //4增加狗的数量
                $res7=$this->db->where("userId=$uid")->setInc("dog",1);
            }
        }
        //增加生长收益
//        $res9=$this->add_profit($uid);  //已废弃
        //4 增加每天用户收益
        if($real_total_add>0){
            //增加收益
            $map=array(
                'userId'=>$uid,
                'dateTime'=>time(),
                'profitNum'=>$real_total_add,
                'profitRate'=>0,
            );
            $res8=M("user_profit")->add($map);
//            $res8=M("user_profit")->where("userId=$uid and dateTime>=$start_time and dateTime<=$end_time")->setInc('profitNum',$real_total_add);
        }else{
            $res8=1;
        }

        if($res1&&$res2&&$res3&&$res6&&$res7&&$res8){
            $model->commit();
            ajax_return_ok('','施肥成功');
        }else{
            $model->rollback();
            ajax_return_error("施肥失败");
//            ajax_return_error($res1.'-'.$res2.'-'.$res3.'-'.$res6.'-'.$res7.'-'.$res8);
        }
    }
    /**
     * 计算化肥的收益率
     */
    public function getProfit($uid){
        $garden=$this->db->where("userId=$uid")->find();
        $level=M("user")->where("id=$uid")->find();
        $sys_add=$this->getConfig(10);//系统每天派发的化肥比例
        $config=M("config");
        $dog_fee=$this->getConfig(16);
        $scarecrow_fee=$this->getConfig(17);
//            $sys_fee=$this->getConfig(13);//系统派发收益率已废弃
        $level_fee=$config->where("type=1")->order("id asc")->select();
        $decay=$config->where("type=5")->order("id asc")->select();
        $dog=$garden['dog'];
        $scarecrow=$garden['scarecrow'];
        $decay_fee=getDecay($decay,$garden['totalGrow'],$garden['landNum']);
        $profit=$sys_add+$dog_fee*$dog+$scarecrow_fee*$scarecrow+$level_fee[$level['level']-1]['value']-$decay_fee;//每天的收益率
        return $profit;
    }
    /**
     * 获取系统派送的化肥
     */
    public function getAddFertilizer($uid){
        $garden=$this->db->where("userId=$uid")->find();
        $profit=$this->getProfit($uid);//每天的收益率
        $add=round($garden['totalNum']*$profit,2);
        $res=$this->db->where("userId=$uid")->save(array('totalFertilizer'=>$add));
        //插入领取化肥表
        $map=array(
            'userId'=>$uid,
            'num'=>$add,
            'dateTime'=>time(),
        );
        $res1=M("fertilizer")->add($map);

    }
    /**
     * 收割
     */
    public function harvest(){
        $land_id=I("post.land_id");
        $fruit_num=I("post.fruit_num");
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
//            $uid=4;
        }
        $land=M("user_land");
        $user_land=$land->where("userId=$uid and landId=$land_id")->find();
        if(!$user_land){
            ajax_return_error("请选择开垦过的土地");
        }
        $model=M();
        $model->startTrans();
        if($land_id<11){
            $harvest_num=$user_land['fruitNum']-$this->ordinary;//可收割的数量
        }else{
            $harvest_num=$user_land['fruitNum']-$this->notordinary;
        }
        if($fruit_num>round($harvest_num,2)){
            ajax_return_error("该果树可收割的最大值为".round($harvest_num,2));
        }
        if($fruit_num<=0){
            ajax_return_error("收割的数量最小值应该大于0");
        }
        //1 扣掉果树上数量

        $res=$land->where("id=".$user_land['id'])->setDec('fruitNum',$fruit_num);
        //2 扣掉果园总量
        $res2=$this->db->where("userId=$uid")->setDec("totalNum",$fruit_num);
        

        //2 加上果园仓库果实数量
        $res1=$this->db->where("userId=$uid")->setInc("houseFruit",$fruit_num);
        if($res1&&$res&&$res2){
            $model->commit();
            ajax_return_ok("","收割成功");
        }else{
            ajax_return_error("收割失败");
        }
    }
    /**
     * 采蜜列表
     */
    public function picklist(){
        $uid=$this->user['id'];
        if(!$uid){
            ajax_return_error(null,101);
        }
//        $page=I("post.page")?:1;
//        $page_num=I("post.page_num")?:10;
//        $left=($page-1)*$page_num;
        $friend=M("recommend")->join("farm_user as u on u.id=farm_recommend.recommendedId")
            ->where("userId=$uid and u.isShow=1 and status=1")->order("farm_recommend.id desc")->field("farm_recommend.*,u.userName,u.realName")
            ->select();
        $start_time=strtotime(date('Y-m-d'));
        $end_time=$start_time+24*3600;
        $sys2=$this->getConfig(11);//好友采蜜为好友化肥数量的比例
        foreach($friend as $k=>$v){
            if($find=M("user_harvest")->where("userId=$uid and friendId=".$v['recommendedId']." and createTime>=$start_time and createTime<=$end_time")->find()){
                $friend[$k]['isPick']=1;//已采摘
            }else{
                //判断好友果园可采蜜数量是否为0
                $friend_id=$v['recommendedId'];
                $house_fruit=M("user_garden")->where("userId=$friend_id")->find();
                $profit=$this->getProfit($friend_id);
                $sys=round($house_fruit['totalNum']*$profit*$sys2,2);//好友可采的果实数量
                if($sys<=0){
                    $friend[$k]['isPick']=1;//已采摘
                }else{
                    $friend[$k]['isPick']=0;//未采摘
                }

            }
        }
        ajax_return_ok($friend);
    }
    /**
     * 好友果园展示
     */
    public function friendGarden(){
        $uid=I("post.friend_id");//好友id
        $garden=$this->db->where("userId=".$uid)->find();
        $level=M("user")->where("id=$uid")->find();
        $garden['level']=$level['level'];
        $garden['friendNum']=$level['friendNum'];
        $user_land=M("user_land")->where("userId=$uid")->order("id asc")->select();
        $garden['user_land']=$user_land;
        //判断好友今天可领的化肥数量
        $start_time=strtotime(date("Y-m-d"));
        $end_time=$start_time+24*3600;
        $sys1=$this->getProfit($uid);//化肥增加比例
        $sys2=$this->getConfig(11);//好友采蜜为好友化肥数量的比例
        $data=M("fertilizer")->where("userId=$uid and dateTime>=$start_time and dateTime<=$end_time")->find();
        if($data){
            $sys=round($data['num']*$sys2,2);
        }else{
            $sys=round(($garden['totalNum']*$sys1)*$sys2,2);//好友可采的果实数量
        }
//        echo $garden['houseFruit'].'--'.$sys1.'--'.$sys2;
        $garden['picknum']=$sys;
        ajax_return_ok($garden);
    }
    /**
     * 到好友果园采蜜
     */
    public function pick(){
        $uid=$this->user['id'];
        $friend_id=I("post.friend_id");//好友id
        $start_time=strtotime(date("Y-m-d"));
        $end_time=$start_time+24*3600;
        $find=M("user_harvest")->where("userId=$uid and friendId=".$friend_id." and createTime>=$start_time and createTime<=$end_time")->find();
        if($find){
            ajax_return_error("你今天已采摘过");
        }
        $friend_garden=$this->db->where("userId=$friend_id")->find();
        //判断好友今天可领的化肥数量
        $start_time=strtotime(date("Y-m-d"));
        $end_time=$start_time+24*3600;
        $sys1=$this->getProfit($friend_id);//系统每天派发化肥的比例
        $sys2=$this->getConfig(11);//好友采蜜为好友化肥数量的比例
        $data=M("fertilizer")->where("userId=$friend_id and dateTime>=$start_time and dateTime<=$end_time")->find();
        if($data){
            $sys=round($data['num']*$sys2,2);
        }else{
            $sys=round(($friend_garden['totalNum']*$sys1)*$sys2,2);//好友可采的果实数量
        }
        //1 增加仓库果实数量

        if(!$uid){
            ajax_return_error(null,101);
//            $uid=4;
        }
        if($sys<=0){
            ajax_return_error("该果园没有可采摘的果实");
        }
        $model=M();
        $model->startTrans();
        $res1=$this->db->where("userId=$uid")->setInc('houseFruit',$sys);
        //2 加入用户采蜜表
        $map=array(
            'userId'=>$uid,
            'friendId'=>$friend_id,
            'fruitNum'=>$sys,
            'createTime'=>time(),
        );
        $res2=M("user_harvest")->add($map);
        if($res1&&$res2){
            $model->commit();
            ajax_return_ok('','采蜜成功');
        }else{
            $model->rollback();
            ajax_return_error("采蜜失败");
        }
    }
    /**
     * 一键采取所有好友果实
     */
    public function pickAll(){
        $uid=$this->user['id'];
        $friend=M("recommend")->join("farm_user as u on u.id=farm_recommend.recommendedId")
            ->where("userId=$uid and u.isShow=1 and status=1")->order("farm_recommend.id desc")->field("farm_recommend.*")
            ->select();
        $start_time=strtotime(date("Y-m-d"));
        $end_time=$start_time+24*3600;
        $sys2=$this->getConfig(11);//好友采蜜为好友化肥数量的比例

        $fertilizer=M("fertilizer");
        foreach($friend as $k=>$v){
            $friend_id=$v['recommendedId'];
            $find=M("user_harvest")->where("userId=$uid and friendId=".$friend_id." and createTime>=$start_time and createTime<=$end_time")->find();
            if($find){
                continue;
            }
            $friend_garden=$this->db->where("userId=$friend_id")->find();
            //判断好友今天可领的化肥数量
            $data=$fertilizer->where("userId=$friend_id and dateTime>=$start_time and dateTime<=$end_time")->find();
            $sys1=$this->getProfit($friend_id);
            if($data){
                $sys=round($data['num']*$sys2,2);
            }else{
                $sys=round(($friend_garden['totalNum']*$sys1)*$sys2,2);//好友可采的果实数量
            }
            //1 增加仓库果实数量
            $model=M();
            $model->startTrans();
            if($sys<=0){
                $res1=1;
            }else{
                $res1=$this->db->where("userId=$uid")->setInc('houseFruit',$sys);
            }

            //2 加入用户采蜜表
            $map=array(
                'userId'=>$uid,
                'friendId'=>$friend_id,
                'fruitNum'=>$sys,
                'createTime'=>time(),
            );
            $res2=M("user_harvest")->add($map);
            if($res1&&$res2){
                $model->commit();
            }else{
                $model->rollback();
                ajax_return_error("系统开小差了,请稍后再试");
            }
        }

        ajax_return_ok('','采蜜成功');
    }
}