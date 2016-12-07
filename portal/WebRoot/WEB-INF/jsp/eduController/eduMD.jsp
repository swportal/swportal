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
		$(function(){
			$.getJSON("/portal/edu/getTrainee?rn="+Math.random(),function(jsondata){
			var data = [
			        	{name : jsondata[0].contents, value:jsondata[0].trainerEvaluation,color:'#a5c2d5'},
			        	{name : jsondata[1].contents, value:jsondata[1].trainerEvaluation,color:'#cbab4f'},
			        	{name : jsondata[2].contents, value:jsondata[2].trainerEvaluation,color:'#76a871'},
			        	{name : jsondata[3].contents, value:jsondata[3].trainerEvaluation,color:'#9f7961'},
			        	{name : jsondata[4].contents, value:jsondata[4].trainerEvaluation,color:'#a56f8f'},
			        	//{name : 'Other',value : 50,color:'#6f83a5'}
		        	];
        	
			new iChart.Bar2D({
				title : {
					text:'Trainee Evaluation (Top 5) ',
					fontsize:12,
					color:'#333333',
					offsetx:-80,
					offsety:-8,
				},
				render : 'eduTrainee',
				data: data,
				
				//showpercent:false,
				width : 1000,
				height : 220,
				coordinate:{
					width:400,
					axis:{
						width:0,
						//color:'#ffffff'
						
					},

					scale:[{
						 position:'bottom',	
						 start_scale:80,
						 end_scale:100,
						 scale_space:5,
						 listeners:{
							parseText:function(t,x,y){
								return {text:t}
							}
						}
					}]
				},
				label:{
						color:'#000000',
						font:'Arial',
						//fontsize:12
						},
				
				border:{
					color:'#ffffff'
				},
				

			}).draw();
		});
	});

		</script>
	</head>



	<body> 
			<div id='eduTrainee'></div>
	</body>

</html>



