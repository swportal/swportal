<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>



<!DOCTYPE html>
<html>
 	<head>
   		<title>Server Info.</title>
  		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
  		<script src="<%=request.getContextPath()%>/js/jquery.table2excel.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
	    <style type="text/css"> 
		    hr{
		    	position:relative;
				top: 500px;
		    }
		    a{
				TEXT-DECORATION:none
			}
	    	#footer{
	    		 position:absolute;
	    		 bottom: 40px;
	    		 margin-left :800px;
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
				right:9%;
			}				
			
		</style>			
			
		<script type="text/javascript">
			function load(pn,serverFlag){
				var disWord="";
				if(!serverFlag)
					disWord="disabled";
				var keyword =document.getElementById("selectitem").value;
				var curpage="";
			    var totalpage="";	
			   
				$.getJSON("/portal/server/findServerList?keyword="+encodeURIComponent(keyword,"utf-8")+"&curPage="+pn+"&rn="+Math.random(),function(data){		
					curpage=data[1].curpage;
	    			totalpage=data[1].totalpage;   
					var str="";
					$.each(data[0].serverList,function(i){					 
						   //for(var i = 0;i<data.length;i++){							  
						   str+="<tr bordercolor='#DEDEDE' bgcolor='#ffffff' >";
						   str+="<input type='hidden' name='id' value=id>";
						   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px; color:#004779; '>"+(i+1)+"</td>"; 
					  	   str+="<td align='center' bordercolor='#DEDEDE' height='29px' style='font-size:12px;'>"+"&nbsp;&nbsp;"+data[0].serverList[i].ip+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].name+"</td>";	
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].useFor+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].cpuCount+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].cpuNumber+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].memCount+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].memSize+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].hddCount+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].hddType+"</td>"; 
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].hddSize+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].osVersion+"</td>";
					  	   str+="<td align='center' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].serverList[i].manager+"</td>";						 
					  	   str+="</tr>";
					});
				 	//$("#tableServer").empty();
				 	//$("#tableServer").append(str);
					$("#tableServer tbody").html("");
					$("#tableServer tbody").html(str);
					var firstpagehtml; 
					var prevpagehtml; 
					var nextpagehtml;
					var lastpagehtml;
					if((curpage-0)<=1){
						firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a><</a>";
					}
					else{
					 	firstpagehtml="<a onclick='load(1"+",\""+serverFlag+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
					 	prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+serverFlag+"\");' href='javascript:void(0);'><</a>";
					}
					if(curpage < totalpage){
						nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+serverFlag+"\");' href='javascript:void(0);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml="<a onclick='load("+(totalpage)+",\""+serverFlag+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
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
	
  	<body onload="load(1,'${usersession.hasPrivilegeByName('Server Info.')}')">  
	  	<div id="navtop">
			<ul class="navtop-skin">
				<li>						 
						<font color="#2c3e50"><strong>| Server Info.|</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" placeholder="Search" name="selectitem" id="selectitem" title="Input IP;Name;Usage;Manager"  oninput="javascript:load(1,'${usersession.hasPrivilegeByName('Server Info.')}')"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
		        </li> 
		    </ul>
		    <ul class="navtop-right">
		    	<li >
					<a href="/portal/server/importExec" title="Data Download">
						<img src="${pageContext.request.contextPath}/style/images/excel6.jpg"   width=20px height=20px style="padding-top:15px"/>
					</a>
		        </li> 
		    </ul>
		</div>
		<br/>

		<center>
		  	<form action="">
		    		<table id = "tableServer"  bgColor='#FFFAF0' cellspacing='0px' border='2px'  cellpadding='0px'   style=' border-collapse:collapse'>
		    			<thead>
					        <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" >
							   <td align="center" width="50px"  rowspan="2"><font  size=2 style="font-weight:bold;">No</font></td>
				        	   <td align="center" width="110px"  rowspan="2"><font  size=2 style="font-weight:bold;">IP</font></td>
				        	   <td align="center" width="180px"  rowspan="2"><font  size=2 style="font-weight:bold;">Server Name</font></td>
				        	   <td align="center" width="180px"  rowspan="2"><font  size=2 style="font-weight:bold;">Server Usage</font></td>
				        	  
				        	   <td align="center"  height="25px" colspan="2"><font  size=2 style="font-weight:bold;">CPU</font></td>
				        	   <td align="center"  height="25px"  colspan="2"><font  size=2 style="font-weight:bold;">Memory</font></td>
				        	   <td align="center"  height="25px"  colspan="3"><font  size=2 style="font-weight:bold;">HDD</font></td>
				        	   
				        	   <td align="center" width="200px"   rowspan="2"><font  size=2 style="font-weight:bold;">OS Version</font></td>
				        	   <td align="center" width="80px"   rowspan="2"><font  size=2 style="font-weight:bold;">Manager</font></td>
				        	</tr>
				        	<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" align="CENTER" valign="MIDDLE" >
				        	   <td align="center" width="70px"  height="25px"><font  size=2 style="font-weight:bold;">Count</font></td>
				        	   <td align="center" width="80px" height="25px"><font  size=2 style="font-weight:bold;">Core Num.</font></td>
				        	   
				        	   <td align="center" width="70px"  height="25px"><font  size=2 style="font-weight:bold;">Count</font></td>
				        	   <td align="center" width="70px" height="25px"><font  size=2 style="font-weight:bold;">Size (GB)</font></td>
				        	   
				        	   <td align="center" width="70px"  height="25px"><font  size=2 style="font-weight:bold;">Count</font></td>
				        	   <td align="center" width="180px" height="25px"><font  size=2 style="font-weight:bold;">Type</font></td>
				        	   <td align="center" width="80px" height="25px"><font  size=2 style="font-weight:bold;">Size (TB)</font></td>
		        	   		</tr>   		    			
		    			</thead>
		    			<tbody></tbody>
		    		</table>
			</form>			
			<div id="footer"></div>
		</center> 
	</body>
</html>
