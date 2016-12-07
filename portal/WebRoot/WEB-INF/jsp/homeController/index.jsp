<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
 <%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>TSDR SW Portal</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/script/jquery_treeview/jquery.cookie.js"></script>
		<link rel="shortcut icon" href="<%=request.getContextPath()%>/FlatUI/img/samsung6.ico">   <!-- 更改标题图标 -->
		<script type="text/javascript">
		$(document).ready(function () {
			$.getJSON("/portal/visitor/updateVisitor?rn="+Math.random(),function(data){
				if("success"==data.result){
					//parent.location.href="/portal/home/index";
				}
				else{
					alert("Update Visitor Failure!");
				}
			});			
		});
		</script>
	</head>

	<frameset rows="100,*,22" framespacing=0 border=0 frameborder="0">
		<frame noresize name="TopMenu" scrolling="no" src="<%=request.getContextPath()%>/home/top">
		<frameset cols="200,*" id="resize">
			<frame noresize name="menu" scrolling="no"  id="menu" src="<%=request.getContextPath()%>/home/left">
			<frame noresize name="right" id="right" scrolling="yes" src="<%=request.getContextPath()%>/home/right">
		</frameset>
		<frame noresize name="status_bar" scrolling="no" src="<%=request.getContextPath()%>/home/bottom">
	</frameset>


	<body> 
			<%System.out.println("访问者IP~~~~~~~~~~~~~~："+request.getRemoteHost() +" "+ new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date())); %>
	</body>

</html>



