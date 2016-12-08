<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>jquery实现饼状图效果</title>

<script type="text/javascript" src="js/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="js/js/highcharts.js" ></script>

</head>
<body>

<div style="width:850px;margin:40px auto 0 auto;">

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


</body>
</html>