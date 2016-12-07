<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Bootstrap 实例 - 标签页（Tab）插件方法</title>
		<link href="<%=request.getContextPath()%>/bootstrap/assets/css/bootstrap.min.css" rel="stylesheet">
		<script src="<%=request.getContextPath()%>/bootstrap/js/jquery-1.8.3.min.js"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		   $(function () {
		      $('#myTab li:eq(0) a').tab('show');
		      $('#ios').hide();
		     
		   });
		   
		   document.getElementById("#home").html("ddd");
		</script>
	</head>
	<body>
		<ul id="mytab" class="nav nav-tabs">
	    <li class="dropdown">
	    <a href="#" id="myTabDrop2" class="dropdown-toggle" data-toggle="dropdown">Project Status <b class="caret"></b></a>
	    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
				<li><a href="#p1" tabindex="-1" data-toggle="tab">Project1</a></li>
				<li><a href="#p2" tabindex="-1" data-toggle="tab">Project2</a></li>
			</ul>
	    <li><a href="#profile" data-toggle="tab">KPI</a></li>
	    <li><a href="#messages" data-toggle="tab">KONA Delay</a></li>
	    <li class="dropdown">
			<a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Setting <b class="caret"></b></a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
				<li><a href="#s1" tabindex="-1" data-toggle="tab">Setting1</a></li>
				<li><a href="#s2" tabindex="-1" data-toggle="tab">Setting2</a></li>
			</ul>
		</li>
	</ul>
 
	<div class="tab-content">
	    <div class="tab-pane fade in active" id="home"><img src="<%=request.getContextPath()%>/style/images/2.gif"/> </div>
	    <div class="tab-pane fade" id="p1">
			<p><img src="<%=request.getContextPath()%>/style/images/2.gif"/></p>
		</div>
		<div class="tab-pane fade" id="p2">
			<p><img src="<%=request.getContextPath()%>/style/images/2.gif"/></p>
		</div>
	    <div class="tab-pane fade" id="profile">
	    	<center>
	    		<img src="<%=request.getContextPath()%>/style/images/2.gif"/>
	    	</center>
	    </div>
	    <div class="tab-pane fade" id="messages"><img src="<%=request.getContextPath()%>/style/images/2.gif"/></div>
	    <div class="tab-pane fade" id="s1">
			<p><img src="<%=request.getContextPath()%>/style/images/2.gif"/></p>
		</div>
		<div class="tab-pane fade" id="s2">
			<p><img src="<%=request.getContextPath()%>/style/images/2.gif"/></p>
		</div>
	</div>
		
	</body>
</html>