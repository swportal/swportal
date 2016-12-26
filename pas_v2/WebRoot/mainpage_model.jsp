
<%@ page import="net.nw.vo.*,net.nw.dao.SearchProjectDAO"%>
<%@ page import="net.nw.dao.DefactAllDAO"%>
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>S/W Project Analysis System</title>
	<style type="text/css">
	    #footer {
	       		 position: fixed;
	       		 bottom: 0;
	    }
	     
	</style>
	<link rel="stylesheet" type="text/css" href="style_button.css" />
	
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
	
	<style>
		a{TEXT-DECORATION:none}
		a:hover{TEXT-DECORATION:underline}
	</style>
	<style>
		html,body{ margin:0; padding:0; height:90%}
		.main{ min-height:100%; heiguto !important; height:100%; margin:0 auto;}
		.footer{ position:absolute; bottom:0; height:40px; background:#9ABAE0;width:100%;}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
	<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />
	
	<script src="js/jquery.js" type="text/javascript"></script>
	<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>
	<script src="jquery.js" type="text/javascript"></script>
	<script type="text/javascript">
		function init_time()
		{
				var now= new Date();
				//now.setDate(now.getDate()+addday);//获取addday天后的日期 
				var year=now.getFullYear();
				var month=now.getMonth()+1;
				var date=now.getDate();
				this.document.getElementById("enddate").value=(year+"-"+month+"-"+date);
				//document.getElementById("enddate").value=year+"-"+month+"-"+day
				//alert("!!!!!!!!!!!!"+year);
		}
	</script>
	
	 
	<script type="text/javascript">
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
							document.getElementById("div").innerHTML = "<font color='red'>连接服务器异常...</font>"	;
						}
					}
					else{
						//document.getElementById("div").innerHTML = "<font color='red'>数据加载中...</font>"	;	
					}
				};//指定响应函数
				js.XMLHttp.send(null);
				return js.XMLHttp;
			}
		};
		//响应函数
		function responseFunction(xmlhttp){			
			var xmlDOM = xmlhttp.responseXML; //接受服务器返回的xml文档
			//alert(xmlDOM);
			parse(xmlDOM);//解析XML文档
		}
		//解析XML文档
		function parse(xmlDOM){
			var person = xmlDOM.getElementsByTagName("project");
			var page = xmlDOM.getElementsByTagName("page")[0];
			var currpage = page.getElementsByTagName("currpage")[0].firstChild.data;
			var pagecount = page.getElementsByTagName("pagecount")[0].firstChild.data; 
			var prevpagehtml; 
			var nextpagehtml;
			if((currpage-0)<=1){
				prevpagehtml = "<a><</a>";
			}
			else{
				prevpagehtml = "<a onclick='AjaxTest("+(currpage-1)+",null);' href='javascript:void(0);'><</a>";
			}
			if((currpage-0)<(pagecount-0)){
				nextpagehtml = "<a onclick='AjaxTest("+(currpage-0+1)+",null);' href='javascript:void(0);'>></a>";
			}
			else{
				nextpagehtml = "<a>></a>";
			}
	  		var html = "<table  border-radius='5px' bordercolor='#DEDEDE' bgColor='#ffffff' border='2px' cellspacing='0px' style='border-collapse:collapse' border='1px'>";
	  			html=html+"<tr bgcolor='#d2e9ff' bordercolor='#DEDEDE'>"
	  			+"<td align='center' width='40px' height='40px' rowspan='2'></td>"
	  			+"<td align='center' height='40px' width='180px' rowspan='2'><font color='#333333' style='font-weight:bold;'>Model Name</font></td>"
	  			+"<td align='center' height='40px' width='80px' rowspan='2'><font font color='#333333' style='font-weight:bold;'>Milestone</font></td>"
	  			+"<td align='center' height='40px' width='80px' rowspan='2'><font font color='#333333' style='font-weight:bold;'>Pjt. Type</font></td>"
	  			+"<td align='center' height='30px' width='160px' colspan='2'><font font color='#333333' style='font-weight:bold;'>PIA</font></td>"
	  			+"<td align='center' height='30px' width='160px' colspan='2'><font font color='#333333' style='font-weight:bold;'>PVR</font></td>"
	  			+"<td align='center' height='30px' width='160px' colspan='2'><font font color='#333333' style='font-weight:bold;'>PRA</font></td>"
	  			+"<td align='center' height='30px' width='320px' colspan='4'><font font color='#333333' style='font-weight:bold;'>Defects</font></td>"
	  			+"</tr>"
	  			+"<tr bgcolor='#d2e9ff' bordercolor='#DEDEDE'>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Plan</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Actual</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Plan</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Actual</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Plan</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Actual</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Total</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Closed</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Resolved</font></td>"
	  			+"<td align='center' height='30px' width='80px'><font font color='#333333' style='font-weight:bold;'>Opened</font></td>"
	  			+"</tr>";
	  			
	  		for(i=0;i<person.length;i++){
  				html=html+"<tr bordercolor='#DEDEDE'>";
  				if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()!="SRA"){
	  				if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()!="-"){   //2016-12-26 wuliying change from "null" to "-" to apply PLM change point
	  					if(person[i].getElementsByTagName(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString())[0].firstChild.data.toString()=="R"){
	  						html=html+"<td align='center' width='50px' height='30px' ><img id='obj3' src='images/chilun_red.png'  width='18' height='18'/></td>";
	  					}
	  					else{
	  						html=html+"<td align='center' width='50px' height='30px' ><img src='images/chilun.png' width='18' height='18'/></td>";
	  					}
	  				}
	  				else{
	  					html=html+"<td align='center' width='50px' height='30px' ><img src='images/chilun.png'  width='18' height='18'/></td>";
	  				}
	  			}
  				else{
	  				html=html+"<td align='center' width='50px' height='30px' ><img src='images/chilun_grey.png'  width='18' height='18'/></td>";
	  			}
	  				
	  			if(person[i].getElementsByTagName("PLMTotal")[0].firstChild.data!=0){
	  				html = html+ "<td align='center'>" +"<font>"+ person[i].getElementsByTagName("DevModelName")[0].firstChild.data+"</font></a></td>";
	  			}
	  			else{
	  			   html = html+ "<td align='center'><font>"+person[i].getElementsByTagName("DevModelName")[0].firstChild.data+"</font></a></td>";
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
	  					html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"
	  						+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					if(person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center' ></td>";
	  					}
	  					else{
	  						html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					}
	  				}
	  				else if(person[i].getElementsByTagName("PIA")[0].firstChild.data.toString()=="Y"){
	  					html=html+"<td align='center' ><font color='blue'>"
	  						+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					if(person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center' ></td>";
	  					}
	  					else{
	  						html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					}
	  				}
	  				else if(person[i].getElementsByTagName("PIA")[0].firstChild.data.toString()=="N"){
	  					html=html+"<td align='center'></td>"+"<td align='center'></td>";
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
	  		    }  //PIA End
	  		    else{
	  				html=html+"<td align='center'>"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>"
	  					+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PIAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
	  		    }
	  		    //PVR Start
	  			if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()=="PVR"){
	  				if(person[i].getElementsByTagName("PVR")[0].firstChild.data.toString()=="R"){
	  					html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"
	  						+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center' ></td>";
	  			   		}
	  					else{
	  						html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					}
	  				}
	  				else if(person[i].getElementsByTagName("PVR")[0].firstChild.data.toString()=="Y"){
	  					html=html+"<td align='center' ><font color='blue'>"
	  						+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
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
	  					html=html+"<td align='center'>"
	  						+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>";
	  					if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"</td>";
	  					}
	  					else{
	  						html=html+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
	  					}
	  				}
	  			}//PVR END
	  			else{
	  				if(person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString()=="null"){
	  					html=html+"<td align='center'>-</td>";
	  					html=html+"<td align='center'>-</td>";
	  				}else{
	  					html=html+"<td align='center'>"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
	  					if(person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center'></td>";
	  					}
	  					else{
	  						html=html+"<td align='center'>"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PVRActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
	  					}
	  				}
	  			}
	  			//PRA START		
	  			if(person[i].getElementsByTagName("Milestone")[0].firstChild.data.toString()=="PRA"){
	  				if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="R"){
	  					html=html+"<td align='center' ><font color='red' style='font-weight:bold;'>"
	  						+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center' ></td>";
	  					}
	  					else{
	  						html=html+"<td align='center'> <font color='red' style='font-weight:bold;'>"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					}
	  				}
	  				else if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="Y"){
	  					html=html+"<td align='center' ><font color='blue'>"
	  						+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"<td align='center' ></td>";
	  					}
	  					else{
	  						html=html+"<td align='center' ><font color='blue'>"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</font></td>";
	  					}
	  				}
	  				else if(person[i].getElementsByTagName("PRA")[0].firstChild.data.toString()=="N"){
	  					 html=html+"<td align='center'></td>"+"<td align='center'></td>";
	  				}
	  				else{
	  					html=html+"<td align='center'>"
	  						+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAPlanDate")[0].firstChild.data.toString().substring(8,10)+"</td><td align='center'>";
	  					if(person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString()=="null"){
	  						html=html+"</td>";
	  					}
	  					else{
	  						html=html+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(5,7)+"/"+person[i].getElementsByTagName("PRAActualDate")[0].firstChild.data.toString().substring(8,10)+"</td>";
	  					}
	  				}
	  			}
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
	  			//PRA END
	  							   
	  			html=html+"<td align='center'>"+person[i].getElementsByTagName("PLMTotal")[0].firstChild.data+"</td><td align='center'>"
	  				+person[i].getElementsByTagName("PLMClosed")[0].firstChild.data+"</td><td align='center'>"
	  				+person[i].getElementsByTagName("PLMResolved")[0].firstChild.data+"</td><td align='center'>"
	  				+person[i].getElementsByTagName("PLMOpened")[0].firstChild.data+"</td>";
			    html=html+"</tr>";
	  		}  		
	  		html = html + "<tr  bgcolor='white' bordercolor='white'> <td height='60px'colspan='16' align='center'><a onclick='AjaxTest(1,null);' href='javascript:void(0);'>&nbsp;<<&nbsp;&nbsp;&nbsp;</a>"+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+currpage+"&nbsp;/&nbsp;"+pagecount+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+" <a onclick='AjaxTest("+pagecount+",null);' href='javascript:void(0);'>&nbsp;>></a> </td></tr>";
	  		html = html+"</table><br>";
	  		document.getElementById("div").innerHTML=html;
		}
			
		function AjaxTest(currpage,projectname) {
			var projectname1="<%=request.getParameter("projectname")%>";
			 var down="";
			 down = down + "<a href='DownModelServlet?projectname="+projectname1+"'  title='Data Download'>	<img src='${pageContext.request.contextPath}/images/excel6.jpg'   width=20px height=20px   style='left:1500px;padding-top:5px;display:inline'/> </a>";
			 document.getElementById("downexcel").innerHTML=down;
			js.sendRequest("ModelServlet?currpage="+currpage+"&projectname="+projectname1,responseFunction,null);			
		}
	</script>
	</head>	
  
	<body onload="AjaxTest(1,null);" > 
		<br/><br/> 	
		<div style="height:680px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Project Name: <%=request.getAttribute("projectname") %>
			<div id="downexcel"  style="position:absolute;   left:1250px; top:30px">	 	 	
	  		</div>
			<center>
				<table>		
					<!-- <tr   height="2px"> <td width="200px"></td> <td width="3800px" > <hr color="lightgrey" /> </td><td width="200px"></td></tr> -->
				</table>
						
		 		<div id="div"> </div>
  			</center>
 
		</div>		
	<%System.out.println("访问者IP~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~："+request.getRemoteAddr()); %>
  </body>
</html>
