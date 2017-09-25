<?php
namespace Api\Controller;
use Think\Controller;
use Common\Util\JwtUtil;
use Common\Util\AuthUtil;
use Common\CommonConstant;
/**
 * 首页
 *
 */
class OrderController extends BaseController {
    public $uid;
    //初始化
    public function _initialize(){

        parent::_initialize();
        //用户身份验证
        $result = AuthUtil::checkIdentity();
        if (!$result['status']){
            ajax_return_error(null,$result['code']);
        }
        $user=session(C("SESSION_NAME_CUR_HOME"));
        $this->uid=$user['id'];
    }
    /**
     * 获取仓库果实数量
     */
    public function getNum(){
        $uid=$this->uid;
        $num=M("user_garden")->where("userId=$uid")->getField("houseFruit");
        $fee=$this->getConfig(27);
        $sale_num=round($num*$fee,2);
        ajax_return_ok(array('num'=>$num,'sale_num'=>$sale_num));
    }
    /**
     * 委托出售
     */
    public function commission() {
        $sale_num=I("post.sale_num");
        if($sale_num<100||$sale_num>1000){
            ajax_return_error("出售果实的数量为100-1000");
        }
        $uid=$this->uid;
        $num=M("user_garden")->where("userId=$uid")->getField("houseFruit");
        if($num<$sale_num){
            ajax_return_error("你的仓库果实数量不足");
        }
        //1 扣去佣金数量
        $fee=$this->getConfig(23);
        $real_num=round($sale_num*(1-$fee),2);
        $model=M();
        $model->startTrans();
        //2 减去仓库果实数量
        $res1=M("user_garden")->where("userId=$uid")->setDec("houseFruit",$sale_num);
        //3 加入委托出售表
        $map=array(
            'saleId'=>$uid,
            'saleNum'=>$sale_num,
            'realNum'=>$real_num,
            'fee'=>$fee,
            'status'=>1,
            'createTime'=>time(),
            'updateTime'=>time(),
        );
        $res2=M("commission_sale")->add($map);
        if($res1&&$res2){
            $model->commit();
            ajax_return_ok('','提交成功');
        }else{
            $model->rollback();
            ajax_return_error("提交失败");
        }
    }
    /**
     * 定向出售
     */
    public function direction(){
        $uid=$this->uid;
        $sale_num=I("post.sale_num");
        $userName=I("post.userName");
        $realName=I("post.realName");
        if($sale_num%10!=0){
            ajax_return_error("出售果实的数量需是10的倍数");
        }
        $where['userName']=array('eq',$userName);
        $where['realName']=array('eq',$realName);
        $user=M("user")->where($where)->find();
        if(!$user){
            ajax_return_error("你输入的目标会员信息有误");
        }
        if($user['id']==$uid){
            ajax_return_error("不可以向自己出售哦");
        }
        $num=M("user_garden")->where("userId=$uid")->getField("houseFruit");
        if($num<$sale_num){
            ajax_return_error("你仓库的果实数量不足");
        }
        $model=M();
        $model->startTrans();
        //1 扣掉佣金数量
        $fee=$this->getConfig(24);
        $real_num=round($sale_num*(1-$fee),2);
        //2 扣掉仓库果实数量
        $res1=M("user_garden")->where("userId=$uid")->setDec("houseFruit",$sale_num);
        //3 加入定向出售表
        $map=array(
            'saleId'=>$uid,
            'saleNum'=>$sale_num,
            'buyId'=>$user['id'],
            'buyUsername'=>$userName,
            'buyRealname'=>$realName,
            'realNum'=>$real_num,
            'fee'=>$fee,
            'status'=>0,
            'createTime'=>time(),
            'updateTime'=>time(),
        );
        $res2=M("direction_sale")->add($map);
        if($res1&&$res2){
            $model->commit();
            ajax_return_ok("","提交成功");
        }else{
            $model->rollback();
            ajax_return_error("提交失败");
        }
    }
    /**
     * 定向出售记录
     */
    public function directionList(){
        $uid=$this->uid;
        $page=I("post.page")?:1;
        $page_num=I("post.page_num")?:10;
        $left=($page-1)*$page_num;
        $data=M("direction_sale")->where("saleId=$uid")->order("id desc")->limit($left,$page_num)->select();
        foreach($data as $k=>$v){
            $data[$k]['createTime']=date("Y-m-d H:i",$v['createTime']);
        }
        ajax_return_ok($data);
    }
    /**
     * 定向出售确认
     */
    public function commitDirection(){
        $order_id=I("post.order_id");
        $info=M("direction_sale")->where("id=$order_id")->find();
        $model=M();
        $model->startTrans();
        //1 改变订单状态
        $res1=M("direction_sale")->where("id=$order_id")->save(array('status'=>2,'updateTime'=>time()));//卖家确认
        //2 买家增加果实数量
        $res2=M("user_garden")->where("userId={$info['buyId']}")->setInc("houseFruit",$info['realNum']);
        if($res1&&$res2){
            $model->commit();
            ajax_return_ok('','确认成功');
        }else{
            $model->rollback();
            ajax_return_error("确认失败");
        }

    }
    /**
     *委托出售记录
     */
    public function commissionList(){
        $uid=$this->uid;
        $page=I("post.page")?:1;
        $page_num=I("post.page_num")?:10;
        $left=($page-1)*$page_num;
        $data=M("commission_sale")->where("saleId=$uid")->order("id desc")->limit($left,$page_num)->select();
        foreach($data as $k=>$v){
            $data[$k]['createTime']=date("Y-m-d H:i",$v['createTime']);
        }
        ajax_return_ok($data);
    }
    /**
     * 购买记录
     */
    public function buyList(){
        $uid=$this->uid;
        $page=I("post.page")?:1;
        $page_num=I("post.page_num")?:10;
        $left=($page-1)*$page_num;
        $data=M("direction_sale")->join("farm_user as u on u.id=farm_direction_sale.saleId")->where("buyId=$uid")
            ->field("farm_direction_sale.*,u.userName,u.realName")->order("id desc")->limit($left,$page_num)->select();
        foreach($data as $k=>$v){
            if($v['status']<1){
                $data[$k]['status']="未确认";
            }else{
                $data[$k]['status']='已确认';
            }
            $data[$k]['createTime']=date("Y-m-d H:i",$v['createTime']);
        }
        ajax_return_ok($data);
    }
    /**
     * 购买记录确认
     */
    public function commitBuy(){
        $order_id=I("order_id");
        $res=M("direction_sale")->where("id=$order_id")->save(array('status'=>1,'updateTime'=>time()));
        if($res){
            ajax_return_ok('','确认成功');
        }else{
            ajax_return_error("确认失败");
        }
    }
    /**
     * 获取种子数量
     */
    public function getSeed(){
        $uid=$this->uid;
        $seed=M("user_garden")->where("userId=$uid")->getField("seed");
        ajax_return_ok($seed);
    }
    /**
     * 种子兑换果实
     */
    public function seedTofruit(){
        $seed_num=I("post.seed_num");
        $uid=$this->uid;
        $seed=M("user_garden")->where("userId=$uid")->getField("seed");
        if($seed_num>$seed){
            ajax_return_error("兑换的数量最大为".$seed);
        }
        $fee=$this->getConfig(14);
        //1 计算转化的果实数量
        $fruit_num=$seed_num*$fee;
        if($fruit_num<=0){
            ajax_return_error("你兑换的数量至少要大于0");
        }
        $model=M();
        $model->startTrans();
        //2 加入仓库果实数量
        $res1=M("user_garden")->where("userId=$uid")->setInc("houseFruit",$fruit_num);
        //3 加入种子转化果实表
        $map=array(
            'userId'=>$uid,
            'seedNum'=>$seed,
            'fruitNum'=>$fruit_num,
            'fee'=>$fee,
            'createTime'=>time(),
            'changeNum'=>$seed_num,
        );
        $res2=M("seed_fruit")->add($map);
        //4 减去种子数量
        $res3=M("user_garden")->where("userId=$uid")->setDec("seed",$seed_num);
        if($res1&&$res2&&$res3){
            $model->commit();
            ajax_return_ok("","兑换成功");
        }else{
            $model->rollback();
            ajax_return_error("兑换失败");
        }
    }
    /**
     * 种子兑换记录
     */
    public function seedList(){
        $uid=$this->uid;
        $data=M("seed_fruit")->where("userId=$uid")->order("id desc")->select();
        ajax_return_ok($data);
    }

}