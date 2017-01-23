<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<!DOCTYPE HTML>
<html>
	<head>
			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
		<title>S/W Project Analysis System</title>
		
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ichart/ichart.1.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdate.js"></script>
		<style>
			html,body{ 
				margin:0; 
				padding:0; 
				height:90%
			}
		</style>
		<style type="text/css">			
			.main{ 
				min-height:100%; heiguto !important; 
				height:100%; 
				margin:0 auto;
			}
			.footer{ 
				position:absolute; 
				bottom:0; 
				height:40px; 
				background:#9ABAE0;
				width:100%;}
			a{
				TEXT-DECORATION:none
			}
			a:hover{
				TEXT-DECORATION:none  <%--underline --%>
			}
		</style>   
		<style type="text/css">
		    #footer {
		       		 position: fixed;
		       		 bottom: 0;
		    }
		    .td-right{    	
		    	border-right:0px
		    }
		    .td-left{    	
		    	border-left:0px
		    }
		</style>
		<style type="text/css">
			ul,li{
				margin:0;
				padding:0;
				list-style:none;
			}
			#navtop{
				width:100%;
				height:47px;
				background-color:#ecf0f1;
				text-align:center;
				overflow:hidden;
			}
			.navtop-skin{
				float:left;
				position:relative;
				left:20%;
			}
			.navtop-skin li{
				float:left;
				margin:0px;
				padding:0 20px;
				position:relative;
				right:20%;
				line-height:40px;
				border:solid 0px #000;
			}	
		</style>
	
	
		<style type="text/css">	
			@media screen and (-webkit-min-device-pixel-ratio:0) {  /*safari and chrome*/
			    select {
			        height:30px;
			        line-height:30px;
			        background:#f4f4f4;
			    } 
			}
			select::-moz-focus-inner { /*Remove button padding in FF*/ 
			    border: 0;
			    padding: 0;
			}
			@-moz-document url-prefix() { /* targets Firefox only */
			    select {
			        padding: 15px 0!important;
			    }
			}        
			@media screen\0 { /* IE Hacks: targets IE 8, 9 and 10 */        
			    select {
			        /*height:30px;
			        line-height:30px;*/
			        -moz-border-radius:5px!important;
			        -webkit-border-radius:5px!important;			       
			        overflow:hidden;
			    }     
			    input{
			    	/*height:30px;
			        line-height:30px;*/
			        -moz-border-radius:5px!important;
			        -webkit-border-radius:5px!important;		       
			    }
			}	
		</style>
	
		<style type="text/css"> 
			.linear{ 
				width:100%; 
				height:100%; 
				FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#15A216,endColorStr=#fafafa); /*IE*/  
				background:-moz-linear-gradient(top,#A0C0E5,#2A4B73);/*火狐*/ 
				background:-webkit-gradient(linear, 0% 0%, 0% 100%,from(#A0C0E5), to(#2A4B73));/*谷歌*/ 
				background-image: -webkit-gradient(linear,left bottom,left top,color-start(0, #15A216),color-stop(1, #fafafa));/* Safari & Chrome*/ 
				filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#A0C0E5', endColorstr='#2A4B73'); /*IE6 & IE7*/ 
				-ms-filter: "progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#A0C0E5', endColorstr='#2A4B73')"; /* IE8 */ 
			} 
		</style> 
	
	<script language="JavaScript">
		function openwin_searchdefect(pn,mod,item){	
			window.open ("/portal/defect/getDefectFromModel?projectname="+pn+"&modelname="+mod+"&item="+item+"&rn="+Math.random(), "newwindow2", "height=700, width=1800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=100");
		}
	</script> 
	<script type="text/javascript">
		function load(currpage,projectname) {
			var projectname1="<%=request.getParameter("projectname")%>";
			 var down="";
			 down = down + "<a href='/portal/model/DownModel?projectname="+projectname1+"'  title='Data Download'>	<img src='<%=request.getContextPath()%>/style/images/excel6.jpg'   width=20px height=20px   style='left:1500px;padding-top:5px;display:inline'/> </a>";
			 document.getElementById("downexcel").innerHTML=down;
			 $.getJSON("/portal/model/findModelList?curPage="+currpage+"&projectname="+projectname1+"&rn="+Math.random(),function(data){		
					var curpage=data[1].curpage;
					var pagecount = data[1].totalpage;  				
					var html="";
					$.each(data[0].modelList,function(i){	
							var mile=data[0].modelList[i].milestone;
							var mileflag="";
							if(mile!="-"){
								var first=mile.substring(0,1).toLowerCase();								
								var rest=mile.substring(1,mile.length);								
								mileflag=first+rest;
								mileflag=eval("data[0].modelList["+i+"]."+mileflag);
							}
							//alert(mile);
							html=html+"<tr bordercolor='#DEDEDE' bgcolor='#ffffff'>";
			  				if(mile!="SRA"){  //齿轮判断
				  				if(mile!="-"){   //2016-12-20 wuliying change from "null" to "-" to apply PLM change point
				  					//alert(mile);
					  				if(mileflag=="R"){
					  					//alert(mile);
					  					html=html+"<td align='center' width='50px' height='29px' ><img id='obj3' src='<%=request.getContextPath()%>/style/images/chilun_red.png'  width='18' height='18'/></td>";
					  				}
					  				else{
					  					//alert(mile);
					  					html=html+"<td align='center' width='50px' height='29px' ><img src='<%=request.getContextPath()%>/style/images/chilun.png'  width='18' height='18'/></td>";
					  				}
			  					}
				  				else{
				  					//alert(1);
				  					html=html+"<td align='center' width='50px' height='29px' ><img src='<%=request.getContextPath()%>/style/images/chilun_grey.png'  width='18' height='18'/></td>";
				  				}
		  					} // SRA END
			  				else{
		  						html=html+"<td align='center' width='50px' height='29px' ><img src='<%=request.getContextPath()%>/style/images/chilun_grey.png'  width='18' height='18'/></td>";
		  					}
		  					
				  			html = html+ "<td align='center'><font>" + data[0].modelList[i].devModelName+"</font></td>";
						  // if(mile!="-"){  //milestone
						   		html=html+"<td align='center'><font size=2>"+data[0].modelList[i].milestone+"</font></td>";						   		
						   //}
						   //else{
						   		//html=html+"<td align='center'><font size=2>-</font></td>";
						   //}
						   if(data[0].modelList[i].devType=="Derivation"){  //pjt type
						   		html=html+"<td align='center'><font size=2>Deriv.</font></td>";
						   }
						   else
						   		html=html+"<td align='center'>"+data[0].modelList[i].devType+"</td>";  
						   if(mile=="PIA"){
							   	if(data[0].modelList[i].pIA=="R"){
									html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pIAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pIAPlanDate.substring(8,10)+"</font></td>";
									if(data[0].modelList[i].pIAActualDate.length==0){
							   			html=html+"<td align='center' ></td>";
							   		}
									else{
							   			html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pIAActualDate.substring(5,7)+"/"+data[0].modelList[i].pIAActualDate.substring(8,10)+"</font></td>";
							   		}
								}
								else if(data[0].modelList[i].pIA=="Y"){
									html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pIAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pIAPlanDate.substring(8,10)+"</font></td>";
						   			if(data[0].modelList[i].pIAActualDate.length==0){
						   				html=html+"<td align='center' ></td>";
						   			}
						   			else{
						   				html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pIAActualDate.substring(5,7)+"/"+data[0].modelList[i].pIAActualDate.substring(8,10)+"</font></td>";
						   			}
								}
								else if(data[0].modelList[i].pIA=="N"){
									html=html+"<td align='center'></td>"+"<td align='center'></td>";
								}
								else{
									html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pIAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pIAPlanDate.substring(8,10)+"</font></td><td align='center'> <font size='2'>";
						   			if(data[0].modelList[i].pIAActualDate.length==0){
						   				html=html+"</font></td>";
						   			}
						   			else{
						   				html=html+data[0].modelList[i].pIAActualDate.substring(5,7)+"/"+data[0].modelList[i].pIAActualDate.substring(8,10)+"</font></td>";
						   			}
								}
						   }//PIA end
						   else{				   
							   if(data[0].modelList[i].pIAPlanDate.length==0){
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   	}
							   else{
							   		html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pIAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pIAPlanDate.substring(8,10)+"</font></td>";
							   		if(data[0].modelList[i].pIAActualDate.length==0){
							   			html=html+"<td align='center'></td>";
							   		}
							   		else{
							   			html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pIAActualDate.substring(5,7)+"/"+data[0].modelList[i].pIAActualDate.substring(8,10)+"</font></td>";
							   		}
						   		}
						   }
						   	   
						   if(mile=="PVR"){
							   	if(data[0].modelList[i].pVR=="R"){
									html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pVRPlanDate.substring(5,7)+"/"+data[0].modelList[i].pVRPlanDate.substring(8,10)+"</font></td>";
									if(data[0].modelList[i].pVRActualDate.length==0){
							   			html=html+"<td align='center' ></td>";
							   		}
									else{
							   			html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pVRActualDate.substring(5,7)+"/"+data[0].modelList[i].pVRActualDate.substring(8,10)+"</font></td>";
							   		}
								}
								else if(data[0].modelList[i].pVR=="Y"){
									html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pVRPlanDate.substring(5,7)+"/"+data[0].modelList[i].pVRPlanDate.substring(8,10)+"</font></td>";
						   			if(data[0].modelList[i].pVRActualDate.length==0){
						   				html=html+"<td align='center' ></td>";
						   			}
						   			else{
						   				html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pVRActualDate.substring(5,7)+"/"+data[0].modelList[i].pVRActualDate.substring(8,10)+"</font></td>";
						   			}
								}
								else if(data[0].modelList[i].pVR=="N"){
									html=html+"<td align='center'></td>"+"<td align='center'></td>";
								}
								else{
									html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pVRPlanDate.substring(5,7)+"/"+data[0].modelList[i].pVRPlanDate.substring(8,10)+"</font></td><td align='center'> <font size='2'>";
						   			if(data[0].modelList[i].pVRActualDate.length==0){
						   				html=html+"</font></td>";
						   			}
						   			else{
						   				html=html+data[0].modelList[i].pVRActualDate.substring(5,7)+"/"+data[0].modelList[i].pVRActualDate.substring(8,10)+"</font></td>";
						   			}
								}
						   }//PVR end
						   else{				   
							   if(data[0].modelList[i].pVRPlanDate.length==0){
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   	}
							   else{
							   		html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pVRPlanDate.substring(5,7)+"/"+data[0].modelList[i].pVRPlanDate.substring(8,10)+"</font></td>";
							   		if(data[0].modelList[i].pVRActualDate.length==0){
							   			html=html+"<td align='center'></td>";
							   		}
							   		else{
							   			html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pVRActualDate.substring(5,7)+"/"+data[0].modelList[i].pVRActualDate.substring(8,10)+"</font></td>";
							   		}
						   		}
						   }
						   
						   if(mile=="PRA"){
							   	if(data[0].modelList[i].pRA=="R"){
									html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pRAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pRAPlanDate.substring(8,10)+"</font></td>";
									if(data[0].modelList[i].pRAActualDate.length==0){
							   			html=html+"<td align='center' ></td>";
							   		}
									else{
							   			html=html+"<td align='center'> <font color='red' size='2' style='font-weight:bold;'>"+data[0].modelList[i].pRAActualDate.substring(5,7)+"/"+data[0].modelList[i].pRAActualDate.substring(8,10)+"</font></td>";
							   		}
								}
								else if(data[0].modelList[i].pRA=="Y"){
									html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pRAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pRAPlanDate.substring(8,10)+"</font></td>";
							   		if(data[0].modelList[i].pRAActualDate.length==0){
							   			html=html+"<td align='center' ></td>";
							   		}
							   		else{
							   			html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].modelList[i].pRAActualDate.substring(5,7)+"/"+data[0].modelList[i].pRAActualDate.substring(8,10)+"</font></td>";
							   		}
								}
								else if(data[0].modelList[i].pRA=="N"){
									html=html+"<td align='center'></td>"
							   		+"<td align='center'></td>";
								}
								else{
									
									html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pRAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pRAPlanDate.substring(8,10)+"</font></td><td align='center'> <font size='2'>";
						   				if(data[0].modelList[i].pRAActualDate.length==0){
						   					html=html+"</font></td>";
						   				}
						   				else{
						   					html=html+data[0].modelList[i].pRAActualDate.substring(5,7)+"/"+data[0].modelList[i].pRAActualDate.substring(8,10)+"</font></td>";
						   				}
								}
						   }//PRA end
						   
						   else{
							   	if(data[0].modelList[i].pRAPlanDate.length==0){
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   		html=html+"<td align='center'> <font size='2'>-</font></td>";
							   	}
							   	else{
							   		//alert(mile);
							   		html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pRAPlanDate.substring(5,7)+"/"+data[0].modelList[i].pRAPlanDate.substring(8,10)+"</font></td>";
							   		if(data[0].modelList[i].pRAActualDate.length==0){
							   			html=html+"<td align='center'></td>";
							   		}
							   		else{
							   			html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pRAActualDate.substring(5,7)+"/"+data[0].modelList[i].pRAActualDate.substring(8,10)+"</font></td>";
							   		}
							   	}				   
						   }
						   if(data[0].modelList[i].pLMTotal!=0){
							   html=html+"<td align='center'>"
								+ "<a onClick='openwin_searchdefect(\""+data[0].modelList[i].pjtName+"\",\""+data[0].modelList[i].devModelName+"\",\"\")'  href='#'>"
						    	+"<font color='#3498db' size='2'>"+data[0].modelList[i].pLMTotal
							   +"</font></a></td><td align='center'> <font size='2'>";
						   }
						   else{
							   html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pLMTotal
							   +"</font></td><td align='center'> <font size='2'>";					   
						   }
						   html=html+data[0].modelList[i].pLMClosed+"</font></td><td align='center'> <font size='2'>"
						   +data[0].modelList[i].pLMResolved+"</font></td>";
						   if(data[0].modelList[i].pLMOpened!=0){
							   html=html+"<td align='center'> "
								+ "<a onClick='openwin_searchdefect(\""+data[0].modelList[i].pjtName+"\",\""+data[0].modelList[i].devModelName+"\",\"Opened\")'  href='#'>"
						    	+"<font color='#3498db' size='2'>"+data[0].modelList[i].pLMOpened
							   +"</font></a></td>";
						   }
						   else{
							   html=html+"<td align='center'> <font size='2'>"+data[0].modelList[i].pLMOpened
							   +"</font></td>";					   
						   }					  
						   
						  html=html+"</tr>";
		  			
					});
					$("#tableId tbody").html("");
					$("#tableId tbody").html(html);
					
					var firstpagehtml; 
					var prevpagehtml; 
					var nextpagehtml;
					var lastpagehtml;
					if((currpage-0)<=1){
						firstpagehtml= "<a><<</a>&nbsp;&nbsp;&nbsp;";
						prevpagehtml = "<a><</a>";
					}else{
						firstpagehtml="<a onclick='load(1,"+"\"\""+");' href='javascript:void(0);'><font color='#3498db'><<&nbsp;&nbsp;&nbsp;</font></a>";
						prevpagehtml = "<a onclick='load("+(currpage-1)+","+"\"\""+");' href='javascript:void(0);'><</a>";
					}
					if((currpage-0)<(pagecount-0)){
						nextpagehtml = "<a onclick='load("+(currpage-0+1)+","+"\"\""+");' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml = " <a onclick='load("+pagecount+","+"\"\""+");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
					}else{
						nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
						lastpagehtml = "<a>>></a>";
					}
		  			html2="";		
		  			html2 = html2 + "<table ><tr  bgcolor='white' bordercolor='white'><td height='60px'   align='center'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+currpage+"&nbsp;/&nbsp;"+pagecount+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
		  			html2 = html2+"</table><br>";
					document.getElementById("paging").innerHTML=html2;
					
			 });
		}
	</script>
	</head>	
  
	<body onload="load(1,'');" > 
		<br/><br/> 	
		<div style="height:680px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Project Name: <%=request.getAttribute("projectname") %>
			<div id="downexcel"  style="position:absolute;   left:1250px; top:30px"></div>
			<center>
		 		<div id="div"> 
			 		<table  id="tableId" border-radius="5px" bordercolor="#DEDEDE" bgColor="#ffffff" border="2px" cellspacing="0px" style="border-collapse:collapse" border="1px">
		  				<thead>
			  				<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
			  					<td align="center" width="40px" height="40px" rowspan="2"></td>
			  			        <td align="center" height="40px" width="180px" rowspan="2"><font color="#333333" style="font-weight:bold;">Model Name</font></td>
			  			        <td align="center" height="40px" width="80px" rowspan="2"><font font color="#333333" style="font-weight:bold;">Milestone</font></td>
			  			        <td align="center" height="40px" width="80px" rowspan="2"><font font color="#333333" style="font-weight:bold;">Dev. Type</font></td>
			  			        <td align="center" height="30px" width="160px" colspan="2"><font font color="#333333" style="font-weight:bold;">PIA</font></td>
			  			        <td align="center" height="30px" width="160px" colspan="2"><font font color="#333333" style="font-weight:bold;">PVR</font></td>
			  			        <td align="center" height="30px" width="160px" colspan="2"><font font color="#333333" style="font-weight:bold;">PRA</font></td>
			  			        <td align="center" height="30px" width="320px" colspan="4"><font font color="#333333" style="font-weight:bold;">Defects</font></td>
			  			    </tr>
			  			    <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Plan</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Actual</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Plan</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Actual</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Plan</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Actual</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Total</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Closed</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Resolved</font></td>
			  			        <td align="center" height="30px" width="80px"><font font color="#333333" style="font-weight:bold;">Opened</font></td>
			  			    </tr>
			  			</thead>
			  			<tbody></tbody>
			  		</table>
		 		</div>
		 		<div id="paging" style="position:absolute;bottom: 10px;margin-left:600px;"></div>
  			</center> 
		</div>		
  </body>
</html>
