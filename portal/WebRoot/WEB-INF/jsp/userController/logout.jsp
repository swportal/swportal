<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
<html>
<head>
	<title>Logout TSDR OA System</title>
	<link href="<%=basePath %>/style/blue/logout.css" rel="stylesheet" type="text/css">
</head>

<body>
	<table border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
		<tr>
			<td align=center>
				<div id=Logout>
					<div id=AwokeMsg>
                        <img id=LogoutImg src="<%=basePath %>/style/blue/images/logout/logout.gif" border=0>
                        <img id=LogoutTitle src="<%=basePath %>/style/blue/images/logout/logout1.jpg" border=0>
                    </div>
					<div id=LogoutOperate>
                        <img src="<%=basePath %>/style/blue/images/logout/logout2.gif" border=0> 
                        <a href="<%=basePath %>user/loginUI">Login Again</a> 
                        <img src="<%=basePath %>/style/blue/images/logout/logout3.gif" border=0> 
                        <a href="javascript: window.open('','_self');window.close();">Close Window</a>
                    </div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
