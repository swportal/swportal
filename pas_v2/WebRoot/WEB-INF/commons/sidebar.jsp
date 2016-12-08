<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'index.jsp' starting page</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
	function refresh()

	{
		window.location = "${pageContext.request.contextPath}/select.action";

	}
</script>
	</head>

	<body>
		<br>
		
		<br>
		<ul>
			<li>
				<a href="admin.action"><font color=blue>SW Function Name</font>
				</a>
			</li>
			<li>
				<a href="/index.jsp"><font color=red>Image Name</font>
				</a>
			</li>
		</ul>
		登录信息：
		<br>
		用户名：
		<s:property value="username" />
		<br>
		密码：
		<s:property value="password" />
		<br>
		<s:bean name="net.nw.dao.UserroleTransferDAO" var="utd1"></s:bean>
		类型：
		<s:property value="#request.msg"></s:property>
		<br>

		<s:form name="selectForm" action="select" method="post" theme="simple">
			<s:bean name="net.nw.vo.Modelcodes" var="c"></s:bean>
			<!-- Model Code:
			<s:select name="codeid" list="%{#c.codes}" headerKey="0"
				headerValue="--请选择--" onchange="this.form.submit()"></s:select>
			<br> -->
			<input type="submit" value="查询" />
		</s:form>


	</body>
</html>
