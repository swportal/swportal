<%@ page import="net.nw.vo.*,net.nw.dao.SearchProjectDAO"%>
<%@ page import="net.nw.dao.DefactAllDAO"%>
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
		<title>S/W Project Analysis System</title>
		
		
		<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />
		<link rel="stylesheet" type="text/css" href="style_button.css" />
		<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.js" ></script>
		<script type="text/javascript" src="js/showdate.js"></script>
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
		var keywd="";
		var ordKey="";
			var js = {
				XMLHttp:null,
				//发送请求函数
				sendRequest:function(url,responseFun,callback){
					//创建XMLHTTPRequest对象
					(function(){
						
						//根据浏览器类型创建XMLHTTPRequest对象
						if(window.XMLHttpRequest){
							js.XMLHttp = new XMLHttpRequest();
						}
						else{
							try{
								js.XMLHttp = new ActionXObject("Msxml2.XMLHTTP");
							}catch (e){
								try{
									js.XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
								} catch (e0){alert("Microsoft"+e0);}
							}
						}
						
						})();
					
					js.XMLHttp.open("POST", url, true);
					js.XMLHttp.onreadystatechange = function(responseFunction){
						if(js.XMLHttp.readyState == 4){
							if(js.XMLHttp.status == 200){
								responseFun(js.XMLHttp);
							}else{
								document.getElementById("maindiv").innerHTML = "<font color='red'>连接服务器异常...</font>"	;
							}
						}
						else{
							//document.getElementById("maindiv").innerHTML = "<font color='red'>数据加载中...</font>"	;	
						}
					};//指定响应函数
					js.XMLHttp.send(null);
					return js.XMLHttp;
				}
			};	
		
			//响应函数
			function responseFunction(xmlhttp){
				var xmlDOM = xmlhttp.responseXML; //接受服务器返回的xml文档
				parse(xmlDOM);//解析XML文档
			}
		
			//解析XML文档
			function parse(xmlDOM){
				var person = xmlDOM.getElementsByTagName("project");
				var page = xmlDOM.getElementsByTagName("page")[0];
				var currpage = page.getElementsByTagName("currpage")[0].firstChild.data;
				//alert(currpage);
				var pagecount = page.getElementsByTagName("pagecount")[0].firstChild.data; 
				var firstpagehtml; 
				var prevpagehtml; 
				var nextpagehtml;
				var lastpagehtml;
				if((currpage-0)<=1){
					firstpagehtml= "<a><<</a>&nbsp;&nbsp;&nbsp;";
					prevpagehtml = "<a><</a>";
				}else{
					firstpagehtml="<a onclick='AjaxTest(1,null,keywd,ordKey);' href='javascript:void(0);'><font color='#3498db'><<&nbsp;&nbsp;&nbsp;</font></a>";
					prevpagehtml = "<a onclick='AjaxTest("+(currpage-1)+",null,keywd,ordKey);' href='javascript:void(0);'><</a>";
				}
				if((currpage-0)<(pagecount-0)){
					nextpagehtml = "<a onclick='AjaxTest("+(currpage-0+1)+",null,keywd,ordKey);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
					lastpagehtml = " <a onclick='AjaxTest("+pagecount+",null,keywd,ordKey);' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
				}else{
					nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
					lastpagehtml = "<a>>></a>";
				}
				var html = "";
				
  			
	  			for(i=0;i<person.length;i++){	  	
		  				if(person[i].getElementsByTagName("PLMTotal")[0].firstChild.data!=0){
		  					html=html+"<tr bordercolor='#DEDEDE' bgcolor='#ffffff'><td align='center' width='50px' height='29px' ><input type='checkbox' name='isSelect' value="+person[i].getElementsByTagName('PjtName')[0].firstChild.data+"></input></td>";
		  				}
		  				else{
		  					html=html+"<tr bordercolor='#DEDEDE' bgcolor='#ffffff'><td align='center' width='50px' height='29px' ><input disabled='disabled' type='checkbox' name='isSelect' value="+person[i].getElementsByTagName('PjtName')[0].firstChild.data+"></input></td>";
		  				}
		  				if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()!="SRA"){
			  				if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()!="-"){   //2016-12-20 wuliying change from "null" to "-" to apply PLM change point
				  				if(person[i].getElementsByTagName(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString())[0].firstChild.data.toString()=="R"){
				  					html=html+"<td align='center' width='50px' height='29px' ><img id='obj3' src='images/chilun_red.png'  width='18' height='18'/></td>";
				  				}
				  				else{
				  					html=html+"<td align='center' width='50px' height='29px' ><img src='images/chilun.png'  width='18' height='18'/></td>";
				  				}
		  					}
			  				else{
			  					html=html+"<td align='center' width='50px' height='29px' ><img src='images/chilun_grey.png'  width='18' height='18'/></td>";
			  				}
	  					} // SRA END
		  				else{
	  						html=html+"<td align='center' width='50px' height='29px' ><img src='images/chilun_grey.png'  width='18' height='18'/></td>";
	  					}
	  					
	  					if(person[i].getElementsByTagName("PLMTotal")[0].firstChild.data!=0){
			  					html = html+ "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
			  					+ "<a onClick='openwin_searchmodel(\""+person[i].getElementsByTagName("PjtName")[0].firstChild.data+"\")'  href='#'>"+"<font color='#3498db'> + </font></a>&nbsp;&nbsp;&nbsp;"
			  					+"<a target='_blank' href='searchcode.action?projectname="+person[i].getElementsByTagName("PjtName")[0].firstChild.data
			  					+"&SWEM="+person[i].getElementsByTagName("SWEM")[0].firstChild.data
			  					+"&PVRPlan="+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data
			  					+"&PVRActual="+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data
			  					+"&PRAPlan="+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data
			  					+"&PRAActual="+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data+"'>"
			  					+"<font color='#3498db'>" +person[i].getElementsByTagName("PjtName")[0].firstChild.data+ "</font></a></td>";
					   }
					   else{
					   		html = html+ "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onClick='openwin_searchmodel(\""+person[i].getElementsByTagName("PjtName")[0].firstChild.data+"\")'  href='#'>"+"<font color='#3498db'> + </font></a>&nbsp;&nbsp;&nbsp;<font>"+person[i].getElementsByTagName("PjtName")[0].firstChild.data+"</font></a></td>";
					   }
	  							 
					   if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()!="null"){
					   		html=html+"<td align='center'>"+person[i].getElementsByTagName("Milestone")[0].firstChild.data+"</td>";
					   }
					   else{
					   		html=html+"<td align='center'>-</td>";
					   }
					   if(person[i].getElementsByTagName("ProjType")[0].firstChild.data.toString()=="Derivation"){
					   		html=html+"<td align='center'>Deriv.</td>";
					   }
					   else
					   		html=html+"<td align='center'>"+person[i].getElementsByTagName("ProjType")[0].firstChild.data+"</td>";  							   
					   if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()=="PIA"){
						   	if(person[i].getElementsByTagName("PIA")[0].firstChild.data.toString()=="R"){
								html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
								if(person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center' ></td>";
						   		}else{
						   			html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		}
							}
							else if(person[i].getElementsByTagName("PIA")[0].firstChild.data.toString()=="Y"){
								html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		if(person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center' ></td>";
						   		}
						   		else{
						   			html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		}
							}
							else if(person[i].getElementsByTagName("PIA")[0].firstChild.data.toString()=="N"){
								html=html+"<td align='center'></td>"
						   		+"<td align='center'></td>";
							}
							else{
								html=html+"<td align='center'>"
								+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>";
					   			if(person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString()=="null"){
					   				html=html+"</td>";
					   			}
					   			else{
					   				html=person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
					   			}
							}
					    }//PIA END
					    else{
					   		html=html+"<td align='center'>"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)
					   		+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)
					   		+"</td><td align='center'>"
					   		+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)
					   		+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
					    }
					   	   
					   if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()=="PVR"){
						   	if(person[i].getElementsByTagName("PVR")[0].firstChild.data.toString()=="R"){
								html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
								if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center' ></td>";
						   		}
								else{
						   			html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		}
							}
							else if(person[i].getElementsByTagName("PVR")[0].firstChild.data.toString()=="Y"){
								html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
					   			if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
					   				html=html+"<td align='center' ></td>";
					   			}
					   			else{
					   				html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
					   			}
							}
							else if(person[i].getElementsByTagName("PVR")[0].firstChild.data.toString()=="N"){
								html=html+"<td align='center'></td>"+"<td align='center'></td>";
							}
							else{
								html=html+"<td align='center'>"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>";
					   			if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
					   				html=html+"</td>";
					   			}
					   			else{
					   				html=html+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
					   			}
							}
					   }//PVR end
					   else{				   
						   if(person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString()=="null"){
						   		html=html+"<td align='center'>-</td>";
						   		html=html+"<td align='center'>-</td>";
						   	}
						   else{
						   		html=html+"<td align='center'>"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
						   		if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center'></td>";
						   		}
						   		else{
						   			html=html+"<td align='center'>"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
						   		}
					   		}
					   }
					   
					   if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()=="PRA"){
						   	if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="R"){
								html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
								if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center' ></td>";
						   		}
								else{
						   			html=html+"<td align='center'> <font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		}
							}
							else if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="Y"){
								html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center' ></td>";
						   		}
						   		else{
						   			html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
						   		}
							}
							else if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="N"){
								html=html+"<td align='center'></td>"
						   		+"<td align='center'></td>";
							}
							else{
								html=html+"<td align='center'>"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>";
					   				if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
					   					html=html+"</td>";
					   				}
					   				else{
					   					html=html+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
					   				}
							}
					   }//PRA end
					   
					   else{
						   	if(person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString()=="null"){
						   		html=html+"<td align='center'>-</td>";
						   		html=html+"<td align='center'>-</td>";
						   	}
						   	else{
						   		html=html+"<td align='center'>"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
						   		if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
						   			html=html+"<td align='center'></td>";
						   		}
						   		else{
						   			html=html+"<td align='center'>"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
						   		}
						   	}				   
					   }
					   if(person[i].getElementsByTagName("PLMTotal")[0].firstChild.data!=0){
						   html=html+"<td align='center'>"
							+ "<a onClick='openwin_searchdefect(\""+person[i].getElementsByTagName("PjtName")[0].firstChild.data+"\",\"\")'  href='#'>"
					    	+"<font color='#3498db'>"+person[i].getElementsByTagName("PLMTotal")[0].firstChild.data
						   +"</font></a></td><td align='center'>";
					   }
					   else{
						   html=html+"<td align='center'>"+person[i].getElementsByTagName("PLMTotal")[0].firstChild.data
						   +"</font></td><td align='center'>";					   
					   }
					   html=html+person[i].getElementsByTagName("PLMClosed")[0].firstChild.data+"</td><td align='center'>"
					   +person[i].getElementsByTagName("PLMResolved")[0].firstChild.data+"</td>";
					   if(person[i].getElementsByTagName("PLMOpened")[0].firstChild.data!=0){
						   html=html+"<td align='center'>"
							+ "<a onClick='openwin_searchdefect(\""+person[i].getElementsByTagName("PjtName")[0].firstChild.data+"\",\"Opened\")'  href='#'>"
					    	+"<font color='#3498db'>"+person[i].getElementsByTagName("PLMOpened")[0].firstChild.data
						   +"</font></a></td>";
					   }
					   else{
						   html=html+"<td align='center'>"+person[i].getElementsByTagName("PLMOpened")[0].firstChild.data
						   +"</font></td>";					   
					   }					  
					   
					   if(person[i].getElementsByTagName("DevPL")[0].firstChild.data.toString()!="null"){
					   		html=html+"<td align='center'>"+person[i].getElementsByTagName("DevPL")[0].firstChild.data+"</td>";
					   }else{
					   		html=html+"<td align='center'>"+"-</td>";
					   }
					   html=html+"<td align='center'>";
					   if(person[i].getElementsByTagName("SWEM")[0].firstChild.data.toString()!="null"){
					   		html=html+person[i].getElementsByTagName("SWEM")[0].firstChild.data+"</td>";
					   }else{
					   		html=html+"-</td>";
					   }
					  html=html+"</tr>";
	  			}  //for end
	  			html2="";		
	  			html2 = html2 + "<table width='1600px'><tr  bgcolor='white' bordercolor='white'><td height='60px' width='750px' align='left'><input type='button' value='Go'   onclick='go();'  style='background:#d2e9ff; color:#2c3e50; font-weight:bold;border-radius:5px; width:55px; height:29px'></td> <td height='60px'   width='850px' align='left'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+currpage+"&nbsp;/&nbsp;"+pagecount+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
	  			html2 = html2+"</table><br>";
	  			
	  			$("#tableId tbody").html("");
				$("#tableId tbody").html(html);
				document.getElementById("paging").innerHTML=html2;
			} //function end
		
			//主调函数,以当前页作为参数
			function AjaxTest(currpage) {
				js.sendRequest("AjaxServlet?currpage="+currpage,responseFunction,null);
			}
		
			function AjaxTest(currpage,projectname,keyword,orderKey) {				
				var projectname1=document.getElementById("selectitem").value;			
				var city1=document.getElementById("city").value;
				var state1=document.getElementById("state").value;
				var milestone1=document.getElementById("milestone").value;
				var startdate1=document.getElementById("startdate").value;
				var enddate1=document.getElementById("enddate").value;
				 var down="";
				 down = down + "<a href='DownPjtServlet?projectname="+projectname1+"&city="+city1+"&milestone="+milestone1+"&startdate="+startdate1+"&enddate="+enddate1+"&state="+state1+"&keyword="+keyword+"&orderKey="+orderKey+"'  title='Data Download'>	<img src='${pageContext.request.contextPath}/images/excel6.jpg'   width=20px height=20px   style='padding-top:5px'/> </a>";
				 document.getElementById("downexcel").innerHTML=down;
				 js.sendRequest("AjaxServlet?currpage="+currpage+"&projectname="+projectname1+"&city="+city1+"&milestone="+milestone1+"&startdate="+startdate1+"&enddate="+enddate1+"&state="+state1+"&keyword="+keyword+"&orderKey="+orderKey,responseFunction,null);
				
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
								 document.getElementById("praplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 
								 document.getElementById("total").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 rows[1].cells[4].innerHTML=rows[1].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[6].innerHTML=rows[1].cells[6].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								
							 }
							 if(iCol==4){
								 document.getElementById("praplan").innerHTML="";
								 document.getElementById("piaplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("total").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 rows[1].cells[0].innerHTML=rows[1].cells[0].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[6].innerHTML=rows[1].cells[6].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								
							 }
							 if(iCol==6){
								 document.getElementById("total").innerHTML="";
								 document.getElementById("praplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("piaplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("open").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 rows[1].cells[4].innerHTML=rows[1].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[0].innerHTML=rows[1].cells[0].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 rows[1].cells[9].innerHTML=rows[1].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
								 
							 }
							 if(iCol==9){
								 document.getElementById("open").innerHTML="";
								 document.getElementById("praplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("total").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
								 document.getElementById("piaplan").innerHTML="<img src='images/arrow.png' width=8 height=10/>";
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
			function sort1(keyword,orderKey){
				//alert(orderKey);
				AjaxTest(1,null,keyword,orderKey);
				keywd=keyword;
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
						window.open("multiproject.action?projectname="+s);			
					}	
			} 
		</script>

		<script type="text/javascript">
			function getResult(stateVal) {
			         var url = "selectServlet?state="+stateVal; 
			         if (window.XMLHttpRequest) { 
			                 req = new XMLHttpRequest(); 
			         }else if (window.ActiveXObject) { 
			                 req = new ActiveXObject("Microsoft.XMLHTTP"); 
			         } 
			         if(req){ 
			                 req.open("GET",url, true); 
			                 req.onreadystatechange = complete; 
			                 req.send(null); 
			         } 
			 } 
			 function complete(){
			         if (req.readyState == 4) { 
			                 if (req.status == 200) { 
			                         var city = req.responseXML.getElementsByTagName("city"); 
			                         var str=new Array();
			                         for(var i=0;i<city.length;i++){
			                                 str[i]=city[i].firstChild.data;
			                         }
			                         buildSelect(str,document.getElementById("city"));
			                         AjaxTest(1,null,null,null);
			                 }
			         }
			 }
			 function buildSelect(str,sel) {
			         sel.options.length=0;
			         for(var i=0;i<str.length;i++) {
			                 sel.options[sel.options.length]=new Option(str[i],str[i]);
			         }
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
				window.open ("searchdefect.action?projectname="+pn+"&item="+item, "newwindow", "height=700, width=1800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=60");
				
			}
			function openwin_searchmodel(pn){	
				window.open ("searchmodel.action?projectname="+pn, "newwindow", "height=700, width=1340, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=150");
				
			}
			function openwin_histogram(){
				window.open ("mainpage_monthlyPRA.jsp", "newwindow2", "height=1000, width=1660, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=100,left=300");
			}
		</script>

		<script>   	
			var t;
			t=(<%=request.getParameter("c")%>==null)?1:<%=request.getParameter("c")%>;	
	  	</script>
	  	
	</head> 

	<body onload="AjaxTest(t,null,null,null);" >   
		<%	
			String projectname=request.getParameter("projectname");
			String status= request.getParameter("status");
			SearchProjectDAO dao=new  SearchProjectDAO(); 
			List<ProjectOngoing> all=null;
			if(status==null){
				all = dao.findAll() ;			
			}
			else{
				all = dao.findAll_status(status);
				
			}	
			Iterator<ProjectOngoing> iter1 = all.iterator();
			Iterator<ProjectOngoing> iter = all.iterator();
			
			String UpdateTime;
		 %>
		 
		 <%
			UpdateTime="no data!!";
			while(iter1.hasNext()){
			ProjectOngoing p1 = iter1.next() ;
			UpdateTime=p1.getUpdateTime();}
		 %>
		 
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
						<input type="text" placeholder="Search"  name="selectitem" id="selectitem"  onKeyUp="AjaxTest(1,null,null,null)" type="text" title="Input Pjt Name; Model Name; SW PL" style="color:#95a5a6;padding-left:-20px;padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
						&nbsp; 
						<select id="state" name="state" onChange="getResult(this.value);" style="font-size:14px; vertical-align:middle;  border-radius:5px; width:128px;height:33px; " >
		         		<option value="choose" >- Select -</option>
		         		<option value="ms" >Milestone</option>
		         		<option value="spt">Project Type</option>
		         		<option value="pg">Prod.Group</option>
		         		<option value="ps">Pjt. Status</option>
						<%-- <option value="pl">PL</option>--%>
		 				</select>
						<select id="city"  onChange="AjaxTest(1,this.value,null,null)" style="font-size:14px; border-radius:5px;width:128px; vertical-align:middle;height:33px; " >
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
						<input type="text" id="startdate" value="2015-01-01" onClick="return Calendar('startdate');" class="text_time" style=" vertical-align:middle; padding-left:5px;  font-size:14px;  border-radius:5px;align:center;width:128px;height:30px;font-style:Arial" />
						<font color="grey" style="font-weight:bold;">to</font>
						<!-- <input id="enddate" type="date" value="2017-01-01"/ style="border-radius:5px;"> -->
						<input type="text" id="enddate" value="<%=endd %>" onClick="return Calendar('enddate');" class="text_time" style="vertical-align:middle;padding-left:5px; font-size:14px;  border-radius:5px;width:128px;height:30px;font-style:Arial"/>
						&nbsp;&nbsp;&nbsp;
						
						<%-- <input type="button" value="      "  style="border-radius:5px;height:30px; background:url(images/dustbin.png) no-repeat" onclick="location='mainpage.jsp'"></input>
						<input type="button" value="              "  style="border-radius:5px;height:30px; background:url(images/Search.JPG) no-repeat" onclick="AjaxTest(1,null)"></input>--%>
						<img src='images/search3.png'  style="vertical-align:middle; height:30px; " onclick="AjaxTest(1,null,null,null)"/>	
					</td>
					<td width="15%">
						<table>
							<tr>
								<td rowspan="2"><img id="obj1" src="images/clock.png"  height=30px  width=30px /></td>
								<td><font   style="font-weight:bold; font-size:12px; font-style: Arial">&nbsp;&nbsp;&nbsp;Data Update Time:&nbsp;&nbsp;&nbsp;</font>
								
								</td>
								
							</tr>
							<tr>
								<td><font color="gray" style=" font-weight:bold;font-style:Arial;font-size:12px">&nbsp;&nbsp;&nbsp;<%=UpdateTime %></font></td>
							</tr>
						</table>
					</td>
					<td width="4%">
					<div id="downexcel"></div>
					</td>
				</tr>
			</table>
			<!-- <a href="javascript:sort('PIAPlanDate','ASC')"><font size="1" color="#2c3e50" style="position:relative; top:44px; left:-115px"/>▲</font></a>
			<a href="javascript:sort('PIAPlanDate','DESC')"><font size="1" color="#2c3e50" style="position:relative; top:54px; left:-130px"/>▼</font></a>			
			<a href="javascript:sort('PRAPlanDate','ASC')"><font size="1" color="#2c3e50" style="position:relative; top:44px; left:180px"/>▲</font></a>
			<a href="javascript:sort('PRAPlanDate','DESC')"><font size="1" color="#2c3e50" style="position:relative; top:54px; left:165px"/>▼</font></a>
			<a href="javascript:sort('PLMTotal','ASC')"><font size="1" color="#2c3e50" style="position:relative; top:44px; left:315px"/>▲</font></a>
			<a href="javascript:sort('PLMTotal','DESC')"><font size="1" color="#2c3e50" style="position:relative; top:54px; left:300px"/>▼</font></a>
			<a href="javascript:sort('PLMOpened','ASC')"><font size="1" color="#2c3e50" style="position:relative; top:44px; left:532px"/>▲</font></a>
			<a href="javascript:sort('PLMOpened','DESC')"><font size="1" color="#2c3e50" style="position:relative; top:54px; left:517px"/>▼</font></a>
			 -->
			<div id="maindiv" style="position:relative; top:20px">
				<table id="tableId"  bgColor="#FFFAF0" cellspacing="0px" border="2px"  cellpadding="0px"   style=" border-collapse:collapse" >
	  				<thead>
	  					<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
			  				<td align="center" width="40px" rowspan="2"></td>
			  				<td align="center" width="40px" rowspan="2"></td>  			
				  			<td align="center" width="320px" rowspan="2"><font style="font-weight:bold;">Pjt. Name</font></td>
				  			<td align="center" width="80px" rowspan="2"><font style="font-weight:bold;">Milestone</font></td>  			
				  			<td align="center" width="80px" rowspan="2"><font style="font-weight:bold;">Pjt. Type</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font style="font-weight:bold;">PIA</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font style="font-weight:bold;">PVR</font></td>  			
				  			<td align="center" height="25px" width="160px" colspan="2"><font style="font-weight:bold;">PRA</font></td>  			
				  			<td align="center" height="25px" width="320px" colspan="4"><font style="font-weight:bold;">Defects</font></td>
				  			<td align="center" width="120px" rowspan="2"><font style="font-weight:bold;">Dev PL</font></td>
				  			<td align="center" width="120px" rowspan="2"><font style="font-weight:bold;">SW PL</font></td>	  			
				  		</tr>
				  		<tr bgcolor="#d2e9ff" bordercolor="#DEDEDE">
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;"  onClick="javascript:sort(this,1,0)">Plan&nbsp;<div id='piaplan' style='display:inline;'><img src='images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;">Plan</font></td>
				  			<td align="center"  width="80px" height="25px" width="80px"><font style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px"height="25px"><font style="font-weight:bold;" onClick="javascript:sort(this,1,4)">Plan&nbsp;<div id='praplan' style='display:inline'><img src='images/arrow.png' width=8 height=10/></div></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;">Actual</font></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;" onClick="javascript:sort(this,1,6)">Total&nbsp;<div id='total' style='display:inline'><img id='total' src='images/arrow.png' width=8 height=10/></div></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;">Closed</font></td>
				  			<td align="center"  width="80px" height="25px"><font style="font-weight:bold;">Resolved</font></td>
				  			<td align="center" height="25px" width="80px"><font style="font-weight:bold;" onClick="javascript:sort(this,1,9)">Opened&nbsp;<div id='open' style='display:inline'><img id='open' src='images/arrow.png' width=8 height=10/></div></td>
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
