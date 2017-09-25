<?php
namespace Admin\Controller;


class UserController extends BaseController {
    public $db;
    function __construct()
    {
        parent::__construct();
        $this->db=M("user");
    }

    /**
    * 用户列表
    */
    public function index() {
        if (!IS_AJAX) {
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
            $nickname = $search['nickName'];
            $mobile = $search['mobile'];


            if ($nickname != '') {
                 $where['realName'] = array('like', '%'.$nickname.'%');
            }
            if ($mobile != '') {
                 $where['phone'] = array('like', '%'.$mobile.'%');
            }
            if ($num != '') {
                 $where['userName'] = array('like', '%'.$num.'%');
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
        $lists = $this->db->where($where)->limit($start,$length)->order($order)->select();
        foreach($lists as $k=>$v){
           $lists[$k]['createTime']=date("Y-m-d H:i:s",$v['createTime']);
           $lists[$k]['updateTime']=date("Y-m-d H:i:s",$v['updateTime']);
        }

        $result['draw'] = $draw;
        $result['recordsTotal'] = $this->db->where($where)->count();
        $result['recordsFiltered'] = $this->db->where($where)->count();
        $result['data'] = $lists;

        $this->ajaxReturn($result);
    }

    /**
     * 添加页面表示
     */
    public function add() {
        $this->display();
    }


    /**
     * 用户添加保存
     */
    public function addHandle() {

        $user['userName'] = I('post.userName');
        $user['realName'] = I('post.realName');
        $user['phone'] = I('post.phone');
        $user['alipay'] = I('post.alipay');
        $user['wechat'] = I('post.wechat');
        if($this->has($user['userName'])){
            $this->wrong('该用户名已存在！');
        }
        $user['password'] = encrypt_pass(I('post.password'));
        $user['secondPwd'] = encrypt_pass(I('post.secondPwd'));
        $user['sex'] = I('post.sex');
        $user['createTime']=time();
        $user['updateTime']=time();
        $res =$this->db->add($user);
        if ($res === false) {
            $this->wrong('添加失败');
        }
        //新人进来送果实
        $fruit=M("config")->where("id=8")->getField("value");
        M("user_garden")->add(array('userId'=>$res,'houseFruit'=>$fruit));
        $this->ok('添加成功');
    }

    /**
     * 编辑页面
     */
    public function edit($id) {
        $user = $this->db->where(array('id'=>$id))->find();
        $this->data=$user;
        // 获取跳转前页面
        $url = $_SERVER['HTTP_REFERER'];
        if (!$user) {
            header("Location:$url");exit;
        }
        $this->display();
    }

    /**
     * 编辑保存
     */
    public function save() {
        $user = I('post.');
        if($this->has($user['userName'], $user['id'])){
            $this->wrong('该用户名已存在！');
        }
        if ($user['password']) {
            $user['password'] = encrypt_pass($user['password']);
        }else{
            unset($user['password']);
        }
        if ($user['secondPwd']) {
            $user['secondPwd'] = encrypt_pass($user['secondPwd']);
        }else{
            unset($user['secondPwd']);
        }
        $user['updateTime']=time();
        $rs = $this->db->save($user);
        if ($rs ===  false) {
            $this->wrong('保存失败！');
        }
        $this->ok('保存成功！');
    }

    /**
     * 删除
     */
    public function del(){
        $id=I("post.id");
//        var_dump($id);exit;
        $res = $this->db->where("id=$id")->save(array('isShow'=>0));
        //判断该用户是否有推荐人
        $recommen=M("recommend")->where("recommendedId=$id")->find();
        if($recommen){
            $uid=$recommen['userId'];
            //减少该用户的好友数量
            if($data=M("user")->where("id=$uid")->find()){
                M("user")->where("id=$uid")->setDec("friendNum",1);
            }
        }
        if ($res === false) {
            $this->wrong('删除失败');
        }
        $this->ok('删除成功');
    }

    /**
     * @param $id 用户id
     * 查看用户好友
     */
   public function land($id){
        $data=M("recommend")->join("farm_user as u on u.id=farm_recommend.recommendedId")->where("userId=$id and isShow=1 and status<2")->field("u.*,farm_recommend.status")->order("id desc")->select();
        $this->data=$data;
        $this->display();
   }

    /**
     * 用户名重复性验证
     */
    private function has($userName, $id=null){
        $userId = M('user')->where(array('userName'=>$userName))->getField('id');
        if($userId && $id != $userId){
            return true;
        }

        return false;
    }
}