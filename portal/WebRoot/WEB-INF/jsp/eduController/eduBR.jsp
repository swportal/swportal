<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
 <%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>Portal-Training Management</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ichart/ichart.1.2.min.js"></script>	
		<link rel="shortcut icon" href="<%=request.getContextPath()%>/FlatUI/img/samsung6.ico">   <!-- 更改标题图标 -->
		<script type="text/javascript">
		var total = 0;
		$(function(){   
				$.getJSON("/portal/edu/getEduPart?rn="+Math.random(),function(jsondata){
					var data = [
					        	{name : 'Int.',value : jsondata[0].intCount,color:'#a5c2d5'},
					        	{name : 'Ext.',value : jsondata[0].extCount,color:'#a56f8f'}
				        	];
					
					var chart = new iChart.Pie2D({
						title : {
							text:'Trainning Category(Int./Ext.) ',
							fontsize:12,
						},
						offset_angle:-120,
						increment:3,
						radius:80,
						render : 'eduCategory',
						padding:'2 10',
						footnote:{
							color:'#e0e5e8',
							height:30,
							border:{
								enable:true,
								width:[2,0,0,0],
								color:'#343b3e'
							}
						},
						width : 400,
						height : 220,
						offsety:0,
						data:data,
						shadow:false,
						shadow_color:'#000000',
						shadow_blur:8,
						background_color : '#FFFFFF',
						showpercent:false,
						decimalsnum:0,
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
									return d.get('name')+"("+ d.get('value')+")";
								}
							}
						},
						border:{
							color:'#ffffff'
						}
					});		
					
					chart.bound(0);
				});
			});
		</script>
	</head>



	<body> 
		<div id='eduCategory'></div>
	</body>

</html>



