
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"></meta>

<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>




<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />
<link rel="stylesheet" type="text/css" href="css/style_button.css" />
	<%DefactAllDAO ddao=new DefactAllDAO();%>
	<script type="text/javascript">
		var sum1 = <%= ddao.getNum_2016_entry("UT",1)%>+<%= ddao.getNum_2016_smart("UT",1)%>+<%= ddao.getNum_2016("HD",1)%>+<%= ddao.getNum_2016("MFM",1)%>+<%= ddao.getNum_2016("LM",1)%>;
		var sum2 = <%= ddao.getNum_2016_entry("UT",2)%>+<%= ddao.getNum_2016_smart("UT",2)%>+<%= ddao.getNum_2016("HD",2)%>+<%= ddao.getNum_2016("MFM",2)%>+<%= ddao.getNum_2016("LM",2)%>;
		var sum3 = <%= ddao.getNum_2016_entry("UT",3)%>+<%= ddao.getNum_2016_smart("UT",3)%>+<%= ddao.getNum_2016("HD",3)%>+<%= ddao.getNum_2016("MFM",3)%>+<%= ddao.getNum_2016("LM",3)%>;
		var sum4 = <%= ddao.getNum_2016_entry("UT",4)%>+<%= ddao.getNum_2016_smart("UT",4)%>+<%= ddao.getNum_2016("HD",4)%>+<%= ddao.getNum_2016("MFM",4)%>+<%= ddao.getNum_2016("LM",4)%>;
		var sum5 = <%= ddao.getNum_2016_entry("UT",5)%>+<%= ddao.getNum_2016_smart("UT",5)%>+<%= ddao.getNum_2016("HD",5)%>+<%= ddao.getNum_2016("MFM",5)%>+<%= ddao.getNum_2016("LM",5)%>;
		var sum6 = <%= ddao.getNum_2016_entry("UT",6)%>+<%= ddao.getNum_2016_smart("UT",6)%>+<%= ddao.getNum_2016("HD",6)%>+<%= ddao.getNum_2016("MFM",6)%>+<%= ddao.getNum_2016("LM",6)%>;
		var sum7 = <%= ddao.getNum_2016_entry("UT",7)%>+<%= ddao.getNum_2016_smart("UT",7)%>+<%= ddao.getNum_2016("HD",7)%>+<%= ddao.getNum_2016("MFM",7)%>+<%= ddao.getNum_2016("LM",7)%>;
		var sum8 = <%= ddao.getNum_2016_entry("UT",8)%>+<%= ddao.getNum_2016_smart("UT",8)%>+<%= ddao.getNum_2016("HD",8)%>+<%= ddao.getNum_2016("MFM",8)%>+<%= ddao.getNum_2016("LM",8)%>;
		var sum9 = <%= ddao.getNum_2016_entry("UT",9)%>+<%= ddao.getNum_2016_smart("UT",9)%>+<%= ddao.getNum_2016("HD",9)%>+<%= ddao.getNum_2016("MFM",9)%>+<%= ddao.getNum_2016("LM",9)%>;
		var sum10= <%= ddao.getNum_2016_entry("UT",10)%>+<%= ddao.getNum_2016_smart("UT",10)%>+<%= ddao.getNum_2016("HD",10)%>+<%= ddao.getNum_2016("MFM",10)%>+<%= ddao.getNum_2016("LM",10)%>;
		var sum11 = <%= ddao.getNum_2016_entry("UT",11)%>+<%= ddao.getNum_2016_smart("UT",11)%>+<%= ddao.getNum_2016("HD",11)%>+<%= ddao.getNum_2016("MFM",11)%>+<%= ddao.getNum_2016("LM",11)%>;
		var sum12 = <%= ddao.getNum_2016_entry("UT",12)%>+<%= ddao.getNum_2016_smart("UT",12)%>+<%= ddao.getNum_2016("HD",12)%>+<%= ddao.getNum_2016("MFM",12)%>+<%= ddao.getNum_2016("LM",12)%>;
		var numbers=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,sum11,sum12];
		var maxInNumbers = Math.max.apply(Math, numbers);

		var date=new Date;
		var month=date.getMonth()+1;
		var space = 70;
		$(function(){
			var data = [
			        	{
			        		name : 'Entry TV',
			        		value:[,<%= ddao.getNum_2016_entry("UT",1)%>,<%= ddao.getNum_2016_entry("UT",2)%>,<%= ddao.getNum_2016_entry("UT",3)%>,<%= ddao.getNum_2016_entry("UT",4)%>,<%= ddao.getNum_2016_entry("UT",5)%>,<%= ddao.getNum_2016_entry("UT",6)%>,<%= ddao.getNum_2016_entry("UT",7)%>,<%= ddao.getNum_2016_entry("UT",8)%>,<%= ddao.getNum_2016_entry("UT",9)%>,<%= ddao.getNum_2016_entry("UT",10)%>,<%= ddao.getNum_2016_entry("UT",11)%>,<%= ddao.getNum_2016_entry("UT",12)%>,,],
			        		color:'#000093',
			        		line_width:1
			        	},
						{
			        		name : 'Smart TV',
			        		value:[,<%= ddao.getNum_2016_smart("UT",1)%>,<%= ddao.getNum_2016_smart("UT",2)%>,<%= ddao.getNum_2016_smart("UT",3)%>,<%= ddao.getNum_2016_smart("UT",4)%>,<%= ddao.getNum_2016_smart("UT",5)%>,<%= ddao.getNum_2016_smart("UT",6)%>,<%= ddao.getNum_2016_smart("UT",7)%>,<%= ddao.getNum_2016_smart("UT",8)%>,<%= ddao.getNum_2016_smart("UT",9)%>,<%= ddao.getNum_2016_smart("UT",10)%>,<%= ddao.getNum_2016_smart("UT",11)%>,<%= ddao.getNum_2016_smart("UT",12)%>,,],
			        		color:'#FF0080',
			        		line_width:1
			        	},
						{
			        		name : 'HTV',
			        		value:[,<%= ddao.getNum_2016("HD",1)%>,<%= ddao.getNum_2016("HD",2)%>,<%= ddao.getNum_2016("HD",3)%>,<%= ddao.getNum_2016("HD",4)%>,<%= ddao.getNum_2016("HD",5)%>,<%= ddao.getNum_2016("HD",6)%>,<%= ddao.getNum_2016("HD",7)%>,<%= ddao.getNum_2016("HD",8)%>,<%= ddao.getNum_2016("HD",9)%>,<%= ddao.getNum_2016("HD",10)%>,<%= ddao.getNum_2016("HD",11)%>,<%= ddao.getNum_2016("HD",12)%>,,],
			        		color:'#FF8000',
			        		line_width:1
			        	}, 
						{
			        		name : 'MFM',
			        		value:[,<%= ddao.getNum_2016("MFM",1)%>,<%= ddao.getNum_2016("MFM",2)%>,<%= ddao.getNum_2016("MFM",3)%>,<%= ddao.getNum_2016("MFM",4)%>,<%= ddao.getNum_2016("MFM",5)%>,<%= ddao.getNum_2016("MFM",6)%>,<%= ddao.getNum_2016("MFM",7)%>,<%= ddao.getNum_2016("MFM",8)%>,<%= ddao.getNum_2016("MFM",9)%>,<%= ddao.getNum_2016("MFM",10)%>,<%= ddao.getNum_2016("MFM",11)%>,<%= ddao.getNum_2016("MFM",12)%>,,],
			        		color:'#01B468',
			        		line_width:1
			        	},
						{
			        		name : 'Mon.',
			        		value:[,<%= ddao.getNum_2016("LM",1)%>,<%= ddao.getNum_2016("LM",2)%>,<%= ddao.getNum_2016("LM",3)%>,<%= ddao.getNum_2016("LM",4)%>,<%= ddao.getNum_2016("LM",5)%>,<%= ddao.getNum_2016("LM",6)%>,<%= ddao.getNum_2016("LM",7)%>,<%= ddao.getNum_2016("LM",8)%>,<%= ddao.getNum_2016("LM",9)%>,<%= ddao.getNum_2016("LM",10)%>,<%= ddao.getNum_2016("LM",11)%>,<%= ddao.getNum_2016("LM",12)%>,,],
			        		color:'#0072E3',
			        		line_width:1
			        	},
						{
			        		name : 'Total',
			        		value:[,sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,sum11,sum12,,],
			        		color:'#FF0000',
			        		line_width:1
			        	}
			       ];
			var chart = new iChart.LineBasic2D({
						render : 'canvasDiv',
						data: data,
						title : '',
						width : 1100,
						height : 560,
						offsetx:-40,
						coordinate:{
							height:'90%',
							background_color:'#f6f9fa',

							scale:[
									{
										position:'left',	
										scale_enable : true,
										start_scale:0,
										scale_space:10,
										end_scale:maxInNumbers+9
									},
									{
										position:'bottom',	
										labels:[" ","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"," "]
									}
								]
						},
						sub_option:{
							hollow_inside:false,//设置一个点的亮色在外环的效果
							point_size:6,
							label:
							{
								fontsize:14,
								offsetx:15,
								padding:0,
								fontweight: 400
							}
						},	

						legend:{
						enable:true,
						background_color : null,
						line_height:35,
						color:'#000000',
						fontsize:12,
						fontweight:800,
						sign_size:20,
						//text_with_sign_color:true,
						offsetx: -20,
						border : {
							enable : false
						}
					},
						
					});
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
					
						.fillText('|',x+2+space*month,y,false,'#FF0000')
						.fillText('|',x+2+space*month,y+20,false,'#FF0000')
						.fillText('|',x+2+space*month,y+40,false,'#FF0000')
						.fillText('|',x+2+space*month,y+60,false,'#FF0000')
						.fillText('|',x+2+space*month,y+80,false,'#FF0000')
						.fillText('|',x+2+space*month,y+100,false,'#FF0000')
						.fillText('|',x+2+space*month,y+120,false,'#FF0000')
						.fillText('|',x+2+space*month,y+140,false,'#FF0000')
						.fillText('|',x+2+space*month,y+160,false,'#FF0000')
						.fillText('|',x+2+space*month,y+180,false,'#FF0000')
						.fillText('|',x+2+space*month,y+200,false,'#FF0000')
						.fillText('|',x+2+space*month,y+220,false,'#FF0000')
						.fillText('|',x+2+space*month,y+240,false,'#FF0000')
						.fillText('|',x+2+space*month,y+260,false,'#FF0000')
						.fillText('|',x+2+space*month,y+280,false,'#FF0000')
						.fillText('|',x+2+space*month,y+300,false,'#FF0000')
						.fillText('|',x+2+space*month,y+320,false,'#FF0000')
						.fillText('|',x+2+space*month,y+340,false,'#FF0000')
						.fillText('|',x+2+space*month,y+360,false,'#FF0000')
						.fillText('|',x+2+space*month,y+380,false,'#FF0000')
						.fillText('|',x+2+space*month,y+400,false,'#FF0000')
						.fillText('|',x+2+space*month,y+420,false,'#FF0000')
						.fillText('|',x+2+space*month,y+440,false,'#FF0000')
						.fillText('|',x+2+space*month,y+460,false,'#FF0000')
						.fillText('|',x+2+space*month,y+480,false,'#FF0000');			
						
					}
			}));
			chart.draw();
		});
				
	</script>
</head>
  
  
  <body > 	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
		<tr>
			<td width="8%"  rowspan="2"></td>
			<td width="4%"  rowspan="2"></td>
			<td width="22%" rowspan="2"><br><img src="images/logo4.jpg"   /><br><br/></td>
			<td width="31%" rowspan="2"align="left" valign="middle"><img src="images/logo1.jpg"   /></td>
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

		
			<table>
		 		<tr>
		 			<td  colspan="3" bgcolor="#2D75DB" width="2500px" height="35px">
					
					<br>
					<br/>
						
				</tr>
			</table>		
	<table>
		<tr bgcolor="white" >
			<td width="12.5%"></td>
			<td width="37.5%" align="center"></td>
			<td width="37.5%" align="center"></td>
			<td width="12.5%"></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
			<br/>
			<strong><font face="Verdana" size="2"> Monthly PRA Model Qty.</font>
			<br/>
			</td>
		</tr>
		<tr>
			<td width="12.5%"></td>
			<td>
				<center>
					<div id='canvasDiv'></div>
				</center>
			</td>
			<td>
				  
			</td>
			<td width="12.5%"></td>
		</tr>
	</table>
	</center>
	<br>
	<br>
	
	
	<!-- <div class="footer"> -->
	<!-- 
	<div style="background-color:#2D75DB;">
	<br/>
		<center>	
			<p>
			<font color="#ffffff">Project Analysis System Copyright &copy;. </font><font color="red">2016</font> <font color="#ffffff">All rights reserved. Design from</font> 
			<a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72" target="_blank" title="Free Templates">TSDR S/W Group</a>
			</p>
		</center>																																																													<div class="inner_copy"><a href="http://www.beautifullife.info/"></a><a href="http://www.grungemagazine.com/"></a></div>
	</div>
 	 -->	
		
		<!-- </div> -->
  </body>
</html>
