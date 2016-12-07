<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>


<!DOCTYPE html>
<html>
  <head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <title>Role Management</title>
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
	   function del(id){
		   if(confirm("Are you sure to delete this item?")){
			   $.get("/portal/role/delRole?id="+id,function(data){
				   if("success"==data.result){
					   //alert("Delete Done!");
					   window.location.reload();
				   }
				   else{
					   alert("Error!");
				   }
			   });
		   }
		   else{
			   return;
		   }	
	   }	 
    </script>
  </head>  
  <body>
	<div id="navtop">
		<ul class="navtop-skin">			
			<li>					
				<strong>| Role  Management |</strong>&nbsp;&nbsp;&nbsp;
				<c:if test="${usersession.hasPrivilegeByName('Role Add')}">
							<input type="button"  onclick="window.location.href='/portal/role/toAddRole'" value="Add" style="color:#95a5a6;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  &nbsp;&nbsp;
							<input type="button"  onclick="javascript:del('${r.id }')" value="Delete" style="color:#95a5a6;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
				</c:if>
			</li>
		</ul>
	</div>
	
	<br/>
	<center>
    <table id = "tableRole"  bgColor="#FFFAF0" cellspacing="0px" border="2px"  cellpadding="0px"   style="border-collapse:collapse; ">
            <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" height="40px" >
            	<td align="center" width="200px"  ><strong>Role Name</strong></td>
                <td align="center" width="400px"  ><strong>Role Description</strong></td>
                <td align="center" width='300px'  ><strong>Role Management</strong></td>
            </tr>
      

		<!--显示数据列表-->
       
       
       	<c:if test="${!empty roles }">
			<c:forEach items="${roles }" var="r">
			 <tr bordercolor="#DEDEDE" bgcolor="#ffffff" >
				<td align="center" height="30px"  bordercolor="#DEDEDE" style="font-size:12px; color:#004779;text-align:center;">${r.name}</td>
				<td align="center" height="30px"  bordercolor="#DEDEDE" style="font-size:12px; color:#004779;text-align:center;">${r.description}</td>
				<td align="center" height="30px"  bordercolor="#DEDEDE" style="font-size:12px; color:#004779;text-align:center;">
					<c:if test="${usersession.hasPrivilegeByName('Role Update')}">
						<a href="/portal/role/getRole?id=${r.id}">Edit</a>
					</c:if>
					&nbsp;&nbsp;&nbsp;
					<c:if test="${usersession.hasPrivilegeByName('Role Delete')}">	
						<a href="javascript:del('${r.id }')">Delete</a>
					</c:if>
					&nbsp;&nbsp;&nbsp;
					<c:if test="${usersession.hasPrivilegeByName('Set Priviledge')}">	
						<a href="/portal/role/setPrivilegeUI?id=${r.id}">Set Privilege</a>
					</c:if>
					
				</td>
			</tr>
       </c:forEach>
       </c:if>
 
    </table>
    <br/>
    </center>
    <br/> 
   
  </body>
</html>
