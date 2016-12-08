
<%@ page import="net.nw.vo.*,net.nw.dao.SearchProjectDAO"%>
<%@ page import="net.nw.dao.DefactAllDAO"%>
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<title>S/W Project Analysis System</title>


<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>




<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />
<link rel="stylesheet" type="text/css" href="css/style_button.css" />
	<%DefactAllDAO ddao=new DefactAllDAO();%>
	<script type="text/javascript">
	
		$(function(){
			var data = [
			         	{
			         		name : 'DTV',
			         		value:[<%= ddao.getNum("UT",1) %>,<%= ddao.getNum_Actual("UT",1) %>,<%= ddao.getNum("UT",2) %>,<%= ddao.getNum_Actual("UT",2) %>,<%= ddao.getNum("UT",3) %>,<%= ddao.getNum_Actual("UT",3) %>,
			         		<%= ddao.getNum("UT",4) %>,<%= ddao.getNum_Actual("UT",4) %>,<%= ddao.getNum("UT",5) %>,<%= ddao.getNum_Actual("UT",5) %>,<%= ddao.getNum("UT",6) %>,<%= ddao.getNum_Actual("UT",6) %>,
			         		<%= ddao.getNum("UT",7) %>,<%= ddao.getNum_Actual("UT",7) %>,<%= ddao.getNum("UT",8) %>,<%= ddao.getNum_Actual("UT",8) %>,
			         		<%= ddao.getNum_2016("UT",1) %>,<%= ddao.getNum_Actual_2016("UT",1) %>,],
			         		color:'#e0b645'
			         	},
			         	{
			         		name : 'Hotel',
			         		value:[<%= ddao.getNum("HD",1) %>,<%= ddao.getNum_Actual("HD",1) %>,<%= ddao.getNum("HD",2) %>,<%= ddao.getNum_Actual("HD",2) %>,<%= ddao.getNum("HD",3) %>,<%= ddao.getNum_Actual("HD",3) %>,
			         		<%= ddao.getNum("HD",4) %>,<%= ddao.getNum_Actual("HD",4) %>,<%= ddao.getNum("HD",5) %>,<%= ddao.getNum_Actual("HD",5) %>,<%= ddao.getNum("HD",6) %>,<%= ddao.getNum_Actual("HD",6) %>,
			         		<%= ddao.getNum("HD",7) %>,<%= ddao.getNum_Actual("HD",7) %>,<%= ddao.getNum("HD",8) %>,<%= ddao.getNum_Actual("HD",8) %>,
			         		<%= ddao.getNum_2016("HD",1) %>,<%= ddao.getNum_Actual_2016("HD",1) %>,],
			         		color:'#7876ba'
			         	},
			         	{
			         		name : 'MFM',
			         		value:[<%= ddao.getNum("MFM",1) %>,<%= ddao.getNum_Actual("MFM",1) %>,<%= ddao.getNum("MFM",2) %>,<%= ddao.getNum_Actual("MFM",2) %>,<%= ddao.getNum("MFM",3) %>,<%= ddao.getNum_Actual("MFM",3) %>,
			         		<%= ddao.getNum("MFM",4) %>,<%= ddao.getNum_Actual("MFM",4) %>,<%= ddao.getNum("MFM",5) %>,<%= ddao.getNum_Actual("MFM",5) %>,<%= ddao.getNum("MFM",6) %>,<%= ddao.getNum_Actual("MFM",6) %>,
			         		<%= ddao.getNum("MFM",7) %>,<%= ddao.getNum_Actual("MFM",7) %>,<%= ddao.getNum("MFM",8) %>,<%= ddao.getNum_Actual("MFM",8) %>,
			         		<%= ddao.getNum_2016("MFM",1) %>,<%= ddao.getNum_Actual_2016("MFM",1) %>,],
			         		color:'#6b8439'
			         	},
			         	{
			         		name : 'Monitor',
			         		value:[<%= ddao.getNum("LM",1) %>,<%= ddao.getNum_Actual("LM",1) %>,<%= ddao.getNum("LM",2) %>,<%= ddao.getNum_Actual("LM",2) %>,<%= ddao.getNum("LM",3) %>,<%= ddao.getNum_Actual("LM",3) %>,
			         		<%= ddao.getNum("LM",4) %>,<%= ddao.getNum_Actual("LM",4) %>,<%= ddao.getNum("LM",5) %>,<%= ddao.getNum_Actual("LM",5) %>,<%= ddao.getNum("LM",6) %>,<%= ddao.getNum_Actual("LM",6) %>,
			         		<%= ddao.getNum("LM",7) %>,<%= ddao.getNum_Actual("LM",7) %>,<%= ddao.getNum("LM",8) %>,<%= ddao.getNum_Actual("LM",8) %>,
			         		<%= ddao.getNum_2016("LM",1) %>,<%= ddao.getNum_Actual_2016("LM",1) %>,],
			         		color:'#FF9933'
			         	}
			         ];
	        
			var chart = new iChart.ColumnStacked3D({
					render : 'canvasDiv',
					data: data,
					labels:["15Jan_Plan","15Jan_Actual","Feb_Plan","Feb_Actual","Mar_Plan","Mar_Actual","Apr_Plan","Plan_Actual","May_Plan","May_Actual","Jun_Plan","Jun_Actual",
					"Jul_Plan","Jul_Actual","Aug_Plan","Aug_Actual","16Jan_Plan","16Jan_Actual"],
					title : {
						text:'',
						color:'#254d70'
					},
					footnote : '',
					width : 1800,
					height : 600,
					column_width:35,
					background_color : '#ffffff',
					shadow : true,
					shadow_blur : 4,
					shadow_color : '#aaaaaa',
					shadow_offsetx : 1,
					shadow_offsety : 0, 
					sub_option:{
						label:{color:'#f9f9f9',fontsize:12,fontweight:600},
						border : {
							width : 2,
							color : '#ffffff'
						} 
					},
					label:{color:'#254d70',fontsize:12,fontweight:600,rotate:10},
					legend:{
						enable:true,
						background_color : null,
						line_height:25,
						color:'#254d70',
						fontsize:12,
						fontweight:600,
						border : {
							enable : false
						}
					},
					tip:{
						enable :true,
						listeners:{
							//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
							parseText:function(tip,name,value,text,i){
								return name+":"+value+ '个';
							}
						} 
					},
					text_space : 20,//坐标系下方的label距离坐标系的距离。
					zScale:1,
					xAngle : 50,
					bottom_scale:1.1, 
					coordinate:{
						width:'90%',
						height:'90%',
						board_deep:10,//背面厚度
						pedestal_height:10,//底座高度
						left_board:false,//取消左侧面板 
						shadow:true,//底座的阴影效果
						grid_color:'#6a6a80',//网格线
						wall_style:[{//坐标系的各个面样式
						color : '#6a6a80'
						},{
						color : '#b2b2d3'
						}, {
						color : '#a6a6cb'
						},{
						color : '#6a6a80'
						},{
						color : '#74749b'
						},{
						color : '#a6a6cb'
						}], 
						axis : {
							color : '#c0d0e0',
							width : 0
						}, 
						scale:[{
							 position:'left',	
							 scale_enable : false,
							 start_scale:0,
							 scale_space:12,
							 end_scale:140,
							 label:{color:'#254d70',fontsize:11,fontweight:600}
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
						.textFont('600 12px 微软雅黑')
						.fillText('',x+10,y-20,false,'#254d70')
						
					}
			}));
			
			chart.draw();
		});
		</script>
</head>
  
  
  <body >
 	
 	<center>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
		<tr>
			<td width="8%"  rowspan="2"></td>
			<td width="4%"  rowspan="2"></td>
			<td width="22%" rowspan="2"><br><img src="images/logo4.jpg"   /><br><br/></td>
			<td width="31%" rowspan="2"align="left" valign="middle"><div id="div_time" style="border: 1px black; " ></div></td>
			<td width="1%"></td>
			<td width="10%"><br></td>
			<td width="4%"></td>
			<td width="1%" rowspan="2"><a style="font-weight:bold;" href="mainpage.jsp"><br></a></td>
			<td width="4%"></td>
			<td width="1%" rowspan="2"></td>
			<td width="4%"></td>
			<td rowspan="2" width="30%" align="left">
			   <!-- <img id="obj" src="images/houniandaji.jpg"   /> -->
			</td> 
			<td rowspan="2" width="12%" ></td>
			</tr>
		<tr>
			<td></td>
			<td></td>
			
		</tr>
		</table>
		
		<center>
		
			<table>
		 		<tr>
		 			<td  colspan="3" bgcolor="#1A94E6" width="2000px" height="35px">
					
					<br>
					<br/>
						
				</tr>
			</table>
		</center>
	<table>
		<tr bgcolor="white" >
			<td width="12.5%"></td>
			<td width="75%" align="center"></td>
			<td width="12.5%"></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
			<br/>
			<font style="font-weight:bold;">2015~2016 Monthly PRA Model Qty.</font>
			<br/>
			</td>
		</tr>
		<tr>
			<td width="12.5%"></td>
			<td>
				<div id='canvasDiv'></div>  
			</td>
			<td width="12.5%"></td>
		</tr>
	</table>
	</center>
	<br>
	<br>
	<br>
	
	<!-- <div class="footer"> -->
 		<table>
 		<tr>
 			<td  colspan="3" bgcolor="#9ABAE0" width="2000px" height="40px">
			<center>
			<br>
			<br/>
				Project Analysis System Copyright &copy;. 2016 All rights reserved. Design from <a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72" target="_blank" title="Free Templates">TSDR S/W Group  &nbsp;</a>
			<br>
			<br/>
			<br>
			
			</center>	
		</tr>
		</table>
		<!-- </div> -->
  </body>
</html>
