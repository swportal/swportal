<!DOCTYPE html>
<html lang="en">
  <head>
 	 <%  
   		 String path = request.getContextPath();  
    	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	%> 
    <meta charset="utf-8">
	<title>TSDR SW Portal</title>
<%--	<link href="<%=basePath %>/FlatUI/style/blue/login.css" type="text/css" rel="stylesheet" charset="utf-8">	--%>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=1000, initial-scale=1.0, maximum-scale=1.0">
    <%--2016/11/08 add by wuliying to make getJSON active --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <!-- Loading Bootstrap -->
    <link href="<%=basePath %>/FlatUI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="<%=basePath %>/FlatUI/dist/css/flat-ui.css" rel="stylesheet">
    <link href="<%=basePath %>/FlatUI/docs/assets/css/demo.css" rel="stylesheet">

    <link rel="shortcut icon" href="<%=basePath %>/FlatUI/img/samsung6.ico">   <!-- 更改标题图标 -->
	
	<style>
		body{
			margin: 10px auto;
			min-width: 780px;
			max-width: 1260px;		
		}
	</style>
	
	
	
	<script type="text/javascript">
		$(function(){
			document.forms[0].loginName.focus();
		});
		
		// 在被嵌套时就刷新上级窗口
		if(window.parent != window){
			window.parent.location.reload(true);
		}
	</script>
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

  <body>
    <div class="container">



<!-- 显示表单 -->
<form action="/portal/user/login"  method="post">
    <div class="login">
        <div class="login-screen" >
          <div class="login-icon" >
<%--            <img src="../../../FlatUI/img/login/icon.png" alt="Welcome to TSDR SW Portal" />--%>
            <h5>Welcome to <small><font color="#ffffff">TSDR SW Portal</font></small></h5>
          </div>

          <div class="login-form">
            <div class="form-group">
              <input type="text" class="form-control login-field" value="" placeholder="Enter your name" id="loginName" name="loginName"/>
              <label class="login-field-icon fui-user" for="loginName"></label>
            </div>

            <div class="form-group">
              <input type="password" class="form-control login-field" value="" placeholder="Password" id="password"  name="password"/>
              <label class="login-field-icon fui-lock" for="password"></label>
            </div>

            <input type="submit" class="btn btn-primary btn-lg btn-block"  value="Log in" />
            <a class="login-link" href="/portal/home/index">Let's get started!</a>
          </div>
        </div>
      </div>

    </form>
    </div>
</body>

</html>

