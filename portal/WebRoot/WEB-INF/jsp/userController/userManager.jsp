<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
	<%--   <title>User Management</title>--%>
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
   <style type="text/css">
  			 #footer{
	    		 position:relative;
	    		 bottom: -600px;
	    		 /*margin-left :600px;*/
	    	}
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
			   $.get("/portal/user/delUser?id="+id,function(data){
				   if("success"==data.result){
					  // alert("Delete done!");
					   window.location.reload();
				   }
				   else{
					   alert("Error");
				   }
			   });
		   }
		   else{
			   return;
		   }
	   }	
	   
	   function initpw(id){
		   if(confirm("Are you sure to initialize password?")){
			   $.get("/portal/user/initPassword?id="+id,function(data){
				   if("success"==data.result){
					   alert("Initialization Password is done!");
					   window.location.reload();
				   }
				   else{
					   alert("Error");
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
				<strong>| User Management |</strong>&nbsp;&nbsp;&nbsp;	
				<c:if test="${usersession.hasPrivilegeByName('User Add')}">
							<input type="button"  onclick="window.location.href='/portal/user/toAddUser'" value="Add" style="color:#95a5a6;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  &nbsp;&nbsp;
							<input type="button"  onclick="javascript:del('${u.id }')" value="Delete" style="color:#95a5a6;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
				</c:if>
			</li>
		</ul>
	</div>
	<center>
	 <div id="footer">
    	<table>
    		<tr  bgcolor='white' bordercolor='white'>
    			<td height='60px'>
    			<%
    				Integer cur=(Integer)request.getAttribute("curpage");
    				Integer tot=(Integer)request.getAttribute("total");
    			%>
    			
    			<% if(cur>1){%>
    				<a href="/portal/user/getAllUser?curpage=1" style="text-decoration: none; "><font color="#3498db"><<&nbsp;&nbsp;&nbsp;</font></a>
    				<a href="/portal/user/getAllUser?curpage=${curpage-1}" style="text-decoration: none; "><font color='#3498db'><&nbsp;&nbsp;&nbsp;</font></a>
    			<%}else{ %>
    				<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;&nbsp;
    			<%} %>
    			
    			${curpage }&nbsp;/&nbsp;${total }&nbsp;&nbsp;&nbsp;
    			
    			<% if(cur<tot){%>
    				<a href="/portal/user/getAllUser?curpage=${curpage+1}" style="text-decoration: none; "><font color='#3498db'>>&nbsp;&nbsp;&nbsp;</font></a>
    				<a  href="/portal/user/getAllUser?curpage=${total }" style="text-decoration: none; "><font color='#3498db'>>>&nbsp;&nbsp;&nbsp;</font></a> 
    			<%}else{ %>
    				>&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;&nbsp;
    			<%} %>
    			
    			
    			</td>
    		
    		</tr>
    	</table>
    </div>
    <div style="position:relative; bottom:40px">
    <table id = "tableRole"  bgColor="#FFFAF0" cellspacing="0px" border="2px"  cellpadding="0px"   style="border-collapse:collapse;">
            <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" height="40px" >
                <td align="center" width="150px"><strong>Login Name</strong></td>
                <td align="center" width="150px"><strong>Name</strong></td>
                <td align="center" width="100px"><strong>Gender</strong></td>
                <td align="center" width="150px"><strong>Role</strong></td>
                <td align="center" width="100px"><strong>Description</strong></td>
                <td align="center" width="300px"><strong>User Management</strong></td>
            </tr>
        
       
        
        <c:if test="${!empty users }">
			<c:forEach items="${users }" var="u">
            <tr bordercolor="#DEDEDE" bgcolor="#ffffff">
               <td align="center" height="30px" style="font-size:12px; color:#004779;text-align:center;">${u.loginName}</td>		
               <td align="center"  height="30px" style="font-size:12px; color:#004779;text-align:center;">${u.name}</td>	
                <td align="center"  height="30px" style="font-size:12px; color:#004779;text-align:center;">${u.gender}&nbsp;</td>
                <td align="center"  height="30px" style="font-size:12px; color:#004779;text-align:center;">
                	<c:forEach items="${u.roles }" var="r">
						${r.name}
					</c:forEach>
                </td>
                <td align="center"  height="30px" style="font-size:12px; color:#004779;text-align:center;">${u.description}</td>
                <td align="center"  height="30px" style="font-size:12px; color:#004779;text-align:center;">
                <c:if test="${usersession.hasPrivilegeByName('User Update')}">
                	<a href="/portal/user/getUser?id=${u.id}">Edit</a>
                </c:if>
                &nbsp;&nbsp;&nbsp;
                 <c:if test="${usersession.hasPrivilegeByName('User Delete')}">
					<a href="javascript:del('${u.id }')" onClick="return window.confirm('Are you sure to delete this user?')">Delete</a>
				</c:if>
				&nbsp;&nbsp;&nbsp;
				<c:if test="${usersession.hasPrivilegeByName('Init Password')}">
					<a href="javascript:initpw('${u.id }')" onClick="return window.confirm('Are you sure to initialize your password as '1234'?')">Password Reset</a>
				</c:if>
                </td>
            </tr>
       </c:forEach>
       </c:if> 
            
      
    </table>
    </div>
    <br/>    
   
   </center>
  </body>
</html>
