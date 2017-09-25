<?php
/**
 * Created by PhpStorm.
 * User: xiaolei
 * Date: 2017/3/23
 * Time: 11:37
 */

namespace Api\Controller;


class SysController extends BaseController
{
    /**
     * 公告列表  详情信息
     */
    public function notice(){
        $data=M("notice")->where("type=1")->order("id desc")->select();
        foreach($data as $k=>$v){
            $pub=explode(' ',$v['publishTime']);
            $data[$k]['time']=$pub[0];
            $data[$k]['content']=htmlspecialchars_decode($v['content']);
        }
        ajax_return_ok($data);
    }
    
}