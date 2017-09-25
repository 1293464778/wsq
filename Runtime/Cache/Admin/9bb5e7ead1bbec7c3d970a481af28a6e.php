<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>系统配置</title>
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
    <h1>系统配置<small></small></h1>
    <ol class="breadcrumb">
        <li><a href="<?php echo U('Index/index');?>"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li class="active">系统配置</li>
    </ol>
</section>


			<!-- Main content -->
			<section class="content">
			
<!-- Custom Tabs -->
<div class="nav-tabs-custom">
    
    <ul class="nav nav-tabs">
        <li class="active"><a href="#tab_1" data-toggle="tab">系统配置</a></li>
        <li><a href="#tab_2" data-toggle="tab">版本配置</a></li>
    </ul>
    
    <div class="tab-content">
        <div class="tab-pane active" id="tab_1" style="max-width:800px;">
                
                <form role="form" action="<?php echo U('Config/level');?>" id="level">
                    <table id="example" class="table table-striped table-bordered table-hover" cellpadding="0" cellspacing="0" border="0" style="width:50%;float:left;">
                        <thead>
                        <tr><th >一级贫农对应的收益率</th><td><input type="text"  id="config_value1" name="config_value[]" value="<?php echo ($data["0"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>二级中农对应的收益率</th><td><input type="text"  id="config_value2" name="config_value[]" value="<?php echo ($data["1"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>三级中上农对应的收益率</th><td><input type="text"  id="config_value3" name="config_value[]" value="<?php echo ($data["2"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>四级富农对应的收益率</th><td><input type="text" id="config_value4" name="config_value[]" value="<?php echo ($data["3"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>五级农场主对应的收益率</th><td><input type="text"  id="config_value5" name="config_value[]" value="<?php echo ($data["4"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>六级庄园主对应的收益率</th><td><input type="text"  id="config_value6" name="config_value[]" value="<?php echo ($data["5"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>七级地产主对应的收益率</th><td><input type="text"  id="config_value7" name="config_value[]" value="<?php echo ($data["6"]["value"]); ?>" autocomplete="off" ></td></tr>
                        <tr><th>操作</th><td><button class="btn btn-success" type="submit">保存</button> </td></tr>
                        </thead>

                    </table>
                </form>

            <form role="form" action="<?php echo U('Config/farm');?>"  id="farm">
                <table id="example1" class="table table-striped table-bordered table-hover" cellpadding="0" cellspacing="0" border="0" style="width:50%;float:right;">
                    <thead>
                    <tr><th >普通土地需要果实基数</th><td><input type="text"  name="config_value[]" value="<?php echo ($data1["0"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>金土地需要果实基数</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["1"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>系统每天派发化肥比例</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["2"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>好友采蜜为好友化肥数量的比例</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["3"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>施肥1对应增加果实的数量</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["4"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>系统每天派发的收益比例</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["5"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>种子转化果实的比例</th><td><input type="text"   name="config_value[]" value="<?php echo ($data1["6"]["value"]); ?>" autocomplete="off" ></td></tr>
                    <tr><th>操作</th><td><button class="btn btn-success" type="submit">保存</button> </td></tr>
                    </thead>
                </table>
            </form>
        </div><!-- /.tab-pane -->

        <div class="tab-pane" id="tab_2" style="max-width:800px;">
                
                <form role="form" action="<?php echo U('Config/saveconf');?>" id="form-add">
                    <input type="hidden" name="confName" value="version_config"/>
                     
                    <div class="form-group">
                        <label for="version">版本号</label>
                        <input type="text" class="form-control" id="version" name="version" value="<?php echo ($version["version"]); ?>" autocomplete="off" placeholder="版本号">
                    </div>

                    <div class="form-group">
                        <label for="file">上传文件(只支持:apk，大小：限100M内)</label>
                        <div id="file"></div>  
                       </div>

                    <div class="form-group">
                        <label for="forceUpdate">是否强制更新</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="forceUpdate" value="1" class="flat-red" <?php if($version['forceUpdate'] == 1): ?>checked<?php endif; ?> > 是
                        </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="forceUpdate"  class="flat-red" value="0" <?php if($version['forceUpdate'] == 0): ?>checked<?php endif; ?> > 否
                        </label>
                    </div>

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

        $("#level").submit(function(){
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
        $("#farm").submit(function(){
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
    <link rel="stylesheet"  href="/Public/Static/Huploadify/Huploadify.css" >
    <script charset="utf-8" src="/Public/Static/Huploadify/jquery.Huploadify.js"></script>
    <script charset="utf-8" src="/Public/Static/Huploadify/Huploadify.js"></script>
    <script>
      $(function(){
          var upUrl = "<?php echo U('upfile');?>";
          var delUrl = "<?php echo U('delfile');?>";
          var file = "<?php echo ($version["file"]); ?>";
          upfile("file","file",upUrl,delUrl, file);
       });
   </script>

  </body>
</html>