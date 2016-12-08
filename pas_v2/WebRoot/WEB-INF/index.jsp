<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jQuery HTML5</title>
<link href="css/style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
</head>
<body>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
body{background:#fff;color:#333;font-family:"Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;font-size:0.9em;}
#container{width:900px;margin:50px auto;}
#chart, #chartData{border:1px solid #333;background:#ebedf2 url("images/gradient.png") repeat-x 0 0;}
#chart{display:block;margin:0 0 50px 0;float:left;cursor:pointer;}
#chartData{width:200px;margin:0 40px 0 0;float:right;border-collapse:collapse;box-shadow:0 0 1em rgba(0, 0, 0, 0.5);-moz-box-shadow:0 0 1em rgba(0, 0, 0, 0.5);-webkit-box-shadow:0 0 1em rgba(0, 0, 0, 0.5);background-position:0 -100px;}
#chartData th, #chartData td{padding:0.5em;border:1px dotted #666;text-align:left;}
#chartData th{border-bottom:2px solid #333;text-transform:uppercase;}
#chartData td{cursor:pointer;}
#chartData td.highlight{background:#e8e8e8;}
#chartData tr:hover td{background:#f0f0f0;}
</style>

<script src="js/jquery.min.js"></script>
<!--[if IE]>
<script src="js/excanvas.js"></script>
<![endif]-->

<script type="text/javascript" src="js/pieChart.js"></script>
<div style="text-align:center;clear:both;">
<script src="/gg_bd_ad_720x90.js" type="text/javascript"></script>
<script src="/follow.js" type="text/javascript"></script>
</div>
<div id="container">
	
		<canvas id="chart" width="500" height="440"></canvas>
		<table id="chartData">
			<tr>
				<th>xuanxiang</th><th>bili</th>
			</tr>
			<tr style="color:#0DA068">
				<td>jquery</td><td>862.12</td>
			</tr>
			<tr style="color:#194E9C">
				<td>1</td><td>100</td>
			</tr>
			<tr style="color:#ED9C13">
				<td>2</td><td>712.49</td>
			</tr>
			<tr style="color:#ED5713">
				<td>3</td><td>3236.27</td>
			</tr>
			<tr style="color:#057249">
				<td>4</td><td>6122.06</td>
			</tr>
			<tr style="color:#5F91DC">
				<td>html5</td><td>128.11</td>
			</tr>
			<tr style="color:#F88E5D">
				<td>6</td><td>245.55</td>
			</tr>
		</table>
	</div>
</body>
</html>