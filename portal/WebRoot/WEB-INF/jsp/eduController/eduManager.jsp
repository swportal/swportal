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
		
		<title>Portal-Training Management</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/script/jquery_treeview/jquery.cookie.js"></script>
		<link rel="shortcut icon" href="<%=request.getContextPath()%>/FlatUI/img/samsung6.ico">   <!-- 更改标题图标 -->
		
	</head>

	<frameset rows="570,*"  FRAMESPACING="3">
		<frame noresize name="Top" scrolling="no" src="<%=request.getContextPath()%>/edu/eduTop"   frameborder="2" bordercolor="#333333">
		<frameset cols="450,*,450" id="resize"  border="1" frameborder="1" bordercolor="#333333"  FRAMESPACING="3">
			<frame noresize name="leftbtm" scrolling="no"  id="leftbtm" src="<%=request.getContextPath()%>/edu/eduBL"   frameborder="2">
			<frame noresize name="midbtm" id="midbtm" scrolling="no" src="<%=request.getContextPath()%>/edu/eduMD"   frameborder="2">
			<frame noresize name="rightbtm" id="rightbtm" scrolling="no" src="<%=request.getContextPath()%>/edu/eduBR"   frameborder="2">
		</frameset>
	</frameset>


	<body> 	</body>

</html>



