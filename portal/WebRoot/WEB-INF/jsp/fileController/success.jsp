<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <title></title>
  </head>  
  <body>
	    <font size="4" face="Arial" color="#004779"><strong>Upload Success!</strong></font>
	    <hr>
	    <font size="2" face="Arial" color="#004779"><strong>File List:</strong>
	    <c:forEach var="month" items="${files}">  
	        <li><a href="/portal/file/download/${month}">${month}</a> &nbsp;&nbsp;&nbsp;&nbsp;</li>  
	    </c:forEach> 
	    </font> 
  		<hr><br>  
<%-- 		 <a href="${pageContext.request.contextPath}/index.jsp">返回</a>  --%>
  </body>
</html>
