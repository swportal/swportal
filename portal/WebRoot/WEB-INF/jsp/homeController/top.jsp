<%@ page language="java" pageEncoding="UTF-8"%>
 <%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf"%>
<%@ page import="com.web.controller.entity.*"%>
<%@ taglib uri="myjstl" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
		<LINK href="<%=basePath %>/style/blue/top.css" type=text/css rel=stylesheet>
		<style type="text/css">
			#messageArea{
				color: white;
				font-size: 14px;
				font-weight: bold;
			}
		</style>
		<script>
			function logout(){
				$.getJSON("/portal/user/logout?rand="+Math.random(),function(data){
					if("success"==data.result){
						parent.location.href="/portal/home/index";
					}
					else{
						alert("logout failure!");
					}
				});			
			}
			function login(){
				window.open("/portal/user/logUI","_parent");
				//window.location.reload();
			}
		</script>
		
	</head>

	<body> 
		<div id="Head1" >
			<div id="Logo">
				<br/>
            	<font color="#0000CC" name="title"  style="color:#ffffff; font-size:28px; font-family:Arial Black, Arial">TSDR SW Portal</font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        	</div>
      
			<div id="Head1Right">
				<div id="Head1Right_UserName">
	                <img border="0" width="18" height="18" src="<%=basePath %>/style/images/top/user.png" /> <font style="font-size:11px; font-family:Microsoft YaHei">&nbsp;${usersession.name }
	                <c:forEach items="${usersession.roles }" var="r">
	                	${r.name }
	                </c:forEach>
	               </b></font>
			
					<%if(session.getAttribute("usersession")!=null){%>
						<input type="button"   value="Log Out" onclick="javascript:logout()" style="color:#2c3e50; font-size:8px;font-weight:bold; border-radius:3px; vertical-align:middle;height:20px;  width:50px; "/>
					<%}else {%>
						<input type="button"   value="Log In" onclick="javascript:login()" style="color:#2c3e50; font-size:8px;font-weight:bold; border-radius:3px; vertical-align:middle;height:20px;  width:50px; "/>
					<%} %>
				</div>
		  </div>
		</div>
	</body>
</html>
