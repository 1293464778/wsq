<?php
namespace Api\Controller;
use Common\Util\AuthUtil;
use Common\CommonConstant;

/**
 * 会员中心基类
 *
 *
 */
class CenterController extends BaseController {
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
     * 获取用户的账号和果园等级   发展好友需要的果实数量
     */
    public function getInfo(){
        $uid=$this->uid;
        $data=M("user")->where("id=$uid")->field("userName,level")->find();
        $apply_fee=$this->getConfig(22);
        $data['apply_fee']=$apply_fee;
        ajax_return_ok($data);
    }
    /**
     * 推荐好友
     */
    public function recommen(){
        $uid=$this->uid;
        $post=I("post.");
        foreach($post as $k=>$v){
            if(empty($v)){
                ajax_return_error(null,2);
            }
        }
        //1 判断新用户名是否存在
        $where['userName']=array('eq',$post['userName']);
//        $where['isShow']=1;
        if($find=M("user")->where($where)->find()){
            ajax_return_error("新果园用户名已存在，请换名");
        }
        //2 判断手机号输入是否合法
        preg_match('/^1[0-9]{10}$/',trim($post['phone']),$matches);
        if(!$matches){
            ajax_return_error("手机号输入有误");
        }
        //3 判断推荐人
        $where1['userName']=array('eq',$post['name']);
        $user=M("user")->where($where1)->find();
        $garden=M("user_garden")->where("userId=".$uid)->find();
        $apply_fee=$this->getConfig(22);//发展好友需要扣掉的果实数量
        if($apply_fee>$garden['houseFruit']){
            ajax_return_error("你的仓库果实数量不足");
        }
        //4 扣掉该用户的仓库果实
        $res1=M("user_garden")->where("userId=".$uid)->setDec('houseFruit',$apply_fee);
        //5 将新用户插入用户表
        $map=array(
            'userName'=>$post['userName'],
            'sex'=>$post['sex'],
            'realName'=>$post['realName'],
            'phone'=>$post['phone'],
            'wechat'=>$post['wechat'],
            'alipay'=>$post['alipay'],
            'createTime'=>time(),
            'updateTime'=>time(),
            'isShow'=>0
        );
        $res2=M("user")->add($map);
        //6 插入推荐表
        $map1=array(
            'userId'=>$user['id'],
            'recommendedId'=>$res2,
            'createTime'=>time(),
            'updateTime'=>time(),
            'status'=>0,
            'seedNum'=>M("config")->where("id=26")->getField('value'),
        );
        $res3=M("recommend")->add($map1);
        if($res1&&$res3){
            ajax_return_ok('','提交成功');
        }else{
            ajax_return_error("提交失败");
        }
    }
    /**
     * 判断二级密码
     */
    public function checkSecPwd(){
        $uid=$this->uid;
        $secondPwd=I("post.secondPwd");
        $pwd=M("user")->where("id=$uid")->getField("secondPwd");
        if($pwd!=encrypt_pass($secondPwd)){
            ajax_return_error("二级密码输入错误");
        }else{
            ajax_return_ok('','输入正确');
        }
    }
    /**
     * 获取用户果园的衰老值
     */
    public function getOld(){
        $uid=$this->uid;
        $garden=M("user_garden")->where("userId=$uid")->find();
        $decay=M("config")->where("type=5")->order("id asc")->select();
//        echo $garden['totalNum'].'--'.$garden['landNum'];exit;
        $decay_fee=getDecay($decay,$garden['totalGrow'],$garden['landNum']);
        ajax_return_ok($decay_fee);
    }
    
    /**
     * 重置果园
     */
    public function resetGarden(){
        $uid=$this->uid;
        $model=M();
        $model->startTrans();
        //1 删掉所有果树
        $res1=M("user_land")->where("userId=$uid")->delete();
        //2 果园土地为0  化肥为0  总量为0
        $res2=M("user_garden")->where("userId=$uid")->save(array('landNum'=>0,'totalFertilizer'=>0,'totalNum'=>0,'totalGrow'=>0));
        if($res1&&$res2){
            $model->commit();
            ajax_return_ok('','重置成功');
        }else{
            $model->rollback();
            ajax_return_error("重置失败");
        }
    }
    /**
     * 个人信息展示
     */
    public function getUser(){
        $uid=$this->uid;
        $data=M("user")->where("id=$uid")->find();
        ajax_return_ok($data);
    }
    /**
     * 个人信息修改
     */
    public function editUser(){
        $uid=$this->uid;
        $post=I("post.");
        foreach($post as $v){
            if(empty($v)){
                ajax_return_error("请把信息填写完整");
            }
        }
        $where['userName']=$post['userName'];
        $where['id']=array('neq',$uid);
        $find=M("user")->where($where)->find();
        if($find){
            ajax_return_error("该用户名已存在，请换名");
        }
        $res=M("user")->where("id=$uid")->save($post);
        if($res){
            ajax_return_ok("","提交成功");
        }else{
            ajax_return_error("信息未作修改");
        }

    }

    /**
     * 修改密码
     */
    public function editPwd(){
        $uid=$this->uid;
        $post=I("post.");
        $model=M("user");
        $user=$model->where("id=$uid")->field("password,secondPwd")->find();
        $res1=0;$res2=0;
        // 修改一级密码
        if($post['newPwd']||$post['rePwd']){
            if($post['newPwd']!=$post['rePwd']){
                ajax_return_error("一级新密码两次输入不一致");
            }
            $str=strlen($post['newPwd']);
            if($str<6||$str>20){
                ajax_return_error("密码的长度应该在6-20位");
            }
            if($user['password']!=encrypt_pass($post['password'])){
                ajax_return_error("一级旧密码输入错误");
            }

            $data['password']=encrypt_pass($post['newPwd']);
            $res1=$model->where("id=$uid")->save($data);
        }
        // 修改二级密码
        if($post['newSecondPwd']||$post['reSecondPwd']){
            if($post['newSecondPwd']!=$post['reSecondPwd']){
                ajax_return_error("二级新密码两次输入不一致");
            }
            $str=strlen($post['newSecondPwd']);
            if($str<6||$str>20){
                ajax_return_error("密码的长度应该在6-20位");
            }
            if($user['secondPwd']!=encrypt_pass($post['secondPwd'])){
                ajax_return_error("二级旧密码输入错误");
            }
            $data1['secondPwd']=encrypt_pass($post['newSecondPwd']);
            $res2=$model->where("id=$uid")->save($data1);
        }
        if(!$res1&&!$res2){
            ajax_return_error("你并未做修改");
        }else{
            ajax_return_ok('',"修改成功");
        }
    }
}