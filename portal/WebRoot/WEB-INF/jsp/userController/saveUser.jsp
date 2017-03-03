<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <!-- Loading Bootstrap -->
    <link href="<%=request.getContextPath()%>/FlatUI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="<%=request.getContextPath()%>/FlatUI/dist/css/flat-ui.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/FlatUI/docs/assets/css/demo.css" rel="stylesheet">
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
	<%--    <title>User Information</title>--%>
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
	    function saveUser(){
	    	var form=document.forms[0];	 	    	
	    	form.action="${user.id }"==""? "/portal/user/addUser":"/portal/user/updateUser";
 	    	form.method="post";
	    	form.submit();    	
	    }    	
	</script>
	<style type="text/css">
<%--			*{margin:0;padding:0;}--%>
			select{
					border: solid 1px #909993 ;
					outline:none;
					margin:22
			}
	</style>
  </head>  
  <body>
  
  <div id="navtop">
				<ul class="navtop-skin">			
					<li>
							<strong>| User Information |</strong>&nbsp;&nbsp;&nbsp;	
					</li>
				</ul>
 </div>
 <br/>
<div align="center">
	<form action="">
 		<input type="hidden" name="id" value="${user.id }">
 			
	   		<div class="ItemBlockBorder">
            	<div class="ItemBlock">
                	<table cellpadding="0" cellspacing="0" >
	  					<tr>
	  						<td><font size="2" face="Arial" >Login Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	  						<td><input type="text"  name="loginName"  value="${user.loginName}"   style="color:#95a5a6; border-radius:5px;  width:100px; height:30px; vertical-align:middle;"> * <font size="1" face="Arial" >(Login Name must be unique!)</font></td>
							<%--<td><input type="text" name="loginName" value="${user.loginName}" class="form-control input-sm" width="10px"/> *（Login Name must be unique!）</td>--%>
	  					</tr>
	 					 <tr>
		 					<td><font size="2" face="Arial" >Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
		 					<td><input type="text"  name="name"  value="${user.name}"   style="color:#95a5a6; border-radius:5px;  width:100px; height:30px; vertical-align:middle;"> *</td>
							<%--<td><input type="text" name="name" value="${user.name}"  cssClass="InputStyle"/> *</td>--%>
     					 </tr>
     					 <tr>
		 					<td><font size="2" face="Arial" >Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
		 					<td><input type="text"  name="password"  value="${user.password}"   style="color:#95a5a6; border-radius:5px;  width:300px; height:30px; vertical-align:middle;"> *</td>
							<%--<td><input type="text" name="password"  value="${user.password}" cssClass="InputStyle"/> *</td>--%>
     					 </tr>
<%--     					 <tr>--%>
<%--      						<td>Gender</td>--%>
<%--       						 <td>--%>
<%--            					 <input type="radio" name="gender" value="Male" id="Male" <c:if test="${user.gender=='Male'}">checked</c:if>/><label for= "male">Male</label>--%>
<%--	  		 					<input type="radio" name="gender" value="Female" id="Female" <c:if test="${user.gender=='Female'}">checked</c:if>/><label for= "female">Female</label><br/>--%>
<%--							</td>--%>
<%--      					</tr>--%>
     					 <tr>
      						<td><font size="2" face="Arial" >Phone Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
      						<td><input type="textarea"  name="phoneNumber"  value="${user.phoneNumber}"   style="color:#95a5a6; border-radius:5px;  width:100px; height:30px; vertical-align:middle;"></td>
							<%--<td><input type="textarea" name="phoneNumber" value="${user.phoneNumber}" cssClass="InputStyle" /></td>--%>
     					 </tr>
      
	  
	  	 				<tr>
	  	 					<td><font size="2" face="Arial" >E-mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	  	 					<td><input type="textarea"  name="email"  value="${user.email}"   style="color:#95a5a6; border-radius:5px;  width:100px; height:30px; vertical-align:middle;"></td>
							<%--<td><input type="textarea" name="email" value="${user.email}" cssClass="InputStyle"/></td>--%>
                  		</tr>
                    	<tr>
                    		<td><font size="2" face="Arial" >Description:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                    		<td><input type="textarea"  name="description"  value="${user.description}"   style="color:#95a5a6; border-radius:5px;  width:100px; height:30px; vertical-align:middle;"></td>
							<%--<td><input type="textarea"  name="description"  value="${user.description}" cssClass="TextareaStyle"></s:textarea></td>--%>
                    	</tr>
	  				 </table>
			  	  </div>
		        </div>
	  	
				<div class="ItemBlock_Title1"><!-- 信息说明 -->
			        	<font size="2" face="Arial" >Role Authority </font>
			    </div> 
			  
					<!-- 表单内容显示 -->
        			<div class="ItemBlockBorder">
            		
               				<table cellpadding="0" cellspacing="0" >
                   			   <tr>
								<td><font size="2" face="Arial" >&nbsp;&nbsp;&nbsp;&nbsp;Role:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                       			 <td>
                        			<select id="roleIds" name="roleIds" multiple="true" background:#000000  value="${roleIds}"  style="width:150px;color:#95a5a6; border-radius:5px;"  >	  	
	  									<c:forEach items="${roleList}" var="c" varStatus="status">
	  										<option value="${c.id}" <c:forEach items="${roleIds}" varStatus="va"> <c:if test="${roleIds[va.index]==c.id}">selected</c:if></c:forEach> > ${c.name}</option>
	   									</c:forEach>
	  								</select><font size="1" face="Arial" >Ctrl key can do the multi-select or withdraw</font>
                       			 </td>
                    			</tr>
               			 	</table>
           			 	
       			 </div>		
			
		        <!-- 表单操作 -->
		        <div id="InputDetailBar">
<%--		            <input type="image" src="<%=request.getContextPath()%>/style/images/save.png" onClick="saveUser()"/>--%>
<%--		            <a href="javascript:history.go(-1);"><img src="<%=request.getContextPath()%>/style/images/goBack.png"/></a>--%>
		            <input type="submit"  value="Save" style="color:#000000;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; " onClick="saveUser()"/>  &nbsp;&nbsp;
					<input type="button"  onclick="javascript:history.go(-1);" value="Back" style="color:#000000;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
		        </div>
		</form>
   	</div>	    
 </body>
</html>
