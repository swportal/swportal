<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Role Information</title>
  <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
	    function saveEdu(){
	    	var form=document.forms[0];	 	    	
	    	form.action="/portal/edu/addEdu"; 
	    	form.method="post";
	    	form.submit();    	
	    }    	
   </script>
  </head>  
  <body>
  
  <div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="<%=basePath %>/style/images/title_arrow.gif"/> Education Management
        </div>
        <div id="Title_End"></div>
    </div>
</div>
<div id="MainArea">
 <form action="">    
  		<input type="hidden" name="id" value="${e.id }">
        <div class="ItemBlock_Title1"> Education Information 
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
                     <tr>
	                        <td width="100">Training Title</td>
	                        <td><input type="text" name="edutitle" value=" " cssClass="InputStyle"> *</td>
	                    </tr>
	                    <tr>
	                        <td>Objective</td>
	                        <td><input type="textarea" name="objective" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Contents</td>
	                        <td><input type="textarea" name="contents" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Schedule</td>
	                        <td><input type="textarea" name="schedule" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Duration</td>
	                        <td><input type="textarea" name="duration" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Trainer Name</td>
	                        <td><input type="textarea" name="trainerName" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Trainer Department</td>
	                        <td><input type="textarea" name="department" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Trainee</td>
	                        <td><input type="textarea" name="trainee" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
	                     <tr>
	                        <td>Remarks</td>
	                        <td><input type="textarea" name="remarks" value=" " cssClass="TextareaStyle"></td>
	                    </tr>
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${pageContext.request.contextPath}/style/images/save.png" onClick="saveEdu()"/>
            <a href="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/style/images/goBack.png"/></a>
        </div>
    </s:form>
</div>	  
  </body>
</html>
