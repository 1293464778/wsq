<?php
namespace Api\Controller;
use Think\Controller;
use Common\Util\AuthUtil;
use Common\CommonConstant;

/**
 * 接口基类
 * @author xiegaolei
 *
 */
class BaseController extends Controller {
  
    public function _initialize(){
         
        //接口签名验证
        $result = AuthUtil::checkSign();
        if (!$result['status']){
    
            ajax_return_error(null,$result['code']);
        }
    }
    /**
     * 获取配置
     */
    public function getConfig($id){
        $data=M("config")->where("id=$id")->getField("value");
        return $data;
    }
    
    
    
}