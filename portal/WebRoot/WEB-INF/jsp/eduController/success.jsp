<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <title></title>
  </head>  
  <body>
	    <font size="4" face="Arial" color="#004779"><strong>File List:</strong></font>
	    <hr>
	    <font size="2" face="Arial" color="#004779">
	    <c:forEach var="file" items="${files}" varStatus = "var">  
	    	<table>
	    		<tr>
	    			<td width="450px">
	    				&nbsp;&nbsp;<a href="/portal/edu/download/${file}">${file}</a> &nbsp;&nbsp;&nbsp;&nbsp;
	    			</td>
	    			<td width="200px">
	    				${times[var.index]}
	    			</td>
	    		</tr>
	    	</table>
	    </c:forEach> 
	    </font> 
  		<hr><br>  
<%-- 		 <a href="${pageContext.request.contextPath}/index.jsp">返回</a>  --%>
  </body>
</html>
