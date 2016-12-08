<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>管理系统</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">  

  function reloadcode(obj,base){  
  var rand=new Date().getTime(); 				//这里用当前时间作为参数加到url中，是为了使URL发生变化，这样验证码才会动态加载，  
            									//只是一个干扰作用，无确实意义，但却又非常巧妙，呵呵  
  obj.src=base+"randomimage.action?abc="+rand;  //其实服务器端是没有abc的字段的。  
  }  
 
</script>
	
	</head>

	<body>
		<center>
			<h1>
				用户登录
			</h1>
			<hr>
			<s:form name="loginForm" action="login" method="post" theme="simple">
				<s:bean name="net.nw.vo.Userroles" var="r"></s:bean>
				<table>
					<tr>
						<td>
							用户名：
						</td>
						<td>
							<s:textfield name="username">
							</s:textfield>
						</td>
						<td>
							<s:actionmessage cssStyle="color:red" /> <s:fielderror cssStyle="color:red"></s:fielderror>
						</td>
					</tr>
					<tr>
						<td>
							密码：
						</td>
						<td>
							<s:password name="password"></s:password>
						</td>
						<td></td>
					</tr>

					<tr>
						<td>
							登录类型：
						</td>
						<td>
							<s:select name="roleid" list="%{#r.roles}" headerKey="0"
								headerValue="--请选择--"></s:select>
						</td>
						<td></td>
					</tr>
					<tr>
						<td>
							验证码：
						</td>
						<td>
							<s:textfield name="randomCode" maxlength="4"></s:textfield>
						</td>
						<td>
							<!--  <img src="randomimage.action" alt="看不清楚？请点击刷新"
								style="cursor: ponitor; vertical-align: middle; height: 18px;" />-->
							<img title="看不清楚请点击这里" width="50" height="20" src="randomimage.action" id="safecode" onclick="reloadcode(this,'<%=basePath%>')" />
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" value="登录" />
						</td>
						<td>
							<input type="button" value="注销" onclick="" />
						</td>
						<td></td>
					</tr>

				</table>
			</s:form>

		</center>
	</body>
</html>
