<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

<head>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 

 
<style>
 
body{
 
font-size:12px;
 
}
 
td{
 
font-size:12px;
 
}
 
</style>
 
</head>
 
<script src="js/histogram.js"></script>
 
<body>
 
<table align="center">
 
<tr><td height="30" align="center" style="font-size:16px;font-weight:bold;color:#fc3a00;">发帖量统计</td></tr>
 
   <tr>
 
     <td ><script language="javascript">
 
var ar,space,width=500,height=400;
 
ar = new Array();
 
ar[0]="攒积麦基|245";   
 
ar[1]="硬件讨论|120";
 
ar[2]="笔记本专区|852";
 
ar[3]="数码产品|424";
 
ar[4]="操作系统|412";
 
ar[5]="软件下载|751";
 
ar[6]="影视下载|123";
 
space=20;
 
histogram(ar,space,width,height);
 

</script></td>
 
   </tr>
 
</table>
 

</body>
 
</html>