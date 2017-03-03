<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="myjstl" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type"    content="text/html; charset=utf-8" />
		<title>Defect Status</title>
		
<%--		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" /> --%>
<%--		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/style_button.css" />--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ichart/ichart.1.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdate.js"></script>
		
		<style type="text/css">
			.imgPlace{ position:relative; top:5px; /*left:5px; right:5px;bottom:5px*/} 
		</style>
		
		
		<script type="text/javascript">
			$(function(){
				var projectname="<%=request.getAttribute("projectname")%>";					
				var codeid= <%=request.getAttribute("codeid")%>;
				document.getElementById("codeid").value=codeid;
				//alert(codeid);
				//$.getJSON("/portal/defectinfo/getDefectinfo?projectname="+projectname+"&codeid="+codeid,function(datainfo){
					//////////////////////////////////Percentage of Resolved(SQA Test) start////////////////////////////////
					var data = [						
					         	{
					         		name : 'Resolved',
					         		value:[(<%=request.getAttribute("SQAPLMResolvedA")%>)/(<%=request.getAttribute("SQAPLMTotalA")%>-<%=request.getAttribute("SQAPLMClosedA")%>),(<%=request.getAttribute("SQAPLMResolvedBC")%>)/(<%=request.getAttribute("SQAPLMTotalBC")%>-<%=request.getAttribute("SQAPLMClosedBC")%>)],
					         		color:'#3498DB'
					         	},
								{
									name : 'Not Resolved',
									value:[(1-(<%=request.getAttribute("SQAPLMResolvedA")%>)/(<%=request.getAttribute("SQAPLMTotalA")%>-<%=request.getAttribute("SQAPLMClosedA")%>)),(1-(<%=request.getAttribute("SQAPLMResolvedBC")%>)/(<%=request.getAttribute("SQAPLMTotalBC")%>-<%=request.getAttribute("SQAPLMClosedBC")%>))],
									color:'#CC0000'
								}
					];
			        
					var chart = new iChart.BarStacked2D({
							render : 'canvasDiv',
							data: data,
							labels:["A","B+C"],
							title : {
								//text:'Total U.S Retail Software Revenue',
								width:400,
								align:'left',
								background_color : '#495998',
								color:'#c0c8e7'
							},
							subtitle : {
								//text:'Showing Jan-Sep Share,2012 Estimated',
								width:280,
								height:20,
								fontsize:12,
								align:'left',
								color:'#c0c8e7'
							},
							padding:10,
							//footnote : '数据来源：互联网',
							width : 850,
							color:'#000000',
							percent:true,
							height : 120,
							bar_height:20,
							background_color : '#ffffff',
							shadow : true,
							shadow_blur : 2,
							shadow_color : '#aaaaaa',
							shadow_offsetx : 1,
							shadow_offsety : 0, 
							offsetx:-40,
							offsety:-10,
							sub_option:{
								label:{color:'#ffffff',fontsize:10,fontweight:400},
								border : {
									width : 2,
									color : '#d3d4f0'
								} 
							},
							label:{color:'#000000',fontsize:10,fontweight:400 },
							showpercent:true,
							decimalsnum:0,
							legend:{
								enable:true,
								background_color : null,
								line_height:25,
								color:'#000000',
								fontsize:10,
								fontweight:400,
								offsetx: -10,
								offsety: 0,
								border : {
									enable : false
								}
							},
							coordinate:{
								background_color : 0,
								axis : {
									color : '#c0c8e7',
									width : 0
								}, 
								scale:[{
									 position:'bottom',	
									 scale_enable : false,
									 start_scale:0,
									 scale_space:20,
									 end_scale:100,
									 label:{color:'#000000',fontsize:10,fontweight:400},
									 listeners:{
										parseText:function(t,x,y){
											return {text:t}
										}
									 }
								}],
								width:600,
								height:100
							}
					});

					//利用自定义组件构造左侧说明文本
					chart.plugin(new iChart.Custom({
							drawFn:function(){
								//计算位置
								var coo = chart.getCoordinate(),
									x = coo.get('originx'),
									y = coo.get('originy'),
									h = coo.height;
								//在左下侧的位置，渲染一个单位的文字
								chart.target.textAlign('start')
								.textBaseline('bottom')
								.textFont('600 11px Verdana')
								//.fillText('Billions',x-20,y+h+30,false,'#a8b2d7');
								
							}
					}));
					
					chart.draw();
					//////////////////////////////////Percentage of Resolved(SQA Test) end////////////////////////////////
					
					////////////////////////////////Defect Status start////////////////////////////////
					
					var sum=<%=request.getAttribute("Resolved")%>+<%=request.getAttribute("Opened")%>+<%=request.getAttribute("Closed")%>;
					document.getElementById("total1").innerHTML="<a href='#' onClick=openwin_searchdefect(\""+projectname+"\","+codeid+","+"\"\""+")>("+sum+")</a>";
					var datastatus = [
							        	{name : 'Opened',value : <%=request.getAttribute("Opened")%>/sum, Count: <%=request.getAttribute("Opened")%>,color:'#CC0000'},
							        	{name : 'Closed',value :<%=request.getAttribute("Closed")%>/sum,Count: <%=request.getAttribute("Closed")%>,color:'#3498db'},
							        	{name : 'Resolved',value :<%=request.getAttribute("Resolved")%>/sum,Count: <%=request.getAttribute("Resolved")%>,color:'#FF9224'}
					];
				
					var chartstatus = new iChart.Pie2D({
						offset_angle:-120,
						increment:3,
						radius:80,
						render : 'canvasDivSta',
						title : {
							//text:'Defect Status('+datainfo[0].listTotal[0]+')',
							fontsize:12,
							color:'#000000',
						},
						padding:'2 5',
						footnote:{
							//text:'StatCounter Global Stats,design by ichartjs',
							color:'#e0e5e8',
							height:30,
							border:{
								enable:true,
								width:[2,0,0,0],
								color:'#343b3e'
							}
						},
						width : 350,
						height :170,
						offsety:5,
						data:datastatus,
						shadow:false,
						shadow_color:'#000000',
						shadow_blur:8,
						background_color : '#FFFFFF',
						//gradient:true,//开启渐变
						//color_factor:0.28,
						//gradient_mode:'RadialGradientOutIn',
						
	
						showpercent:true,
						decimalsnum:0,
						/*legend:{
							offsetx:50,
							offsety:-50,
							enable:true,
							padding:100,
							color:'#000000',
							border:{
								width:[0,0,0,0],
								color:'#343b3e'
							},
							background_color : null,
						},*/
						sub_option:{						
							border:{
								enable:false
							},
							label : {
								sign:false,
								fontsize:10,
								color:'#000000'
							},
							
							listeners:{
								parseText:function(d, t){
									return d.get('name')+"("+ d.get('Count')+")"+"	"+d.get('value');
								},
								
	
								/**
								 * s:iChart.Sector2D对象
								 * e:eventObject对象
								 * m:额外参数
								 */
								click:function(s,e,m){	
									if(s.get('name')=='Opened')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'Opened');
									
									if(s.get('name')=='Closed')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'Closed');
									
									if(s.get('name')=='Resolved')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'Resolved');
								}
							}
						},
						//鼠标移上去提示文字
						tip:{
							enable :true,
							listeners:{
								//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return "See Details";
								}
							} 
						},
						border:{
							//width:[0,20,0,20],
							color:'#ffffff'
						}
					});		
				
					//chart.bound(0);
					chartstatus.draw();
					////////////////////////////////Defect Status end////////////////////////////////
					
					
					//////////////////////////////////Defect Priority start////////////////////////////////
					var sum=<%=request.getAttribute("TotalA")%>+<%=request.getAttribute("TotalB")%>+<%=request.getAttribute("TotalC")%>;
					document.getElementById("total2").innerHTML="<a href='#' onClick=openwin_searchdefect(\""+projectname+"\","+codeid+","+"\"\""+")>("+sum+")</a>";
					var dataprio = [
				        	{name : 'A',value : <%=request.getAttribute("TotalA")%>/sum, Count: <%=request.getAttribute("TotalA")%>,color:'#CC0000'},
				        	{name : 'B',value : <%=request.getAttribute("TotalB")%>/sum,Count: <%=request.getAttribute("TotalB")%>,color:'#3498db'},
				        	{name : 'C',value :  <%=request.getAttribute("TotalC")%>/sum,Count: <%=request.getAttribute("TotalC")%>,color:'#FF9224'}
			        ];
				
					var chartprio = new iChart.Pie2D({
						offset_angle:-120,
						increment:3,
						radius:80,
						render : 'canvasDivPri',
						title:{
							//text:'Defect Priority',
							color:'#000000',
							height:40,
							//border:{
								//enable:false,
								//width:[0,0,2,0],
								//color:'#FFFFFF'
							//}
						},
						padding:'2 10',
						footnote:{
							//text:'StatCounter Global Stats,design by ichartjs',
							color:'#e0e5e8',
							height:30,
							border:{
								enable:true,
								width:[2,0,0,0],
								color:'#343b3e'
							}
						},
						width : 350,
						height : 170,
						offsety:5,
						data:dataprio,
						shadow:false,
						shadow_color:'#000000',
						shadow_blur:8,
						background_color : '#FFFFFF',
						//gradient:true,//开启渐变
						//color_factor:0.28,
						//gradient_mode:'RadialGradientOutIn',
						showpercent:true,
						decimalsnum:0,
						/*legend:{
							offsetx:50,
							offsety:-50,
							enable:true,
							padding:100,
							color:'#000000',
							border:{
								width:[0,0,0,0],
								color:'#343b3e'
							},
							background_color : null,
						},*/
						sub_option:{						
							border:{
								enable:false
							},
							label : {
								sign:false,
								fontsize:10,
								color:'#000000'
							},
							
							listeners:{
								parseText:function(d, t){
									return d.get('name')+"("+ d.get('Count')+")"+"	"+d.get('value');
								},
								click:function(s,e,m){	
									if(s.get('name')=='A')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'A');
									
									if(s.get('name')=='B')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'B');
									
									if(s.get('name')=='C')
										openwin_searchdefect('<%=request.getAttribute("projectname")%>',codeid,'C');
								}
							}
						},
						//鼠标移上去提示文字
						tip:{
							enable :true,
							listeners:{
								//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return "See Details";
								}
							} 
						},
						border:{
							//width:[0,20,0,20],
							color:'#ffffff'
						}
					});		
					
					//chart.bound(0);
					chartprio.draw();
					//////////////////////////////////Defect Priority end////////////////////////////////
					
					
					///////////////////////////Defect Defects Status of Component (Top10)  start//////////////////////////
					var dataComp = [
			        	{
			         		name : 'Closed',
			         		value:[<%=request.getAttribute("CompClose1")%>,<%=request.getAttribute("CompClose2")%>,<%=request.getAttribute("CompClose3")%>,<%=request.getAttribute("CompClose4")%>,<%=request.getAttribute("CompClose5")%>,<%=request.getAttribute("CompClose6")%>,<%=request.getAttribute("CompClose7")%>,<%=request.getAttribute("CompClose8")%>,<%=request.getAttribute("CompClose9")%>,<%=request.getAttribute("CompClose10")%>],
			         		color:'#3498db'
			         	},
			         	{
			         		name : 'Resolved',
			         		value:[<%=request.getAttribute("CompResolved1")%>,<%=request.getAttribute("CompResolved2")%>,<%=request.getAttribute("CompResolved3")%>,<%=request.getAttribute("CompResolved4")%>,<%=request.getAttribute("CompResolved5")%>,<%=request.getAttribute("CompResolved6")%>,<%=request.getAttribute("CompResolved7")%>,<%=request.getAttribute("CompResolved8")%>,<%=request.getAttribute("CompResolved9")%>,<%=request.getAttribute("CompResolved10")%>],
			         		color:'#FF9224'
			         	},
			         	/*
			         	{
			         		name : 'Rejected',
			         		value:[<s:property value="#request.CompRejected1"/>,<s:property value="#request.CompRejected2"/>,<s:property value="#request.CompRejected3"/>,<s:property value="#request.CompRejected4"/>,<s:property value="#request.CompRejected5"/>,<s:property value="#request.CompRejected6"/>,<s:property value="#request.CompRejected7"/>,<s:property value="#request.CompRejected8"/>,<s:property value="#request.CompRejected9"/>,<s:property value="#request.CompRejected10"/>],
			         		color:'#6b8439'
			         	},
			         	*/
			         	{
			         		name : 'Opened',
			         		value:[<%=request.getAttribute("CompPending1")%>,<%=request.getAttribute("CompPending2")%>,<%=request.getAttribute("CompPending3")%>,<%=request.getAttribute("CompPending4")%>,<%=request.getAttribute("CompPending5")%>,<%=request.getAttribute("CompPending6")%>,<%=request.getAttribute("CompPending7")%>,<%=request.getAttribute("CompPending8")%>,<%=request.getAttribute("CompPending9")%>,<%=request.getAttribute("CompPending10")%>],
			         		color:'#CC0000'
			         	}
			     	 ];
	        
					  var chartComp = new iChart.ColumnStacked3D({
							render : 'componentDiv',
							data: dataComp,
							labels:["<%=request.getAttribute("CompItem1")%>","<%=request.getAttribute("CompItem2")%>","<%=request.getAttribute("CompItem3")%>","<%=request.getAttribute("CompItem4")%>","<%=request.getAttribute("CompItem5")%>","<%=request.getAttribute("CompItem6")%>","<%=request.getAttribute("CompItem7")%>","<%=request.getAttribute("CompItem8")%>","<%=request.getAttribute("CompItem9")%>","<%=request.getAttribute("CompItem10")%>"],
							title : {
								//text:'各Component别问题点现况',
								color:'#000000'
							},
						//footnote : '数据来源：KONA数据库',
						width : 850,
						height : 200,
						column_width:25,
						background_color : '',//#ffffff
						shadow : true,
						shadow_blur : 4,
						shadow_color : '',//#aaaaaa
						shadow_offsetx : 1,
						shadow_offsety : 0, 
						offsety:-20,
						sub_option:{
							label:{color:'#ffffff',fontsize:9,fontweight:400},
							border : {
								width : 2,
								color : '#ffffff'
							} 							
						},
						label:{color:'#000000',fontsize:10,fontweight:80,rotate:20,offsetx:20},
						legend:{
							enable:true,
							background_color : null,
							line_height:20,
							color:'#000000',
							fontsize:10,
							fontweight:400,
							offsety:-40,
							border : {
								enable : false
							}
						},
						tip:{
							enable :true,
							listeners:{
								//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return name+":"+value;
								}
							} 
						},
						text_space : 15,//坐标系下方的label距离坐标系的距离。
						zScale:0.5,
						xAngle : 50,
						bottom_scale:1.1, 
						coordinate:{
							//position:left,
							width:'90%',
							height:'70%',
							board_deep:10,//背面厚度
							pedestal_height:10,//底座高度
							left_board:false,//取消左侧面板 
							shadow:true,//底座的阴影效果
							grid_color:'#ffffff',//网格线
							wall_style:[{//坐标系的各个面样式
							color : '#ffffff'
							},{
							color : '#ffffff'
							}, {
							color : '#ffffff'
							},{
							color : '#ffffff'
							},{
							color : '#ffffff'
							},{
							color : '#ffffff'
							}], 
							axis : {
								color : '#ffffff',
								width : 0
							}, 
							scale:[{
								 position:'left',	
								 scale_enable : false,
								 start_scale:0,
								 //scale_space:20,
								 end_scale:<%=request.getAttribute("CompClose1")%>+<%=request.getAttribute("CompResolved1")%>+<%=request.getAttribute("CompRejected1")%>+<%=request.getAttribute("CompPending1")%>+5,
								 label:{color:'#ffffff',fontsize:10,fontweight:400}
							}]
						}
					});

					//利用自定义组件构造左上侧单位
					chart.plugin(new iChart.Custom({
						drawFn:function(){
							//计算位置
							var coo = chart.getCoordinate(),
							x = coo.get('originx'),
							y = coo.get('originy');
							//在左上侧的位置，渲染一个单位的文字
							chart.target.textAlign('end')
							.textBaseline('bottom')
							.textFont('400 10px ')
							.fillText('',x+10,y-30,false,'#254d70')
						
						}
					}));
			
					chartComp.draw();
					///////////////////////////Defect Defects Status of Component (Top10)   end/////////////////////////
					
					
					///////////////////////////Defects Status of Block (Top10)    start/////////////////////////
					var dataBlock = [
			         	{
			         		name : 'Closed',
			         		value:[<%=request.getAttribute("BlockClose1")%>,<%=request.getAttribute("BlockClose2")%>,<%=request.getAttribute("BlockClose3")%>,<%=request.getAttribute("BlockClose4")%>,<%=request.getAttribute("BlockClose5")%>,<%=request.getAttribute("BlockClose6")%>,<%=request.getAttribute("BlockClose7")%>,<%=request.getAttribute("BlockClose8")%>,<%=request.getAttribute("BlockClose9")%>,<%=request.getAttribute("BlockClose10")%>],
			         		color:'#3498db'
			         	},
			         	{
			         		name : 'Resolved',
			         		value:[<%=request.getAttribute("BlockResolved1")%>,<%=request.getAttribute("BlockResolved2")%>,<%=request.getAttribute("BlockResolved3")%>,<%=request.getAttribute("BlockResolved4")%>,<%=request.getAttribute("BlockResolved5")%>,<%=request.getAttribute("BlockResolved6")%>,<%=request.getAttribute("BlockResolved7")%>,<%=request.getAttribute("BlockResolved8")%>,<%=request.getAttribute("BlockResolved9")%>,<%=request.getAttribute("BlockResolved10")%>],
			         		color:'#FF9224'
			         	},
			         	/*
			         	{
			         		name : 'Rejected',
			         		value:[<s:property value="#request.BlockRejected1"/>,<s:property value="#request.BlockRejected2"/>,<s:property value="#request.BlockRejected3"/>,<s:property value="#request.BlockRejected4"/>,<s:property value="#request.BlockRejected5"/>,<s:property value="#request.BlockRejected6"/>,<s:property value="#request.BlockRejected7"/>,<s:property value="#request.BlockRejected8"/>,<s:property value="#request.BlockRejected9"/>,<s:property value="#request.BlockRejected10"/>],
			         		color:'#6b8439'
			         	},
			         	*/
			         	{
			         		name : 'Opened',
			         		value:[<%=request.getAttribute("BlockPending1")%>,<%=request.getAttribute("BlockPending2")%>,<%=request.getAttribute("BlockPending3")%>,<%=request.getAttribute("BlockPending4")%>,<%=request.getAttribute("BlockPending5")%>,<%=request.getAttribute("BlockPending6")%>,<%=request.getAttribute("BlockPending7")%>,<%=request.getAttribute("BlockPending8")%>,<%=request.getAttribute("BlockPending9")%>,<%=request.getAttribute("BlockPending10")%>],
			         		color:'#CC0000'
			         	}
			         ];
	        
					var chartBlock = new iChart.ColumnStacked3D({
						//align:'left',
						render : 'FeatureDiv',
						data: dataBlock,
						labels:["<%=request.getAttribute("BlockItem1")%>","<%=request.getAttribute("BlockItem2")%>","<%=request.getAttribute("BlockItem3")%>","<%=request.getAttribute("BlockItem4")%>","<%=request.getAttribute("BlockItem5")%>","<%=request.getAttribute("BlockItem6")%>","<%=request.getAttribute("BlockItem7")%>","<%=request.getAttribute("BlockItem8")%>","<%=request.getAttribute("BlockItem9")%>","<%=request.getAttribute("BlockItem10")%>"],
						//footnote : '数据来源：KONA数据库',
						width : 850,
						height : 200,
						column_width:25,
						background_color : '',//#ffffff
						shadow : true,
						shadow_blur : 4,
						shadow_color : '',//#aaaaaa
						shadow_offsetx : 1,
						shadow_offsety : 0, 
						offsety:-20,
						sub_option:{
							label:{color:'#ffffff',fontsize:9,fontweight:500},
							border : {
								width : 2,
								color : '#ffffff'
							} 
						},
						label:{color:'#000000',fontsize:10,fontweight:80,rotate:20,offsetx:20},
						legend:{
							enable:true,
							background_color : null,
							line_height:20,
							color:'#000000',
							fontsize:10,
							fontweight:400,
							offsety:-40,
							border : {
								enable : false
							}
						},
						tip:{
							enable :true,
							listeners:{
								//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return name+":"+value;
								}
							} 
						},
						text_space : 15,//坐标系下方的label距离坐标系的距离。
						zScale:1,
						xAngle : 50,
						bottom_scale:1.1, 
						coordinate:{
							//position:left,
							width:'90%',
							height:'70%',
							board_deep:10,//背面厚度
							pedestal_height:10,//底座高度
							left_board:false,//取消左侧面板 
							shadow:true,//底座的阴影效果
							grid_color:'#ffffff',//网格线
							wall_style:[{//坐标系的各个面样式
							color : '#ffffff'
							},{
							color : '#ffffff'
							}, {
							color : '#ffffff'
							},{
							color : '#ffffff'
							},{
							color : '#ffffff'
							},{
							color : '#ffffff'
							}], 
							axis : {
								color : '#ffffff',
								width : 0
							}, 
							scale:[{
								 position:'left',	
								 scale_enable : false,
								 start_scale:0,
								 //scale_space:60,
								 end_scale:<%=request.getAttribute("BlockClose1")%>+<%=request.getAttribute("BlockResolved1")%>+<%=request.getAttribute("BlockRejected1")%>+<%=request.getAttribute("BlockPending1")%>+5,
								 label:{color:'#ffffff',fontsize:10,fontweight:400}
							}]
						}
					});

					//利用自定义组件构造左上侧单位
					chart.plugin(new iChart.Custom({
							drawFn:function(){
								//计算位置
								var coo = chart.getCoordinate(),
									x = coo.get('originx'),
									y = coo.get('originy');
								//在左上侧的位置，渲染一个单位的文字
								chart.target.textAlign('end')
								.textBaseline('bottom')
								.textFont('400 10px ')
								.fillText('',x+10,y-30,false,'#254d70')
								
							}
					}));
					
					chartBlock.draw();
					
					///////////////////////////Defects Status of Block (Top10)     end/////////////////////////
					
					
					///////////////////////////   Submit & Resolve      start/////////////////////////
					//避免选择model后， 日期不更新为当日
					var d=new Date();
					var year=d.getFullYear();
					var month = d.getMonth()+1;
					var dt=d.getDate();
					var today = year+"-"+month+"-"+dt;
					document.getElementById("enddate").value= today;
					var dataSR = [{
					         		 name : 'Submit',
					         		value:[<%=request.getAttribute("Day1")%>,<%=request.getAttribute("Day2")%>,<%=request.getAttribute("Day3")%>,<%=request.getAttribute("Day4")%>,<%=request.getAttribute("Day5")%>,<%=request.getAttribute("Day6")%>,<%=request.getAttribute("Day7")%>,<%=request.getAttribute("Day8")%>,<%=request.getAttribute("Day9")%>,<%=request.getAttribute("Day10")%>,<%=request.getAttribute("Day11")%>,<%=request.getAttribute("Day12")%>,<%=request.getAttribute("Day13")%>,<%=request.getAttribute("Day14")%>,<%=request.getAttribute("Day15")%>,<%=request.getAttribute("Day16")%>,<%=request.getAttribute("Day17")%>,<%=request.getAttribute("Day18")%>,<%=request.getAttribute("Day19")%>,<%=request.getAttribute("Day20")%>,<%=request.getAttribute("Day21")%>,<%=request.getAttribute("Day22")%>,<%=request.getAttribute("Day23")%>,<%=request.getAttribute("Day24")%>,<%=request.getAttribute("Day25")%>,<%=request.getAttribute("Day26")%>,<%=request.getAttribute("Day27")%>,<%=request.getAttribute("Day28")%>,<%=request.getAttribute("Day29")%>,<%=request.getAttribute("Day30")%>,<%=request.getAttribute("Day31")%>,<%=request.getAttribute("Day32")%>,<%=request.getAttribute("Day33")%>,<%=request.getAttribute("Day34")%>,<%=request.getAttribute("Day35")%>,<%=request.getAttribute("Day36")%>,<%=request.getAttribute("Day37")%>,<%=request.getAttribute("Day38")%>,<%=request.getAttribute("Day39")%>,<%=request.getAttribute("Day40")%>,<%=request.getAttribute("Day41")%>,<%=request.getAttribute("Day42")%>,<%=request.getAttribute("Day43")%>,<%=request.getAttribute("Day44")%>,<%=request.getAttribute("Day45")%>,<%=request.getAttribute("Day46")%>,<%=request.getAttribute("Day47")%>,<%=request.getAttribute("Day48")%>,<%=request.getAttribute("Day49")%>,<%=request.getAttribute("Day50")%>,<%=request.getAttribute("Day51")%>,<%=request.getAttribute("Day52")%>,<%=request.getAttribute("Day53")%>,<%=request.getAttribute("Day54")%>,<%=request.getAttribute("Day55")%>,<%=request.getAttribute("Day56")%>,<%=request.getAttribute("Day57")%>,<%=request.getAttribute("Day58")%>,<%=request.getAttribute("Day59")%>,<%=request.getAttribute("Day60")%>],
					         		 color:'#f68f70',
					         		 line_width:2
					         	},
					         	{
					         		name : 'Resolve',
					         		value:[<%=request.getAttribute("ResolveDay1")%>,<%=request.getAttribute("ResolveDay2")%>,<%=request.getAttribute("ResolveDay3")%>,<%=request.getAttribute("ResolveDay4")%>,<%=request.getAttribute("ResolveDay5")%>,<%=request.getAttribute("ResolveDay6")%>,<%=request.getAttribute("ResolveDay7")%>,<%=request.getAttribute("ResolveDay8")%>,<%=request.getAttribute("ResolveDay9")%>,<%=request.getAttribute("ResolveDay10")%>,<%=request.getAttribute("ResolveDay11")%>,<%=request.getAttribute("ResolveDay12")%>,<%=request.getAttribute("ResolveDay13")%>,<%=request.getAttribute("ResolveDay14")%>,<%=request.getAttribute("ResolveDay15")%>,<%=request.getAttribute("ResolveDay16")%>,<%=request.getAttribute("ResolveDay17")%>,<%=request.getAttribute("ResolveDay18")%>,<%=request.getAttribute("ResolveDay19")%>,<%=request.getAttribute("ResolveDay20")%>,<%=request.getAttribute("ResolveDay21")%>,<%=request.getAttribute("ResolveDay22")%>,<%=request.getAttribute("ResolveDay23")%>,<%=request.getAttribute("ResolveDay24")%>,<%=request.getAttribute("ResolveDay25")%>,<%=request.getAttribute("ResolveDay26")%>,<%=request.getAttribute("ResolveDay27")%>,<%=request.getAttribute("ResolveDay28")%>,<%=request.getAttribute("ResolveDay29")%>,<%=request.getAttribute("ResolveDay30")%>,<%=request.getAttribute("ResolveDay31")%>,<%=request.getAttribute("ResolveDay32")%>,<%=request.getAttribute("ResolveDay33")%>,<%=request.getAttribute("ResolveDay34")%>,<%=request.getAttribute("ResolveDay35")%>,<%=request.getAttribute("ResolveDay36")%>,<%=request.getAttribute("ResolveDay37")%>,<%=request.getAttribute("ResolveDay38")%>,<%=request.getAttribute("ResolveDay39")%>,<%=request.getAttribute("ResolveDay40")%>,<%=request.getAttribute("ResolveDay41")%>,<%=request.getAttribute("ResolveDay42")%>,<%=request.getAttribute("ResolveDay43")%>,<%=request.getAttribute("ResolveDay44")%>,<%=request.getAttribute("ResolveDay45")%>,<%=request.getAttribute("ResolveDay46")%>,<%=request.getAttribute("ResolveDay47")%>,<%=request.getAttribute("ResolveDay48")%>,<%=request.getAttribute("ResolveDay49")%>,<%=request.getAttribute("ResolveDay50")%>,<%=request.getAttribute("ResolveDay51")%>,<%=request.getAttribute("ResolveDay52")%>,<%=request.getAttribute("ResolveDay53")%>,<%=request.getAttribute("ResolveDay54")%>,<%=request.getAttribute("ResolveDay55")%>,<%=request.getAttribute("ResolveDay56")%>,<%=request.getAttribute("ResolveDay57")%>,<%=request.getAttribute("ResolveDay58")%>,<%=request.getAttribute("ResolveDay59")%>,<%=request.getAttribute("ResolveDay60")%>],
					         		color:'#aad0db',
					         		line_width:2
					         	}
					];
		         
					var labels = [""+(time(-59).getMonth()+1)+"/"+time(-59).getDate()+"", ""+(time(-58).getMonth()+1)+"/"+time(-58).getDate()+"",
									""+(time(-57).getMonth()+1)+"/"+time(-57).getDate()+"", ""+(time(-56).getMonth()+1)+"/"+time(-56).getDate()+"",
									""+(time(-55).getMonth()+1)+"/"+time(-55).getDate()+"", ""+(time(-54).getMonth()+1)+"/"+time(-54).getDate()+"",
									""+(time(-53).getMonth()+1)+"/"+time(-53).getDate()+"", ""+(time(-52).getMonth()+1)+"/"+time(-52).getDate()+"",
									""+(time(-51).getMonth()+1)+"/"+time(-51).getDate()+"", ""+(time(-50).getMonth()+1)+"/"+time(-50).getDate()+"",
									""+(time(-49).getMonth()+1)+"/"+time(-49).getDate()+"", ""+(time(-48).getMonth()+1)+"/"+time(-48).getDate()+"",
									""+(time(-47).getMonth()+1)+"/"+time(-47).getDate()+"", ""+(time(-46).getMonth()+1)+"/"+time(-46).getDate()+"",
									""+(time(-45).getMonth()+1)+"/"+time(-45).getDate()+"", ""+(time(-44).getMonth()+1)+"/"+time(-44).getDate()+"",
									""+(time(-43).getMonth()+1)+"/"+time(-43).getDate()+"", ""+(time(-42).getMonth()+1)+"/"+time(-42).getDate()+"",
									""+(time(-41).getMonth()+1)+"/"+time(-41).getDate()+"", ""+(time(-40).getMonth()+1)+"/"+time(-40).getDate()+"",
									""+(time(-39).getMonth()+1)+"/"+time(-39).getDate()+"", ""+(time(-38).getMonth()+1)+"/"+time(-38).getDate()+"",
									""+(time(-37).getMonth()+1)+"/"+time(-37).getDate()+"", ""+(time(-36).getMonth()+1)+"/"+time(-36).getDate()+"",
									""+(time(-35).getMonth()+1)+"/"+time(-35).getDate()+"", ""+(time(-34).getMonth()+1)+"/"+time(-34).getDate()+"",
									""+(time(-33).getMonth()+1)+"/"+time(-33).getDate()+"", ""+(time(-32).getMonth()+1)+"/"+time(-32).getDate()+"",
									""+(time(-31).getMonth()+1)+"/"+time(-31).getDate()+"", ""+(time(-30).getMonth()+1)+"/"+time(-30).getDate()+"",
									""+(time(-29).getMonth()+1)+"/"+time(-29).getDate()+"", ""+(time(-28).getMonth()+1)+"/"+time(-28).getDate()+"",
									""+(time(-27).getMonth()+1)+"/"+time(-27).getDate()+"", ""+(time(-26).getMonth()+1)+"/"+time(-26).getDate()+"",
									""+(time(-25).getMonth()+1)+"/"+time(-25).getDate()+"", ""+(time(-24).getMonth()+1)+"/"+time(-24).getDate()+"",
									""+(time(-23).getMonth()+1)+"/"+time(-23).getDate()+"", ""+(time(-22).getMonth()+1)+"/"+time(-22).getDate()+"",
									""+(time(-21).getMonth()+1)+"/"+time(-21).getDate()+"", ""+(time(-20).getMonth()+1)+"/"+time(-20).getDate()+"",
									""+(time(-19).getMonth()+1)+"/"+time(-19).getDate()+"", ""+(time(-18).getMonth()+1)+"/"+time(-18).getDate()+"",
									""+(time(-17).getMonth()+1)+"/"+time(-17).getDate()+"", ""+(time(-16).getMonth()+1)+"/"+time(-16).getDate()+"",
									""+(time(-15).getMonth()+1)+"/"+time(-15).getDate()+"", ""+(time(-14).getMonth()+1)+"/"+time(-14).getDate()+"",
									""+(time(-13).getMonth()+1)+"/"+time(-13).getDate()+"", ""+(time(-12).getMonth()+1)+"/"+time(-12).getDate()+"",
									""+(time(-11).getMonth()+1)+"/"+time(-11).getDate()+"", ""+(time(-10).getMonth()+1)+"/"+time(-10).getDate()+"",
									""+(time(-9).getMonth()+1)+"/"+time(-9).getDate()+"", ""+(time(-8).getMonth()+1)+"/"+   time( -8).getDate()+"",
									""+(time(-7).getMonth()+1)+"/"+time(-7).getDate()+"", ""+(time(-6).getMonth()+1)+"/"+time(-6).getDate()+"",
									""+(time(-5).getMonth()+1)+"/"+time(-5).getDate()+"", ""+(time(-4).getMonth()+1)+"/"+time(-4).getDate()+"",
									""+(time(-3).getMonth()+1)+"/"+time(-3).getDate()+"", ""+(time(-2).getMonth()+1)+"/"+time(-2).getDate()+"",
									""+(time(-1).getMonth()+1)+"/"+time(-1).getDate()+"", ""+(time(0).getMonth()+1)+"/"+time(0).getDate()+""];
					var chartSR = new iChart.LineBasic2D({
						render : 'canvasDivZhe',
						data: dataSR,
						align:'center',
						title:{
							//text:'Submit & Resolve',
							color:'#000000',
							fontsize:14,
							//fontweight:'',
							height:40,
						},
						//subtitle : 'Submit & Resolve',
						//footnote : 'CCCCCCCCCCCCCCCCCCC',
						width : 850,
						height : 350,
						background_color:'#FEFEFE',
						tip:{
							enable:true,
							shadow:true,
							move_duration:400,
							border:{
								 enable:true,
								 radius : 5,
								 width:2,
								 color:'#3f8695'
							},
							listeners:{
								 //tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
								parseText:function(tip,name,value,text,i){
									return name+":"+value;
								}
							}
						},
						tipMocker:function(tips,i){
							return "<div style='font-weight:600'>"+labels[i]+
									" "+//时间
									"</div>"+tips.join("<br/>");
						},
						legend : {
							enable : true,
							row:1,//设置在一行上显示，与column配合使用
							column : 'max',
							valign:'top',
							sign:'bar',
							background_color:null,//设置透明背景
							offsetx:-30,//设置x轴偏移，满足位置需要
							offsety:0,
							fontsize:10,
							fontweight:400,
							border : true
						},
						crosshair:{
							enable:true,
							line_color:'#62bce9'//十字线的颜色
						},
						sub_option : {
							label:false,
							point_size:6						
						},
						coordinate:{
							width:700,
							height:240,
							axis:{
								color:'#dcdcdc',
								width:1
							},
							scale:[{
									 position:'left',	
									 start_scale:0,
									 //end_scale:maxInNumbers+10,
									 //scale_space:20,
									 scale_size:2,
									 scale_color:'#9f9f9f',
									 label:{color:'#000000',fontsize:10,fontweight:400},
									  },{
										 position:'bottom',								 
										 labels:["","","",
													""+(time(-56).getMonth()+1)+"/"+time(-56).getDate()+"","","","","","","",
													""+(time(-49).getMonth()+1)+"/"+time(-49).getDate()+"","","","","","","",
													""+(time(-42).getMonth()+1)+"/"+time(-42).getDate()+"","","","","","","",
													""+(time(-35).getMonth()+1)+"/"+time(-35).getDate()+"","","","","","","",
													""+(time(-28).getMonth()+1)+"/"+time(-28).getDate()+"","","","","","","",
													""+(time(-21).getMonth()+1)+"/"+time(-21).getDate()+"","","","","","","",
													""+(time(-14).getMonth()+1)+"/"+time(-14).getDate()+"","","","","","","",
													""+(time(-7).getMonth()+1)+"/"+time(-7).getDate()+"","","","","","","",
													""+(time(0).getMonth()+1)+"/"+time(0).getDate()+""],
										label:{color:'#000000',fontsize:10,fontweight:400},
							}]
						}//coordinate					
					});
				
					//开始画图
					chartSR.draw();	
					///////////////////////////  Submit & Resolve       end/////////////////////////
					
					
				//}); //getJSON	
			});//load
		</script>
		<script language="javascript" type="text/javascript">	
		///////////////////////////  Submit & Resolve   动态查询  start/////////////////////////
			function go(){
						var projectname="<%=request.getAttribute("projectname")%>";					
						var codeid= <%=request.getAttribute("codeid")%>;
						//alert(getBeforeDate(341));
						var d=document.getElementById("enddate").value;
						var year= d.substring(0,4);
						var mon=d.substring(5,d.lastIndexOf("-"));
				        var day=d.substring(d.lastIndexOf("-")+1,d.length);
				        
				        var selectDate = year+"-"+((mon.length==1)?('0'+mon):mon)+"-"+(day.length==1?('0'+day):day);
						//alert(selectDate);
						if(selectDate<=getBeforeDate(341)||(selectDate>=getBeforeDate(-1))){
							var info="No Data!\r\nPlease Select a Valid Date During: \""+getBeforeDate(341)+" ~ "+getBeforeDate(0)+"\"";
							alert(info);
						}
						else{
							
							var url="/portal/defectinfo/getDailyData?currdate="+document.getElementById('enddate').value+"&projectname="+projectname+"&codeid="+codeid;
							//alert(projectname);
							$.getJSON(url,function(jsondata) {	
								var dataGo = [{
							         		 name : 'Submit',
							         		 value: jsondata[0].listDay,
							         		 color:'#f68f70',
							         		 line_width:2
							         		},
							         		{
							         		name : 'Resolve',
							         		value: jsondata[0].listResolveDay,
							         		color:'#aad0db',
							         		line_width:2
							         		}
								];
								var labels = [""+(time(-59-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-59-jsondata[0].daysBetween).getDate()+"", ""+(time(-58-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-58-jsondata[0].daysBetween).getDate()+"",
											""+(time(-57-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-57-jsondata[0].daysBetween).getDate()+"", ""+(time(-56-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-56-jsondata[0].daysBetween).getDate()+"",
											""+(time(-55-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-55-jsondata[0].daysBetween).getDate()+"", ""+(time(-54-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-54-jsondata[0].daysBetween).getDate()+"",
											""+(time(-53-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-53-jsondata[0].daysBetween).getDate()+"", ""+(time(-52-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-52-jsondata[0].daysBetween).getDate()+"",
											""+(time(-51-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-51-jsondata[0].daysBetween).getDate()+"", ""+(time(-50-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-50-jsondata[0].daysBetween).getDate()+"",
											""+(time(-49-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-49-jsondata[0].daysBetween).getDate()+"", ""+(time(-48-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-48-jsondata[0].daysBetween).getDate()+"",
											""+(time(-47-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-47-jsondata[0].daysBetween).getDate()+"", ""+(time(-46-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-46-jsondata[0].daysBetween).getDate()+"",
											""+(time(-45-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-45-jsondata[0].daysBetween).getDate()+"", ""+(time(-44-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-44-jsondata[0].daysBetween).getDate()+"",
											""+(time(-43-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-43-jsondata[0].daysBetween).getDate()+"", ""+(time(-42-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-42-jsondata[0].daysBetween).getDate()+"",
											""+(time(-41-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-41-jsondata[0].daysBetween).getDate()+"", ""+(time(-40-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-40-jsondata[0].daysBetween).getDate()+"",
											""+(time(-39-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-39-jsondata[0].daysBetween).getDate()+"", ""+(time(-38-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-38-jsondata[0].daysBetween).getDate()+"",
											""+(time(-37-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-37-jsondata[0].daysBetween).getDate()+"", ""+(time(-36-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-36-jsondata[0].daysBetween).getDate()+"",
											""+(time(-35-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-35-jsondata[0].daysBetween).getDate()+"", ""+(time(-34-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-34-jsondata[0].daysBetween).getDate()+"",
											""+(time(-33-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-33-jsondata[0].daysBetween).getDate()+"", ""+(time(-32-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-32-jsondata[0].daysBetween).getDate()+"",
											""+(time(-31-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-31-jsondata[0].daysBetween).getDate()+"", ""+(time(-30-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-30-jsondata[0].daysBetween).getDate()+"",
											""+(time(-29-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-29-jsondata[0].daysBetween).getDate()+"", ""+(time(-28-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-28-jsondata[0].daysBetween).getDate()+"",
											""+(time(-27-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-27-jsondata[0].daysBetween).getDate()+"", ""+(time(-26-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-26-jsondata[0].daysBetween).getDate()+"",
											""+(time(-25-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-25-jsondata[0].daysBetween).getDate()+"", ""+(time(-24-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-24-jsondata[0].daysBetween).getDate()+"",
											""+(time(-23-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-23-jsondata[0].daysBetween).getDate()+"", ""+(time(-22-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-22-jsondata[0].daysBetween).getDate()+"",
											""+(time(-21-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-21-jsondata[0].daysBetween).getDate()+"", ""+(time(-20-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-20-jsondata[0].daysBetween).getDate()+"",
											""+(time(-19-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-19-jsondata[0].daysBetween).getDate()+"", ""+(time(-18-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-18-jsondata[0].daysBetween).getDate()+"",
											""+(time(-17-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-17-jsondata[0].daysBetween).getDate()+"", ""+(time(-16-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-16-jsondata[0].daysBetween).getDate()+"",
											""+(time(-15-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-15-jsondata[0].daysBetween).getDate()+"", ""+(time(-14-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-14-jsondata[0].daysBetween).getDate()+"",
											""+(time(-13-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-13-jsondata[0].daysBetween).getDate()+"", ""+(time(-12-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-12-jsondata[0].daysBetween).getDate()+"",
											""+(time(-11-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-11-jsondata[0].daysBetween).getDate()+"", ""+(time(-10-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-10-jsondata[0].daysBetween).getDate()+"",
											""+(time(-9-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-9-jsondata[0].daysBetween).getDate()+"", ""+(time(-8-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-8-jsondata[0].daysBetween).getDate()+"",
											""+(time(-7-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-7-jsondata[0].daysBetween).getDate()+"", ""+(time(-6-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-6-jsondata[0].daysBetween).getDate()+"",
											""+(time(-5-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-5-jsondata[0].daysBetween).getDate()+"", ""+(time(-4-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-4-jsondata[0].daysBetween).getDate()+"",
											""+(time(-3-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-3-jsondata[0].daysBetween).getDate()+"", ""+(time(-2-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-2-jsondata[0].daysBetween).getDate()+"",
											""+(time(-1-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-1-jsondata[0].daysBetween).getDate()+"", ""+(time(0-jsondata[0].daysBetween).getMonth()+1)+"/"+time(0-jsondata[0].daysBetween).getDate()+""];
								var chartGo = new iChart.LineBasic2D({
									render : 'canvasDivZhe',
									data: dataGo,
									align:'center',
									title:{
										//text:'Submit & Resolve',
										color:'#000000',
										fontsize:14,
										//fontweight:'',
										height:40,
									},
									//subtitle : 'Submit & Resolve',
									//footnote : 'CCCCCCCCCCCCCCCCCCC',
									width : 850,
									height : 350,
									background_color:'#FEFEFE',
									tip:{
										enable:true,
										shadow:true,
										move_duration:400,
										border:{
											 enable:true,
											 radius : 5,
											 width:2,
											 color:'#3f8695'
										},
										listeners:{
											 //tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
											parseText:function(tip,name,value,text,i){
												return name+":"+value;
											}
										}
									},
									tipMocker:function(tips,i){
										return "<div style='font-weight:600'>"+labels[i]+
												" "+//时间
												"</div>"+tips.join("<br/>");
									},
									legend : {
										enable : true,
										row:1,//设置在一行上显示，与column配合使用
										column : 'max',
										valign:'top',
										sign:'bar',
										background_color:null,//设置透明背景
										offsetx:-30,//设置x轴偏移，满足位置需要
										offsety:0,
										fontsize:10,
										fontweight:400,
										border : true
									},
									crosshair:{
										enable:true,
										line_color:'#62bce9'//十字线的颜色
									},
									sub_option : {
										label:false,
										point_size:6						
									},
									coordinate:{
										width:700,
										height:240,
										axis:{
											color:'#dcdcdc',
											width:1
										},
										scale:[{
												 position:'left',	
												 start_scale:0,
												 //end_scale:maxInNumbers+10,
												 //scale_space:20,
												 scale_size:2,
												 scale_color:'#9f9f9f',
												 label:{color:'#000000',fontsize:10,fontweight:400},
												  },{
													 position:'bottom',								 
													 labels:["","","",
													""+(time(-56-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-56-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-49-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-49-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-42-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-42-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-35-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-35-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-28-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-28-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-21-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-21-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-14-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-14-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-7-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-7-jsondata[0].daysBetween).getDate()+"","","","","","","",
													""+(time(-jsondata[0].daysBetween).getMonth()+1)+"/"+time(-jsondata[0].daysBetween).getDate()+""],
													label:{color:'#000000',fontsize:10,fontweight:400},
										}]
									}//coordinate	
								}); //var chart
							
								//开始画图
								chartGo.draw();	
							}); //json
						}
			}
					///////////////////////////  Submit & Resolve   动态查询  end/////////////////////////
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
			

			function openwin_searchdefect(pn,id,item){	
				window.open ("/portal/defect/getDefectFromPie?projectname="+pn+"&codeid="+id+"&item="+item+"&rn="+Math.random(), "newwindow", "height=700, width=1800, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no, top=50,left=150");
			}
		</script>
		<script>
			function getBeforeDate(n){
			    var n = n;
			    var d = new Date();
			    var year = d.getFullYear();
			    var mon=d.getMonth()+1;
			    var day=d.getDate();
			    if(day <= n){
			            if(mon>1) {
			               mon=mon-1;
			            }
			           else {
			             year = year-1;
			             mon = 12;
			             }
			           }
			          d.setDate(d.getDate()-n);
			          year = d.getFullYear();
			          mon=d.getMonth()+1;
			          day=d.getDate();
			     s = year+"-"+(mon<10?('0'+mon):mon)+"-"+(day<10?('0'+day):day);
			     return s;
			}
		</script>

		<script type="text/javascript">
			$(document).ready(function () {
				$.getJSON("/portal/visitor/updateVisitor?rn="+Math.random(),function(data){
					if("success"==data.result){
						//parent.location.href="/portal/home/index";
					}
					else{
						alert("Update Visitor Failure!");
					}
				});			
			});
		</script>
	</head>


	<body style="overflow: hidden;">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">	
			<tr >		
				<td width="12%"></td>
				<td width="22%"><br/><a href="/portal/home/index"><img src="<%=request.getContextPath()%>/style/images/logo4.jpg"   /></a><br><br/></td>
				<td width="20%" align="left" valign="middle"> <img src="<%=request.getContextPath()%>/style/images/logo1.jpg"   /> </td>
				<td valign="middle" width="40%">
				<form name="modelForm" action="/portal/defectinfo/toDefectPage?projectname=<%=request.getAttribute("projectname")%>"  method="post"  theme="simple">	
					<font color="gray" face="Arial"   style="font-size:14px; font-weight:bold; ">Project:&nbsp;</font><font color="gray" face="Arial"   style="font-size:14px;   "><%=request.getAttribute("projectname")%> <br /><br /><font color="gray" face="Arial"   style="font-size:14px; font-weight:bold; ">Model &nbsp; </font>
					<select id="codeid" name="codeid"   headerKey="0"  onChange="modelForm.submit()" style="padding-left:5px; vertical-align:middle; font-size:14px;border-radius:5px; width:160px;height:33px">
						<c:forEach items= "${mapcode}"  var="c">
							<option value="${c.key}">${c.value}</option>
						</c:forEach>
					</select>		
				</form>
				</td>
			</tr>
		</table>

		<table >
	 		<tr>
	 			<td  colspan="3" bgcolor="#d2e9ff" width="2600px" height="33px">			<%--#d2e9ff --%>		
			</tr>
		</table>									


		<%
				String endd;
				SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
				String today=format.format(new Date());
				endd=today;
		%>
		<table border="1"  align="center"  style="border-collapse:collapse;" width="98%">
			<tr bordercolor='#DEDEDE'>				  
				<td align="center" rowspan='2' border='1'>	
				<div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <font color="#333333" face="Arial"   style="font-size:14px; font-weight:bold; ">Submit & Resolve </font> 	
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
					<font  color="#333333" face="Arial" style="font-size:12px;">End Date &nbsp;&nbsp;&nbsp;</font><input type="text" id="enddate" value="<%=endd %>" onClick="return Calendar('enddate');" onChange="alert(1)"  class="text_time" style="border-radius:5px;"/>
					<a href="#"><img width="20" height="20" id="go" alt="Go" onClick="go()" src="<%=request.getContextPath()%>/style/images/search3.png" class="imgPlace"/></a>
				</div>
					<br />	
					<div id="canvasDivZhe"></div>	
				</td>
			
				<td align="center" border="1">
					<br/>
					<center>
						<font color="#333333"  face="Arial" style=" font-size:14px; font-weight:bold; ">Defect Status	</font>
						<font color="blue" face="Verdana" size="1"><div id="total1" style="display:inline"></div></font>					
					</center>
					<br />
					<div id='canvasDivSta'></div>
				</td>
			
				<td align="center" border="1">
					<br/>	
					<center> 
						<font color="#333333"  face="Arial" style=" font-size:14px; font-weight:bold; ">Defect Priority</font>
						<font color="blue" face="Verdana" size="1"><div id="total2" style="display:inline"></div></font>
					 </center>
					<br />
					<div id='canvasDivPri'></div>
				</td>
			</tr>
			<tr bordercolor='#DEDEDE' height="50%" width="50%">
					<td  align="center" colspan="2" >
						<br/>
						<font color="#333333"  face="Arial" style=" font-size:14px; font-weight:bold; ">Percentage of Resolved(SQA Test)</font> 
						<br/><br/>
						<div id='canvasDiv' height="100px"></div>
						<br />	
					</td>
			</tr>

			<tr bordercolor='#DEDEDE' height="50%">	
				<td align="center" width="50%">	
					<center> 
						<font color="#333333"  face="Arial" style=" font-size:14px; font-weight:bold; ">Defects Status of Component (Top10)</font> 
					</center> 
					<br/>
					<div id='componentDiv'></div> 
				</td>
		
				<td align="center" width="50%" colspan ="2">
					<center>
						<br/> 
						<font color="#333333"  face="Arial" style=" font-size:14px; font-weight:bold; ">Defects Status of Block (Top10) </font> 
						<br/><br/>
					<center>
					<div id='FeatureDiv'></div>			
					<br/>	
				</td>
			</tr>	
			<br/>
		</table>
		<div id="bottom" style="width:100%; align-left:0px; position:absolute; bottom:0px">
			<table> 		
	 			<tr bgcolor="#ecf0f1"  height="20px" style="padding-bottom:5px">
		 			<td  width="246px"><font size=1 face="Arial" color="#9d9d9d">&nbsp;&nbsp;&nbsp;&nbsp;
		 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&copy;.TSDR SW Group</font>
		 			</td>
		 			<td width="150px" align="center">
		 				<a href="http://mosaic.sec.samsung.net/club/club.main.index.screen?p_club_id=31153" target="_blank" title="Community"><font size=1 face="Arial">TSDR SW MOSAIC</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://splm.sec.samsung.net/portal/com/shared/main.do" target="_blank" title="Project Management System"><font size=1 face="Arial">PLM</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://kona.sec.samsung.net/kona_server/main/mainPage.do" target="_blank" title="SW Defect Traking System"><font size=1 face="Arial">KONA</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://vdsmart.sec.samsung.net/home/menu.do" target="_blank" title="SW Standard Asset and Process Information"><font size=1 face="Arial">SMART</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://10.40.68.65:8085/default.jsp" target="_blank" title="Global Management & Adjustment of Product"><font size=1 face="Arial">G-MAP</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://168.219.241.102/VDOSS/#/" target="_blank" title="Opensource License Verification"><font size=1 face="Arial">OpenSource</font></a>
					</td>
					<td width="100px" align="center">
		 				<a href="http://vdswportal.sec.samsung.net/SWPortal/static_analysis.aspx" target="_blank" title="SW Static Test tool"><font size=1 face="Arial">SVACE</font></a>
					</td>
					<td width="100px" align="center">
		 				<a href="http://109.110.100.50:4982/defect" target="_blank" title="SW Code Quality Improvement System"><font size=1 face="Arial">Dexter</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://platz.sec.samsung.net/tapi/" target="_blank" title="Platform API of Tizen"><font size=1 face="Arial">PLATZ</font></a>
					</td>
		 			<td width="100px" align="center">
		 				<a href="http://vdcosmos.sec.samsung.net/signin" target="_blank" title="VD Tizen Build & Test System"><font size=1 face="Arial">COSMOS</font></a>
					</td>
		 				<td width="100px" align="center">
						<a href="http://10.40.68.68/isms/identity/anonymous/ssoLogin.do" target="_blank" title="Integrated SW Security Management System"><font size=1 face="Arial">ISMS</font></a>
					</td>
		 			<td width="100px" align="center">
						<a href="http://vdsw.sec.samsung.net/SitePages/New_Home.aspx" target="_blank" title="Microsoft Office Sharepoint Server"><font size=1 face="Arial">MOSS</font></a>
					</td>	
					<td width="100px" align="center">
						<a href="https://wormhole.sec.samsung.net/cnh/secure/StructureBoard.jspa" target="_blank" title="Microsoft Office Sharepoint Server"><font size=1 face="Arial">Wormhole</font></a>
					</td>
					<td width="100px" align="center">
						<a href="http://109.110.41.139:8000/" target="_blank" title="What's Model"><font size=1 face="Arial">What's Model</font></a>
					</td>
					<td width="100px" align="center">
						<a href="http://109.110.100.57/index.html" target="_blank" title="SW Technical Material Library"><font size=1 face="Arial">STeML</font></a>
					</td>
					<td width="500px" align="center">
					
					</td>			
					<td width="100px" align="center">
						<a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=31153&p_menu_id=65&p_group_id=67" target="_blank" title=""><font color="#9d9d9d" size=1 face="Arial">VOC</font></a>
					</td>
					<td width="100px" align="center">				
						<a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=31153&p_menu_id=81&p_group_id=67" target="_blank"><font color="#9d9d9d" size=1 face="Arial">Q&A</font></a>
					</td>
					<td width="100px" align="center" >
						<a href="/portal/home/download/SW Portal User Manual.pptx" title='TSDR SW Portal Manual Download'><font color="#9d9d9d" size=1 face="Arial">User Manual</font></a>
					</td>
					<td width="100px" align="center">
						<font color="#9d9d9d" size=1 face="Arial">V1.4.4</font>
					</td>
				</tr>
			</table>	
		</div>
	</body>
</html>
