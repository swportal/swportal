<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>


<!DOCTYPE html>
<html>
	<head>
  		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
		<script>
	     	$(document).ready(function(){
	     		  $("#btnsub").click(function(){
			     		if (($("#file1").val()=="")&& ($("#file2").val()=="")&&($("#file3").val()=="")){
			     		     alert ("Please select at least one file to upload!");
			     		}
			     		else if((($("#file1").val()!="")&&($("#file1").val()==$("#file2").val()||$("#file1").val()==$("#file3").val()))||(($("#file2").val()!="")&&($("#file2").val()==$("#file3").val()))){
			     			alert ("Please don't upload the same file!")
			     		}//2016-11-26 wuliying add to avoid uploading the same file
			     		else	{
			     		    $("#fileForm").submit();
			     		}
	     		  });
	     	});
     	</script>
	</head>  
  <body>
	<font size="4" face="Arial" color="#004779"><strong>&nbsp;&nbsp;File Upload: </strong></font>
	<hr>		      


	   <form id="fileForm" action="/portal/trip/upload" method="post" enctype="multipart/form-data">
	    	<input type="hidden" name="id" id="id" value="${id }">
	   		<font size="2" face="Arial" color="#004779">&nbsp;&nbsp;<strong>Select:</strong></font> <br/>
	   		&nbsp;&nbsp;<input type="file" id="file1" name="files"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:500px; height:28px; vertical-align:middle;">
	   		<br/>
	   		&nbsp;&nbsp;<input type="file" id="file2" name="files"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:500px; height:28px; vertical-align:middle;">
	   		<br/>
	   		&nbsp;&nbsp;<input type="file" id="file3" name="files"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:500px; height:28px; vertical-align:middle;">
	   		<br/><br/>&nbsp;
	   		<input type="button" id="btnsub" value="Upload" style="color:#2c3e50;font-size:12px; font-weight:bold; border-radius:5px; vertical-align:middle;height:30px;  width:60px; ">
	   </form>
		<br/><br/><br/><br/>	
		<font size="4" face="Arial" color="#004779"><strong>&nbsp;&nbsp;File List:</strong></font>
	    <hr>
	    <font size="2" face="Arial" color="#004779">
	    <c:forEach var="file" items="${files}" varStatus = "var">  
	    	<table>
	    		<tr>
	    			<td width="400px">
	    				&nbsp;&nbsp;<a href="/portal/trip/download/${file}">${file}</a> &nbsp;&nbsp;&nbsp;&nbsp;
	    			</td>
	    			<td width="200px">
	    				${times[var.index]}
	    			</td>
	    			<c:if test="${files.size()>0}">
		    			<td>
		    				<a href="/portal/trip/delete/${file}?id=${id }">Delete</a>
		    			</td>
	    			</c:if>
	    		</tr>
	    	</table>
	    </c:forEach> 
	    </font> 
  </body>
</html>
