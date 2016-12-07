<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>



<!DOCTYPE html>
<html>
 	<head>
   		<title>Material URL</title>
  		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
	    <style> 
		    hr{
		    	position:relative;
				top: 500px;
		    }
		    a{
				TEXT-DECORATION:none
			}
	    	#footer{
	    		 position:absolute;
	    		 bottom: 280px;
	    		 margin-left :800px;
	    	}
	    	.current-page  {
	    		font-size:12px;
	 			font-color: #004779;
	    	}
	    	.page-num  {
	    		font-size:12px;
	 			font-color: #004779;
	    	}
	    	input[type=text]::-ms-clear{
				display: none;
				
			}
			input::-webkit-search-cancel-button{
				display: none;
			}  
			input.t {
				border:1px solid #fff;
				background:#fff; 			
	 			padding-left:5px; 
	 			height:30px; 
	 			line-height:30px;
	 			/*font-size:16px;*/
	 			/*font-color: #004779;*/
	 			
	 		} 
			input.s {
				border:1px solid #369;
				background:#fff; 
				padding-left:5px;
		 		height:30px; 
		 		line-height:30px
	 		} 
	 		#MainArea form{
				padding-left: 0px;
			}
			
			.test_box {
					    width: 280px; 
					    min-height: 20px; 
					    max-height: 300px;
					    
					    margin-left: auto; 
					    margin-right: auto; 
					    padding: 3px; 
					    outline: 0; 
					    border: 0px solid #a0b3d6; 
					    font-size: 12px; 
					    word-wrap: break-word;
					    overflow-x: hidden;
					    overflow-y: hidden;
					    _overflow-y: visible;
			}
			
			
			.textPlace{ position:relative; top:-5px; /*left:5px; right:5px;bottom:5px*/} 
		</style>
			
		<style type="text/css">
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
    
		
	</head>  
  	
  	<body >
  	<form action="/portal/edu/updateUrl" onsubmit="window.opener=null;window.close();">
	 	<font size="2"  color="#004779"> Change URL To:</font><br/> 
<%--	 	 <input type="hidden" name="id" id="id" value="${id }">--%>
<%--	 	 <input type="hidden" name="item" id="item" value="${item }">--%>
	 	 <input type="text" name="value" id="value" value="${value }" style="color:#95a5a6; padding-left:5px;border-radius:5px;  width:700px; height:28px; vertical-align:middle;">
	 	 <input type="submit"   value="Save" style="color:#2c3e50; font-size:12px;font-weight:bold; border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>
    </form>

  </body>
</html>
