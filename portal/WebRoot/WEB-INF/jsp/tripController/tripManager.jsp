<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>



<!DOCTYPE html>
<html>
 	<head>
   		<title>Business Trip Management</title>
  		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
     	     	<%--  2017-03-21 wuliying add --%>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/button-flag.css" />
	    <style type="text/css"> 
		    hr{
		    	position:relative;
				bottom: -500px;
		    }
		    a{
				TEXT-DECORATION:none
			}
	    	#footer{
	    		 position:absolute;
	    		 bottom: 40px;
	    		 margin-left :750px;
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
			
			
			.textPlace{ position:relative; top:-5px; /*left:5px; right:5px;bottom:5px*/} 
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
				right:6%;
			}				
		</style>
    
		<script type="text/javascript">	
		 var f=0;
		 var pn=1;
		 var flag1,flag2;
		 var orderitm;
		 var orderk;
		 function addTrip(){			 	
			   $.getJSON("/portal/trip/addTrip?adr="+Math.random(),function(data){
				   if("success"==data.result){					  
					   window.location.reload();
					   // load(pn,tripFlag);
				   }
				   else{
					   
					   alert("Error!");
					   window.location.reload();
				   }
			   });	 
		   
		  }
		  function delTrip(){			
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
						$.get("/portal/trip/delTripList?ids="+ids,function(data){
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
				   $.get("/portal/trip/delTrip?id="+id,function(data){
					   if("success"==data.result){
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
			  function updateTrip(element,id){			
				 $.getJSON("/portal/trip/updateTrip?id="+id+"&item="+element.id+"&value="+encodeURIComponent(element.value,"utf-8"),function(data){
						   if("success"==data.result){
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
			  
			  function changeUrl(element,id){
				 var winObj = window.open ("/portal/trip/changeUrl?id="+id+"&item="+element.id+"&value="+encodeURIComponent(element.alt), "newwindow", "height=100, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				 var loop = setInterval(function() {       
				        if(winObj.closed) {      
				            clearInterval(loop);      
				            window.location.reload();
				        }  				       
				    }, 1); 
			  }
			  function sort(flag,iRow, iCol){
				  var table=document.getElementById("tableTrip");
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
		        	  load(1,flag1,flag2,"scheduleStart","DESC");
		        	  th.innerHTML=th.innerHTML.replace(ascChar, descChar);
		          }
		          else{
		        	   load(1,flag1,flag2,"scheduleStart","ASC");
		        	  th.innerHTML=th.innerHTML.replace(descChar, ascChar);
		          }
			  }
			  
			  function upload(id){
				  /*url=encodeURI(encodeURI(value));//转码两次，很关键
				  url = url.replace(/\+/g,"+");
				  url = url.replace(/\&/g,"&");
				  url = url.replace(/\#/g,"#");*/
				  //alert(item);
				 var winObj = window.open ("/portal/trip/toUpload?id="+id, "newwindow", "height=700, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
				 var loop = setInterval(function() {       
				        if(winObj.closed) {      
				            clearInterval(loop);      
				            //window.location.reload(); 2016-11-24 wuliying delete
				        }      
				    }, 1); 				 
			  }
			  function getFileList(id){
				  var winObj = window.open ("/portal/trip/getFileList?id="+id, "newwindow", "height=500, width=800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=1100");
			  }
		</script>

		<script type="text/javascript">
			function load(cur,tripFlag,delflag,orderItem,orderKey){	
				pn=cur;
			  	orderitm=orderItem;
			  	orderk=orderKey;
			  	flag1=tripFlag;
			  	flag2=delflag;
			  	var disWord="";
			  	
			  	if(tripFlag.toString()=="true"||tripFlag==1)
					tripFlag=1;
		   	  	else
		   			tripFlag=0;
			    //wuliying add delete flag ---2017/02/10
				//wuliying add delflag==1  ---2017/02/15
			  	if(delflag.toString()=="true"||delflag==1)
					delflag=1;
		   	  	else
		   			delflag=0;
		   	  	if(!tripFlag)
		   			disWord="disabled";
			   	var keyword =document.getElementById("selectitem").value;
			   	var curpage="";
	    	   	var totalpage="";
			    $.getJSON("/portal/trip/findTripList?keyword="+encodeURIComponent(keyword,"utf-8")+"&orderItem="+orderItem+"&orderKey="+orderKey+"&curpage="+cur+"&rn="+Math.random(),function(data){
			    	if(data[0].tripList.length!=0)
			    		document.getElementById("urllink").href = data[0].tripList[0].report;
		    	   	curpage=data[1].curpage;
    			   	totalpage=data[1].totalpage;
				   	var str="";
        	   		$.each(data[0].tripList,function(i){
						str+="<tr bordercolor='#DEDEDE' bgcolor='#ffffff'>";
					   	str+="<input type='hidden' name='id' value=id>";
			  		   	if(delflag)
				  			str+="<td align='center' bordercolor='#DEDEDE'><input type='checkbox' name='isSelect' value='"+data[0].tripList[i].id+"' ></input></td>";
				  	   	else
				  			str+="<td align='center' bordercolor='#DEDEDE'  style='font-size:12px; color:#004779; '>"+(i+1+(pn-1)*18)+"</td>"; 

				  	   	str+="<td bordercolor='#DEDEDE' width='120px'><input type='text' "+disWord+" class='t'   id='name'   style='font-size:12px; color:black; text-align:center;width:120px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].name.replace('\'','&#39;')+"'> </td>";	
				  	   	str+="<td bordercolor='#DEDEDE' width='110px'><input type='text' "+disWord+" class='t'   id='part'   style='font-size:12px;  color:black;  text-align:center;width:110px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].part.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='110px'><input type='text' "+disWord+" class='t'   id='subPart'   style='font-size:12px;  color:black;  text-align:center;width:110px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].subPart.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='400px'><input type='text' "+disWord+" class='t'   id='purpose'   style='font-size:12px;  color:black;  text-align:center;width:400px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].purpose.replace('\'','&#39;')+"'> </td>";
				  	  	str+="<td bordercolor='#DEDEDE' width='110px'><input type='text' "+disWord+" class='t'   id='scheduleStart'   style='font-size:12px;  color:black;  text-align:center;width:110px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].scheduleStart.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='110px'><input type='text' "+disWord+" class='t'   id='scheduleEnd'   style='font-size:12px;  color:black;  text-align:center;width:110px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].scheduleEnd.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='50px'><input type='text' "+disWord+" class='t'   id='duration'   style='font-size:12px;  color:black;  text-align:center;width:50px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].duration.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='destination'   style='font-size:12px; color:black;   text-align:center;width:80px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].destination.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='80px'><input type='text' "+disWord+" class='t'   id='region'   style='font-size:12px;  color:black;  text-align:center;width:80px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].region.replace('\'','&#39;')+"'> </td>";
				  	   	str+="<td bordercolor='#DEDEDE' width='100px'><input type='text' "+disWord+" class='t'   id='department'   style='font-size:12px; color:black;   text-align:center;width:100px'  onChange='updateTrip(this,"+data[0].tripList[i].id+")'  value='"+data[0].tripList[i].department.replace('\'','&#39;')+"'> </td>";
				  	 	if(tripFlag){
				  			if(data[0].tripList[i].filename.length==0){ //2017-02-07 wuliying, 区分是否已经存在上传文件
				  				str+="<td align='center' bordercolor='#DEDEDE' width='60px'><a href='javascript:upload("+data[0].tripList[i].id+")' title='Upload Report'> <img src='${pageContext.request.contextPath}/FlatUI/img/edit2.png'   width=18px height=18px/></a></td>";
				  			}
					  		else{
					  			str+="<td align='center' bordercolor='#DEDEDE' width='60px'><a href='javascript:upload("+data[0].tripList[i].id+")' title='Upload Report'> <img src='${pageContext.request.contextPath}/FlatUI/img/link.png'   width=15px height=15px/></a></td>";
					  		}
					  	   	}
				  	 	else{
						 	if(data[0].tripList[i].filename.length==0){
								 str+="<td align='center' bordercolor='#DEDEDE' width='60px'></td>";
							 }
						 	else{
							 	if(data[0].tripList[i].filename.indexOf(",")==-1){
									 str+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='/portal/trip/download/"+data[0].tripList[i].filename+"' title='Business Trip Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								 }
							 	else{
									 str+="<td align='center' width='60px' bordercolor='#DEDEDE'><a href='javascript:getFileList("+data[0].tripList[i].id+")' title='Business Trip Materials Download'><img src='${pageContext.request.contextPath}/FlatUI/img/link.png' width=15px height=15px/></a></td>";
								 }
							}
				   		}					
				  		str+="</tr>";
					});  //$.each
						
				 	$("#tableTrip tbody").html("");
				 	$("#tableTrip tbody").html(str);
					var firstpagehtml; 
					var prevpagehtml; 
					var nextpagehtml;
					var lastpagehtml;
					if((curpage-0)<=1){
						firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
					 	prevpagehtml = "<a><</a>";
					}
					else{
					 	firstpagehtml="<a onclick='load(1"+",\""+tripFlag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
					 	prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+tripFlag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><</a>";
					}
					if(curpage < totalpage){
						nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+tripFlag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
					 	lastpagehtml="<a onclick='load("+(totalpage)+",\""+tripFlag+"\",\""+delflag+"\",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
					}
					else{
						nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
					 	lastpagehtml = "<a>>></a>";
					}
					var html2="";		
					html2 = html2 + "<table><tr  bgcolor='white' bordercolor='white'><td height='60px'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+curpage+"&nbsp;/&nbsp;"+totalpage+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
					html2 = html2+"</table>";
				    document.getElementById("footer").innerHTML=html2;
		 		}); //$.getJSON
			}
		</script>
		<script type="text/javascript">
	  		function ExportToExcel() {
	  	        var elTable = document.getElementById("tableServer"); 
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
		<script language="JavaScript">
			$(function(){
				document.getElementById("selectitem").focus();
			});
		</script>		
  	</head> 
	
  	<body onload="load(1,'${usersession.hasPrivilegeByName('Trip Update')}','${usersession.hasPrivilegeByName('Trip Delete')}','id','DESC')">
 
  	<div id="navtop">
		<ul class="navtop-skin">
			<li style="padding-left:20">
					<font color="#2c3e50"><strong><a target="_blank" href="#" id="urllink" title="GO TO MOSAIC">| Business Trip Info. |</a></strong></font>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" placeholder="Search" name="selectitem" id="selectitem" title="Input Name; Part;Destination"  oninput="javascript:load(1,'${usersession.hasPrivilegeByName('Trip Update')}','${usersession.hasPrivilegeByName('Trip Delete')}','id','DESC')"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
	        </li>
	        <li style="padding-left:850">
					<c:if test="${usersession.hasPrivilegeByName('Trip Add')}">
						<input type="button"  onclick="addTrip()" value=" Add "  class="button button-raised button-rounded button-small"  />  &nbsp;&nbsp; <%-- 2017-03-21 wuliying delete : style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; " --%>
					</c:if>
					<c:if test="${usersession.hasPrivilegeByName('Trip Delete')}">
						<input type="button"  onclick="delTrip()" value="Delete"  class="button button-raised button-rounded button-small"  />  &nbsp;&nbsp; <%-- 2017-03-21 wuliying delete : style="color:#2c3e50; font-size:12px;font-weight:bold;   border-radius:5px; vertical-align:middle;height:30px;  width:60px; " --%>
					</c:if>
			</li>
		</ul>
		<ul class="navtop-right">
			<li >
				<a href="/portal/trip/importExec" title="Data Download">
					<img src="${pageContext.request.contextPath}/style/images/excel6.jpg"   width=20px height=20px style="padding-top:15px"/>
				</a>
		    </li> 
	    </ul>
	</div>
	<br/>
	<center>
	  	<form action="">
	    		<table id = "tableTrip"  bgColor='#FFFAF0' cellspacing='0px' border='2px'  cellpadding='0px'   style=' border-collapse:collapse'>
	    			<thead>
	    				<tr bgcolor='#d2e9ff' bordercolor='#DEDEDE'>
	    					<c:choose>  
								<c:when test="${usersession.hasPrivilegeByName('Trip Update')}">   
									<td align="center" width="50px" rowspan="2"><input type="checkbox" name="allSelect" onclick="sel(this)"></input></td>
								</c:when>  
								<c:otherwise>   
									<td align="center" width="50px"  rowspan="2"><font  size=2 style="font-weight:bold;">No</font></td>
								</c:otherwise> 
							</c:choose> 
						  
			        	 	<td align="center" width="140px"  rowspan="2"><font size=2  style="font-weight:bold;">Name</font></td>
			        	   	<td align="center" width="250px"  rowspan="2" colspan="2"><font  size=2 style="font-weight:bold;">Part</font></td>
			        	   	<td align="center" width="420px"  rowspan="2"><font  size=2 style="font-weight:bold;">Purpose</font></td>
			        	  
			        	   	<td align="center" width="300px"  height="25px" colspan="3"><font size=2  style="font-weight:bold;">Schedule</font></td>
			        	  	<td align="center" width="300px" height="25px"  colspan="3"><font  size=2 style="font-weight:bold;">Destination</font></td>
			        	  	<td align="center" width="60px"   rowspan="2"><font  size=2 style="font-weight:bold;">Report</font></td>
			        	</tr>
			        	<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" align="CENTER" valign="MIDDLE" >
			        	   <td align="center" width="110px"  height="25px" onClick="javascript:sort('${usersession.hasPrivilegeByName('Trip Update')}',1,0)"><font  size=2 style="font-weight:bold;">Start&nbsp; <font size='1' color='#2c3e50'>▼</font></font></td>
			        	   <td align="center" width="110px" height="25px"><font  size=2 style="font-weight:bold;">End</font></td>
			        	   <td align="center" width="54px" height="25px"><font  size=2 style="font-weight:bold;">Days</font></td>
			        	   
			        	   <td align="center" width="80px" height="25px" ><font  size=2 style="font-weight:bold;">Country</font></td>
			        	   <td align="center" width="80px" height="25px" ><font  size=2 style="font-weight:bold;">Region</font></td>
			        	   <td align="center" width="100px" height="25px" ><font  size=2 style="font-weight:bold;">Dept.</font></td>
			        	</tr> 
			        </thead>
			        <tbody></tbody>
	    		</table>
		</form>
		<div id="footer"></div>
	</center>  
  </body>
</html>
