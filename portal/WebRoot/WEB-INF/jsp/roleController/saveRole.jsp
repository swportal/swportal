<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="myjstl" prefix="c"%> 
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%--		<title>Role Information</title>--%>
		<!-- Loading Bootstrap -->
	    <link href="<%=request.getContextPath()%>/FlatUI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	    <!-- Loading Flat UI -->
	    <link href="<%=request.getContextPath()%>/FlatUI/dist/css/flat-ui.css" rel="stylesheet">
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
		     	<%--  2017-03-21 wuliying add --%>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/button-flag.css" />
		<style type="text/css">
			ul,li{
				margin:0;
				padding:0;
				list-style:none;
			}
			#navtop{
				width:100%;
				height:46px;
				background-color:#ecf0f1;
				text-align:center;
				overflow:hidden;
			}
			.navtop-skin{
				float:left;
				position:relative;
				left:5%;
			}
			.navtop-skin li{
				float:left;
				margin:0px;
				padding:0 20px;
				position:relative;
				right:20%;
				line-height:40px;
				border:solid 0px #000;
			}	
		</style>
		<script type="text/javascript">
			function saveRole(){
			   	var form=document.forms[0];	 	    	
			   	form.action="${role.id }"==""? "/portal/role/addRole":"/portal/role/updateRole"; 
			   	form.method="post";
			   	form.submit();    	
			}    	
		 </script>
	</head>  
	<body>
 		<form action="">
			<input type="hidden" name="id" value="${role.id }">     
       		<div id="navtop">
				<ul class="navtop-skin">			
					<li>
							<strong>| Role Information |</strong>&nbsp;&nbsp;&nbsp;	
					</li>
				</ul>
			</div>
       		<br/>
        	<div align="center">
	        	<!-- 表单内容显示 -->    
	        	<div class="ItemBlockBorder" >
	        		<div class="ItemBlock">
			            <table cellpadding="0" cellspacing="0" >
			            	<tr>
			                	<td width="100"><font size="2" face="Arial" >Role Name:&nbsp;&nbsp;</font></td>
			                    <td>
									<%--  <input type="text" name="name" value="${role.name }" cssClass="InputStyle"> --%>
									<input type="text"  name="name" id="selectitem"  value="${role.name }"   style="color:#95a5a6; border-radius:5px;  width:200px; height:30px; vertical-align:middle;">*
			                    </td>
			                </tr>
			                <tr>
			                    <td><font size="2" face="Arial" >Role Description:&nbsp;&nbsp;</font></td>
			                    <td>
									<%-- <input type="textarea" name="description" value="${role.description }" cssClass="TextareaStyle">--%>
			                       	<input type="text"  name="description" value="${role.description }"  style="color:#95a5a6; border-radius:5px;  width:200px; height:30px; vertical-align:middle;">
			                    </td>
			                </tr>
			            </table>
		            </div>
	            </div>
           		<br/>
        
	        	<!-- 表单操作 -->
	            <input type="button"  onClick="saveRole()" value="Save" class="button button-raised button-rounded button-small"/>  &nbsp;&nbsp; <%--style="color:#000000;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; " --%>
	       		<input type="button"  onClick="javascript:history.go(-1);" value="Back" class="button button-raised button-rounded button-small"/>  &nbsp;&nbsp;
				<%--  <input type="image" src="<%=request.getContextPath()%>/style/images/save.png" onClick="saveRole()"/>--%>
				<%--  <a href="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/style/images/goBack.png"/></a>--%>
			</div>
		</form>
	</body>
</html>
