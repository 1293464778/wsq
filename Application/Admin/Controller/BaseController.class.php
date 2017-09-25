<?php
namespace Admin\Controller;
use Common\Util\TreeUtil;
/**
 * 基类
 * @author xiegaolei
 *
 */
class BaseController extends \think\Controller
{
    // 控制器权限分块
    public $privilege;

    // 默认控制器块的action
    public $entry = "index";

    public function _initialize(){
        if (is_login()==0) {
            $this->redirect('Login/index');
        }

        $myrules = M('auth_group')->where(array('id'=>$_SESSION['admin_auth']['roleId']))->getfield('rules');
        $myrules = explode(',', $myrules);
        $mymenus = M('auth_rule')->where(array('id'=>array('in',$myrules),'status'=>1))->order('sorts asc,id asc')->select();

        $mymenus = TreeUtil::listToTreeMulti($mymenus, 0, 'id', 'pid', 'child');

        $this->mymenus = $mymenus;

        $this->module = MODULE_NAME;
        $this->controller = CONTROLLER_NAME;
        $this->action = ACTION_NAME;
        $this->nowUrl = CONTROLLER_NAME.'/'.ACTION_NAME;
        // 权限验证
        // 判断该控制器是否分为多个权限块
        if(!empty($this->privilege)){
            foreach($this->privilege as $k=>$value){
                if(in_array($this->action,$value)){

                    $this->nowUrl = CONTROLLER_NAME.'/'.$k;
                }
            }
        } else {
            $this->nowUrl = CONTROLLER_NAME.'/'.$this->entry;
        }

        // 在auth_rule中查询是否有该url
        $rule = M('AuthRule')->getByName($this->nowUrl);
//        dump($this->nowUrl);exit;
        if($rule){
            if(!in_array($rule['id'], $myrules)){
                if(IS_AJAX){
                    $this->ajaxReturn('');
                }
                if($this->nowUrl == 'Index/index'){
                    $this->display('default');
                    return;
                }
                $this->redirect("index/index");
            }
        }else{
            // 权限查不到时
            if(IS_AJAX){
                $this->ajaxReturn('');
            }
            if($this->nowUrl == 'Index/index'){
                $this->display('default');
                return;
            }
            $this->redirect("index/index");
        }
    }

    /**
     * [ok 成功ajax返回]
     * @param [type] $msg [description]
     * @param array $data [description]
     * @return [type] [description]
     */
    protected function ok($msg, $data = array()) {
        $info = array (
            'status' => 1,
            'info' => $msg );
        if (! empty ( $data )) {
            $info ['data'] = $data;
        }
        
        $this->ajaxReturn ( $info );
    }

    /**
     * [wrong 失败ajax返回]
     * @param [type] $msg [description]
     * @return [type] [description]
     */
    protected function wrong($msg) {
        $info = array (
            'status' => 0,
            'info' => $msg );
        $this->ajaxReturn ( $info );
    }

    /**
     * 省份内市区获取
     */
    public function getCity(){
        $province = I('province');
        // 市区获取
        $city = M("chinaCity")->field('cityId,city')->where(array('provinceId'=>$province))->select();
        $this->ok($city);
    }

    /**
     * 城市区域获取
     */
    public function getArea() {
        $city = I('city');
        // 市区获取
        $area = M("chinaArea")->field('areaId,area')->where(array('father'=>$city))->select();
        $this->ok($area);
    }
}
