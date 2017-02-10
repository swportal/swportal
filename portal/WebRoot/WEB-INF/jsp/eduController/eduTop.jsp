<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>



<!DOCTYPE html>
<html>
 	<head>
   		<title>Education Management</title>
  		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
	    <style type="text/css"> 
	    	hr{
		    	position:relative;
				bottom: -500px;
		    }
		    a{
				TEXT-DECORATION:none
			}
	    	#footer{
	    		 position:relative;
	    		 bottom: -5px;
	    	}
	    	.current-page  {
	    		font-size:12px;
	 			font-color: #004779;
	    	}
	    	.page-num  {
	    		font-size:12px;
	 			font-color: #004779;
	    	}
	    	input[type=text]::-ms-clear{
				display: none;
			}
			input::-webkit-search-cancel-button{
				display: none;
			}  
			input.t {
				border:1px solid #fff;
				background:#fff; 			
	 			padding-left:5px; 
	 			height:30px; 
	 			line-height:30px;
	 			/*font-size:16px;*/
	 			/*font-color: #004779;*/
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
			.test_box {
					    width: 280px; 
					    min-height: 20px; 
					    max-height: 300px;
					    
					    margin-left: auto; 
					    margin-right: auto; 
					    padding: 3px; 
					    outline: 0; 
					    border: 0px solid #a0b3d6; 
					    font-size: 12px; 
					    word-wrap: break-word;
					    overflow-x: hidden;
					    overflow-y: hidden;
					    _overflow-y: visible;
			}
			.textPlace{ position:relative; top:-5px; } 
			
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
				/*position:relative;
				left:5%;*/
			}
			.navtop-skin li {
				float:left;
				margin:0px;
				padding:0 20px;
				/*position:relative;
				right:20%;*/
				margin-left:20px;
				
				line-height:40px;
				border:solid 0px #000;
			}
			.navtop-right{
				float:right;
				position:relative;
				right:11%;
			}	
			select option {font-size:12px; font-family:Arial}			
		</style>
    
		<script type="text/javascript">	
			var f=0;
			var pn=1;
			var flag1,flag2;
			var orderitm;
			var orderk;
			function addEdu(){			 	
				$.getJSON("/portal/edu/addEdu?adr="+Math.random(),function(data){
					if("success"==data.result){					  
						window.location.reload();
					}
					else{
 				   		alert("Error!");
					   	window.location.reload();
					}
				});	 
			}
			function delEdu(){			
				var obj=document.getElementsByName('isSelect'); 
				var s1="Select:"; 
				var ids='';
				for(var i=0; i<obj.length; i++){ 
					if(obj[i].checked) ids=ids+obj[i].value+","; //如果选中，将value添加到变量s中 
				} 	
				if(ids==''){
					alert("Please choose one!");
				}
					
				else{	
					if(confirm("Are you sure to delete this item?")){
						$.get("/portal/edu/delEduList?ids="+ids,function(data){
							   if("success"==data.result){
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
			} 
		
			function del(id){			  
				if(confirm("Are you sure to delete this item?")){
					$.get("/portal/edu/delEdu?id="+id,function(data){
						if("success"==data.result){
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
			function updateEdu(element,id){			
				$.getJSON("/portal/edu/updateEdu?id="+id+"&item="+element.id+"&value="+encodeURIComponent(element.value,"utf-8"),function(data){
					if("success"==data.result){
					  	// window.location.reload();
				  		load(pn,flag1,flag2,orderitm,orderk);
					}
					else{ 
						alert("Update Error!");
					}
				 });
			}
			  
			function sel(obj){
				var a = document.getElementsByName('isSelect');
				for(var i = 0;i<a.length;i++){
					a[i].checked = obj.checked;
				}
			}
			  
			function changeUrl(item,value,id){
				/*url=encodeURI(encodeURI(value));//转码两次，很关键
				url = url.replace(/\+/g,"+");
				url = url.replace(/\&/g,"&");
				url = url.replace(/\#/g,"#");*/
				var winObj = window.open ("/portal/edu/changeUrl?id="+id+"&item="+item+"&value="+encodeURIComponent(value), "newwindow", "height=100, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				var loop = setInterval(function() {       
					if(winObj.closed) {      
				    	clearInterval(loop);      
			            window.location.reload();
			        }      
			    }, 1); 				 
			}
			function changeUrl(){
				var winObj = window.open ("/portal/edu/changeUrl", "newwindow", "height=100, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				var loop = setInterval(function() {       
					if(winObj.closed) {      
				    	clearInterval(loop);      
			            window.location.reload();
			        }      
			    }, 1); 				 
		  	}
			  
			function sort(eduFlag,iRow, iCol){
				var table=document.getElementById("tableEdu");
				var ascChar = "▲";
		        var descChar = "▼";
		        var rows=table.tHead.rows;		         
		        for (var i = 0; i < rows.length; i++) {
					for(var j=0;j<rows[i].cells.length;j++){//取得第几行下面的td个数，再次循环遍历该行下面的td元素
						var th = rows[i].cells[j];					 
						var thText= th.innerHTML.replace(ascChar, "").replace(descChar, "");
						if(i==iRow&&j==iCol){	
						}
						else{
							th.innerHTML=thText;
						}					
					}
				}
		        var th = rows[iRow].cells[iCol];
		        if(++f%2==0){
		        	load(1,eduFlag,flag2,"schedule","DESC");
		        	th.innerHTML=th.innerHTML.replace(ascChar, descChar);
		       	}
		        else{
		        	load(1,eduFlag,flag2,"schedule","ASC");
		        	th.innerHTML=th.innerHTML.replace(descChar, ascChar);
		       	}
			}
			  
			function upload(id){
				var winObj = window.open ("/portal/edu/toUpload?id="+id, "newwindow", "height=700, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				var loop = setInterval(function() {       
					if(winObj.closed) {      
				    	clearInterval(loop);      
			            //window.location.reload(); 2016-11-24 wuliying delete
			        }      
			    }, 1); 				 
			}
			function getFileList(id){
			  var winObj = window.open ("/portal/edu/getFileList?id="+id, "newwindow", "height=500, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
			}
			  
		</script>

		<script type="text/javascript">
			function load(cur,flag,delflag,orderItem,orderKey){	
				pn=cur;
				orderitm=orderItem;
			  	orderk=orderKey;
			  	flag1=flag;
			  	flag2=delflag;
		   	  	var disWord="";
		   	  	if(flag.toString()=="true")
		   			flag=1;
		   	  	else
		   			flag=0;
		   		if(delflag.toString()=="true")
		   			delflag=1;
		   	  	else
		   			delflag=0;
		   	  	if(!flag)
		   		  	disWord="disabled";
			   	var keyword =document.getElementById("selectitem").value;
			    var curpage="";
	    	    var totalpage="";
			    $.getJSON("/portal/edu/findEduList?keyword="+encodeURI(keyword,"utf-8")+"&orderItem="+orderItem+"&orderKey="+orderKey+"&curpage="+cur+"&rn="+Math.random(),function(data){	
			    	if(data[0].eduList.length!=0){
			    		document.getElementById("urllink").href = data[0].eduList[0].materials;
			    	}
			    	curpage=data[1].curpage;
	    			totalpage=data[1].totalpage;
			    	var str="";
					$.each(data[0].eduList,function(i){
						str+="<tr bordercolor='#DEDEDE' bgcolor='#ffffff'>";
						str+="<input type='hidden' name='id' value=eduid>";
						if(delflag)
						   str+="<td align='center' bordercolor='#DEDEDE'><input type='checkbox' name='isSelect' value='"+data[0].eduList[i].id+"' ></input></td>";
						else
						   str+="<td align='center' bordercolor='#DEDEDE'  style='font-size:12px; color:#004779; '>"+(i+1+(pn-1)*12)+"</td>";   
						if(flag){						  		 
							if(data[0].eduList[i].category=="Internal")
								str+="<td bordercolor='#DEDEDE' width='80px'><select id='category'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:80px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Internal</option><option>External</option></select></td>";
						  	if(data[0].eduList[i].category=="External")
								str+="<td bordercolor='#DEDEDE'width='80px'><select id='category'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:80px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>External</option><option>Internal</option></select></td>";
						  	if(data[0].eduList[i].category=="")
						  		 str+="<td bordercolor='#DEDEDE'width='80px'><select id='category'  class='t'"+disWord+"  style='font-size:12px; color:black; padding-left:5px; text-align:center;width:80px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Internal</option><option>External</option></select></td>";
							  
					  		if(data[0].eduList[i].cateclass=="Tech.")
						  		str+="<td bordercolor='#DEDEDE' width='70px'><select id='cateclass'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:70px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Tech.</option><option>Proc.</option><option>Tool</option></select></td>";
					  		if(data[0].eduList[i].cateclass=="Proc.")
						  		str+="<td bordercolor='#DEDEDE' width='70px'><select id='cateclass'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:70px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Proc.</option><option>Tech.</option><option>Tool</option></select></td>";
						  	if(data[0].eduList[i].cateclass=="Tool")
							 	str+="<td bordercolor='#DEDEDE' width='70px'><select id='cateclass'  class='t'"+disWord+"  style='font-size:12px; color:black; padding-left:5px; text-align:center;width:70px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Tool</option><option>Tech.</option><option>Proc.</option></select></td>";
						  	if(data[0].eduList[i].cateclass=="")
						  		 str+="<td bordercolor='#DEDEDE' width='70px'><select id='cateclass'  class='t'"+disWord+"  style='font-size:12px; color:black; padding-left:5px; text-align:center;width:70px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>Tech.</option><option>Proc.</option><option>Tool</option></select></td>";
				  		}
					  	else{						  		   
					  		str+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='category'   style='font-size:12px; color:black;  text-align:center;width:70px'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'  value='"+data[0].eduList[i].category+"'> </td>";
					  		str+="<td bordercolor='#DEDEDE' width='70px'><input type='text' "+disWord+" class='t'   id='cateclass'   style='font-size:12px;  color:black; text-align:center;width:70px'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'  value='"+data[0].eduList[i].cateclass+"'> </td>";
					  	}
					  	str+="<td bordercolor='#DEDEDE' width='420px'><input type='text' "+disWord+" class='t'   id='contents'   style='font-size:12px;  color:black;   width:500px'  onChange='updateEdu(this,"+data[0].eduList[i].id+")' value='"+data[0].eduList[i].contents.replace('\'','&#39;')+"'> </td>";
					  	str+="<td bordercolor='#DEDEDE' width='100px'><input type='text' "+disWord+" class='t'   id='trainerName'  style='font-size:12px;  color:black;  text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'  value='"+data[0].eduList[i].trainerName.replace('\'','&#39;')+"'> </td>";
					  	   
					  	if(flag){
							if(data[0].eduList[i].department=="SW Group")
								str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>SQA Part</option><option>External</option></select></td>";
						  	if(data[0].eduList[i].department=="SW 1Part")
					  			str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option selected>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>SQA Part</option><option>External</option></select></td>";
					  		if(data[0].eduList[i].department=="SW 2Part")
						  		str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option selected>SW 2Part</option><option>Mon. Part</option><option>SQA Part</option><option>External</option></select></td>";
					  		if(data[0].eduList[i].department=="Mon. Part")
						  		str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option selected>Mon. Part</option><option>SQA Part</option><option>External</option></select></td>";
						  	if(data[0].eduList[i].department=="SQA Part")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option selected>Mon. Part</option><option selected>SQA Part</option><option>External</option></select></td>";
						  	if(data[0].eduList[i].department=="External")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option selected>Mon. Part</option><option>SQA Part</option><option selected>External</option></select></td>";
							if(data[0].eduList[i].department=="")
					  			str+="<td bordercolor='#DEDEDE' width='100px'><select id='department'  class='t'"+disWord+"  style='font-size:12px; color:black; padding-left:5px; text-align:center;width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>SQA Part</option></select></td>";
				  	    }
						else
						   	str+="<td bordercolor='#DEDEDE' width='100px'><input type='text' "+disWord+" class='t'   id='department'   style='font-size:12px; color:black;   text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")' value='"+data[0].eduList[i].department+"'> </td>";
						str+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='schedule'   style='width:80px;font-size:12px; color:black;   text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")' value='"+data[0].eduList[i].schedule.replace('\'','&#39;')+"'> </td>";
						str+="<td bordercolor='#DEDEDE' width='60px'><input type='text' "+disWord+" class='t'   id='duration'   style='width:60px;font-size:12px; color:black;   text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")' value='"+data[0].eduList[i].duration.replace('\'','&#39;')+"'> </td>";
						
						if(flag){
				  			if(data[0].eduList[i].traineeObject=="SW Group")
					  			str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center;width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
				  			if(data[0].eduList[i].traineeObject=="SW 1Part")
					  			str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option selected>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
					  		if(data[0].eduList[i].traineeObject=="SW 2Part")
						  		str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option selected>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
					  		if(data[0].eduList[i].traineeObject=="Mon. Part")
						  		str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option selected>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
						  	if(data[0].eduList[i].traineeObject=="Orsay")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option selected>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="Tizen")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option selected>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="NonOS")
							 	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option selected>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
						 	if(data[0].eduList[i].traineeObject=="Apps")
						  		str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option selected>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
						  	if(data[0].eduList[i].traineeObject=="SP")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option selected>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="App Platform")
							  	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option selected>App Platform</option><option>New Member</option><option>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="New Member")
							 	str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option selected>New Member</option><option>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="Others")
								 str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+" style='font-size:12px; color:black; padding-left:5px; text-align:center; width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option selected>Others</option></select></td>";
							if(data[0].eduList[i].traineeObject=="")
					  			str+="<td bordercolor='#DEDEDE' width='100px'><select id='traineeObject'  class='t'"+disWord+"  style='font-size:12px; color:black; padding-left:5px; text-align:center;width:100px;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'><option selected>SW Group</option><option>SW 1Part</option><option>SW 2Part</option><option>Mon. Part</option><option>Orsay</option><option>Tizen</option><option>NonOS</option><option>Apps</option><option>SP</option><option>App Platform</option><option>New Member</option><option>Others</option></select></td>";
						}
				  	    else
				  	   		str+="<td bordercolor='#DEDEDE' width='100px'><input type='text' "+disWord+" class='t'   id='traineeObject'  style='width:100px; font-size:12px;  color:black;  text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'  value='"+data[0].eduList[i].traineeObject+"'> </td>";
					   	str+="<td bordercolor='#DEDEDE'><input type='text' "+disWord+" class='t'   id='traineeTotal'  style='width:50px; font-size:12px;  color:black;  text-align:center;'  onChange='updateEdu(this,"+data[0].eduList[i].id+")'  value='"+data[0].eduList[i].traineeTotal.replace('\'','&#39;')+"'> </td>";
					   	//2017-02-07 wuliying, 区分是否已经存在上传文件
						if(flag){ //有编辑权限， 可以上传附件
						   if(data[0].eduList[i].filename.length==0){ //没有上传文件存在， 直接上传图标
							   str+="<td align='center' bordercolor='#DEDEDE'><a href='javascript:upload("+data[0].eduList[i].id+")'  title='Upload Report'> <img src='${pageContext.request.contextPath}/FlatUI/img/edit2.png' width=18px height=18px/></a></td>";
						   }
						   else{ //已存在上传文件， 显示黄色图标
							   str+="<td align='center' bordercolor='#DEDEDE'><a href='javascript:upload("+data[0].eduList[i].id+")'  title='Upload Report'> <img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
						   }								   
					   	}
					   	else{
							if(data[0].eduList[i].filename.length==0){
								str+="<td align='center' bordercolor='#DEDEDE' width='60px'></td>";
							}
							else{
								if(data[0].eduList[i].filename.indexOf(",")==-1){
									str+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='/portal/edu/download/"+data[0].eduList[i].filename+"' title='Training Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								}
								else{
									str+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='javascript:getFileList("+data[0].eduList[i].id+")' title='Training Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								}
							}
					   	}
						str+="</tr>";						  	  
					});
					$("#tableEdu tbody").html("");
					$("#tableEdu tbody").html(str);
					var firstpagehtml; 
					var prevpagehtml; 
					var nextpagehtml;
					var lastpagehtml;
					if((curpage-0)<=1){
						firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a><</a>";
					}
					else{
						firstpagehtml="<a onclick='load(1"+",\""+flag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+flag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><</a>";
					}
					if(curpage < totalpage){
						nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+flag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml="<a onclick='load("+(totalpage)+",\""+flag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
					}
					else{
						nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml = "<a>>></a>";
					}
					var html2="";		
					html2 = html2 + "<table><tr  bgcolor='white' bordercolor='white'><td height='60px'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+curpage+"&nbsp;/&nbsp;"+totalpage+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
					html2 = html2+"</table>";
				    document.getElementById("footer").innerHTML=html2;
		 		});
			}
		</script>
  	</head> 
	
  	<body onload="load(1,'${usersession.hasPrivilegeByName('Training Update')}','${usersession.hasPrivilegeByName('Training Delete')}','id','DESC')">
  	<div id="navtop" >
		<ul class="navtop-skin">
			<li>
				<font color="#2c3e50"><strong><a target="_blank" href="#" id="urllink" title="GO TO MOSAIC">| Trainning Management |</a></strong></font>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" placeholder="Search" name="selectitem" id="selectitem" title="Input Title;Trainer;Trainer/Trainee Department"  oninput="javascript:load(1,'${usersession.hasPrivilegeByName('Training Update')}','${usersession.hasPrivilegeByName('Training Delete')}','id','DESC')"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">	
	        </li>
	       	<li>
				<c:if test="${usersession.hasPrivilegeByName('Training Add')}">
					<input type="button"  onclick="addEdu()" value="Add" style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  &nbsp;&nbsp;
				</c:if>
				<c:if test="${usersession.hasPrivilegeByName('Training Delete')}">
					<input type="button"  onclick="delEdu()" value="Delete" style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
				</c:if>
			</li>
		</ul>
		<ul class="navtop-right">
			<li >
				<a href="/portal/edu/importExec" title="Data Download">
					<img src="${pageContext.request.contextPath}/style/images/excel6.jpg"   width=20px height=20px style="padding-top:15px"/>
				</a>
		    </li> 
		</ul>
	</div>
	<br>
	<center>
	  	<table id = "tableEdu"  bgColor='#FFFAF0' cellspacing='0px' border='2px'  cellpadding='0px'   style=' border-collapse:collapse'>
	  		<thead>
	  			<tr bgcolor='#d2e9ff' bordercolor='#DEDEDE'>
    				<c:choose>  
						<c:when test="${usersession.hasPrivilegeByName('Training Update')}">   
							<td align="center" width="50px" rowspan="2"><input type="checkbox" name="allSelect" onclick="sel(this)"></input></td>
						</c:when>  
						<c:otherwise>   
							<td align="center" width="50px"  rowspan="2"><font  size=2 style="font-weight:bold;">No</font></td>
						</c:otherwise> 
					</c:choose> 
					<td align="center" width="150px"  rowspan="2" colspan="2"><font  size=2 style="font-weight:bold;">Category</font></td>
		        	<td align="center" width="420px"  rowspan="2"><font  size=2 style="font-weight:bold;">Title/Contents</font></td>
		        	<td align="center" width="200px"  height="25px" colspan="2"><font size=2 style="font-weight:bold;">Trainer</font></td>
		        	<td align="center" width="180px" height="25px"  colspan="2"><font  size=2 style="font-weight:bold;">Schedule</font></td>
		        	<td align="center" width="150px"  rowspan="2" colspan="2"><font size=2  style="font-weight:bold;">Trainee</font></td>
		        	<td align="center" width="65px"   rowspan="2"><font  size=2 style="font-weight:bold;">Training Mat.</font></td>
		        </tr>
		        <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" align="CENTER" valign="MIDDLE" >
		        	 <td align="center" width="100px"  height="25px"><font size=2  style="font-weight:bold;">Name</font></td>
		        	 <td align="center" width="100px" height="25px"><font  size=2 style="font-weight:bold;">Department</font></td>
		        	 <td align="center" width="100px" height="25px"  onClick="javascript:sort('${usersession.hasPrivilegeByName('Training Update')}',1,2)"><font  size=2 style="font-weight:bold;">Date&nbsp; <font size='1' color='#2c3e50'>▼</font></font></td>
		        	 <td align="center" width="80px" height="25px" ><font  size=2 style="font-weight:bold;">Duration</font></td>
		        </tr>
		     </thead> 
		     <tbody></tbody> 
	  	</table>	
	  	<div id="footer"></div>	
	</center>   
  </body>
</html>
