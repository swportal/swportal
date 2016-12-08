
<%@ page import="java.sql.ResultSet"%>
<%@ page import="net.nw.dao.ProjectStatusDAO"%>
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>S/W Project Analysis System</title>

	
<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var table = $('#delaymodel').DataTable( {
        scrollY:        true,
        scrollX:        true,
        scrollCollapse: true,
        paging:         false,
        fixedRows:   {
            upRows: 1,
            //rightColumns: 1
        }
    } );
} );
</script>
<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />
<link rel="stylesheet" type="text/css" href="css/style_button.css" />
	
	<script type="text/javascript">
	<%
		ProjectStatusDAO psd2 = new ProjectStatusDAO();
		ResultSet rs_Monitor1 = psd2.getResultSet("Monitor");
		ResultSet rs_MFM1 = psd2.getResultSet("MFM");
		ResultSet rs_HDTV1 = psd2.getResultSet("HDTV");
		ResultSet rs_4K5K1 = psd2.getResultSet("4K/5K");
		ResultSet rs_DTV1 = psd2.getResultSet("DTV");
	%>

		$(function(){
			var data = [<%while(rs_DTV1.next()&&rs_4K5K1.next()&&rs_HDTV1.next()&&rs_MFM1.next()&&rs_Monitor1.next()){%>
						{
							name : 'Completed',
							value:[<%=Integer.parseInt(rs_DTV1.getString("PRACompl")) %>/(<%=Integer.parseInt(rs_DTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_4K5K1.getString("PRACompl")) %>/(<%=Integer.parseInt(rs_4K5K1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_HDTV1.getString("PRACompl")) %>/(<%=Integer.parseInt(rs_HDTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_MFM1.getString("PRACompl")) %>/(<%=Integer.parseInt(rs_MFM1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_Monitor1.getString("PRACompl")) %>/(<%=Integer.parseInt(rs_Monitor1.getString("PRAModelQty")) %>)],
							color:'#2D75DB',							
						},
			         	{
			         		name : 'Progress',
			         		value:[<%=Integer.parseInt(rs_DTV1.getString("PRAProgre")) %>/(<%=Integer.parseInt(rs_DTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_4K5K1.getString("PRAProgre")) %>/(<%=Integer.parseInt(rs_4K5K1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_HDTV1.getString("PRAProgre")) %>/(<%=Integer.parseInt(rs_HDTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_MFM1.getString("PRAProgre")) %>/(<%=Integer.parseInt(rs_MFM1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_Monitor1.getString("PRAProgre")) %>/(<%=Integer.parseInt(rs_Monitor1.getString("PRAModelQty")) %>)],
			         		color:'#FF9224',
			         	},
						{
							name : 'Delay',
							value:[<%=Integer.parseInt(rs_DTV1.getString("PRADelay")) %>/(<%=Integer.parseInt(rs_DTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_4K5K1.getString("PRADelay")) %>/(<%=Integer.parseInt(rs_4K5K1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_HDTV1.getString("PRADelay")) %>/(<%=Integer.parseInt(rs_HDTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_MFM1.getString("PRADelay")) %>/(<%=Integer.parseInt(rs_MFM1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_Monitor1.getString("PRADelay")) %>/(<%=Integer.parseInt(rs_Monitor1.getString("PRAModelQty")) %>)],
			         		color:'#CE0000',
						},
			         	{
			         		name : 'Not start',
			         		value:[<%=Integer.parseInt(rs_DTV1.getString("PRANotStart")) %>/(<%=Integer.parseInt(rs_DTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_4K5K1.getString("PRANotStart")) %>/(<%=Integer.parseInt(rs_4K5K1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_HDTV1.getString("PRANotStart")) %>/(<%=Integer.parseInt(rs_HDTV1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_MFM1.getString("PRANotStart")) %>/(<%=Integer.parseInt(rs_MFM1.getString("PRAModelQty")) %>),<%=Integer.parseInt(rs_Monitor1.getString("PRANotStart")) %>/(<%=Integer.parseInt(rs_Monitor1.getString("PRAModelQty")) %>)],
			         		color:'#dedede'
			         		<%}%>
			         	}
			         ];
	        
			var chart = new iChart.BarStacked2D({
					render : 'canvasDiv',
					data: data,
					labels:["DTV  ","4K5K  ","HDTV  ","MFM  ","Monitor  "],
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
					width : 740,				
					color:'#000000',
					percent:true,
					height : 305,
					bar_height:20,
					background_color : '#FFFAF0',
					shadow : true,
					shadow_blur : 2,
					shadow_color : '#aaaaaa',
					shadow_offsetx : 1,
					shadow_offsety : 0, 
					offsety:-20,
					offsetx:-8,
					sub_option:{
						label:{color:'#000000',fontsize:10,fontweight:400,offsetx:2},
						border : {
							width : 2,
							color : '#d3d4f0'
						}
					},
					label:{color:'#000000',fontsize:10,fontweight:400},
					showpercent:true,
					decimalsnum:0,
					legend:{
						enable:true,
						background_color : null,
						line_height:25,
						color:'#000000',
						fontsize:10,
						fontweight:400,
						offsetx: 20,
						border : {
							enable : false
						}
					},
					tip:{
						enable :true,
						listeners:{
							//tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
							parseText:function(tip,name,value,text,i){
								return text;
							}
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
							// end_scale:100,
							 label:{color:'#000000',fontsize:10,fontweight:400},
							 listeners:{
								parseText:function(t,x,y){
									return {text:t}
								}
							 }
						}],
						width:600,
						height:260
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
		});
	</script>
	
	<script type="text/javascript">
		function theWeek(){
			
			var totalDays=0;
			var now =new Date();	
			years=now.getFullYear();
			if(years<1000){
				years+=1900;
			}		
			var days=new Array(12);
			days[0]=31;
			days[2]=31;
			days[3]=30;
			days[4]=31;
			days[5]=30;
			days[6]=31;
			days[7]=31;
			days[8]=30;
			days[9]=31;
			days[10]=30;
			days[11]=31;
			if(years % 4 == 0 && (years % 100 != 0 || years % 400 == 0)){			
				days[1]=29;				
			}
			else{			
				days[1]=28;
				alert(days[1]);
			}
			//days[1]=29;
			if(now.getMonth()==0){
				totalDays=totalDays+now.getDate();
			}
			else{
				var curMonth=now.getMonth();
				for(var count=1;count<=curMonth;count++){
					totalDays=totalDays+days[count-1];
				}
				totalDays=totalDays+now.getDate();
			}
			var week=Math.round(totalDays/7);	
					
			return week;
		}
		var curWeek=theWeek();	
		//alert(curWeek);	
	</script>
	
	
	
</head>
  
<body>

 	<%
		ProjectStatusDAO psd1 = new ProjectStatusDAO();
		ResultSet rs_Monitor = psd1.getResultSet("Monitor");
		ResultSet rs_MFM = psd1.getResultSet("MFM");
		ResultSet rs_HDTV = psd1.getResultSet("HDTV");
		ResultSet rs_4K5K = psd1.getResultSet("4K/5K");
		ResultSet rs_DTV = psd1.getResultSet("DTV");
		ResultSet rs_Total= psd1.getResultSet("Total");
		
		ResultSet rs_Delay= psd1.getResultSet_Delay();
		//ResultSet rs=  psd1.getResultSet("Monitor"); 
		//while (rs_Monitor.next()) {
		//System.out.println(rs_Monitor.getInt(2));	}	
	%>
	
 	<center>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="8%"  rowspan="2"></td>
			<td width="4%"  rowspan="2"></td>
			<td width="22%" rowspan="2"><br><img src="images/logo4.jpg"   /><br><br/></td>
			<td width="31%" rowspan="2"align="left" valign="middle"><img src="images/logo1.jpg"   /></div></td>
			<td width="1%"></td>
			<td width="10%"><br></td>
			<td width="4%"></td>
			<td width="1%" rowspan="2"><a style="font-weight:bold;" href="mainpage.jsp"><br></a></td>
			<td width="4%"></td>
			<td width="1%" rowspan="2"></td>
			<td width="4%"></td>
			<td rowspan="2" width="30%" align="left"></td> 
			   <!-- <img id="obj" src="images/houniandaji.jpg"   /> -->
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
			 	<td  colspan="3" bgcolor="#2D75DB" width="2000px" height="35px"></td>					
			</tr>
		</table>
	</center>			
<!-- 	<table>
		<tr  bgcolor="white">
			<td width="25%"><br></td>
			<td width="35%" align="center"><br></td>
			<td width="40%"><br></td>
		</tr>
	</table>
 -->
	<br>
	<table border="2"  align="center"  style="border-collapse:collapse;" width="96%">
		<tr bordercolor='#DEDEDE' border="1" >
			<td colspan="2" align="center">	
				<strong><font face="Verdana" size="2"><br>Model Status<br><br></font></strong>
				<table width="95%"  border="2" bordercolor='#DEDEDE' bgcolor='#FFFAF0' cellspacing='0px' style='border-collapse:collapse' >
					<tr bgcolor='#FFEFDB' bordercolor='#DEDEDE' border="1" >
						<td width="96px" rowspan="2" height="80px" align="center" ><strong><font face="Verdana" size="2">Product</font></strong></td>
						<td  colspan='4' align="center" height="35px"><strong><font face="Verdana" size="2">'16 Model</strong></font></td>
						<td  colspan='5' align="center"><strong><font face="Verdana" size="2">PVR</strong></font></td>
						<td  colspan='5' align="center"><strong><font face="Verdana" size="2">PRA</strong></font></td>
						<td  colspan='3' align="center"><strong><font face="Verdana" size="2">Weekly <font color="blue" face="Verdana" size="1">(W<script>document.write(curWeek)</script>)</font></strong></td>
					</tr>
					<tr bgcolor='#FFEFDB' bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="50px"><strong><font face="Verdana" size="2"> Total</strong></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Basic</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2">Deri.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> RC</strong></font></td>
										
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Model Qty.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Delay</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Normal<br>&nbsp;Compl.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Delay<br>&nbsp;Compl.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Compl.<br>&nbsp;Rate</strong></font></td>
						
										
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Model Qty.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Delay</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Normal<br>&nbsp;Compl.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Delay<br>&nbsp;Compl.</strong></font></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> Compl.<br>&nbsp;Rate</strong></font></td>
						
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> PVR <br>Compl.</strong></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> PRA<br>&nbsp;Compl.</strong></td>
						<td width="62px" align="center"><strong><font face="Verdana" size="2"> SRA<br>&nbsp;Compl.</strong></td>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="25px"> <strong><font face="Verdana" size="2">Monitor</font></strong></td>
						<%while(rs_Monitor.next()) {%>
						<td width="62px" align="center" ><font face="Verdana" size="2"><%= rs_Monitor.getInt("Total") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("RC") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PVRModelQty") %> </font></td>	
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PVRCompl_D") %> </font></td>
<%--<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PVRCompl") %>/<%= rs_Monitor.getInt("PVRModelQty") %></font></td>--%>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_Monitor.getInt("PVRCompl") %>/<%= rs_Monitor.getInt("PVRModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_Monitor.getInt("PRACompl") %>/<%= rs_Monitor.getInt("PRAModelQty")%>* 100)  + "%")</script></font></td>
						
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("WeeklyPVRCompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Monitor.getInt("WeeklySRACompl") %> </font></td>
						
						<%} %>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="25px"> <strong><font face="Verdana" size="2">MFM</strong></font></td>
						<%while(rs_MFM.next()) {%>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("Total") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("RC") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PVRModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PVRCompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_MFM.getInt("PVRCompl") %>*100/<%= rs_MFM.getInt("PVRModelQty")%>)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_MFM.getInt("PRACompl") %>*100/<%= rs_MFM.getInt("PRAModelQty")%>)  + "%")</script></font></td>
						
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("WeeklyPVRCompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_MFM.getInt("WeeklySRACompl") %> </font></td>
						<% }%>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="25px"> <strong><font face="Verdana" size="2">HDTV</strong></font></td>
						<%while(rs_HDTV.next()) {%>
						<td width="62px" align="center"><font face="Verdana" size="2"><font face="Verdana" size="2"><%= rs_HDTV.getInt("Total") %> </td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("RC") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PVRModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PVRCompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_HDTV.getInt("PVRCompl") %>/<%= rs_HDTV.getInt("PVRModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_HDTV.getInt("PRACompl") %>/<%= rs_HDTV.getInt("PRAModelQty")%>* 100)  + "%")</script></font></td>
						
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("WeeklyPVRCompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_HDTV.getInt("WeeklySRACompl") %> </font></td>
						<%} %>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="25px"> <strong><font face="Verdana" size="2">4K/5K</strong></font></td>
						<%while(rs_4K5K.next()) {%>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("Total") %></font> </td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("RC") %></font> </td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PVRModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PVRCompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_4K5K.getInt("PVRCompl") %>/<%= rs_4K5K.getInt("PVRModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_4K5K.getInt("PRACompl") %>/<%= rs_4K5K.getInt("PRAModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("WeeklyPVRCompl") %></font> </td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_4K5K.getInt("WeeklySRACompl") %> </font></td>
						<%} %>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center" height="25px"> <strong><font face="Verdana" size="2">DTV</strong></font></td>
						<%while(rs_DTV.next()) {%>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("Total") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("RC") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PVRModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PVRCompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_DTV.getInt("PVRCompl") %>/<%= rs_DTV.getInt("PVRModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_DTV.getInt("PRACompl") %>/<%= rs_DTV.getInt("PRAModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("WeeklyPVRCompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_DTV.getInt("WeeklySRACompl") %> </font></td>
						<%} %>
					</tr>
					
					<tr  bordercolor='#DEDEDE'>
						<td width="62px" align="center"  height="25px"> <strong><font face="Verdana" size="2">Total</strong></font></td>
						<%while(rs_Total.next()) {%>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("Total") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("Basic") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("Derivation") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("RC") %> </font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PVRModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PVRDelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PVRCompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PVRCompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_Total.getInt("PVRCompl") %>/<%= rs_Total.getInt("PVRModelQty")%>* 100)  + "%")</script></font></td>
						
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PRAModelQty") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PRADelay") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PRACompl_N") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("PRACompl_D") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><script>document.write(Math.round(<%= rs_Total.getInt("PRACompl") %>/<%= rs_Total.getInt("PRAModelQty")%>* 100)  + "%")</script></font></td>
						
					
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("WeeklyPVRCompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("WeeklyPRACompl") %> </font></td>
						<td width="62px" align="center"><font face="Verdana" size="2"><%= rs_Total.getInt("WeeklySRACompl") %> </font></td>
						<%} %>
					</tr>		
				</table><br/>				
			</td>							
	</tr>	
		
	<tr bordercolor='#DEDEDE'>
		<td align="center" width="57%" >	
			<center><strong><font face="Verdana" size="2"><br>PRA Status<br><br></strong></center>			
			<div id='canvasDiv' ></div>  </center>
			<br/>
		</td>
		<td align="center" border="1" width="40%">
			<!-- 		<td width="650px" valign="top" align="left">	 -->
			<center><strong><font face="Verdana" size="2">Delay Model Status<br><br></strong></center>
			
	   		<table id='delaymodel' width="500px"; height="35px" border-radius='5px' bordercolor='#DEDEDE' bgcolor='#FFFAF0' cellspacing='0px' style='border-collapse:collapse' border='1' >
					<tr bgcolor='#FFEFDB' bordercolor='#DEDEDE'>
						<td width="91px" align="center" height="36px"><strong><font face="Verdana" size="2">Prod. Gr.</font></strong></td>
						<td width="165px" align="center"><strong><font face="Verdana" size="2">Model</font></strong></td>
						<td width="91px" align="center"><strong><font face="Verdana" size="2">Milestone</font></strong></td>
						<td width="91px" align="center" ><strong><font face="Verdana" size="2">Delay <br>Days</font></strong></td>
						<td width="15px" align="center" ><strong><font face="Verdana" size="2"></font></strong></td>
					</tr>
			</table>
			<div style="width:500px; height:270px; overflow-y:scroll;">
				<table id='delaymodel2' border-radius='5px' bordercolor='#DEDEDE' bgcolor='#FFFAF0' cellspacing='0px' style='border-collapse:collapse' border='1' >
					<%while(rs_Delay.next()){ %>
					<tr  bordercolor='#DEDEDE'>
						<td width="100px" align="center" height="30px"><strong><font face="Verdana" size="2"><%=rs_Delay.getString("Product") %></font></strong></td>
						<td width="180px" align="center"><font face="Verdana" size="2"><%=rs_Delay.getString("Dev. Model Name") %></font></td>
						<td width="100px" align="center"><font face="Verdana" size="2"><%=rs_Delay.getString("Milestone") %></font></td>
						
						<%
							DateFormat fmt=new SimpleDateFormat("yyyy/MM/dd");
							Date dt=new Date();
							String current=fmt.format(dt); 
							String MiltStone1=rs_Delay.getString("Milestone").toString();
							
							if(MiltStone1.equals("PVR")){
								//System.out.println("-----------------------------Milestone-------------------"+MiltStone1);
								String Month=rs_Delay.getString("PVR Plan Date").substring(5,7);
								String Year=rs_Delay.getString("PVR Plan Date").substring(0,4);
								String Day=rs_Delay.getString("PVR Plan Date").substring(8,10);
								
								long a=((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(Month+'/'+Day+'/'+Year)))/86400000;
	
						 %>
						<td width="100px" align="center"><font face="Verdana" size="2"><%=a%></font></td>
						<%}
					
						else if(MiltStone1.equals("PRA")){
								String Month=rs_Delay.getString("PRA Plan Date").substring(5,7);
								String Year=rs_Delay.getString("PRA Plan Date").substring(0,4);
								String Day=rs_Delay.getString("PRA Plan Date").substring(8,10);
								long b=((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(Month+'/'+Day+'/'+Year)))/86400000;
						%>
						<td width="100px" align="center"><%=b %></td>
						<%}
							else if(MiltStone1.equals("SRA")){
									String Month=rs_Delay.getString("SRA Plan Date").substring(5,7);
									String Year=rs_Delay.getString("SRA Plan Date").substring(0,4);
									String Day=rs_Delay.getString("SRA Plan Date").substring(8,10);
									
									long b=((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(Month+'/'+Day+'/'+Year)))/86400000;
						%>
						<td width="100px" align="center"><%=b %></td>
						<%
								}
						} %>
					</tr>
				</table>				
			</div>			
		</td>
		
	</tr>
</table>
	<br/>
	<!--  
	<div style="background-color:#2D75DB;">
	<br/>
		<center>	
			<p>
			<font color="#ffffff">Copyright &copy;. </font><font color="red">2016</font> <font color="#ffffff">All rights reserved. Design from</font> 
			<a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72" target="_blank" title="Free Templates">TSDR S/W Group</a>
			</p>
		</center>																																																													<div class="inner_copy"><a href="http://www.beautifullife.info/"></a><a href="http://www.grungemagazine.com/"></a></div>
	</div>
	-->
	<!-- <div class="footer"> 
 		<table>
 		<tr>
 			<td  colspan="3" bgcolor="#2D75DB" width="2000px" height="20px">
 			
			<center>
			<br/>
				Project Analysis System Copyright &copy;. 2016 All rights reserved. Design from <a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72" target="_blank" title="Free Templates">TSDR S/W Group  &nbsp;</a>
			</center>
			<br/>			
		</tr>
		</table>
		 </div> -->
  </body>
</html>
