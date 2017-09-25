<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
    <title>公告管理</title>

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
        <h1>公告列表<small></small></h1>
        <ol class="breadcrumb">
            <li><a href="<?php echo U('Admin/Index/index');?>"><i class="fa fa-dashboard"></i> 主页</a></li>
            <li class="active">公告管理</li>
        </ol>
    </section>


			<!-- Main content -->
			<section class="content">
			
    <!-- Custom Tabs -->
    <div class="nav-tabs-custom">

        <ul class="nav nav-tabs">
            <li class="active"><a href="#tab_1" data-toggle="tab">公告列表</a></li>
            <li><a href="<?php echo U('Sys/add');?>">添加公告</a></li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="tab_1">
                <!-- datatable -->
                <table id="example" class="table table-striped table-bordered table-hover" cellpadding="0" cellspacing="0" border="0" width="100%">
                    <thead>
                        <tr>
                            <th style="width:30px;">排序</th>
                            <th>标题</th>
                            <th>发布时间</th>
                            <th>创建时间</th>
                            <th>修改时间</th>
                            <th style="text-align:center;padding-right: 8px;width:80px;">操作</th>
                        </tr>
                    </thead>

                </table>
                <!-- /datatable -->

            </div>
            <!-- /.tab-pane -->

        </div>
        <!-- /.tab-content -->
    </div>
    <!-- nav-tabs-custom -->


			 
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
	
    <!-- page script -->
    <script src="/Public/Admin/js/dataTables.js" type="text/javascript"></script>
    <script type="text/javascript">
        var table = null;
        $(document).ready(function() {
            table = $('#example').dataTable({
                "processing": true, //加载提示
                "serverSide": true, //服务端模式
                "ajax": {
                    "url": "<?php echo U('Admin/Sys/index');?>",
                    "type": "POST",
                    "data": {
                        'mycolumns': ['sort', 'title', 'publishTime', 'createTime','updateTime'],
                    },
                },
                //展示的列
                "columns": [{
                    "data": "sort"
                }, {
                    "data": "title"
                }, {
                    "data": "publishTime"
                }, {
                    "data": "createTime"
                },{
                    "data": "updateTime"
                },

                ],
                //设置列排序
                "order": [
                    [0, "asc"]
                ],
                //列设置
                "columnDefs": [{
                        "targets": [0],
                        "render": function(data, type, row) {
                            alert(row['content']);
                            var html = '<input type="number" name="sort" value="'+data+'" onchange="sort(this,'+row['id']+')" min="0" max="99" value="50" style="width:40px;">';
                            return html;
                        },
                    },{
                        "targets": [1],
                        "orderable": false,
                    },{
                        "targets": [2],
                        "orderable": false,
//                        "render": function(data, type, row) {
//                            var html = '<img src="'+data+'">';
//                            return html;
//                        },
                    },{
                        "targets": [3],
                        "orderable": false,
//                        "render": function(data, type, row) {
//                            var html = '<img src="'+data+'">';
//                            return html;
//                        },
                    },{
                    "targets": [4],
                    "orderable": false,
//                        "render": function(data, type, row) {
//                            var html = '<img src="'+data+'">';
//                            return html;
//                        },
                },
                    {
                        "targets": [5],
                        "orderable": false,
                        "render": function(data, type, row) {
                            var btn = '<a href="/index.php/Admin/Sys/edit/id/' + row['id'] + '" class="btn btn-primary btn-xs btn-flat" >编辑</a>';
                            var btn = btn+' <a href="javascript:void(0);" onclick="deleteFun('+row['id']+')"  class="btn btn-danger btn-xs btn-flat" >删除</a>';
                            return btn;
                        },
                    },
                ],
            });
        });

        function deleteFun(id){
            layer.confirm('确定删除该记录吗？', {
                btn: ['确认','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                 _deleteFun(id); 
            }, function(){
            });
        }

        /**
        * 删除
        * @param id
        * @private
        */
        function _deleteFun(id) {
            
            $.ajax({
                url: "<?php echo U('Sys/del');?>",
                data: {"id": id},
                type: "post",
                success: function (data) {
                    if (data.status) {
                        layer.msg(data.info, {
                            icon:1,
                            offset: 0,
                            shift: 0,
                            time:1500
                        },function(){
                            table.api().draw(false); 
                        });
                    } else {
                        layer.msg(data.info, {
                            icon:0,
                            offset: 0,
                            shift: 6,
                            time:1500
                        });
                    }
                }, 
                error: function (error) {
                    alert(data.info);
                }
            });
        }
        
        function sort(obj, id){
            var val = $(obj).val();
            $.post('<?php echo U("Sys/sort");?>', {id:id, sort:val}, success, 'json');
            return false;
            function success(data){
                    if (data.status) {
                        layer.msg(data.info, {
                            icon:1,
                            offset: 0,
                            shift: 0,
                            time:1500
                        },function(){
                            table.api().draw(false); 
                        });
                    } else {
                        layer.msg(data.info, {
                            icon:0,
                            offset: 0,
                            shift: 6,
                            time:1500
                        });
                    }
            }
        }

        function clearFun(){
            if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
            if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105))) 
            event.returnValue=false; 
        }
    </script>


  </body>
</html>