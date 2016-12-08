<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="net.nw.vo.*,net.nw.dao.ModelcodesDAO"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Model别问题点数状态图</title>
		<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />

		<script type="text/javascript" src="js/zxjs/jquery.js"></script>
		<script type="text/javascript" src="js/piechart/jsapi.js"></script>
		<script type="text/javascript" src="js/piechart/corechart.js"></script>
		<script type="text/javascript" src="js/piechart/jquery.gvChart-1.0.1.min.js"></script>
		<script type="text/javascript" src="js/piechart/jquery.ba-resize.min.js"></script>
		<!--<script type="text/javascript" src="js/js/jquery-1.4.2.min.js"></script>-->
		<script type="text/javascript" src="js/js/highcharts.js"></script>
		
		<!--<script type="text/javascript" src="js/piechart2/jquery.js"></script>
		<script type="text/javascript" src="js/piechart2/highcharts.js"></script>
		<script type="text/javascript" src="js/piechart2/exporting.js"></script>-->
		
		<!--<script type="text/javascript" src="js/zxjs/jQuery.js"></script>
		<script type="text/javascript" src="js/zxjs/jqplot.js"></script>-->
	<s:bean name="net.nw.vo.Modelcodes" var="cc"></s:bean>	
	<script type="text/javascript">
	function updateCode(){
		
		//<s:bean name="net.nw.action.ModelcodesAction" var="mca"></s:bean>
		//alert("2222222");
	}
	</script>



<script type="text/javascript">
	
	gvChartInit();
	$(document).ready(function() {
		$('#myTable5').gvChart( {
			chartType : 'PieChart',
			gvSettings : {
				vAxis : {
					title : 'No of players'
				},
				hAxis : {
					title : 'Month'
				},
				width : 400,
				height : 350
			}
		});
	});
</script>

<script type="text/javascript">
	gvChartInit();
	$(document).ready(function() {
		$('#myTable6').gvChart( {
			chartType : 'PieChart',
			gvSettings : {
				vAxis : {
					title : 'No of players'
				},
				hAxis : {
					title : 'Month'
				},
				width : 400,
				height : 350
			}
		});
	});
</script>
<script type="text/javascript">
	gvChartInit();
	$(document).ready(function() {
		$('#myTable7').gvChart( {
			chartType : 'PieChart',
			gvSettings : {
				vAxis : {
					title : 'No of players'
				},
				hAxis : {
					title : 'Month'
				},
				width : 400,
				height : 350
			}
		});
	});
</script>

 <script type="text/javascript">
function showtime()
{
	var now=new Date();
	var year=now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
	var hours=now.getHours();
	var minutes=now.getMinutes();
	var seconds=now.getSeconds();
	//alert("566666");
	if(month<10)
	{month="0"+month;}

	if(day<10)
	{
		day="0"+day;
	}
	if(hours<10)
	{
		hours="0"+hour;
	}
	if(minutes<10)
	{
		minutes="0"+minutes;
	}
	//alert(minutes);
	if(seconds<10)
	{
		seconds="0"+seconds;
	}

	time=year+"/"+month+"/"+day +"   "+hours+':'+minutes+':'+seconds;
	var div1=document.getElementById('div1');
	div1.innerHTML="Current Time:  "+time;
	}

		function letstart()
		{taskId=setInterval(showtime,500);}
		window.onload=function(){letstart();}
		</script> 

</head>


<body>
		
	<%/*
		String projectname=request.getParameter("projectname");
		ModelcodesDAO mcd=new ModelcodesDAO();
		Map<Integer,String> map=mcd.getCodes(projectname);%>
		map=request.getParameter(mapcode);
		<% Set  set=map.entrySet();   

          Iterator   iterator=set.iterator();   

          while (iterator.hasNext()){   

            Map.Entry  mapentry = (Map.Entry) iterator.next();   

            System.out.println(mapentry.getkey()+"/"+ mapentry.getValue());   

          }   
*/
		
	%>		

<div style="background-color:lightblue;">
<br/>
	<table>
	<tr bgcolor="">
		<td align="left">
			<img src="images/(zhaoxi.net).png"/>
		</td>
		<td width="25px"></td>
		<td width="300px" align="center">
			<div id="div1"></div>
			<!-- Current Time：<s:property value="#request.SelectDate"/> -->
		</td>
		
		<td valign="middle">Model Code:
			<s:form name="modelForm" action="select" method="post" 
				theme="simple" cssStyle="backcolor:lightblue">
				<!--<s:bean name="net.nw.dao.ModelcodesDAO" var="c"></s:bean>-->
				
				<s:select name="projectid" id="mo"  multiple="true" list="#session.mapcode" headerKey="0" headerValue="--Please choose--" onchange="modelForm.submit()"></s:select>
					<br></br>
			</s:form>
		</td>
		<td width="50px"></td>
		<td width="150px" align="right">
				<font color="red" >Project Information：</font>
		</td>
			
		<td >
			<!-- <font color="red">Project Information:</font> -->
			<table border="1" >
			<tr bgcolor="#dcdcb8">
				<td width="200px" align="center">Project Name&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td align="center" width="100px">Model code</td>
				<td align="center" width="150px">S/W PL Name</td>
				<td colspan="2" align="center" width="150px">PVR </td>
				<td colspan="2" align="center" width="150px">PRA </td>
				
			</tr>
			<tr bgcolor="#dcdcb8">
				<td rowspan="2" align="center"  width="150px"><%= session.getAttribute("projectname_session") %></td>
				<td rowspan="2" align="center" >--------</td>
				<td rowspan="2" align="center" ><%= request.getParameter("PL") %></td>
				<td align="center">Plan</td>
				<td align="center">--------</td>
				<td align="center">Plan</td>
				<td align="center">--------</td>
				
			</tr>
			<tr bgcolor="#dcdcb8">
				<td align="center">Actual</td>
				<td align="center">--------</td>
				<td align="center">Actual</td>
				<td align="center">--------</td>
				
				
				
			</tr>
			
			</table>
		</td>
	</tr>	
	
</table>
	
</div>
<br />	
		
	
				
	
<hr/>											


<center>
						<table border="1"    style="border-collapse:collapse;">
						<tr>
							<td width="25%" align="center">
								
								&nbsp;&nbsp;&nbsp;
								<font color="red"><s:property
										value="#request.msg_codename"></s:property>
										
								</font>&nbsp;(Model)&nbsp; Open Close Resolve defects：
								<font color="blue"><s:property value="#request.Total" />
								</font>

								<table id='myTable5'>


									<thead>
										<tr>
											<th></th>
											<th>
												Resolved :
												<s:property value="#request.Resolved" />
											</th>
											<th>
												
												Opened :
												<s:property value="#request.Opened" />
											</th>
											
											
											<th>
											Closed :
												<s:property value="#request.Closed" />
											</th>
											<th>
											
											</th>



										</tr>
									</thead>
									<tbody>
										<tr>
											<th>
												<s:property value="#request.Total" />
											</th>
											<td>
												<s:property value="#request.Resolved" />
											</td>
											<td>
												<s:property value="#request.Opened" />
											</td>
											<td>
												<s:property value="#request.Closed" />
											</td>


										</tr>
									</tbody>
								</table>
								
							</td>
							<td width="25%" align="center">
							
								&nbsp;&nbsp;&nbsp;
								<font color="red"><s:property
										value="#request.msg_codename"></s:property>
								</font>&nbsp;(Model)&nbsp; Significance of defects：
								<font color="blue"><s:property value="#request.Total" />
								</font>

								<table id='myTable6'>
									<!--  <caption>
					<s:property value="#request.msg_codename"></s:property>&nbsp;(Model)&nbsp;问题点种类：<s:property value="#request.Total"/>
				</caption>
				-->
									<thead>
										<tr>
											<th></th>
											<th>
												Total B :
												<s:property value="#request.TotalB" />
											</th>
											<th>
											Total A :
												<s:property value="#request.TotalA" />
												
											</th>
											<th>
												Total C :
												<s:property value="#request.TotalC" />
											</th>
											<th>
												Total N :
												<s:property value="#request.TotalN" />
											</th>


										</tr>
									</thead>
									<tbody>
										<tr>
											<th>
												<s:property value="#request.Total" />
											</th>
											<td>
												<s:property value="#request.TotalB" />
											</td>
											<td>
												<s:property value="#request.TotalA" />
											</td>
											<td>
												<s:property value="#request.TotalC" />
											</td>

											<td>
												<s:property value="#request.TotalN" />
											</td>
											
										</tr>
									</tbody>
								</table>

							</td>
							<td width="25%" align="center">
								
								&nbsp;&nbsp;&nbsp;
								<font color="red"><s:property
										value="#request.msg_codename"></s:property>
										
								</font>&nbsp;(Model)&nbsp; SQA defects Open Resolved Closed：
								<font color="blue"><s:property value="#request.SQAPLMTotal" />
								</font>

								<table id='myTable7'>


									<thead>
										<tr>
											<th></th>
											<th>
												Resolved :
												<s:property value="#request.SQAPLMResolved" />
											</th>
											<th>
												Opened :
												<s:property value="#request.SQAPLMOpened" />
												
											</th>
											<th>
												Closed :
												<s:property value="#request.SQAPLMClosed" />
											</th>



										</tr>
									</thead>
									<tbody>
										<tr>
											<th>
												<s:property value="#request.SQAPLMTotal" />
											</th>
											<td>
												<s:property value="#request.SQAPLMResolved " />
											</td>
											<td>
												<s:property value="#request.SQAPLMOpened" />
											</td>
											<td>
												<s:property value="#request.SQAPLMClosed" />
											</td>


										</tr>
									</tbody>
								</table>
								
							</td>
							<td width="25%" align="center"></td>
						</tr>
<tr>
							  
<td>

 <div style="margin:40px auto 0 auto;">

	<div id="chart_combo" class="chart_combo"></div>

</div>

<script type="text/javascript">
var chart;

$(function() {
    chart = new Highcharts.Chart({
        chart: {
            renderTo: 'chart_combo' //关联页面元素div#id
        },

        title: {  //图表标题
            text: '<s:property value="#request.msg_codename"></s:property>'+  ' 课题 A B C 问题点解决状况统计图'
        },

        xAxis: { //x轴
            categories: ['A等级问题点', 'B等级问题点','C等级问题点', '其他问题点'],  //X轴类别
			labels:{y:18}  //x轴标签位置：距X轴下方18像素
        },
		yAxis: {  //y轴
            title: {text: '问题点数'}, //y轴标题
			lineWidth: 2 //基线宽度
        },
        tooltip: {
            formatter: function() { //格式化鼠标滑向图表数据点时显示的提示框
                var s;
                if (this.point.name) { // 饼状图
                    s = '<b>' + this.point.name + '</b>: <br>' + this.y+ this.point.name + twoDecimal(this.percentage) + '%)';
                } else {//柱状图
                    s = '' + this.x + ': ' + this.y + '个';
                }
                return s;
            }
        },
        labels: { //图表标签
            items: [{
                html: 'Opened，Resolved，Closed问题点对比',
                style: {
                    left: '48px',
                    top: '8px'
                }
            }]
        },
		exporting: {
			enabled: true  //设置导出按钮不可用
		},
		credits: { 
			text: 'TSDR SW Group',
			href: ''
		},
        series: [{ //数据列
            type: 'column',
            name: 'Opened',
            data: [(<s:property value="#request.OpenedA"/>), <s:property value="#request.OpenedB"/>, <s:property value="#request.OpenedC"/>, <s:property value="#request.OpenedN"/>]
        },
        {
            type: 'column',
            name: 'Resolved',
            data: [<s:property value="#request.ResolvedA"/>, <s:property value="#request.ResolvedB"/>, <s:property value="#request.ResolvedC"/>, <s:property value="#request.ResolvedN"/>]
        },
        {
            type: 'column',
            name: 'Closed',
            data: [<s:property value="#request.ClosedA"/>, <s:property value="#request.ClosedB"/>, <s:property value="#request.ClosedC"/>, <s:property value="#request.ClosedN"/>]
        },
        {
            type: 'spline',
            name: '平均值',
            data: [(<s:property value="#request.OpenedA"/>+<s:property value="#request.ResolvedA"/>+<s:property value="#request.ClosedA"/>)/3, (<s:property value="#request.OpenedB"/>+<s:property value="#request.ResolvedB"/>+<s:property value="#request.ClosedB"/>)/3, (<s:property value="#request.OpenedC"/>+<s:property value="#request.ResolvedC"/>+<s:property value="#request.ClosedC"/>)/3, (<s:property value="#request.OpenedN"/>+<s:property value="#request.ResolvedN"/>+<s:property value="#request.ClosedN"/>)/3]
        },
        {
            type: 'pie', //饼状图
            name: '问题点统计',
            data: [{
                name: 'Opened',
                y: <s:property value="#request.OpenedA"/>+<s:property value="#request.OpenedB"/>+<s:property value="#request.OpenedC"/>+<s:property value="#request.OpenedN"/>,
                color: '#4572A7' 
            },
            {
                name: 'Resolved',
                y: <s:property value="#request.ResolvedB"/>+<s:property value="#request.ResolvedB"/>+<s:property value="#request.ResolvedC"/>+<s:property value="#request.ResolvedN"/>,
                color: '#AA4643' 
            },
            {
                name: 'Closed',
                y: <s:property value="#request.ClosedA"/>+<s:property value="#request.ClosedB"/>+<s:property value="#request.ClosedC"/>+<s:property value="#request.ClosedN"/>,
                color: '#89A54E' 
            }],
            center: [100, 80],  //饼状图坐标
            size: 100,  //饼状图直径大小
            dataLabels: {
                enabled: true  //显示饼状图数据标签
            }
        }]
    });
});
//保留2位小数
function twoDecimal(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
        alert('错误的参数');
        return false;
    }
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}
</script>
 
</td>
	<td>
		<!--<script type="text/javascript" src="js/zxjs/jquery.js"></script>
		<script type="text/javascript" src="js/zxjs/jqplot.js"></script>-->
		<script type="text/javascript">
			$(document).ready(function() {
			var data = [[<s:property value="#request.Total_unclosed_0"/>,<s:property value="#request.Total_unclosed_1"/>,<s:property value="#request.Total_unclosed_2"/>,<s:property value="#request.Total_unclosed_3"/>,<s:property value="#request.Total_unclosed_4"/>,<s:property value="#request.Total_unclosed_5"/>,<s:property value="#request.Total_unclosed_6"/>],[<s:property value="#request.Total_Date_0"/>,<s:property value="#request.Total_Date_1"/>,<s:property value="#request.Total_Date_2"/>,<s:property value="#request.Total_Date_3"/>,<s:property value="#request.Total_Date_4"/>,<s:property value="#request.Total_Date_5"/>,<s:property value="#request.Total_Date_6"/>]];
			var data_max = <s:property value="#request.Total_Date_6"/>+20; //Y轴最大刻度
			var line_title = ["未解决问题点","已提问题点"]; //曲线名称
			var y_label = "问题点数"; //Y轴标题
			var x_label = "时间（天）"; //X轴标题
			var x = ["<s:property value="#request.SelectDate_0"/>","<s:property value="#request.SelectDate_1"/>","<s:property value="#request.SelectDate_2"/>","<s:property value="#request.SelectDate_3"/>","<s:property value="#request.SelectDate_4"/>","<s:property value="#request.SelectDate_5"/>","<s:property value="#request.SelectDate_6"/>"]; //定义X轴刻度值
			var y=[[0],[20],[40],[60]]
			var title = "问题点"; //统计图标标题
			j.jqplot.diagram.base("chart1", data, line_title, "<s:property value="#request.msg_codename"/>"+" 问题点解决", x, x_label, y_label, data_max, 1);
			j.jqplot.diagram.base("chart2", data, line_title, "<s:property value="#request.msg_codename"/>"+"问题点解决", x, x_label, y_label, data_max, 2);
		});
		</script>
		
		
		<div id="chart1"></div>
		<font color="red">注：日期为"*"表示当天无数据。</font>
		 
		<div id="chart2"></div>
		
	</td>
	<td>

		<!--<script type="text/javascript" src="js/zxjs/jQuery.js"></script>-->
		<script type="text/javascript" src="js/zxjs/jqplot.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
			var data = [[<s:property value="#request.SQAPLMTotalDelay"/>,<s:property value="#request.SQAPLMTotalDelay30"/>,<s:property value="#request.SQAPLMTotalDelay60"/>]];
			var data_max = 20; //Y轴最大刻度
			var line_title = ["Delay Defects"]; //曲线名称
			var y_label = "Num. of Delay Defects"; //Y轴标题
			var x_label = "Delay(day)"; //X轴标题
			var x = ["Delay 7 days","Delay 30days","Delay 60 days"]; //定义X轴刻度值
			var title = "问题点"; //统计图标标题
			//j.jqplot.diagram.base("chart11", data, line_title, "<s:property value="#request.msg_codename"/>"+"问题点解决", x, x_label, y_label, data_max, 1);
			j.jqplot.diagram.base("chart3", data, line_title, "<s:property value="#request.msg_codename"/>"+" Delay Defects", x, x_label, y_label, data_max, 2);
		});
		</script>
		
		<div id="chart3"></div>
		

	</td>
	<td></td>
</tr>

</table>
<div style="background-color:lightblue;"><center><br/><p>Copyright &copy;. All rights reserved. Design from <a href="http://mosaic.sec.samsung.net/club/club.main.index.screen?p_club_id=14115" target="_blank" title="Free Templates">TSDR S/W Group</a></p>																														</center>																																																													<div class="inner_copy"><a href="http://www.beautifullife.info/"></a><a href="http://www.grungemagazine.com/"></a></div>
			<br/></center></div>
</center>
</body>
</html>
