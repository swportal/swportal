<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>


<!DOCTYPE html>
<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
  	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
  	<script type="text/javascript" src="<%=request.getContextPath()%>/js/ichart/ichart.1.2.min.js"></script>
    <title>Visitor Management</title>
    <style type="text/css">
    		#footer{
	    		 position:absolute;
	    		 bottom: 0px;
	    		 margin-left :750px;
	    	}
	    	 a{
				TEXT-DECORATION:none
			}
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
				position:relative;
				left:5%;
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
		<script type="text/javascript">
			var f=0;
			var pn=1;
			var orderitm;
			var orderk;
			function sort(iRow, iCol){
				  var table=document.getElementById("tableVisitor");
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
		          if(++f%2!=0){
			      	  //gotoASC(${usersession.hasPrivilegeByName("Business Trip Info.")});
			      	  //load();
			      	    load(1,"visitTime","ASC");
			      	    th.innerHTML=th.innerHTML.replace(descChar, ascChar);
		          }
		          else{
			      	  //gotoDESC(${usersession.hasPrivilegeByName("Business Trip Info.")});
			      	  load(1,"visitTime","DESC");
			      	  th.innerHTML=th.innerHTML.replace(ascChar, descChar);
		        	}
			 	  }
				   function load(cur,orderItem,orderKey){
					   pn=cur;
					   orderitm=orderItem;
					   orderk=orderKey;
					   var keyword =document.getElementById("selectitem").value;		   
					   $.getJSON("/portal/visitor/findVisitorList?keyword="+encodeURI(keyword,"utf-8")+"&orderItem="+orderItem+"&orderKey="+orderKey+"&curpage="+cur+"&rn="+Math.random(),function(data){		
						   document.getElementById("totalall").innerText=data[1].totalvisit;
						   curpage=data[1].curpage;
		    			  totalpage=data[1].totalpage; 
						  var str="";
						  $.each(data[0].visitorList,function(i){								 
							    //alert(data[0].visitorList[i].materials);
								//for(var i = 0;i<data.length;i++){							  
								   str+="";
								   str+="<tr bordercolor='#DEDEDE' bgcolor='#ffffff'>";
								   str+="<input type='hidden' name='id' value=id>";
							  	   str+="<td align='center' width='50px' height='28px' bordercolor='#DEDEDE'  style='font-size:12px; color:#004779; '>"+(i+1+(pn-1)*12)+"</td>"; 
							  	   str+="<td align='center' width='200px' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].visitorList[i].ip+"</td>";	  
							  	   str+="<td align='center' width='150px' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].visitorList[i].name+"</td>";	 
							  	   str+="<td align='center' width='250px' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].visitorList[i].part+"</td>";	 
							  	   str+="<td align='center' width='100px' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].visitorList[i].grade+"</td>";	 
							  	   str+="<td align='center' width='300px' bordercolor='#DEDEDE' style='font-size:12px;'>"+data[0].visitorList[i].visitTime+"</td>";	 
						  		   str+="</tr>";						  	  
							   });
							   $("#tableVisitor tbody").html("");
							   $("#tableVisitor tbody").html(str);
							   var firstpagehtml; 
							   var prevpagehtml; 
							   var nextpagehtml;
							   var lastpagehtml;
								if((curpage-0)<=1){
									firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
									prevpagehtml = "<a><</a>";
								}else{
									firstpagehtml="<a onclick='load(1"+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
									prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><</a>";
								}
								if(curpage < totalpage){
									nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);' href='javascript:void(0);'><font color='#3498db'>></font></a>&nbsp;&nbsp;&nbsp;";
									lastpagehtml="<a onclick='load("+(totalpage)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
								}else{
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
	  		<script language="javascript" type="text/javascript">		
				var year;
				var month;
				var date;
				var nowdate;			
			
				function time(addday)
				{							
					var now= new Date();				
					nowdate=now.getDate();
					//alert(nowdate);
					now.setDate(nowdate+addday);//获取addday天后的日期 
					year=now.getFullYear();
					month=now.getMonth();
					date=now.getDate();
					
					//写入相应id
					//document.getElementById("info1").innerHTML=""+year+"/"+(month+1)+"/"+date;
					return now;
				}	
			</script>
			<script>
				$(function(){
					$.getJSON("/portal/visitor/getVisitorCount?rn="+Math.random(),function(jsondata){
					document.getElementById("todaytotal").innerText=jsondata[0].total[29];
					var data = [
								{
									name : 'SW Group',
									value:jsondata[0].swCount,
									color:'#cbab4f',
									line_width:2
								},
					         	{
					         		name : 'System S/W R&D 1Part',
					         		value:jsondata[0].sw1Count,
					         		color:'#a5c2d5',
					         		line_width:2
					         	},
					         	
					         	{
					         		name : 'System S/W R&D 2Part',
					         		value:jsondata[0].sw2Count,
					         		color:'#76a871',
					         		line_width:2
					         	},
					         	{
					         		name : 'Mon(S)开发Part',
					         		value:jsondata[0].monCount,
					         		color:'#9f7961',
					         		line_width:2
					         	},
					         	{
					         		name : 'SE',
					         		value:jsondata[0].seCount,
					         		color:'#a56f8f',
					         		line_width:2
					         	},{
					         		name : 'SQA&Others',
					         		value:jsondata[0].sqaCount,
					         		color:'#6f83a5',
					         		line_width:2
					         	},{
					         		name : 'Total',
					         		value:jsondata[0].total,
					         		color:'#CC0000',
					         		line_width:2
					         	}
					         ];
			         
					var labels = ["",""+(time(-28).getMonth()+1)+"/"+time(-28).getDate()+"","",""+(time(-26).getMonth()+1)+"/"+time(-26).getDate()+"","",""+(time(-24).getMonth()+1)+"/"+time(-24).getDate()+"","",""+(time(-22).getMonth()+1)+"/"+time(-22).getDate()+"","",""+(time(-20).getMonth()+1)+"/"+time(-20).getDate()+"","",""+(time(-18).getMonth()+1)+"/"+time(-18).getDate()+"","",""+(time(-16).getMonth()+1)+"/"+time(-16).getDate()+"","",""+(time(-14).getMonth()+1)+"/"+time(-14).getDate()+"","",""+(time(-12).getMonth()+1)+"/"+time(-12).getDate()+"","",""+(time(-10).getMonth()+1)+"/"+time(-10).getDate()+"","",""+(time(-8).getMonth()+1)+"/"+time(-8).getDate()+"","",""+(time(-6).getMonth()+1)+"/"+time(-6).getDate()+"","",""+(time(-4).getMonth()+1)+"/"+time(-4).getDate()+"","",""+(time(-2).getMonth()+1)+"/"+time(-2).getDate()+"","",""+(time(0).getMonth()+1)+"/"+time(0).getDate()+""];
					var line = new iChart.LineBasic2D({
						render : 'visitDiv',
						data: data,
						align:'center',
						//title : 'SW Portal Recent 30D Flow Analysis',
						title : {
							text:'Daily Visit Count',
							fontsize:14,
							font: 'Arial',
							color:'#000000'
						},
		
						width : 1500,
						height : 320,
						background_color : '#FFFFFF',
						tip:{
							enable :true,
							shadow:true,
							listeners:{  
								//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return name+" : "+value;
								}
							} 
						},
						legend : {
							enable : true,
							row:1,//设置在一行上显示，与column配合使用
							column : 'max',
							valign:'top',
							sign:'round',
							fontsize:10,
							font: 'Arial',
							background_color:null,//设置透明背景
							offsetx:-220,//设置x轴偏移，满足位置需要
							offsety:-5,//设置x轴偏移，满足位置需要
							border : true
						},
						crosshair:{
							enable:true,
							line_color:'#62bce9'
						},
						sub_option : {
							border:{
								enable:false
							},
							
							label:false,
							point_hollow : false
						},
						border:{
							color:'#ffffff'
						},  //去掉外边框
						coordinate:{
							width:1050,
							height:200,
							axis:{
								color:'#9f9f9f',
								width:[0,0,1,1]  //边框粗细
							},
							grids:{
								
							},
							scale:[{
								position:'left',  //竖轴样式	
								scale_enable : true,
								start_scale:0,
								scale_space:5,
								end_scale:10,
								label : {color:'#000000',fontsize:11,font: 'Arial',} //竖轴文字样式
							},{
								 position:'bottom',	
								 label : {color:'#000000',fontsize:11,font: 'Arial',},//横轴文字样式
								 labels:labels,
							}]
						}
					});
				
					//开始画图
					line.draw();
				});
			});
		</script>
		<script language="JavaScript">
			$(function(){
				document.getElementById("selectitem").focus();
			});
		</script>
	</head>  
	<body onload="load(1,'visitTime','DESC')">  
		<div id="navtop">
			<ul class="navtop-skin">			
				<li>					
					<strong>| Visitor  Management |</strong>&nbsp;&nbsp;&nbsp;
					<input type="text" placeholder="Search" name="selectitem" id="selectitem" title="Input IP;Part,Grade"  oninput="javascript:load(1,'visitTime','DESC')"  style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:160px; height:30px; vertical-align:middle;">
				</li>
			</ul>
		</div>
		<br>
		<center>
		    <table id = "tableVisitor"  bgColor="#FFFAF0" cellspacing="0px" border="2px"  cellpadding="0px"   style="border-collapse:collapse; ">
		         <thead>  
		            <tr bgcolor="#d2e9ff" bordercolor="#DEDEDE" height="40px" >
		            	<td align="center" width="50px"  ><strong>ID</strong></td>
		            	<td align="center" width="200px"  ><strong>IP</strong></td>
		                <td align="center" width="150px"  ><strong>Name</strong></td>
		                <td align="center" width="250px"  ><strong>Part</strong></td>
		                <td align="center" width="100px"  ><strong>Grade</strong></td>
		                <td align="center" width='300px'  onClick="javascript:sort(0,5)"><strong>Visit Time&nbsp;<font size='1' color='#2c3e50'>▼</font></strong></td>
		            </tr>
		        </thead>
		        <tbody></tbody>
		    </table>
		    
		    <div id="visitDiv" ></div>
		</center>
		<div  style="margin-left:333px"><font size=2 >Today:</font>&nbsp;<font id ="todaytotal" size=2 color="red"></font> <font size=2 >&nbsp;&nbsp;|&nbsp;&nbsp;Total:</font>&nbsp;<font id="totalall" size=2 ></font></div>
		<div id="footer"></div>
    	<br/> 
  </body>
</html>
