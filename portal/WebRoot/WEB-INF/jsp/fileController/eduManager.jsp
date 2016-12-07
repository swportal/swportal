<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 	<head>
   		<title>Education Management</title>
  		<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.2.min.js"></script>
     	
	    <style> 
			input.t {
				border:1px solid #fff;
				background:#fff; 			
	 			padding-left:5px; 
	 			height:30px; 
	 			line-height:30px 
	 			
	 		} 
			input.s {
				border:1px solid #369;
				background:#fff; 
				padding-left:5px;
		 		height:30px; 
		 		line-height:30px
	 		} 
	 		#MainArea form{
				padding-left: 0px;
			}
		</style> 
    
		<script type="text/javascript"> 
		   $(function(){	
				var inputTitle = document.getElementById("inputTitle"); 
				var inputObj = document.getElementById("inputObj"); 
				var inputCont = document.getElementById("inputCont"); 
				var inputSchedule = document.getElementById("inputSchedule"); 
				var inputDuration = document.getElementById("inputDuration"); 
				var inputName = document.getElementById("inputName"); 
				var inputDepart = document.getElementById("inputDepart"); 
				var inputTrainee = document.getElementById("inputTrainee"); 
				var inputRemarks = document.getElementById("inputRemarks"); 
				var submitTitle = document.getElementById("submitTitle"); 
				var submitObj = document.getElementById("submitObj"); 	
				var submitCont = document.getElementById("submitCont"); 	
				var submitSchedule = document.getElementById("submitSchedule"); 	
				var submitDuration = document.getElementById("submitDuration"); 	
				var submitName = document.getElementById("submitName"); 	
				var submitDepart = document.getElementById("submitDepart"); 	
				var submitTrainee = document.getElementById("submitTrainee"); 	
				var submitRemarks = document.getElementById("submitRemarks"); 	
				inputTitle.ondblclick = function(){
						this.readOnly = false; 
				 		this.className = "s"; 
				 		submitTitle.style.display = ""; 
				} 
				submitTitle.onclick = function(){ 
						inputTitle.readOnly = true; 
						inputTitle.className = "t"; 
						this.style.display = "none"; 
						var form=document.forms[0];	 	    	
				    	form.action="/portal/edu/updateEdu"; 
				    	
				    	//alert("aa");
				    	form.method="post";
				    	form.submit();    	
				} 
				inputObj.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitObj.style.display = ""; 
				} 
				submitObj.onclick = function(){ 
						inputObj.readOnly = true; 
						inputObj.className = "t"; 
						this.style.display = "none"; 
				} 
				inputCont.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitCont.style.display = ""; 
				} 
				submitCont.onclick = function(){ 
						inputCont.readOnly = true; 
						inputCont.className = "t"; 
						this.style.display = "none"; 
				} 
				inputSchedule.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitSchedule.style.display = ""; 
				} 
				submitSchedule.onclick = function(){ 
						inputSchedule.readOnly = true; 
						inputSchedule.className = "t"; 
						this.style.display = "none"; 
				} 
				inputDuration.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitDuration.style.display = ""; 
				} 
				submitDuration.onclick = function(){ 
						inputDuration.readOnly = true; 
						inputDuration.className = "t"; 
						this.style.display = "none"; 
				} 
				inputName.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitName.style.display = ""; 
				} 
				submitName.onclick = function(){ 
						inputName.readOnly = true; 
						inputName.className = "t"; 
						this.style.display = "none"; 
				} 
				inputDepart.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitDepart.style.display = ""; 
				} 
				submitDepart.onclick = function(){ 
						inputDepart.readOnly = true; 
						inputDepart.className = "t"; 
						this.style.display = "none"; 
				} 
				inputTrainee.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitTrainee.style.display = ""; 
				} 
				submitTrainee.onclick = function(){ 
						inputTrainee.readOnly = true; 
						inputTrainee.className = "t"; 
						this.style.display = "none"; 
				} 
				inputRemarks.ondblclick = function(){
					this.readOnly = false; 
			 		this.className = "s"; 
			 		submitRemarks.style.display = ""; 
				} 
				submitRemarks.onclick = function(){ 
						inputRemarks.readOnly = true; 
						inputRemarks.className = "t"; 
						this.style.display = "none"; 
				} 
		   });
	 	 </script>  
	 	 
	 	 <script type="text/javascript">
		   function del(id){
			   if(confirm("Are you sure to delete this item?")){
				   $.get("/portal/edu/delEdu?id="+id,function(data){
					   if("success"==data.result){
						   alert("Delete Done!");
						   window.location.reload();
					   }
					   else{
						   alert("Error!");
					   }
				   });
			   }else{
				   return;
			   }
			   
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
    		<table cellspacing="0" cellpadding="0" class="TableStyle">
       
	       		<!-- 表头-->
	       		<thead>
		            <tr align=center valign=middle id=TableTitle>		             	
		                <td width="150px" rowspan="2">Training Title</td>
		                <td width="80px" rowspan="2">Objective</td>
		                <td width="300px" rowspan="2">Contents</td>
		                <td width="100px" rowspan="2">Schedule</td>
		                <td width="100px" rowspan="2">Duration</td>
		                <td width="230px" colspan="2">Trainer</td>
		                <td width="100px" rowspan="2">Trainee</td>
		                <td width="200px" rowspan="2">Remarks</td>	  
		                <td width="10px" rowspan="2"> <img border="0" width="15" height="15" src="<%=basePath %>/style/images/del.png" onClick="javascript:del('${e.id }')" /></td>            
		            </tr>
	             	<tr align=center valign=middle id=TableTitle>
	              	    <td width="80px">Name</td>
	                 	<td width="150px">Department</td>
	                </tr>
				</thead>
	        
	       		<!--显示数据列表-->
	       		
	       		<col style="width: 20%" />  <%--Title --%>
				<col style="width: 5%" /> 	 <%--Objective --%>
				<col style="width: 20%" />	<%--Contents --%>
				<col style="width: 10%" />	<%--Schedule --%>
				<col style="width: 5%" />	<%--Duration --%>
				<col style="width: 5%" />	<%--Name --%>
				<col style="width: 5%" />	<%--Department --%>
				<col style="width:10%" />	<%--Trainee --%>
				<col style="width: 20%" />	<%--Remarks --%>
				<col style="width: 1%" />  <%--Delete --%>
	        	<tbody id="TableData" class="dataContainer" datakey="eduList">    
	        	<c:forEach items="${edus }" var="e">    
		            <tr class="TableDetail1 template">	            	
						<input type="hidden" name="id" value="${e.id }">
						<td><input type="text"  class="t" id="inputTitle" readonly value="${e.title }" >   
							<input type="submit" value="Edit" style="display:none;" id="submitTitle" /> </td>	
						<td><input type="text"  class="t" id="inputObj" readonly value="chinachina"   > 
							<input type="submit" value="Edit" style="display:none;" id="submitObj" /> </td>		
						<td><input type="text"  class="t" id="inputCont" readonly value="${e.contents }"  > 
							<input type="submit" value="Edit" style="display:none;" id="submitCont" /> </td>		
						<td><input type="text"  class="t" id="inputSchedule" readonly value="${e.schedule }"  > 
							<input type="submit" value="Edit" style="display:none;" id="submitSchedule" /> </td>		
						<td><input type="text"  class="t" id="inputDuration" readonly value="${e.duration }"  >
							<input type="submit" value="Edit" style="display:none;" id="submitDuration" /> </td>		
						<td><input type="text"  class="t" id="inputName" readonly value="${e.trainerName }"  >
							<input type="submit" value="Edit" style="display:none;" id="submitName" /> </td>				
						<td><input type="text"  class="t" id="inputDepart" readonly value="${e.department }" >
							<input type="submit" value="Edit" style="display:none;" id="submitDepart" /> </td>		
						<td><input type="text"  class="t" id="inputTrainee" readonly value="${e.trainee }">
							<input type="submit" value="Edit" style="display:none;" id="submitTrainee" /> </td>			
						<td><input type="text"  class="t" id="inputRemarks" readonly value="${e.remarks }"  >
							<input type="submit" value="Edit" style="display:none;" id="submitRemarks" /> </td>	
						<td><img border="0" width="15" height="15" src="<%=basePath %>/style/images/lajitong.jpg" onClick="javascript:del('${e.id }')" /></td>   			                
		            </tr>
		            </c:forEach>
	           </tbody>
   		 </table>
        
   		<div id="TableTail">
      	 	 <div id="TableTail_inside">
		        <c:if test="${usersession.hasPrivilegeByName('User Add')}">
		            <a href="/portal/edu/toAddEdu"><img src="<%=basePath %>style/images/createNew.png" /></a>
		        </c:if>
        	</div>
   		</div>
   		</form>
	</div>   
  </body>
</html>
