<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%--<%@ taglib uri="/struts-tags" prefix="s"%>--%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
		<title>S/W Project Analysis System</title>
		
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" /> 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/style_button.css" />
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
 
		<script type="text/javascript">		
			var ordItem="";
			var ordKey="";		
			var favor=0;
			var cur=1;
			//var userid=${usersession}.length==0?"":${usersession.id};
			function updateFavor(id){
				//var aa=${usersession.id}+" "+id;
				//alert(aa);				
				var pasid=id;
				$.getJSON("/portal/user/updateFavor?pasid="+pasid,function(data){
					if("yes"==data.result){
						 //alert("Add Success!");
						 load(cur,'','');
					}
					else{ 
						// alert("Delete Success!");
						 load(cur,'','');
				   	}
				});
			}
			function getFavorList(){
				$("#tableId tbody").html("");
				favor=favor==0?1:0;
				load(1,'','');
			}
			function load(currpage,orderItem,orderKey) {
				cur=currpage;
				//alert(favor);
				var keyword=document.getElementById("selectitem").value;	
				var parentSelect=document.getElementById("parentSelect").value;
				var childSelect=document.getElementById("childSelect").value;
				var milestone=document.getElementById("milestone").value;
				var startdate=document.getElementById("startdate").value;
				var enddate=document.getElementById("enddate").value;
				var down="";
				
				 down = down + "<a href='/portal/pas/DownProject?favor="+favor+"&keyword="+keyword+"&parentSelect="+parentSelect+"&childSelect="+childSelect+"&milestone="+milestone+"&startdate="+startdate+"&enddate="+enddate+"&orderItem="+encodeURIComponent(orderItem,"utf-8")+"&orderKey="+orderKey+"&rn="+Math.random()+", title='Data Download'>	<img src='<%=request.getContextPath()%>/style/images/excel6.jpg'   width=20px height=20px   style='padding-top:5px'/> </a>";
				 document.getElementById("downexcel").innerHTML=down;
				 //alert(childSelect);
				
				 $.getJSON("/portal/pas/findPasList?curPage="+currpage+"&favor="+favor+"&keyword="+keyword+"&parentSelect="+parentSelect+"&childSelect="+childSelect+"&milestone="+milestone+"&startdate="+startdate+"&enddate="+enddate+"&orderItem="+encodeURIComponent(orderItem,"utf-8")+"&orderKey="+orderKey+"&rn="+Math.random(),function(data){		
					 //alert(childSelect);
					    document.getElementById("updatetime").innerHTML=data[2].updatetime;
					    if(data[3].userid!=0){  //有登录用户
					    	if(favor==0)
					    		document.getElementById("favor").innerHTML="<img id='star' title='Favorites List'  onClick='getFavorList()();' src='<%=request.getContextPath()%>/style/images/starye.png'  width='15' height='15' style='cursor:pointer'/>";
					    	else
					    		document.getElementById("favor").innerHTML="<img id='star' title='All Data'  onClick='getFavorList()();' src='<%=request.getContextPath()%>/style/images/stargrey.png'  width='15' height='15' style='cursor:pointer'/>";
					    }
					    
					 	var curpage=data[1].curpage;
						var pagecount = data[1].totalpage;   
						var html="";
						//alert(data[4].pasid[1]);
						$.each(data[0].pasList,function(i){	
							 
								var mile=data[0].pasList[i].milestone;
								var mileflag="";
								if(mile!="-"){
									var first=mile.substring(0,1).toLowerCase();								
									var rest=mile.substring(1,mile.length);								
									mileflag=first+rest;
									mileflag=eval("data[0].pasList["+i+"]."+mileflag);
								}
								
								
				  				if(data[0].pasList[i].pLMTotal!=0){
				  					html=html+"<tr bordercolor='#DEDEDE' bgcolor='#ffffff'><td align='center' width='50px' height='29px' ><input type='checkbox' name='isSelect' value="+data[0].pasList[i].pjtName+"></input></td>";
				  				}
				  				else{
				  					html=html+"<tr bordercolor='#DEDEDE' bgcolor='#ffffff'><td align='center' width='50px' height='29px' ><input disabled='disabled' type='checkbox' name='isSelect' value="+data[0].pasList[i].PjtName+"></input></td>";
				  				}
				  				
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
			  					
				  				if(data[3].userid!=0){  //有登录用户
				  					var flag=0;
				  					for(var j=0;j<data[4].pasid.length;j++){
				  						//alert(data[4].pasid[j]);
				  						if(data[0].pasList[i].projectid==data[4].pasid[j]){
				  							flag=1;
				  						}
				  					}
				  					if(flag==1){
					  						if(data[0].pasList[i].pLMTotal!=0){  //pjt name
							  					html = html+ "<td>&nbsp;<img id='star' title='Delete from Favorites'  onClick='updateFavor("+data[0].pasList[i].projectid+");' src='<%=request.getContextPath()%>/style/images/starye.png'  width='14' height='14' style='cursor:pointer'/>&nbsp;&nbsp;" 
							  					+ "<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;"
							  					+"<a target='_blank' href='/portal/defectinfo/toDefectPage?projectname="+data[0].pasList[i].pjtName
							  					+"'><font color='#3498db' size=2>" +data[0].pasList[i].pjtName+ "</font></a></td>";
										    }
										    else{
										   		html = html+ "<td>&nbsp;<img id='star' title='Delete from Favorites' onClick='updateFavor("+data[0].pasList[i].projectid+");' src='<%=request.getContextPath()%>/style/images/starye.png' width='14' height='14' style='cursor:pointer'/>&nbsp;&nbsp;<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;<font size=2>"+data[0].pasList[i].pjtName+"</font></a></td>";
										    }
				  					}
				  					else{
				  						if(data[0].pasList[i].pLMTotal!=0){  //pjt name
						  					html = html+ "<td>&nbsp;<img id='star' title='Add to Favorites' onClick='updateFavor("+data[0].pasList[i].projectid+");' src='<%=request.getContextPath()%>/style/images/stargrey.png'  width='14' height='14' style='cursor:pointer'/>&nbsp;&nbsp;" 
						  					+ "<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;"
						  					+"<a target='_blank' href='/portal/defectinfo/toDefectPage?projectname="+data[0].pasList[i].pjtName
						  					+"'><font color='#3498db' size=2>" +data[0].pasList[i].pjtName+ "</font></a></td>";
									    }
									    else{
									   		html = html+ "<td>&nbsp;<img id='star' title='Add to Favorites' onClick='updateFavor("+data[0].pasList[i].projectid+");' src='<%=request.getContextPath()%>/style/images/stargrey.png' width='14' height='14' style='cursor:pointer'/>&nbsp;&nbsp;<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;<font size=2>"+data[0].pasList[i].pjtName+"</font></a></td>";
									    }
				  					}			  					
				  				}
				  				else{  //无登录用户
				  					if(data[0].pasList[i].pLMTotal!=0){  //pjt name
					  					html = html+ "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
					  					+ "<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;"
					  					+"<a target='_blank' href='/portal/defectinfo/toDefectPage?projectname="+data[0].pasList[i].pjtName
					  					+"'><font color='#3498db' size=2>" +data[0].pasList[i].pjtName+ "</font></a></td>";
							   		}
							    	else{
							   			html = html+ "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onClick='openwin_searchmodel(\""+data[0].pasList[i].pjtName+"\")'  href='#'>"+"<font color='#3498db' size=2> + </font></a>&nbsp;&nbsp;&nbsp;<font size=2>"+data[0].pasList[i].pjtName+"</font></a></td>";
							    	}
				  				}
			  							 
							  // if(mile!="-"){  //milestone
							   		html=html+"<td align='center'><font size=2>"+data[0].pasList[i].milestone+"</font></td>";
							   //}
							   //else{
							   		//html=html+"<td align='center'><font size=2>-</font></td>";
							   //}
							   if(data[0].pasList[i].projType=="Derivation"){  //pjt type
							   		html=html+"<td align='center'><font size=2>Deriv.</font></td>";
							   }
							   else
							   		html=html+"<td align='center'>"+data[0].pasList[i].projType+"</td>";  							   
							   if(mile=="PIA"){								   
								   	if(data[0].pasList[i].pIA=="R"){  //日期红色
										html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pIAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pIAPlanDate.substring(8,10)+"</font></td>";
										if(data[0].pasList[i].pIAActualDate.length==0){
								   			html=html+"<td align='center' ></td>";
								   		}else{
								   			html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pIAActualDate.substring(5,7)+"/"+data[0].pasList[i].pIAActualDate.substring(8,10)+"</font></td>";
								   		}
									}
									else if(data[0].pasList[i].pIA=="Y"){  //日期蓝色
										html=html+"<td align='center' ><font color='blue'  size='2'>"+data[0].pasList[i].pIAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pIAPlanDate.substring(8,10)+"</font></td>";
								   		if(data[0].pasList[i].pIAActualDate.length==0){
								   			html=html+"<td align='center' ></td>";
								   		}
								   		else{
								   			html=html+"<td align='center' ><font color='blue'  size='2'>"+data[0].pasList[i].pIAActualDate.substring(5,7)+"/"+data[0].pasList[i].pIAActualDate.substring(8,10)+"</font></td>";
								   		}
									}
									else if(data[0].pasList[i].pIA=="N"){  //日期空
										html=html+"<td align='center'></td>"
								   		+"<td align='center'></td>";
									}
									else{	
										//alert(1);
										html=html+"<td align='center'> <font size='2'>"  //正常黑色
										+data[0].pasList[i].pIAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pIAPlanDate.substring(8,10)+"</font></td><td align='center'><font size='2'>";
							   			if(data[0].pasList[i].pIAActualDate.length==0){
							   				html=html+"</font></td>";
							   			}
							   			else{
							   				//alert(1);
							   				html=data[0].pasList[i].pIAActualDate.substring(5,7)+"/"+data[0].pasList[i].pIAActualDate.substring(8,10)+"</font></td>";
							   			}
									}
							    }//PIA END
							    else{
							    	//alert(1);
							   		html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pIAPlanDate.substring(5,7)
							   		+"/"+data[0].pasList[i].pIAPlanDate.substring(8,10)
							   		+"</font></td><td align='center'> <font size='2'>"
							   		+data[0].pasList[i].pIAActualDate.substring(5,7)
							   		+"/"+data[0].pasList[i].pIAActualDate.substring(8,10)+"</font></td>";
							    }
							   	   
							   if(mile=="PVR"){
								   	if(data[0].pasList[i].pVR=="R"){
										html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pVRPlanDate.substring(5,7)+"/"+data[0].pasList[i].pVRPlanDate.substring(8,10)+"</font></td>";
										if(data[0].pasList[i].pVRActualDate.length==0){
								   			html=html+"<td align='center' ></td>";
								   		}
										else{
								   			html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pVRActualDate.substring(5,7)+"/"+data[0].pasList[i].pVRActualDate.substring(8,10)+"</font></td>";
								   		}
									}
									else if(data[0].pasList[i].pVR=="Y"){
										html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].pasList[i].pVRPlanDate.substring(5,7)+"/"+data[0].pasList[i].pVRPlanDate.substring(8,10)+"</font></td>";
							   			if(data[0].pasList[i].pVRActualDate.length==0){
							   				html=html+"<td align='center' ></td>";
							   			}
							   			else{
							   				html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].pasList[i].pVRActualDate.substring(5,7)+"/"+data[0].pasList[i].pVRActualDate.substring(8,10)+"</font></td>";
							   			}
									}
									else if(data[0].pasList[i].pVR=="N"){
										html=html+"<td align='center'></td>"+"<td align='center'></td>";
									}
									else{
										html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pVRPlanDate.substring(5,7)+"/"+data[0].pasList[i].pVRPlanDate.substring(8,10)+"</font></td><td align='center'> <font size='2'>";
							   			if(data[0].pasList[i].pVRActualDate.length==0){
							   				html=html+"</font></td>";
							   			}
							   			else{
							   				html=html+data[0].pasList[i].pVRActualDate.substring(5,7)+"/"+data[0].pasList[i].pVRActualDate.substring(8,10)+"</font></td>";
							   			}
									}
							   }//PVR end
							   else{				   
								   if(data[0].pasList[i].pVRPlanDate.length==0){
								   		html=html+"<td align='center'> <font size='2'>-</font></td>";
								   		html=html+"<td align='center'> <font size='2'>-</font></td>";
								   	}
								   else{
								   		html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pVRPlanDate.substring(5,7)+"/"+data[0].pasList[i].pVRPlanDate.substring(8,10)+"</font></td>";
								   		if(data[0].pasList[i].pVRActualDate.length==0){
								   			html=html+"<td align='center'></td>";
								   		}
								   		else{
								   			html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pVRActualDate.substring(5,7)+"/"+data[0].pasList[i].pVRActualDate.substring(8,10)+"</font></td>";
								   		}
							   		}
							   }
							   
							   if(mile=="PRA"){
								   	if(data[0].pasList[i].pRA=="R"){
										html=html+"<td align='center' ><font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pRAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pRAPlanDate.substring(8,10)+"</font></td>";
										if(data[0].pasList[i].pRAActualDate.length==0){
								   			html=html+"<td align='center' ></td>";
								   		}
										else{
								   			html=html+"<td align='center'> <font color='red' size='2' style='font-weight:bold;'>"+data[0].pasList[i].pRAActualDate.substring(5,7)+"/"+data[0].pasList[i].pRAActualDate.substring(8,10)+"</font></td>";
								   		}
									}
									else if(data[0].pasList[i].pRA=="Y"){
										html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].pasList[i].pRAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pRAPlanDate.substring(8,10)+"</font></td>";
								   		if(data[0].pasList[i].pRAActualDate.length==0){
								   			html=html+"<td align='center' ></td>";
								   		}
								   		else{
								   			html=html+"<td align='center' ><font color='blue' size='2'>"+data[0].pasList[i].pRAActualDate.substring(5,7)+"/"+data[0].pasList[i].pRAActualDate.substring(8,10)+"</font></td>";
								   		}
									}
									else if(data[0].pasList[i].pRA=="N"){
										html=html+"<td align='center'></td>"
								   		+"<td align='center'></td>";
									}
									else{
										
										html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pRAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pRAPlanDate.substring(8,10)+"</font></td><td align='center'> <font size='2'>";
							   				if(data[0].pasList[i].pRAActualDate.length==0){
							   					html=html+"</font></td>";
							   				}
							   				else{
							   					html=html+data[0].pasList[i].pRAActualDate.substring(5,7)+"/"+data[0].pasList[i].pRAActualDate.substring(8,10)+"</font></td>";
							   				}
									}
							   }//PRA end
							   
							   else{
								   	if(data[0].pasList[i].pRAPlanDate.length==0){
								   		html=html+"<td align='center'> <font size='2'>-</font></td>";
								   		html=html+"<td align='center'> <font size='2'>-</font></td>";
								   	}
								   	else{
								   		//alert(mile);
								   		html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pRAPlanDate.substring(5,7)+"/"+data[0].pasList[i].pRAPlanDate.substring(8,10)+"</font></td>";
								   		if(data[0].pasList[i].pRAActualDate.length==0){
								   			html=html+"<td align='center'></td>";
								   		}
								   		else{
								   			html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pRAActualDate.substring(5,7)+"/"+data[0].pasList[i].pRAActualDate.substring(8,10)+"</font></td>";
								   		}
								   	}				   
							   }
							   if(data[0].pasList[i].pLMTotal!=0){
								   html=html+"<td align='center'>"
									+ "<a onClick='openwin_searchdefect(\""+data[0].pasList[i].pjtName+"\",\"\")'  href='#'>"
							    	+"<font color='#3498db' size='2'>"+data[0].pasList[i].pLMTotal
								   +"</font></a></td><td align='center'> <font size='2'>";
							   }
							   else{
								   html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pLMTotal
								   +"</font></td><td align='center'> <font size='2'>";					   
							   }
							   html=html+data[0].pasList[i].pLMClosed+"</font></td><td align='center'> <font size='2'>"
							   +data[0].pasList[i].pLMResolved+"</font></td>";
							   if(data[0].pasList[i].pLMOpened!=0){
								   html=html+"<td align='center'> "
									+ "<a onClick='openwin_searchdefect(\""+data[0].pasList[i].pjtName+"\",\"Opened\")'  href='#'>"
							    	+"<font color='#3498db' size='2'>"+data[0].pasList[i].pLMOpened
								   +"</font></a></td>";
							   }
							   else{
								   html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].pLMOpened
								   +"</font></td>";					   
							   }					  
							   
							   if(data[0].pasList[i].devPL!="null"){
							   		html=html+"<td align='center'> <font size='2'>"+data[0].pasList[i].devPL+"</font></td>";
							   }else{
							   		html=html+"<td align='center'> <font size='2'>"+"-</font></td>";
							   }
							   html=html+"<td align='center'> <font size='2'>";
							   if(data[0].pasList[i].sWEM!="null"){
							   		html=html+data[0].pasList[i].sWEM+"</font></td>";
							   }else{
							   		html=html+"-</font></td>";
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
							firstpagehtml="<a onclick='load(1,"+"ordItem,ordKey);' href='javascript:void(0);'><font color='#3498db'><<&nbsp;&nbsp;&nbsp;</font></a>";
							prevpagehtml = "<a onclick='load("+(currpage-1)+",ordItem,ordKey);' href='javascript:void(0);'><</a>";
						}
						if((currpage-0)<(pagecount-0)){
							nextpagehtml = "<a onclick='load("+(currpage-0+1)+",ordItem,ordKey);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
							lastpagehtml = " <a onclick='load("+pagecount+",ordItem,ordKey);' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
						}else{
							nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
							lastpagehtml = "<a>>></a>";
						}
			  			html2="";		
			  			html2 = html2 + "<table width='1600px'><tr  bgcolor='white' bordercolor='white'><td height='60px' width='750px' align='left'><input type='button' value='Go'   onclick='go();'  style='background:#d2e9ff; color:#2c3e50; font-weight:bold;border-radius:5px; width:55px; height:29px'></td> <td height='60px'   width='850px' align='left'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+currpage+"&nbsp;/&nbsp;"+pagecount+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
			  			html2 = html2+"</table><br>";
						document.getElementById("paging").innerHTML=html2;
						
						//document.getElementById("star").src="<%=request.getContextPath()%>/style/images/favor.jpg";
				 });
				
			}
  		</script>

		<script type="text/javascript">
		var f0=0;
		var f4=0;
		var f6=0;
		var f9=0;
		
		function sort(th,iRow, iCol){
			  var table=document.getElementById("tableId");
			  var ascChar = "▲";
	          var descChar = "▼";
	          var nullstr="";
	          var rows=table.tHead.rows;		         
	          //alert(rows[1].cells[4].innerHTML);
	          for (var i = 0; i < rows.length; i++) {
					 for(var j=0;j<rows[i].cells.length;j++){//取得第几行下面的td个数，再次循环遍历该行下面的td元素
						 var th = rows[i].cells[j];					 
						 if(i==iRow&&j==iCol){	
							 if(iCol==0){
								 document.getElementById("piaplan").innerHTML="";
								 document.getElementById("praplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 
								 document.getElementById("total").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 rows[1].cells[4].innerHTML=rows[1].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[6].innerHTML=rows[1].cells[6].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								
							 }
							 if(iCol==4){
								 document.getElementById("praplan").innerHTML="";
								 document.getElementById("piaplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("total").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 rows[1].cells[0].innerHTML=rows[1].cells[0].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[6].innerHTML=rows[1].cells[6].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								
							 }
							 if(iCol==6){
								 document.getElementById("total").innerHTML="";
								 document.getElementById("praplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("piaplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 rows[1].cells[4].innerHTML=rows[1].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[0].innerHTML=rows[1].cells[0].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 
							 }
							 if(iCol==9){
								 document.getElementById("open").innerHTML="";
								 document.getElementById("praplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("total").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 document.getElementById("piaplan").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
								 rows[1].cells[4].innerHTML=rows[1].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[6].innerHTML=rows[1].cells[6].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[0].innerHTML=rows[1].cells[0].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 
							 }
						 }
						 else{
							
						 }		
					}
	          }
	          var th = rows[iRow].cells[iCol];	 	          
	          if (th.innerHTML.indexOf(ascChar) == -1 && th.innerHTML.indexOf(descChar) == -1) {
	                 th.innerHTML += "<font size=1 color='#2c3e50'>"+descChar+"</font>";
					 //alert(th.innerHTML);
	             }
	             
	          //判断上一次排列的列和现在需要排列的是否同一个。        
	            if (table.sortCol == iCol) {		            	
	            	if(iCol==0){
	            		f0++;
	            		if(f0%2!=0){
	            			sort1("PIAPlanDate","ASC");
	            			th.innerHTML=th.innerHTML.replace(descChar, ascChar);
	            		}
	            		else{
	            			sort1("PIAPlanDate","DESC");
	            			 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	            		}
	            	}
	            	if(iCol==4){
	            		f4++;
	            		if(f4%2!=0){
	            			sort1("PRAPlanDate","ASC");
	            			th.innerHTML=th.innerHTML.replace(descChar, ascChar);
	            		}
	            		else{
	            			sort1("PRAPlanDate","DESC");
	            			 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	            		}
	            	}
	            	if(iCol==6){
	            		f6++;
	            		if(f6%2!=0){
	            			sort1("PLMTotal","ASC");
	            			th.innerHTML=th.innerHTML.replace(descChar, ascChar);
	            		}
	            		else{
	            			sort1("PLMTotal","DESC");
	            			 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	            		}
	            	}
	            	if(iCol==9){
	            		f9++;
	            		if(f9%2!=0){
	            			sort1("PLMOpened","ASC");
	            			th.innerHTML=th.innerHTML.replace(descChar, ascChar);
	            		}
	            		else{
	            			sort1("PLMOpened","DESC");
	            			 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	            		}
	            	}
	            	
	            } 
	            else {
	                 if(iCol==0){
	                	 sort1("PIAPlanDate","DESC");
	                	 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	                	 f0=0;
	                	
	                 }
	                 else if(iCol==4){
	                	 sort1("PRAPlanDate","DESC");
	                	 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	                	f4=0;
	                 }
	                 else if(iCol==6){
	                	 sort1("PLMTotal","DESC");
	                	 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	                	f6=0;
	                 }
	                 else if(iCol==9){
	                 	sort1("PLMOpened","DESC");
	                 	 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
	                 	f9=0;
	                 }
	             }
	          
	            table.sortCol = iCol;
	          
	         
		  }
			function sort1(orderItem,orderKey){
				//alert(orderKey);
				load(1,orderItem,orderKey);
				ordItem=orderItem;
				ordKey=orderKey;
			}
			function go(){
				//alert(currpage);
				var obj=document.getElementsByName('isSelect'); 
				//alert(obj.length);
				var s1="您选择的课题是"; 
				var s='';
				for(var i=0; i<obj.length; i++){ 
					if(obj[i].checked) s=s+obj[i].value+","; //如果选中，将value添加到变量s中 
				} 
				//那么现在来检测s的值就知道选中的复选框的值了 
				//alert(s==''?s1+'你还没有选择任何内容！':s1+s+'点击确定将跳转到问题点页面！'); 
				if(s=='')
					alert("Please choose projects you need!");
				else{					
						window.open("/portal/defectinfo/toDefectPage?projectname="+s);			
					}	
			} 
			
		</script>

		<script type="text/javascript">
			function getResult(parentSelectVal) {
				 $.getJSON("/portal/pas/getCity?parentSelect="+parentSelectVal+"&rn="+Math.random(),function(data){
					 document.getElementById("childSelect").options.length=0;		
					 for(var i = 0;i<data.length;i++){
						var leng = 	 document.getElementById("childSelect").options.length;
						 document.getElementById("childSelect").options[leng]=new Option(data[i].childSelect,data[i].childSelect);
					 }
					 load(1,'','');
				 });		
			}
			         
		</script>

		<script language="JavaScript">
			function openwin(){
				window.open ("mainpage_zhexian.jsp", "newwindow1", "height=830, width=1070, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=100,left=300");
			}
			function openwin_projectstatus(){	
				window.open ("mainpage_projectstatus.jsp", "newwindow", "height=900, width=1440, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=150");
			}
			function openwin_searchdefect(pn,item){	
				window.open ("/portal/defect/getDefect?projectname="+pn+"&item="+item, "newwindow", "height=700, width=1800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=60");
				
			}
			function openwin_searchmodel(pn){	
				window.open ("/portal/model/getModel?projectname="+pn, "newwindow", "height=700, width=1340, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=150");
				
			}
			function openwin_histogram(){
				window.open ("mainpage_monthlyPRA.jsp", "newwindow2", "height=1000, width=1660, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=100,left=300");
			}
		</script>

	</head> 

	<body onload="load(1,'','');" >   		
		 <%
			String endd;
	 		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			String today=format.format(new Date());
			endd=today;			
		 %>		 
		<center>
			<table  bgcolor="#ecf0f1" width="100%" height="47px" style="border-radius: 0px;">
	 			<tr>
					<td  align="left">	 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" placeholder="Search"  name="selectitem" id="selectitem"  onKeyUp="load(1,'','')" type="text" title="Input Pjt Name; Model Name; SW PL" style="color:#95a5a6;padding-left:-20px;padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
						&nbsp; 
						<select id="parentSelect" name="parentSelect" onChange="getResult(this.value);" style="font-size:14px; vertical-align:middle;  border-radius:5px; width:128px;height:33px; " >
		         		<option value="choose" >- Select -</option>
		         		<option value="ms" >Milestone</option>
		         		<option value="spt">Project Type</option>
		         		<option value="pg">Prod.Group</option>
		         		<option value="ps">Pjt. Status</option>
						<%-- <option value="pl">PL</option>--%>
		 				</select>
						<select id="childSelect"  onChange="load(1,'','')" style="font-size:14px; border-radius:5px;width:128px; vertical-align:middle;height:33px; " >
							     <option value=""><font face="Arial" style="font-size:14px;">- Select -</font></option>
						</select>	
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="grey" style="font-weight:bold;">Milestone	</font>
						<select id="milestone" style="font-size:14px;  border-radius:5px;width:128px; height:33px;vertical-align:middle; " >
								<option value="choose" style="font-size:14px;">- Select -</font></option>
								<option value="PIA" style="font-size:14px;">PIA</option>
							    <option value="PVR" style="font-size:14px;">PVR</option>
							    <option value="PRA" style="font-size:14px;">PRA</option>
						</select>
						
							
						<font color="grey" style="font-weight:bold;">From	</font>
						<input type="text" id="startdate" value="2017-01-01" onClick="return Calendar('startdate');" class="text_time" style=" vertical-align:middle; padding-left:5px;  font-size:14px;  border-radius:5px;align:center;width:128px;height:30px;font-style:Arial" />
						<font color="grey" style="font-weight:bold;">to</font>
						<!-- <input id="enddate" type="date" value="2017-01-01"/ style="border-radius:5px;"> -->
						<input type="text" id="enddate" value="<%=endd %>" onClick="return Calendar('enddate');" class="text_time" style="vertical-align:middle;padding-left:5px; font-size:14px;  border-radius:5px;width:128px;height:30px;font-style:Arial"/>
						&nbsp;&nbsp;&nbsp;
						
						<%-- <input type="button" value="      "  style="border-radius:5px;height:30px; background:url(images/dustbin.png) no-repeat" onclick="location='mainpage.jsp'"></input>
						<input type="button" value="              "  style="border-radius:5px;height:30px; background:url(images/Search.JPG) no-repeat" onclick="load(1,null)"></input>--%>
						<img src='<%=request.getContextPath()%>/style/images/search3.png'  style="vertical-align:middle; height:30px; cursor:pointer" onclick="load(1,'','')"/>	
					</td>
					<td width="15%">
						<table>
							<tr>
								<td rowspan="2"><img id="obj1" src="<%=request.getContextPath()%>/style/images/clock.png"  height=30px  width=30px /></td>
								<td><font   style="font-weight:bold; font-size:12px; font-style: Arial">&nbsp;&nbsp;&nbsp;Data Update Time:&nbsp;&nbsp;&nbsp;</font>
								
								</td>
								
							</tr>
							<tr>
								<td><font color="gray" style=" font-weight:bold;font-style:Arial;font-size:12px">&nbsp;&nbsp; <div id="updatetime" style="display:inline"></div></font></td>
							</tr>
						</table>
					</td>
					<td width="4%">
					<div id="downexcel"></div>
					</td>
				</tr>
			</table>
			<div id="maindiv" style="position:relative; top:20px">
				<table id="tableId"  bgColor="#FFFAF0" cellspacing="0px" border="2px"  cellpadding="0px"   style=" border-collapse:collapse" >
	  				<thead>
	  					<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
			  				<td align="center" width="50px" rowspan="2"></td>
			  				<td align="center" width="50px" rowspan="2"></td>  			
				  			<td align="center" width="320px" rowspan="2"><font size="2" style="font-weight:bold;"><div style="position:relative;">Pjt. Name</font>&nbsp;&nbsp;<div id='favor' style="position:absolute; z-index:2; left:200px; top:2px"></div></td>
				  			<td align="center" width="80px" rowspan="2"><font size="2" style="font-weight:bold;">Milestone</font></td>  			
				  			<td align="center" width="80px" rowspan="2"><font size="2" style="font-weight:bold;">Pjt. Type</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font size="2" style="font-weight:bold;">PIA</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font size="2" style="font-weight:bold;">PVR</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font size="2" style="font-weight:bold;">PRA</font></td>  			
				  			<td align="center" height="25px" width="320px" colspan="4"><font size="2" style="font-weight:bold;">Defects</font></td>
				  			<td align="center" width="120px" rowspan="2"><font size="2" style="font-weight:bold;">Dev PL</font></td>
				  			<td align="center" width="120px" rowspan="2"><font size="2" style="font-weight:bold;">SW PL</font></td>	  			
				  		</tr>
				  		<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;"  onClick="javascript:sort(this,1,0)">Plan&nbsp;<div id='piaplan' style='display:inline;'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;">Plan</font></td>
				  			<td align="center"  width="80px" height="25px" width="80px"><font size="2" style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px"height="25px"><font size="2" style="font-weight:bold;" onClick="javascript:sort(this,1,4)">Plan&nbsp;<div id='praplan' style='display:inline'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/></div></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;" onClick="javascript:sort(this,1,6)">Total&nbsp;<div id='total' style='display:inline'><img id='total' src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/></div></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;">Closed</font></td>
				  			<td align="center"  width="80px" height="25px"><font size="2" style="font-weight:bold;">Resolved</font></td>
				  			<td align="center" height="25px" width="80px"><font size="2" style="font-weight:bold;" onClick="javascript:sort(this,1,9)">Opened&nbsp;<div id='open' style='display:inline'><img id='open' src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/></div></td>
				  		</tr>
				  	</thead>
				  	<tbody></tbody>
				  </table>
			 </div>
			 <div id="paging" style="position:absolute;bottom: 10px;margin-left:40px;"></div>
	 	</center>
<%--	 	<% --%>
<%--	 	Date now= new Date();--%>
<%--	 	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");--%>
<%--	 	%>--%>
<%--		<%System.out.println("访问者IP~~~~~~~~~~~~~~："+request.getRemoteHost() +" "+ dateFormat.format(now)); %>--%>
  </body>
</html>
