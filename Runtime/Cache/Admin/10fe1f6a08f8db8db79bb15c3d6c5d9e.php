<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>编辑管理员</title>
		<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<link rel="stylesheet" href="/Public/admin/css/my.css">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="/Public/Static/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="/Public/Static/adminlte/dist/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="/Public/Static/adminlte/dist/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/Public/Static/adminlte/dist/css/css.css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<link rel="stylesheet" href="/Public/Static/adminlte/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="/Public/Static/adminlte/dist/css/skins/skin-blue.min.css">
<!-- DataTables -->
<link rel="stylesheet" href="/Public/Static/adminlte/plugins/datatables/dataTables.bootstrap.css">

<script src="/Public/Static/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="/Public/Static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- AdminLTE App -->
<script src="/Public/Static/adminlte/dist/js/app.min.js" type="text/javascript"></script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
	<script src="/Public/Static/adminlte/dit/js/html5shiv.min.js"></script>
	<script src="/Public/Static/adminlte/dit/js/respond.min.js"></script>
<![endif]-->

<!-- DATA TABES SCRIPT -->
<script src="/Public/Static/adminlte/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/Public/Static/adminlte/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script charset="utf-8" src="/Public/Static/layer/layer.js"></script>
<!-- ʱ���� -->
<script charset="utf-8" src="/Public/Static/laydate/laydate.js"></script>
		
	</head>
  
	<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
		<!-- Main Header -->
		<header class="main-header">
			<!-- Logo -->
			<a href="" class="logo">
				<!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>后</b>台</span>
				<!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>后台</b>管理系统</span>
			</a>

			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
					<span class="sr-only">Toggle navigation</span>
				</a>
				
				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">

  <li><a href="<?php echo U('Pwd/index');?>" target="_bank" class="nav-current"> 修改密码</a></li>
  <li><a href="<?php echo U('Login/logout');?>"><i class="fa fa-power-off"></i> 退出</a></li>
	
</ul>
				</div>
				 
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar Menu -->
				<!-- Sidebar user panel (optional) -->
<div class="user-panel">
	<div class="pull-left image">
		<img src="/Public/Static/adminlte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
	</div>
	<div class="pull-left info">
		<p><?php echo $_SESSION['user_auth']['group']; ?></p>
		<!-- Status -->
		<a href="#"><i class="fa fa-circle text-success"></i>  <?php echo $_SESSION['user_auth']['username']; ?></a>
	</div>
</div>

 
<ul class="sidebar-menu" id="mymenu">
	<li class="header">后台管理菜单</li>

	<?php
 $menuHtml = ''; foreach($mymenus as $v){ if($v['child']){ if(strpos($v['name'],$controller) === false){ $menuHtml .='<li class="treeview">'; }else{ $menuHtml .='<li class="treeview active">'; } $menuHtml .='<a href="#"><i class="fa fa-square"></i> <span>'.$v["title"].'</span> <i class="fa fa-angle-left pull-right"></i></a>'; $menuHtml .='<ul class="treeview-menu">'; foreach($v['child'] as $vo){ if($vo['hasChild'] == 0){ if($vo['name'] == $nowUrl){ $class="active"; }else{ $class = ''; } $menuHtml .='<li class="'.$class.'"><a href="'.U($vo["name"]).'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-link"></i> <span>'.$vo["title"].'</span></a></li>'; } } $menuHtml .='</ul>'; $menuHtml .='</li>'; }else{ if($v['name'] == $nowUrl){ $class="active"; }else{ $class = ''; } $menuHtml.='<li class="'.$class.'"><a href="'.U($v["name"]).'"><i class="fa fa-link"></i> <span>'.$v["title"].'</span></a></li>'; } } echo $menuHtml; ?>

</ul>
 
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			
<section class="content-header">
    <h1>编辑管理员<small></small></h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo U('Index/index');?>"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li class="active">管理员管理</li>
    </ol>
</section>


			<!-- Main content -->
			<section class="content">
			
<!-- Custom Tabs -->
<div class="nav-tabs-custom">
    
    <ul class="nav nav-tabs">
        <li><a href="<?php echo U('Manager/adminList');?>">管理员列表</a></li>
        <li class="active"><a href="#tab_1" data-toggle="tab">编辑管理员</a></li>
    </ul>
    
    <div class="tab-content">
        <div class="tab-pane active" id="tab_1" style="max-width:800px;">
             
                <form role="form" action="<?php echo U('Manager/adminSave');?>" id="form-add">
                    <input type="hidden" name="id" value="<?php echo ($info["id"]); ?>"/>
                    <?php if($info['id'] != 1): ?><div class="form-group">
                        <label>角色<font color='red'>*</font></label>
                        <select class="form-control" name="group" style="width:150px;">
                            <option value="0">请选择角色</option>
                            <?php if(is_array($groups)): foreach($groups as $key=>$v): ?><option value="<?php echo ($v["id"]); ?>" <?php if(($group_id) == $v["id"]): ?>selected<?php endif; ?> ><?php echo ($v["title"]); ?></option><?php endforeach; endif; ?>
                        </select>

                    </div><?php endif; ?>
                    <div class="form-group">
                        <label for="username">登录账号<font color='red'>*</font></label>
                        <input type="text" class="form-control" id="username" name="username" value="<?php echo ($info["username"]); ?>" autocomplete="off" placeholder="登录账号" style="width:250px;">
                    </div>
                    <div class="form-group">
                        <label for="mobile">手机号码</label>
                        <input type="text" class="form-control" id="mobile" name="mobile" value="<?php echo ($info["mobile"]); ?>" autocomplete="off" placeholder="手机号码" style="width:250px;">
                    </div>
                     
                    <div class="form-group">
                        <label for="email">电子邮箱</label>
                        <input type="email" class="form-control" id="email" name="email" value="<?php echo ($info["email"]); ?>" autocomplete="off" placeholder="电子邮箱" style="width:250px;">
                    </div>
                    <div class="form-group">
                        <label for="password">登录密码<font color='red'>*</font></label>
                        <input type="text" class="form-control" id="password" name="password" autocomplete="off" placeholder="不修改则留空" style="width:250px;">
                    </div>    
                    <?php if($info['id'] != 1): ?><div class="form-group">
                        <label>
                            <input type="radio" name="status" id="status1" value="1" <?php if(($info['status']) == "1"): ?>checked<?php endif; ?>  class="flat-red" > 正常
                        </label>
                        <label>
                            <input type="radio" name="status" id="status2" <?php if(($info['status']) == "0"): ?>checked<?php endif; ?> class="flat-red" value="0"> 禁用
                        </label>
                    </div><?php endif; ?>
                    <button class="btn btn-success" type="submit">保存</button>     
                </form>
             
          
        </div><!-- /.tab-pane -->
 
    </div><!-- /.tab-content -->
</div><!-- nav-tabs-custom -->
 


			 
			</section><!-- /.content -->
		</div><!-- /.content-wrapper -->
		<!-- Main Footer -->
		<footer class="main-footer">
	<!-- To the right -->
	<div class="pull-right hidden-xs">
	</div>
	<!-- Default to the left -->
	<strong>Copyright &copy; 2016 <a href="http://www.palmble.com/" target="_blank">郑州掌尚信息科技有限公司</a></strong> All rights reserved
</footer>
    </div><!-- ./wrapper -->
	
     
    <script type="text/javascript">
        $(function () {
             
        });
  
        //表单提交
        $(document)
            .ajaxStart(function(){
                $("button:submit").addClass("btn-default").removeClass('btn-primary').attr("disabled", true);
            })
            .ajaxStop(function(){
                $("button:submit").removeClass("btn-default").addClass("btn-primary").attr("disabled", false);
            });

        $("form").submit(function(){
             
            var self = $(this);
            $.post(self.attr("action"), self.serialize(), success, "json");
            return false;

            function success(data){
                if(data.status){
                    layer.msg(data.msg, {
                        icon:1,
                        offset: 0,
                        shift: 0,
                        time:1500
                    },function(){
                        //window.location.reload();//刷新当前页面 ;
                    });
                } else {
                    layer.msg(data.msg, {
                        icon:0,
                        offset: 0,
                        shift: 6,
                        time:1500
                    }); 
                     
                }
            }
        });
    </script>


  </body>
</html>