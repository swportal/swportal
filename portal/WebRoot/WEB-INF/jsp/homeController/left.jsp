<%@ page language="java" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
<!DOCTYPE html>
<html >
	<head>
	 <%  
   		 String path = request.getContextPath();  
    	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	%> 
		<title>Home Page</title>
	
		<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
			
			<link href="<%=basePath %>/style/left/jquery-accordion-menu.css" rel="stylesheet" type="text/css" />
			<link href="<%=basePath %>/style/left/font-awesome.css" rel="stylesheet" type="text/css" />
			
			<style type="text/css">
			*{box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;}
			body{background:#3c3c3c;}  /*背景*/
			.content{width:160px;margin: -7px}
			.filterinput{
				background-color:rgba(249, 244, 244, 0);
				border-radius:15px;
				width:98%;
				height:30px;
				border:thin solid #FFF;
				text-indent:0.5em;
				font-weight:bold;
				color:#FFF;
			}
			#demo-list a{
				overflow:hidden;
				text-overflow:ellipsis;
				-o-text-overflow:ellipsis;
				white-space:nowrap;
				width:98%;
			}
			</style>

	<script src="<%=basePath %>/js/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>/js/jquery-accordion-menu.js" type="text/javascript"></script>
	<script type="text/javascript">
		jQuery(document).ready(function () {
			jQuery("#jquery-accordion-menu").jqueryAccordionMenu();
			
		});
		
		$(function(){	
			//顶部导航切换
			$("#demo-list li").click(function(){
				$("#demo-list li.active").removeClass("active")
				$(this).addClass("active");
			})	
		})	
	</script>

	<script type="text/javascript">
	function openurl(url)  
	{  
	    var rframe = parent.document.getElementById("right") ;  
	    rframe.src = url;  
	   // parent.document.getElementById("menu11").location.reload;
	    //parent.document.getElementById("menu11").src="<%=basePath %>/home/left" ; 
	    //parent.document.getElementById("TopMenu").src.getElementByName("title")=+name ; 
	   //parent.document.getElementById("TopMenu").src="<%=basePath %>/home/left" ; 
	}  

	</script>
	
	
	
	<script type="text/javascript">
		
	</script>
	</head>

	<body >
	<div class="content">
		<div id="jquery-accordion-menu" class="jquery-accordion-menu white">		
			<ul id="demo-list">					
					<%-- 显示一级菜单 --%>
					<c:forEach items="${topPrivilegeList}" var="topp" varStatus = "v1">	
						<c:if test="${usersession == null }">
							<c:if test="${v1.index<2}">
								<li class="active"><a href="#"><i class="fa fa-cog"></i>${topp.name}</a>
								<ul class="submenu">								
											<%-- 显示二级菜单 --%>
											<c:forEach items="${topp.children }" var="c" varStatus="var">
											<c:if test="${v1.index==0 and var.index!=2}">																													
													<li><a href="${c.url}" target="right">${c.name}</a></li>
											</c:if>	
											<c:if test="${v1.index==1}">																													
													<li><a href="${c.url}" target="right">${c.name}</a></li>
												</c:if>											
											</c:forEach>
										</ul> 
								</li>
							</c:if>
						</c:if>
										
						<c:if test="${usersession.hasPrivilegeByName(topp.name)}">
								<li class="active"><a href="#"><i class="fa fa-cog"></i>${topp.name}</a>
									<ul class="submenu">								
										<%-- 显示二级菜单 --%>
										<c:forEach items="${topp.children }" var="c" varStatus="var">
											<c:if test="${usersession.hasPrivilegeByName(c.name)}">	
												<li><a href="${c.url}"  target="right">${c.name}</a></li>
											</c:if>
										</c:forEach>
									</ul> 
								</li>
						</c:if>
					</c:forEach>				
				</ul>
				<div class="jquery-accordion-menu-footer"></div>
		</div>
	</div>
	</body>
</html>