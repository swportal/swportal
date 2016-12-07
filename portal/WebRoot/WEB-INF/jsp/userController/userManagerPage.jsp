<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <style type="text/css">
  	body{
  	text-align:center;
	margin-left:auto;
	margin-right:auto;}
  </style>
  <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <title>My JSP 'addUser.jsp' starting page</title>
    <script type="text/javascript">
	   function del(id){
		   $.get("/portal/user/delUser?id="+id,function(data){
			   if("success"==data.result){
				   alert("删除成功");
				   window.location.reload();
			   }
			   else{
				   alert("删除失败");
			   }
		   });
	   }	 
    </script>
  </head>  
  <body>
    <a href="/portal/user/toAddUser">添加用户</a>
	<table border="1" align="center">
		<tbody>
			<tr>
				<th>姓名</th>
				<th>年龄</th>
				<th>编辑</th>
			</tr>
			<c:if test="${!empty pageusers }">
			<c:forEach items="${pageusers }" var="u">
			<tr>
				<td>${u.userName}</td>
				<td>${u.age}</td>
				<td>
					<a href="/portal/user/getUser?id=${u.id}">编辑</a>
					<a href="javascript:del('${u.id }')">删除</a>
				</td>
			</tr>
			</c:forEach>
			</c:if>
			<tr>
            <td colspan="6" align="center">共${page.totalRecords}条记录 共${page.totalPages}页 当前第${page.pageNo}页<br>
                
                <a href="/portal/user/getAllUsers?pageNo=${page.topPageNo }"><input type="button" name="fristPage" value="首页" /></a>
                <c:choose>
                  <c:when test="${page.pageNo!=1}">
                    
                      <a href="/portal/user/getAllUsers?pageNo=${page.previousPageNo }"><input type="button" name="previousPage" value="上一页" /></a>
                    
                  </c:when>
                  <c:otherwise>
                    
                      <input type="button" disabled="disabled" name="previousPage" value="上一页" />
                    
                  </c:otherwise>
                </c:choose>
                <c:choose>
                  <c:when test="${page.pageNo != page.totalPages}">
                    <a href="/portal/user/getAllUsers?pageNo=${page.nextPageNo }"><input type="button" name="nextPage" value="下一页" /></a>
                  </c:when>
                  <c:otherwise>
                    
                      <input type="button" disabled="disabled" name="nextPage" value="下一页" />
                    
                  </c:otherwise>
                </c:choose>
                <a href="/portal/user/getAllUsers?pageNo=${page.bottomPageNo }"><input type="button" name="lastPage" value="尾页" /></a>
            </td>
        </tr>			
		</tbody>
	</table>
  </body>
</html>
