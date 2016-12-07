<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>


<!DOCTYPE html>
<html>
  <head>
  <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <title></title>
  </head>  
  <body>
File Upload
		      


	   <form name="fileForm" action="/portal/file/upload" method="post" enctype="multipart/form-data">
	   		Select:<input type="file" name="file">
	   		<input type="submit" value="Upload">
	   	
	   </form>

  </body>
</html>
