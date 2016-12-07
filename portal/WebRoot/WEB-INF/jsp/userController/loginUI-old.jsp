<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
<html>
<head>
	<title>TSDR OA System</title>
	<link href="<%=basePath %>/style/blue/login.css" type="text/css" rel="stylesheet" charset="utf-8">
	
	<script type="text/javascript">
		$(function(){
			document.forms[0].loginName.focus();
		});
		
		// 在被嵌套时就刷新上级窗口
		if(window.parent != window){
			window.parent.location.reload(true);
		}
	</script>
	
	<%--<script type="text/javascript">
	  $(function(){
		   $.get("/springMVCSSH2/user/login",function(data){
			   if("fail"==data.result){
				   alert("aa");
				  document.getElementById("error").innerHTML="<font color="red">用户名或者密码错误</font>";
			   }
			  
		   });
	   }
	</script>
--%>
</head>

<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 class=PageBody >



<!-- 显示表单 -->
<form action="/portal/user/login" focusElement="loginNameInput">
    <div id="CenterAreaBg"> 
        <div id="CenterArea">
            <div id="LogoImg"><img border="0" src="<%=basePath %>/style/blue/images/logo.png" /></div>
            <div id="LoginInfo">
                <table BORDER=0 CELLSPACING=0 CELLPADDING=0 width=100%>
                	<tr>
                		<td colspan="3"><!-- 显示错误 -->
							<font color="red">&nbsp;&nbsp;&nbsp;${loginError }</font>
                		</td> 
                	</tr>
                    <tr>
                        <td width=45 class="Subject"><img border="0" src="<%=basePath %>/style/blue/images/login/userId.gif" /></td>
                        <td>
                        	<input type="text" name="loginName" size="19" tabindex="1" cssClass="TextField required" id="loginNameInput" />
                        </td>
                        <td rowspan="2" style="padding-left:10px;">
                        	<input type="image" tabindex="3" src="<%=basePath %>/style/blue/images/login/userLogin_button.jpg" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Subject"><img border="0" src="<%=basePath %>/style/blue/images/login/password.gif" /></td>
                        <td><input type="password" name="password" id="aa" size="20" tabindex="2" showPassword="false" cssClass="TextField required" /></td>
                    </tr>
                </table>
            </div>
            <div id="CopyRight"><a href="javascript:void(0)">&copy; 2016 版权所有 TSEC TSDR SE Lab</a></div>
        </div>
    </div>
    </form>
</body>

</html>

