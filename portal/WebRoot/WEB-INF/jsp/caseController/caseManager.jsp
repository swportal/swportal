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
		
		<title>Portal-Failed Case Management</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
		
		<link rel="shortcut icon" href="<%=request.getContextPath()%>/FlatUI/img/samsung6.ico">   <!-- 更改标题图标 -->
		
	</head>

	<frameset rows="570,*"  FRAMESPACING="3">
		<frame noresize name="Top" scrolling="no" src="<%=request.getContextPath()%>/case/caseTop"   frameborder="2" bordercolor="#333333">
		<frameset cols="25%,25%,25%,25%" id="resize"  border="1" frameborder="1" bordercolor="#333333"  FRAMESPACING="3">
			<frame noresize name="caseType"     scrolling="no"  id="caseType"    src="<%=request.getContextPath()%>/case/caseType"    frameborder="2">
			<frame noresize name="caseChip"     scrolling="no"  id="caseChip"    src="<%=request.getContextPath()%>/case/caseChip"    frameborder="2">
			<frame noresize name="casePhase"    scrolling="no"  id="casePhase"   src="<%=request.getContextPath()%>/case/casePhase"   frameborder="2">
			<frame noresize name="caseImprove"  scrolling="no"  id="caseImprove" src="<%=request.getContextPath()%>/case/caseImprove" frameborder="2">
	</frameset>


	<body> 	</body>

</html>



