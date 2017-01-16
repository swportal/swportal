<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="myjstl" prefix="c"%>
<html>  
	<head>  
		<title>Failed Case Management</title>  
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">  
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
	    <style> 
	    	td {text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }
		    hr{
		    	position:relative;
				bottom: -515px;
		    }
		    a{
				TEXT-DECORATION:none
			}
	    	#footer{
	    		 position:relative;
	    		 bottom: -10px;
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
	 		.txt{	 		 	
	 			border:1px solid #fff;
				background:#fff; 			
	 			padding-left:5px;  /*框体左留空*/
	 			word-break:break-all;
	 			text-overflow:ellipsis;
	 			display:-webkit-box; 
	 			-webkit-box-orient:vertical; 
	 			-webkit-line-clamp:2;
	 			scrollbar-arrow-color:#ffffff;
<%--	 			overflow-y:hidden;--%>
	 			
	 			
	 		} 
	 		#MainArea form{
				padding-left: 0px;
			}
			
			.test_box {
					    
					    min-height: 50px; 
					    max-height: 50px;
					    
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
			
			
			.textPlace{ position:relative; top:-5px; /*left:5px; right:5px;bottom:5px*/} 
		</style>
			
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
				/*position:relative;
				left:5%;*/
			}
			.navtop-skin li{
				float:left;
				margin:0px;
				padding:0 20px;
				/*position:relative;
				right:20%;*/
				line-height:40px;
				border:solid 0px #000;
			}	
			.navtop-right{
				float:right;
				position:relative;
				right:2%;
			}	
			select option {font-size:12px; font-family:Arial}
		</style>
		<script type="text/javascript">	
		var f=0;
		var c=0;
		var pn=1;
		var flag1;
		var flag2;
		var orderitm;
		var orderk;
		//var chicolor;
		 function sort(caseFlag,conFlag, iRow, iCol){
			  var table=document.getElementById("topRight");
			  //alert(tid);
			  var ascChar = "▲";
	          var descChar = "▼";
	          var rows=table.tHead.rows;	
	          
	          //alert(iCol);
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
	        	  //gotoASC(${usersession.hasPrivilegeByName("Business Trip Info.")});
	        	  //load();
	        	   load(1,flag1,flag2,"occurTime","DESC");
	        	  th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	        	 
	          }
	          else{
	        	  //gotoDESC(${usersession.hasPrivilegeByName("Business Trip Info.")});
	        	  load(1,flag1,flag2,"occurTime","ASC");
	        	  th.innerHTML=th.innerHTML.replace(descChar, ascChar);
	          }
		  }
		 function addCase(){			 	
			   $.getJSON("/portal/case/addCase?adr="+Math.random(),function(data){
				   if("success"==data.result){					  
					   window.location.reload();
					   // load(pn,flag);
				   }
				   else{
					   
					   alert("Error!");
					   window.location.reload();
				   }
			   });	 
		   
		  }
		  function delCase(){			
				var obj=document.getElementsByName('isSelect'); 
				var s1="Select:"; 
				var ids='';
				//alert(obj.length);
				for(var i=0; i<obj.length; i++){ 
					if(obj[i].checked) ids=ids+obj[i].value+","; //如果选中，将value添加到变量s中 
				} 	
				if(ids==''){
					alert("Please choose one!");
				}
					
				else{	
					if(confirm("Are you sure to delete this item?")){
						$.get("/portal/case/delCaseList?ids="+ids,function(data){
							   if("success"==data.result){
								  // alert("Delete Done!");
								   window.location.reload();
								   //load(pn,flag);
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
		
			
			  function updateCase(element,id){			
				 $.getJSON("/portal/case/updateCase?id="+id+"&item="+element.id+"&value="+encodeURIComponent(element.value,"utf-8"),function(data){
						   if("success"==data.result){
							   //alert("aa");
							  // window.location.reload();
							  //alert(pn);
							  load(pn,flag1,flag2,orderitm,orderk);
						   }
						   else{ 
							  // alert(data.resultup);
							   alert("Update Error!");
						   }
				 });
			   }
			  
			  function confirmCase(element,id){			
					 $.getJSON("/portal/case/confirmCase?id="+id+"&item="+element.id,function(data){
							   if("success"==data.result){
								   //alert("aa");
								  // alert(pn);
								 load(pn,flag1,flag2,orderitm,orderk);
								  //if(element.name=="gray"){
									 // element.src="<%=request.getContextPath()%>/style/images/chilun.png";
									 // element.name="green";
									 //alert("gray");
								  //}
								 // if(element.name=="green"){
									 // element.src="<%=request.getContextPath()%>/style/images/chilun_grey.png";
									  //element.name="gray";
								  	 // alert("green");
								 // }
								  //load(pn,flag);
							   }
							   else{ 
								   alert("Update Error!");
							   }
					 });
			  }
			  
			  function sel(obj){
				  var a = document.getElementsByName('isSelect');
				  //alert(document.getElementsByName('isSelect').length);
				  for(var i = 0;i<a.length;i++){
					  a[i].checked = obj.checked;
				  }
			  }
			  
			  function changeUrl(item,value,id){
				  /*url=encodeURI(encodeURI(value));//转码两次，很关键
				  url = url.replace(/\+/g,"+");
				  url = url.replace(/\&/g,"&");
				  url = url.replace(/\#/g,"#");*/
				  //alert(item);
				 var winObj = window.open ("/portal/case/changeUrl?id="+id+"&item="+item+"&value="+encodeURIComponent(value), "newwindow", "height=100, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				 var loop = setInterval(function() {       
				        if(winObj.closed) {      
				            clearInterval(loop);      
				            //alert('closed');      
				            window.location.reload();
				        }      
				    }, 1); 				 
			  }
			  
			  function upload(id){
				  /*url=encodeURI(encodeURI(value));//转码两次，很关键
				  url = url.replace(/\+/g,"+");
				  url = url.replace(/\&/g,"&");
				  url = url.replace(/\#/g,"#");*/
				  //alert(item);
				 var winObj = window.open ("/portal/case/toUpload?id="+id, "newwindow", "height=500, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				 var loop = setInterval(function() {       
				        if(winObj.closed) {      
				            clearInterval(loop);      
				            //alert('closed');      
				            //window.location.reload(); 2016-11-23 wuliying delete
				        }      
				    }, 1); 				 
			  }
			  
			  function getFileList(id){
				  var winObj = window.open ("/portal/case/getFileList?id="+id, "newwindow", "height=500, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
			  }
			  
		</script>
		<script>  
			function syncscroll(obj)  
			{  
			 //y.innerHTML = obj.scrollTop;  
			 //x.innerHTML = obj.scrollLeft;  
			 scroll1.children[0].style.position = "relative";  
			 scroll2.children[0].style.position = "relative";  
			 scroll1.children[0].style.left = "-"+obj.scrollLeft;  
			 scroll2.children[0].style.top =  "-"+obj.scrollTop;    
			}  
			function click(){
				alert(1);
			}
		</script> 
		
		<script>
			function load(cur,flag,conflag,orderItem,orderKey){	
				//alert(conflag);
				//alert("a");
				pn=cur;
				orderitm=orderItem;
				orderk=orderKey;
				flag1=flag;  //Edit priority
				flag2=conflag;  //Confirm priority
				//alert(pn);
				var now = new Date();
				var curDate=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
				//alert(curDate);
				var keyword =document.getElementById("selectitem").value;
				var disWord="";
				var fontColor="";
				var curpage="";
		    	var totalpage="";
				$.getJSON("/portal/case/findCaseList?keyword="+encodeURIComponent(keyword,"utf-8")+"&orderItem="+orderItem+"&orderKey="+orderKey+"&curpage="+cur+"&rn="+Math.random(),function(data){
					if(data[0].caseList.length!=0) 
						document.getElementById("urllink").href = data[0].caseList[0].report;
					curpage=data[0].curpage;
    				totalpage=data[0].totalpage;
	        		strLeft="";
	        		strRight="";
	        		
					 $.each(data[0].caseList,function(i){	
						// alert(flag);
						 if(data[0].caseList[i].confirmy=="Y") {
							 disWord="disabled";
							 fontColor="gray";
						 }
						 else{
							 fontColor="black";
							 if(flag){
						   		  disWord="";
							 }
							 else{
								 disWord="disabled";
							 }
						 } 
						 //alert(disWord);
						 //alert(flag);
						// alert(disWord);
						 strLeft+="<tr bgcolor='#ffffff'  bordercolor='#DEDEDE'>";
						 if(flag){
							 if(data[0].caseList[i].confirmy=="Y")
								 strLeft+="<td align='center' width='50px' height='50px' bordercolor='#DEDEDE'><input type='checkbox' disabled='disabled' name='isSelect' value='"+data[0].caseList[i].id+"' ></input></td>";
							 else
								 strLeft+="<td align='center' width='50px' height='50px' bordercolor='#DEDEDE'><input type='checkbox' name='isSelect' value='"+data[0].caseList[i].id+"' ></input></td>";
						 }
						else
			        		strLeft+="<td align='center'  width='50px' height='50px'><font style='font-size:12px; color:#004779;'>"+(i+1+(pn-1)*7)+"</font></td>";
			        	 var con=conflag.toString();
			        		//alert(con);
			        	 if(con=="true"){
			        		 //alert(conflag);
				        	 if(data[0].caseList[i].confirmy=="Y")
				        	 	strLeft+="<td align='center' width='50px' ><img name='gray' title='Complete' src='<%=request.getContextPath()%>/style/images/chilun_grey.png' width='18' height='18' id='confirmy' onClick='confirmCase(this,"+data[0].caseList[i].id+")'/></td>";	
				        	 else
				        		 strLeft+="<td align='center'  width='50px' ><img  name='green' title='Ongoing' src='<%=request.getContextPath()%>/style/images/chilun.png' width='18' height='18' id='confirmy' onClick='confirmCase(this,"+data[0].caseList[i].id+")'/></td>";
				         }
				         else{
				        	 
				        	 if(data[0].caseList[i].confirmy=="Y")
						    	 strLeft+="<td align='center'  width='50px' > <img  src='<%=request.getContextPath()%>/style/images/chilun_grey.png' width='18' height='18'/></td>";	
						     else
						       	 strLeft+="<td align='center'  width='50px' > <img  src='<%=request.getContextPath()%>/style/images/chilun.png' width='18' height='18'/></td>";
			        	 }
			        	 strLeft+="<td bordercolor='#DEDEDE' width='70px' ><input type='text' "+disWord+" class='t'   id='prodType'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:70px'  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].prodType.replace('\'','&#39;')+"'> </td>";
			        	 strLeft+="<td bordercolor='#DEDEDE' width='70px' ><input type='text' "+disWord+" class='t'   id='chipset'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:70px'  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].chipset.replace('\'','&#39;')+"'> </td>";
			        	 strLeft+="<td  bordercolor='#DEDEDE' width='110px'  title='"+data[0].caseList[i].model+"'><input type='text' "+disWord+" class='t'   id='model'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:110px'  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].model.replace('\'','&#39;')+"'> </td>";
			        	 strLeft+="<td bordercolor='#DEDEDE' width='400px'  height='50px'><div title='"+data[0].caseList[i].description+"'><textarea rows='2'  "+disWord+" class='txt'   id='description'   style='font-size:12px; color:"+fontColor+";  text-align:left; width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")' >"+data[0].caseList[i].description+" </textarea></div></td>";
			        	 strLeft+="</tr>"; 
		        		
						 strRight+="<tr bgcolor='#FFFFFF' bordercolor='#DEDEDE'>";
						 strRight+="<td bordercolor='#DEDEDE' width='90px'  height='50px'><input type='text' "+disWord+" class='t'   id='occurTime'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].occurTime.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='90px'><input type='text' "+disWord+" class='t'   id='occurSite'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].occurSite.replace('\'','&#39;')+"'> </td>";
						 if(flag){
					  		if(data[0].caseList[i].occurPhase=="MP")
					  			strRight+="<td bordercolor='#DEDEDE' width='90px'><select id='occurPhase'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>MP</option><option>市场</option></select></td>";
					  		 if(data[0].caseList[i].occurPhase=="市场")
					  			strRight+="<td bordercolor='#DEDEDE'width='90px'><select id='occurPhase'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>市场</option><option>MP</option></select></td>";
						  	 if(data[0].caseList[i].occurPhase=="")
						  		strRight+="<td bordercolor='#DEDEDE'width='90px'><select id='occurPhase'  class='t'"+disWord+"  style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>MP</option><option>市场</option></select></td>";
						  		
						  	if(data[0].caseList[i].occurType=="SW")
					  			strRight+="<td bordercolor='#DEDEDE' width='90px'><select id='occurType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>SW</option><option>HW</option><option>工厂</option><option>Others</option></select></td>";
					  		if(data[0].caseList[i].occurType=="HW")
					  			strRight+="<td bordercolor='#DEDEDE'width='90px'><select id='occurType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>HW</option><option>SW</option><option>工厂</option><option>Others</option></select></td>";
					  		if(data[0].caseList[i].occurType=="工厂")
						  		strRight+="<td bordercolor='#DEDEDE' width='90px'><select id='occurType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>SW</option><option>HW</option><option selected>工厂</option><option>Others</option></select></td>";
						  	if(data[0].caseList[i].occurType=="Others")
						  		strRight+="<td bordercolor='#DEDEDE'width='90px'><select id='occurType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>HW</option><option>SW</option><option>工厂</option><option selected>Others</option></select></td>";
							  	  
					  		if(data[0].caseList[i].occurType=="")
						  		strRight+="<td bordercolor='#DEDEDE'width='90px'><select id='occurType'  class='t'"+disWord+"  style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>SW</option><option>HW</option><option>工厂</option><option>Others</option></select></td>";
						 
						 }  
						 else{
						 	strRight+="<td bordercolor='#DEDEDE' width='90px'><input type='text' "+disWord+" class='t'   id='occurPhase'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].occurPhase+"'> </td>";
						 	strRight+="<td bordercolor='#DEDEDE' width='90px'><input type='text' "+disWord+" class='t'   id='occurType'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].occurType+"'> </td>";
						 }
						 strRight+="<td bordercolor='#DEDEDE' width='160px'><input type='text' "+disWord+" class='t'   id='version'   style=' word-wrap:break-word;word-break:break-all;font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].version.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='400px'  ><div title='"+data[0].caseList[i].rootReason+"'><textarea rows='2'  "+disWord+" class='txt'   id='rootReason'   style='font-size:12px; color:"+fontColor+";  text-align:left;width:100%  '  onChange='updateCase(this,"+data[0].caseList[i].id+")' >"+data[0].caseList[i].rootReason.replace('\'','&#39;')+" </textarea></div></td>";
						 strRight+="<td bordercolor='#DEDEDE' width='400px'  ><div title='"+data[0].caseList[i].unknownReason+"'><textarea rows='2'  "+disWord+" class='txt'   id='unknownReason'   style='font-size:12px; color:"+fontColor+";  text-align:left;width:100%  '  onChange='updateCase(this,"+data[0].caseList[i].id+")' >"+data[0].caseList[i].unknownReason+" </textarea></div></td>";
						 strRight+="<td bordercolor='#DEDEDE' width='300px'  ><div title='"+data[0].caseList[i].measureDev+"'><textarea rows='2'  "+disWord+" class='txt'   id='measureDev'   style='font-size:12px; color:"+fontColor+";  text-align:left;width:100%  '  onChange='updateCase(this,"+data[0].caseList[i].id+")' >"+data[0].caseList[i].measureDev+" </textarea></div></td>";
						 strRight+="<td bordercolor='#DEDEDE' width='300px'  ><div title='"+data[0].caseList[i].measureTest+"'><textarea rows='2'  "+disWord+" class='txt'   id='measureTest'   style='font-size:12px; color:"+fontColor+";  text-align:left;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")' >"+data[0].caseList[i].measureTest+" </textarea></div></td>";
						 if(flag){
							  	if(data[0].caseList[i].measureType=="SW->SW")
						  			strRight+="<td bordercolor='#DEDEDE' width='100px'><select id='measureType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>SW->SW</option><option>HW->SW</option><option>工厂->SW</option><option>Others</option></select></td>";
						  		if(data[0].caseList[i].measureType=="HW->SW")
						  			strRight+="<td bordercolor='#DEDEDE' width='100px'><select id='measureType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>HW->SW</option><option>SW->SW</option><option>工厂->SW</option><option>Others</option></select></td>";
						  		if(data[0].caseList[i].measureType=="工厂->SW")
							  		strRight+="<td bordercolor='#DEDEDE' width='100px'><select id='measureType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>SW->SW</option><option>HW->SW</option><option selected>工厂->SW</option><option>Others</option></select></td>";
							  	if(data[0].caseList[i].measureType=="Others")
							  		strRight+="<td bordercolor='#DEDEDE' width='100px'><select id='measureType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>HW->SW</option><option>SW->SW</option><option>工厂->SW</option><option selected>Others</option></select></td>";
						  		if(data[0].caseList[i].measureType=="")
							  		strRight+="<td bordercolor='#DEDEDE' width='100px'><select id='measureType'  class='t'"+disWord+"  style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>SW->SW</option><option>HW->SW</option><option>工厂->SW</option><option>Others</option></select></td>";
						 }  
						 else
							strRight+="<td bordercolor='#DEDEDE' width='100px'><input type='text' "+disWord+" class='t'   id='measureType'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].measureType+"'> </td>";
							
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='personINCharge'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].personINCharge.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='propagation'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].propagation.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='gmapRegister'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].gmapRegister.replace('\'','&#39;')+"'> </td>";
						 if(flag){
							  	if(data[0].caseList[i].improvedType=="Process")
						  			strRight+="<td bordercolor='#DEDEDE' width='80px'><select id='improvedType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>Process</option><option>Tech.</option><option>Test</option><option>Tool</option></select></td>";
						  		if(data[0].caseList[i].improvedType=="Tech.")
						  			strRight+="<td bordercolor='#DEDEDE' width='80px'><select id='improvedType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>Process</option><option selected>Tech.</option><option>Test</option><option>Tool</option></select></td>";
						  		if(data[0].caseList[i].improvedType=="Test")
							  		strRight+="<td bordercolor='#DEDEDE' width='80px'><select id='improvedType'  class='t'"+disWord+" style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>Process</option><option>Tech.</option><option selected>Test</option><option>Tool</option></select></td>";
						  		if(data[0].caseList[i].improvedType=="Tool")
							  		strRight+="<td bordercolor='#DEDEDE' width='80px'><select id='improvedType'  class='t'"+disWord+"  style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option>Process</option><option>Tech.</option><option>Test</option><option selected>Tool</option></select></td>";
						  		if(data[0].caseList[i].improvedType=="")
							  		strRight+="<td bordercolor='#DEDEDE' width='80px'><select id='improvedType'  class='t'"+disWord+"  style='font-size:12px; color:"+fontColor+"; padding-left:5px; text-align:center;width:100%;border-width: 0px;border-top-style: none;border-right-style: none;border-left-style: none; border-bottom-style: none;height: 15px;overflow:hidden'  onChange='updateCase(this,"+data[0].caseList[i].id+")'><option selected>Process</option><option>Tech.</option><option>Test</option><option>Tool</option></select></td>";
						 }  
						 else
						 	strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='improvedType'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].improvedType+"'> </td>";
						
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='checklistUpdate'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].checklistUpdate.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='tcUpdate'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].tcUpdate.replace('\'','&#39;')+"'> </td>";
						 strRight+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='plmRegister'   style='font-size:12px; color:"+fontColor+";  text-align:center;width:100% '  onChange='updateCase(this,"+data[0].caseList[i].id+")'  value='"+data[0].caseList[i].plmRegister.replace('\'','&#39;')+"'> </td>";
						 if(flag){
							 if(data[0].caseList[i].confirmy=="Y"){
								 if(data[0].caseList[i].filename.length==0){
									 strRight+="<td align='center' bordercolor='#DEDEDE' width='60px'></td>";
								 }
								 else if(data[0].caseList[i].filename.length!=0&&data[0].caseList[i].filename.indexOf(",")==-1){
								 	 strRight+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='/portal/case/download/"+data[0].caseList[i].filename+"' title='Failed Case Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								 }
								 else if(data[0].caseList[i].filename.length!=0&&data[0].caseList[i].filename.indexOf(",")!=-1){
									 strRight+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='javascript:getFileList("+data[0].caseList[i].id+")' title='Failed Case Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								 }
							 }
							 else{
							 	strRight+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='javascript:upload("+data[0].caseList[i].id+")'  title='Upload Report'><img src='${pageContext.request.contextPath}/FlatUI/img/edit2.png' width=18px height=18px style='cursor:pointer'/></a></td>";
							 }
						 }
						 else{
							 if(data[0].caseList[i].filename.length==0){
								 strRight+="<td align='center' bordercolor='#DEDEDE' width='60px'></td>";
							 }
							 else if(data[0].caseList[i].filename.length!=0&&data[0].caseList[i].filename.indexOf(",")==-1){
							 	 strRight+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='/portal/case/download/"+data[0].caseList[i].filename+"' title='Failed Case Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
							 }
							 else if(data[0].caseList[i].filename.length!=0&&data[0].caseList[i].filename.indexOf(",")!=-1){
								 strRight+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='javascript:getFileList("+data[0].caseList[i].id+")' title='Failed Case Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
							 }
						 }
						 strRight+="</tr>";
						
					 });
					$("#bottomLeft tbody").html("");
					$("#bottomLeft tbody").html(strLeft);
					//$("#bottomLeft").empty();
					//$("#bottomLeft").append(strLeft);
					$("#bottomRight").empty();
					$("#bottomRight").append(strRight);
					var firstpagehtml; 
					var prevpagehtml; 
					var nextpagehtml;
					var lastpagehtml;
					if((curpage-0)<=1){
						firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a><</a>";
					}else{
						firstpagehtml="<a onclick='load(1"+",\""+flag+"\",\""+conflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+flag+"\",\""+conflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><</a>";
					}
					if(curpage < totalpage){
						nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+flag+"\",\""+conflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml="<a onclick='load("+(totalpage)+",\""+flag+"\",\""+conflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
					}else{
						nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml = "<a>>></a>";
					}
					 var html2="";		
					 html2 = html2 + "<table><tr  bgcolor='white' bordercolor='white'><td height='60px'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+curpage+"&nbsp;/&nbsp;"+totalpage+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
					 html2 = html2+"</table>";
					//alert(html2);
					// $(".page-num").text(pageTotal); 
				    document.getElementById("footer").innerHTML=html2;
				});
			}
			function gotoASC(flag,conflag){
				load(flag,"occurTime","ASC",conflag);
	  		}
			function gotoDESC(flag,conflag){
				//alert(conflag);
				load(flag,"id","DESC",conflag);
	  		}

		</script>
		<script type="text/javascript">
	  		function ExportToExcel() {
	  	        var elTable = document.getElementById("tableServer"); //table1改成你的tableID
	  	        var oRangeRef = document.body.createTextRange();
	  	        oRangeRef.moveToElementText(elTable);
	  	        oRangeRef.execCommand("Copy");
	  	        try {
	  	            var appExcel = new ActiveXObject("Excel.Application");
	  	        } catch (e) {
	  	            alert("Did you install Excel and put this site into your trusted sites list?");
	  	            return;
	  	        }
	  	        appExcel.Visible = true;
	  	        appExcel.Workbooks.Add().Worksheets.Item(1).Paste();
	  	        appExcel = null;
	  	    }
		</script>
		 <script type="text/javascript">	  		
	  		function gotoSort(flag){
				sort(flag,1,1);
	  		}
		</script>
	</head>  
 
	<body onload="load(1, '${usersession.hasPrivilegeByName('Case Update')}','${usersession.hasPrivilegeByName('Case Confirm')}','','')">  
		<div id="navtop">
			<ul class="navtop-skin">
				<li style="padding-left:20">
					<font color="#2c3e50"><strong><a target="_blank" href="#" id="urllink" title="GO TO MOSAIC">| Failed Case Mgmt. |</a></strong></font>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" placeholder="Search" name="selectitem" id="selectitem" title="Input ProdType;Chipset;Model;Description;OccurTime;OccurSite"  oninput="javascript:load(1,'${usersession.hasPrivilegeByName('Case Update')}','${usersession.hasPrivilegeByName('Case Confirm')}','','')"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
					<li style="padding-left:10">
						<c:if test="${usersession.hasPrivilegeByName('Case Add')}">
							<input type="button"  onclick="addCase()" value="Add" style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  &nbsp;&nbsp;
						</c:if>
						<c:if test="${usersession.hasPrivilegeByName('Case Delete')}">
							<input type="button"  onclick="delCase()" value="Delete" style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
						</c:if>						
					</li>
		        </li>
		    </ul>
		     <ul class="navtop-right">
				 <li >
						<%--<input id="export" type="button" value="Export" onclick="javascript:ExportToExcel()" style="color:#2c3e50;font-size:12px; font-weight:bold; border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  --%>
						<%--<img src="${pageContext.request.contextPath}/style/images/excel3.png"  onclick="javascript:ExportToExcel()"  width=18px height=18px style="padding-top:10px"/>--%>
						<a href="/portal/case/importExec" title="Data Download">
							<img src="${pageContext.request.contextPath}/style/images/excel6.jpg"   width=20px height=20px style="padding-top:15px"/>
						</a>
		        </li> 
		  </ul>
		</div>
		<br>
<%--		<hr style="height:2px;border:none;border-top:4px ridge gray;" /> --%>
		
		<center>
<%--			<div style="position:relative; bottom:40px">--%>
			<table border="0" cellpadding="0" cellspacing="0">  
	  			<tr>  
	   				 <td>  
		  				 <!--*********左上-BEGIN***********-->  
		 					 <table id="topLeft" width="770" height="70px" border="2" cellpadding="0" cellspacing="0" bgcolor="#FFFAF0"  bordercolor='#DEDEDE' style=' border-collapse:collapse'>  
		 					 	<tr bgcolor="#d2e9ff"  bordercolor="#DEDEDE">
		 					 	<c:choose>  
								   <c:when test="${usersession.hasPrivilegeByName('Case Delete')}">   
								     <td align="center"  width="50px" height="70px" rowspan="2"><input type="checkbox" name="allSelect" onclick="sel(this)"></input></td>
								   </c:when>  
								   <c:otherwise>   
								   		<td align="center"  width="50px" height="70px" rowspan="2"><font size="2px" style="font-weight:bold;">No.</font></td>
								   </c:otherwise> 
								</c:choose> 
								 	<td align="center"  width="50px" height="70px" rowspan="2"><font size="2px" style="font-weight:bold;">Status</font></td>
									 <td align="center" width="70px" height="70px" rowspan="2"><font  size="2px" style="font-weight:bold;">Prod. Type</font></td>
									 <td align="center" width="70px" height="70px" rowspan="2"><font  size="2px" style="font-weight:bold;">Chipset</font></td>
									 <td align="center" width="110px" height="70px" rowspan="2"><font  size="2px" style="font-weight:bold;">Model</font></td>
									 <td align="center" width="400px" height="70px" rowspan="2"><font  size="2px" style="font-weight:bold;">Defect Description</font></td>
								 <!-- 
								   <td align="center"  width="70px"  rowspan="2">
								 	<select id="prodType" onChange="typeSelect(${usersession.hasPrivilegeByName("Case Update")})" style="font-size:14px; border:0; background:#d2e9ff ;border-radius:5px;width:70px; vertical-align:middle; " >
								 		<option style="color:#000000; ">Prod. Type</option>
								 		<c:forEach items="${types}" var="t">
								 		<option style="color:#FFFFFF; ">${t.prodType}</option>
								 		</c:forEach>
								 	</select>
								 </td>
								  <td align="center"  width="70px"  rowspan="2">
								 	<select id="chipset" onChange="chipSelect(${usersession.hasPrivilegeByName("Case Update")})" style="font-size:14px;  border-radius:5px;width:70px; height:33px;vertical-align:middle; " >
								 		<option  >Chipset</option>
								 		<c:forEach items="${chips}" var="c">
								 		<option>${c.chipset}</option>
								 		</c:forEach>
								 	</select>
								 </td>
								  <td align="center"  width="110px"  rowspan="2">
								 	<select id="model" onChange="modelSelect(${usersession.hasPrivilegeByName("Case Update")})" style="font-size:14px;  border-radius:5px;width:110px; height:33px;vertical-align:middle; " >
								 		<option  >Model</option>
								 		<c:forEach items="${models}" var="m">
								 		<option>${m.model}</option>
								 		</c:forEach>
								 	</select>
								 </td>-->
								 </tr>
		 					 </table>
		 					  
		  				 <!--**************左上-END**********-->  
	 				</td>  
	    			<td>  
	 					<div id='scroll1' style="width:910;overflow:hidden ">  <!-- 控制左右滑动条的宽度 -->
		  					<!--***********右上-BEGIN********-->  
		  						<table id="topRight" width="2700px" height="70px" border="2" cellpadding="0" cellspacing="0" bgcolor="#FFFAF0"  bordercolor='#DEDEDE' style=' border-collapse:collapse'> 
								    <thead><tr height="29px" bgcolor='#d2e9ff' bordercolor='#DEDEDE'>  
								    	 <td align="center" colspan="5"><font  size="2px" style='font-weight:bold;'>Defect Occured</font></td>
								    	 <td align="center" colspan="2"><font  size="2px" style='font-weight:bold;'>Reason</font></td>
								    	 <td align="center" colspan="3"><font  size="2px" style='font-weight:bold;'>Countermeasure</font></td>
								    	 <td align="center" colspan="7"><font  size="2px" style='font-weight:bold;'>Mgmt. Method</font></td>
								    	 <td align="center" rowspan="2"width="60px" ><font  size="2px" style='font-weight:bold;'>Report</font></td>
								    </tr>
								    <tr  height="41px" bgcolor='#d2e9ff' bordercolor='#DEDEDE'>
<%--								  		 <td align="center"  width="500px"><font  size="2px" style='font-weight:bold;'>Description</font></td>  --%>
								   		 <td align="center"  width="90px" ><font  size="2px" style='font-weight:bold;'  onClick="javascript:sort('${usersession.hasPrivilegeByName('Case Update')}','${usersession.hasPrivilegeByName('Case Confirm')}',1,0)">Time&nbsp;<font size='1' color='#2c3e50'>▼</font></font></td>  
								   		 <td align="center"  width="90px" ><font  size="2px" style='font-weight:bold;'>Site</font></td>  
								  		 <td align="center"  width="90px" ><font  size="2px" style='font-weight:bold;'>Phase</font></td>  
								  		 <td align="center"  width="90px" ><font  size="2px" style='font-weight:bold;'>Type</font></td>  
								   		 <td align="center"  width="160px"><font  size="2px" style='font-weight:bold;'>SW Ver.</font></td>  
								    
								  		 <td align="center"  width="400px"><font  size="2px" style='font-weight:bold;'>Root Reason</font></td>  
								   		 <td align="center"  width="400px"><font  size="2px" style='font-weight:bold;'>No Found Reason</font></td>  							   		 
								   
								  		 <td align="center"  width="300px"><font  size="2px" style='font-weight:bold;'>Dev. Team</font></td>  
								   		 <td align="center"  width="300px"><font  size="2px" style='font-weight:bold;'>Test Team</font></td>  	
								   		 <td align="center"  width="100px"><font  size="2px" style='font-weight:bold;'>Type</font></td> 						   		 
								   
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>Person In<br/>Charge</font></td>
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>Propa-<br/>gation?</font></td>
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>G-MAP<br/>Register?</font></td>
								  		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>Improved<br/>Type</font></td>  
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>Checklist<br/>Update?</font></td> 
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>TC<br/>Update?</font></td>   
								   		 <td align="center"  width="80px" ><font  size="2px" style='font-weight:bold;'>PLM<br/>Register?</font></td>  
								   		 							   		 
								    </tr> </thead> 
								</table>  
		  					<!--************右上-END**********-->  
	 					</div>   
	 				</td>  
	  			</tr>  
	  			<tr>  
				    <td align="left" valign="top">  
					 	<div id='scroll2' style="height:370px;overflow-y:hidden;overflow-x:scroll">  
						  	<!--*************左下-BEGIN**************-->  
			  				<table id="bottomLeft" width="770"  bgColor='#FFFAF0' cellspacing='0px' border='2px'  cellpadding='0px'   style=' border-collapse:collapse'> <tbody></tbody> </table>
		 					 <!--*************左下-END***********-->  
	 					</div>  
	 				</td>  
	    		
		    		<td align="left" valign="top">  
						 <div style="width:910;height:370px;overflow-x:scroll " overflow-y:hidden; onscroll="javascript:syncscroll(this)">   <!-- 控制左右滑动条的宽度 -->
						 	<!--***********右下-BEGIN***********-->  
		  					<table  id="bottomRight"  width="2700px"   bgColor='#FFFAF0' cellspacing='0px' border='2px'  cellpadding='0px'   style=' border-collapse:collapse'>  </table>  
		  					 <!--*************右下-END*****************-->  
		 				</div>  
		 			</td>  
		 		 </tr>  
			</table>  
			<div id="footer"></div>
		</center>
	</body>  
</html>