<?php
namespace Api\Controller;
use Think\Controller;
use Common\Util\ArrayUtil;

/**
 * 用户登录退出
 */
class LoginController extends BaseController {

    /**
     * 登录
     */
    public function login() {
        // 登录主名称：手机号
        $name = I ( 'userName', '' ,'trim');
        // 未加密的密码
        $pass = I ( 'password', '' ,'trim');
        $verify=I('verify','','trim');
        if (empty($name)) {
            ajax_return_error('请填写账号！');
        }
        if (empty($pass)){
            ajax_return_error('请填写密码！');
        }
        if(empty($verify)){
            ajax_return_error('请填写验证码！');
        }
        if(!$this->check_verify($verify)){
            ajax_return_error('验证码输入错误！');
        }
        // 登录验证并获取包含访问令牌的用户
        $result = D('User')->login ( $name, $pass );
        $data = array ('userAccessToken' => $result ['userAccessToken'],'user' => $result['user'] );
        ajax_return_ok($data,'登录成功');
    }

    /**
     * 登出
     * 已知bug：登出的附加操作依赖session中的用户缓存，而logout方法自身并不提供用户缓存，因此这并不总是有效。
     */
    public function logout() {
        // 当前用户缓存删除
        session ( C( "SESSION_NAME_CUR_HOME" ), null );
        ajax_return_ok();
    }
    
    function check_verify($code, $id = 1){
        $verify = new \Think\Verify();
        return $verify->check($code, $id);
    }


}

