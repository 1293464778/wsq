<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
    <title>管理主页</title>

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
        <h1>管理主页<small></small></h1>
        <ol class="breadcrumb">
            <li><a href="<?php echo U('Index/index');?>"><i class="fa fa-dashboard"></i> 主页</a></li>
        </ol>
    </section>


			<!-- Main content -->
			<section class="content">
			

    <div class="box box-primary direct-chat direct-chat-primary">
        <div class="box-header with-border">
            <h3 class="box-title"> 系统信息</h3>
            <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-toggle="tooltip" title="" data-widget="collapse"><i class="fa fa-minus"></i></button>
            </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body" style="padding:10px;">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa  fa-building-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">收费总数</span>
                            <span class="info-box-number"><?php echo ($money); ?></span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-pie-chart"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">停车次数</span>
                            <span class="info-box-number"><?php echo ($num); ?></span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-yellow"><i class="fa fa-institution"></i></span>

                        <div class="info-box-content">
                           <span class="info-box-text">停车场数</span>
                            <span class="info-box-number"><?php echo ($parkNum); ?></span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-green"><i class="fa fa-user"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">收费员数</span>
                            <span class="info-box-number"><?php echo ($userNum); ?></span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>

            </div>
        </div>
        <div class="box-footer"></div>
        <!-- /.box-footer-->
    </div>

<div class="row">
        <div class="col-md-12"> 
           <div class="box">
                <div class="box-header">
                    <h3 class="box-title">数据统计</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body no-padding" id="main" style="height:400px;">

                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>


			 
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
	
<script src="/Public/Admin/js/echarts.min.js"></script>
<script>
var myChart = echarts.init(document.getElementById('main'));

option = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    toolbox:{
        show:true,
        orient: 'horizontal',
        itemSize: 20,
        itemGap: 10,
        showTitle: true,
        feature:{
            myTool1:{
                show: true,
                title: '按日统计',
                icon: 'image:///Public/Admin/images/ri1.png',
                onclick: function (){
                    search(1, 'image:///public/Admin/images/ri.png');
                }
            },
            myTool2:{
                show: true,
                title: '按月统计',
                icon: 'image:///Public/Admin/images/yue.png',
                onclick: function (){
                    search(2, 'image:///public/Admin/images/yue1.png');
                }
            },
            myTool3:{
                show: true,
                title: '按年统计',
                icon: 'image:///Public/Admin/images/nian.png',
                onclick: function (){
                    search(3, 'image:///public/Admin/images/nian1.png');
                }
            },
        },
        right:40,
    },
    legend: {
        data:['收费次数','逃单次数','收费总数','逃单费用']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : <?php echo ($data["date"]); ?>
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'收费次数',
            type:'bar',
            stack: '停车次数',
            data:<?php echo ($data["gotOrder"]); ?>
        },
        {
            name:'逃单次数',
            type:'bar',
            stack: '停车次数',
            data:<?php echo ($data["lostOrder"]); ?>
        },
        {
            name:'收费总数',
            type:'bar',
            stack: '费用',
            data:<?php echo ($data["gotMoney"]); ?>
        },
        {
            name:'逃单费用',
            type:'bar',
            stack: '费用',
            data:<?php echo ($data["lostMoney"]); ?>
        },
    ]
};

myChart.setOption(option);
var open = true;
var nowStatus = 1;
var optionImg = {
    myTool1:{
        before:'image:///public/Admin/images/ri.png',
        after:'image:///public/Admin/images/ri1.png',
    },
    myTool2:{
        before:'image:///public/Admin/images/yue.png',
        after:'image:///public/Admin/images/yue1.png',
    },
    myTool3:{
        before:'image:///public/Admin/images/nian.png',
        after:'image:///public/Admin/images/nian1.png',
    },
};
function search(status, img){
    if(open == false){
        return false;
    }else{
        if(nowStatus == status){
            return false;
        }
        open = false;
        nowStatus = status;
    }

    $.post("<?php echo U('Index/getData');?>", {'status': status}, success, 'json');
    return false;
    function success(res){
        if(res.status){
            option.xAxis[0].data = jQuery.parseJSON(res.data.date);
            option.series[0].data = jQuery.parseJSON(res.data.gotOrder);
            option.series[1].data = jQuery.parseJSON(res.data.lostOrder);
            option.series[2].data = jQuery.parseJSON(res.data.gotMoney);
            option.series[3].data = jQuery.parseJSON(res.data.lostMoney);
            
            // 图标样式变更
            for(x in optionImg){
                if(x == 'myTool'+status){
                    option.toolbox.feature[x]['icon'] = optionImg[x]['after'];
                }else{
                    option.toolbox.feature[x]['icon'] = optionImg[x]['before'];
                }
            }
            myChart.setOption(option);
        }
        open = true;
    }
}
</script>

  </body>
</html>