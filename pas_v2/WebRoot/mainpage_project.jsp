<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="net.nw.vo.*,net.nw.dao.SearchProjectDAO"%>
<%@ page import="net.nw.dao.DefactAllDAO"%>
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<title>S/W Management Dev Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />

<script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="ichart/ichart.1.2.min.js"></script>
<script src="jquery.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
$(".radioItem").change(function() {
var $selectedvalue = $("input[name='status']:checked").val();
// alert($selectedvalue);
if ($selectedvalue == 0) {
//alert('0');
window.location.href="mainpage.jsp?onloadnumber=0";
} else if ($selectedvalue == 1) {
//alert('1');
window.location.href="mainpage.jsp?onloadnumber=1&status=Normal in pro";
}
 else if ($selectedvalue == 2) {
 //alert('2');
window.location.href="mainpage.jsp?onloadnumber=2&status=Delay";
}
 else if ($selectedvalue == 3) {
//alert('3');
window.location.href="mainpage.jsp?onloadnumber=3&status=Compl";
}
});
});
</script>

 
<script type="text/javascript">
	function init()
	{
		var onloadnumber=<%=request.getParameter("onloadnumber")%>;
		//alert(onloadnumber);
		if(onloadnumber=="1")
		document.getElementById("status1").checked="checked";
		if(onloadnumber=="2")
		document.getElementById("status2").checked="checked";
		if(onloadnumber=="3")
		document.getElementById("status3").checked="checked";
		if(onloadnumber=="0")
		document.getElementById("status0").checked="checked";
	}
</script> 


<script language =javascript >
var curIndex=0;
//时间间隔(单位毫秒)，每秒钟显示一张，数组共有5张图片放在Photos文件夹下。
var timeInterval=2000;
var arr=new Array();
arr[0]="images/monkey.jpg";
arr[1]="images/houniandaji.jpg";
arr[2]="images/avdertisement1.jpg";


setInterval(changeImg,timeInterval);
function changeImg()
{
    var obj=document.getElementById("obj");
    if (curIndex==arr.length-1) 
    {
        curIndex=0;
    }
    else
    {
        curIndex+=1;
    }
    obj.src=arr[curIndex];
}
</script>

<script type="text/javascript">

function currenttime()
{
	var now=new Date();
	var year=now.getFullYear();
	var month=now.getMonth()+1;
	var day=now.getDate();
	var time=year+"/"+month+"/"+day
	return time;
}

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

<body onLoad="init()" >
	<% 
	
	String projectname=request.getParameter("projectname");
	String status= request.getParameter("status");
	//String onloadnumber= request.getParameter("onloadnumber");
	SearchProjectDAO dao=new  SearchProjectDAO(); 
	List<ProjectOngoing> all=null;
	if(projectname!=""){
		all=dao.findAll(projectname);
	}
	else{
	%>
	<script type="text/javascript">
	alert("Please input search contents! -->projectname?");
	
	</script>
	<% 
	all=dao.findAll();}
	if(status!=null){
		all = dao.findAll_status(status);
		
	}
	
	Iterator<ProjectOngoing> iter1 = all.iterator();
	Iterator<ProjectOngoing> iter = all.iterator();
	
	String UpdateTime;
	
	UpdateTime="no data!!";
	
	%>
	<table width="100%" cellpadding="0" cellspacing="0" border="0"  >
	<tr  bgcolor="lightblue" height="3px"><td width="300px" colspan="6"> &nbsp;&nbsp; </td></tr>
		<tr  bgcolor="lightblue" height="20px">
			<td width="8%" height="20px"></td>
			
			
			<td width="2%" height="20px"></td>
			<td width="22%" ><br><a href="mainpage.jsp"><img src="images/(zhaoxi.net).png"   /></a><br><br/></td>
			<td width="24%" align="left" valign="middle"><div id="div1" style="border: 1px black; " ></div></td>
			<td width="36%" height="20px" align="right">
			   <img id="obj" src="images/houniandaji.jpg"   />
			</td> 
			<td width="80%" height="20px"></td>
		    
				
			
			
		</tr>
		<tr  bgcolor="lightblue" height="3px"><td width="300px" colspan="6"> &nbsp;&nbsp; </td></tr>
		</table>
		<table>
		</table>
	
		<table>
		<tr   >
		
			<td width="100%"    bordercolor="#ff0080" >
			<br/>
			<form action="mainpage_project.jsp" name="projectname" id="projectsearch">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search Project:&nbsp;&nbsp;<input type="text" name="projectname" id="projectname">
				&nbsp;&nbsp;&nbsp;<input type="submit" value="search"></input>
			</form>
			</td>
			
			</tr>
			<tr>
			
			
			<td width="100%"    bordercolor="blue" >
			
			<br>
			<form action="mainpage_PL.jsp" name="searchPL" id="searchPL">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search PL/EM:&nbsp;&nbsp;&nbsp;<input type="text" name="PL" id="plname">
				&nbsp;&nbsp;&nbsp;<input type="submit" value="search"></input> 
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<font color="red">(*Support fuzzy Search)</font>
				<%
				while(iter1.hasNext()){
					ProjectOngoing p1 = iter1.next() ;
					UpdateTime=p1.getUpdateTime();
				
				%>
				
			<%} %>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="blue">Data update time:&nbsp;&nbsp;&nbsp;</font><font style="font-weight:bold;font-style:italic;"><%=UpdateTime %></font>
			</form>
			</td>
			
			</tr>
			
			</table>
			<% 
			if(UpdateTime=="no data!!"){%>
			<script type="text/javascript">
			alert("no such data");
			</script>
			<% 
			}%>
			<br/>
			<center>
				<table  bordercolor="#ff0080" bgColor="#f2f0d0">
					<tr>
					<td colspan="9" height="60px" bgcolor="lightgreen">
						<font  style="font-weight:bold; backcolor='#dcdcb8';">&nbsp;&nbsp;&nbsp;Select Projects Status:&nbsp;&nbsp;&nbsp;</font>
						
						<input type="radio" class="radioItem" name="status" id="status0" value="0" checked="checked"  /><font style="font-weight:bold;">All</font>&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" class="radioItem" name="status" id="status1" value="1" /><font style="font-weight:bold;">Normal in progress</font>
						<input type="radio" class="radioItem" name="status" id="status2" value="2" /><font style="font-weight:bold;">Delay in progress</font>
						<input type="radio" class="radioItem" name="status" id="status3" value="3" /><font style="font-weight:bold;">Normal Complete</font>
					</td>
					
					
					 
					<td colspan="2" bgcolor="lightgreen" align="center"> <a href="mainpage.jsp"><font style="font-weight:bold;">Show all projects</font></a></td>
					</tr>
					<tr  bgcolor="lightgreen">
						<td align="center" height="60px" width="300px"> <font style="font-weight:bold;">Project Name</font></td>
						<td align="center" height="60px" width="190px"> <font style="font-weight:bold;">Project Status</font></td>
						<td align="center" bgcolor="grey" width="150px"> <font style="font-weight:bold;">PL</font></td>
						<td align="center" bgcolor="grey" width="150px"> <font style="font-weight:bold;">S/W EM</font></td>
						<td align="center"  width="120px"> <font style="font-weight:bold;">PVR Plan</font></td>
						<td align="center"  width="120px"> <font style="font-weight:bold;">PVR Actual</font></td>
						<td align="center" width="120px"> <font style="font-weight:bold;">PRA Plan</font></td>
						<td align="center" width="120px"> <font style="font-weight:bold;">PRA Actual</font></td>
						<td align="center" width="100px"> <font style="font-weight:bold;">Total</font></td>
						<td align="center" width="100px"> <font style="font-weight:bold;">Close</font></td>
						<td align="center" width="100px"> <font style="font-weight:bold;">Doing</font></td>
						
					</tr>
					<%	
						int count=0;
						while(iter.hasNext()){
						count++;
						ProjectOngoing p = iter.next() ;
						if(count%2==0){
					%>
					<tr bgcolor="white">
					<%System.out.println("RRRRRRRRRRR"+p.getPLMTotal());
					if(p.getPLMTotal()!=0){ %>
						<td align="left" height="30px"> <a href="searchcode.action?projectname=<%=p.getPjtName()%>&SWEM=<%=p.getSWEM()%>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%=p.getPRAActualDate() %>"><font color="blue"><%= p.getPjtName() %></font></a></td>
					<% } else {%>
						<td align="left" height="30px"> <font color="blue"><%= p.getPjtName() %></font></td>
					<%} %>
						<td align="center" width="60px"> <%= p.getPjtStatus() %> </td>
						<td align="left" width="60px"> <%= p.getDevPL() %></td>
						<td align="left" width="60px"> <%= p.getSWEM() %></td>
						<%
							DateFormat fmt=new SimpleDateFormat("yyyy/MM/dd");
							Date dt=new Date();
							String current=fmt.format(dt); 
						 %>
						<% if(p.getPVRPlanDate()!=null ){
						System.out.println("p.getPVRPlanDate()................................."+p.getPVRPlanDate());
						
						String PlanMonth=p.getPVRPlanDate().substring(5,7);
						String Planyear=p.getPVRPlanDate().substring(0,4);
						String PlanDay=p.getPVRPlanDate().substring(8,10);
						
						long a=-((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(PlanMonth+'/'+PlanDay+'/'+Planyear)))/86400000;
						%>
						
						<% if(p.getPVRActualDate()!=null){
						System.out.println("p.getPVRActualDate():"+p.getPVRActualDate());
						if(Integer.parseInt((p.getPVRActualDate().substring(0,4)+p.getPVRActualDate().substring(5,7)+p.getPVRActualDate().substring(8,10)))>Integer.parseInt((p.getPVRPlanDate().substring(0,4)+p.getPVRPlanDate().substring(5,7))+p.getPVRPlanDate().substring(8,10))){ %>
						
						<td align="center" width="100px" bGcolor="red"> <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="red"> <%= p.getPVRActualDate() %></td>
						<%}else {%>
						<td align="center" width="100px" > <%= p.getPVRPlanDate() %></td>
						<td align="center"> <%= p.getPVRActualDate() %></td>
						<%}}else{ 
						if(a<0){
						
						%>
						<td align="center" width="100px" bGcolor="red"> <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="red"> ---</td>
						<%}else if(a<3) {%>
						<td align="center" width="100px" bGcolor="yellow" > <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="yellow"> ---</td>
						<%}else{ 
						//System.out.println("a:"+a);
						%>
						
						<td align="center" width="100px" > <%= p.getPVRPlanDate() %></td>
						<td align="center"> --</td>
						<%}}}else{%>
						
						<td align="center" width="100px" > --</td>
						<td align="center"> --</td>
						<% 
						
						}%>
						
						
						<% 
						if(p.getPRAPlanDate()!=null ){
						String ActualMonth=p.getPRAPlanDate().substring(5,7);
						String Actualyear=p.getPRAPlanDate().substring(0,4);
						String ActualDay=p.getPRAPlanDate().substring(8,10);
						long b=-((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(ActualMonth+'/'+ActualDay+'/'+Actualyear)))/86400000;
						%>
						
						<% if(p.getPRAActualDate()!=null){
						
						if(Integer.parseInt((p.getPRAActualDate().substring(0,4)+p.getPRAActualDate().substring(5,7)+p.getPRAActualDate().substring(8,10)))>Integer.parseInt((p.getPRAPlanDate().substring(0,4)+p.getPRAPlanDate().substring(5,7))+p.getPRAPlanDate().substring(8,10))){ %>
						
						<td align="center" width="100px" bGcolor="red"> <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="red"> <%= p.getPRAActualDate() %></td>
						<%}else {%>
						<td align="center" width="100px" > <%= p.getPRAPlanDate() %></td>
						<td align="center"> <%= p.getPRAActualDate() %></td>
						<%}}else{ 
						if(b<0){
						
						%>
						<td align="center" width="100px" bGcolor="red"> <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="red"> ---</td>
						<%}else if(b<3) {%>
						<td align="center" width="100px" bGcolor="yellow" > <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="yellow"> ---</td>
						<%}else{ %>
						
						<td align="center" width="100px" > <%= p.getPRAPlanDate() %></td>
						<td align="center"> --</td>
						<%}}}else{ %>
						<td align="center" width="100px" > --</td>
						<td align="center"> --</td>
						<%} %>
												
						
						<%if(p.getPLMTotal()!=0){ %>
						<td align="center">  <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMTotal() %></font></a> </td>
						<td align="center"> <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMClosed()+p.getPLMResolved() %></font></a>  </td>
						<td align="center">  <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMOpened() %></font></a> </td>
						<% }else{%>
						<td align="center">  <font color="blue"><%= p.getPLMTotal() %></font> </td>
						<td align="center"> <font color="blue"><%= p.getPLMClosed()+p.getPLMResolved() %></font>  </td>
						<td align="center">  <font color="blue"><%= p.getPLMOpened() %></font> </td>
						
						<% }%>
					</tr>
					
					<%}else if(count%2==1){%>
					
					<tr >
						<%System.out.println("ZZZZZZZZZ"+p.getPLMTotal());
						if(p.getPLMTotal()!=0){ %>
						<td align="left" height="30px"> <a href="searchcode.action?projectname=<%=p.getPjtName()%>&SWEM=<%=p.getSWEM()%>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%=p.getPRAActualDate() %>"><font color="blue"><%= p.getPjtName() %></font></a></td>
					<% } else {%>
						<td align="left" height="30px"> <font color="blue"><%= p.getPjtName() %></font></td>
					<%} %><td align="center" width="60px"> <%= p.getPjtStatus() %> </td>
						<td align="left" width="60px"> <%= p.getDevPL() %></td>
						<td align="left" width="60px"> <%= p.getSWEM() %></td>
						<% 
						DateFormat fmt=new SimpleDateFormat("yyyy/MM/dd");
						Date dt=new Date();
						String current=fmt.format(dt); %>
						<% if(p.getPVRPlanDate()!=null ){
						String PlanMonth=p.getPVRPlanDate().substring(5,7);
						String Planyear=p.getPVRPlanDate().substring(0,4);
						String PlanDay=p.getPVRPlanDate().substring(8,10);
						
						long a=-((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(PlanMonth+'/'+PlanDay+'/'+Planyear)))/86400000;
						%>
						
						<% if(p.getPVRActualDate()!=null){
						System.out.println("p.getPVRActualDate():"+p.getPVRActualDate());
						if(Integer.parseInt((p.getPVRActualDate().substring(0,4)+p.getPVRActualDate().substring(5,7)+p.getPVRActualDate().substring(8,10)))>Integer.parseInt((p.getPVRPlanDate().substring(0,4)+p.getPVRPlanDate().substring(5,7))+p.getPVRPlanDate().substring(8,10))){ %>
						
						<td align="center" width="100px" bGcolor="red"> <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="red"> <%= p.getPVRActualDate() %></td>
						<%}else {%>
						<td align="center" width="100px" > <%= p.getPVRPlanDate() %></td>
						<td align="center"> <%= p.getPVRActualDate() %></td>
						<%}}else{ 
						if(a<0){
						
						%>
						<td align="center" width="100px" bGcolor="red"> <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="red"> ---</td>
						<%}else if(a<3) {%>
						<td align="center" width="100px" bGcolor="yellow" > <%= p.getPVRPlanDate() %></td>
						<td align="center" bGcolor="yellow"> ---</td>
						<%}else{ 
						//System.out.println("a:"+a);
						%>
						
						<td align="center" width="100px" > <%= p.getPVRPlanDate() %></td>
						<td align="center"> --</td>
						<%}}}else{%>
						
						<td align="center" width="100px" > --</td>
						<td align="center"> --</td>
						<% 
						
						}%>
						
						<% 
						if(p.getPRAPlanDate()!=null ){
						String ActualMonth=p.getPRAPlanDate().substring(5,7);
						String Actualyear=p.getPRAPlanDate().substring(0,4);
						String ActualDay=p.getPRAPlanDate().substring(8,10);
						long b=-((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(ActualMonth+'/'+ActualDay+'/'+Actualyear)))/86400000;
						%>
						
						<% if(p.getPRAActualDate()!=null){
						if(Integer.parseInt((p.getPRAActualDate().substring(0,4)+p.getPRAActualDate().substring(5,7)+p.getPRAActualDate().substring(8,10)))>Integer.parseInt((p.getPRAPlanDate().substring(0,4)+p.getPRAPlanDate().substring(5,7))+p.getPRAPlanDate().substring(8,10))){ %>
						
						<td align="center" width="100px" bGcolor="red"> <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="red"> <%= p.getPRAActualDate() %></td>
						<%}else {%>
						<td align="center" width="100px" > <%= p.getPRAPlanDate() %></td>
						<td align="center"> <%= p.getPRAActualDate() %></td>
						<%}}
						else{ 
						if(b<0){
						
						%>
						<td align="center" width="100px" bGcolor="red"> <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="red"> ---</td>
						<%}else if(b<3) {%>
						<td align="center" width="100px" bGcolor="yellow" > <%= p.getPRAPlanDate() %></td>
						<td align="center" bGcolor="yellow"> ---</td>
						<%}else{ %>
						
						<td align="center" width="100px" > <%= p.getPRAPlanDate() %></td>
						<td align="center"> --</td>
						<%}}}else{ %>						
						<td align="center" width="100px" > --</td>
						<td align="center"> --</td>
						<%} %>
						
						<%if(p.getPLMTotal()!=0){ %>
						<td align="center">  <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMTotal() %></font></a> </td>
						<td align="center"> <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMClosed()+p.getPLMResolved() %></font></a>  </td>
						<td align="center">  <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%= p.getPRAActualDate() %>"><font color="blue"><%= p.getPLMOpened() %></font></a> </td>
						<% }else{%>
						<td align="center">  <font color="blue"><%= p.getPLMTotal() %></font> </td>
						<td align="center"> <font color="blue"><%= p.getPLMClosed()+p.getPLMResolved() %></font>  </td>
						<td align="center">  <font color="blue"><%= p.getPLMOpened() %></font> </td>
						
						<% }%></tr>
					<% }}%>
					
					
					
					<tr>
						<td align="left" height="30"> <font color="blue">...</font></td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
						<td align="center"> </td>
					</tr>
				
					
				</table>
				</center>
			
		<table>
		<tr bgcolor="white" >
		<td width="12.5%"></td>
						<td width="75%" align="center"> 
							<!-- <script type="text/javascript" src="js_1/jquery-1.4.2.min.js" ></script>
							<script type="text/javascript" src="js_1/highcharts.js" ></script>
							<div style="width:1600px;margin:60px auto 0 auto;">

								<div id="chart_combo" class="chart_combo"></div>

							</div>

								<script type="text/javascript">
								var chart;
								$(function() {
								    chart = new Highcharts.Chart({
								        chart: {
								            renderTo: 'chart_combo' 
								        },
								
								        title: {  
								            text: ' 2016 Monthly Num.of PVR Project'
								        },
								
								        xAxis: { //x轴
								            categories: ['Jan', 'Feb','Mar', 'Apr','may', 'Jun','Jul', 'Aug','Sep', 'Oct','Nov', 'Dec'],  
											labels:{y:18}  //x轴标签位置：距X轴下方18像素
								        },
										yAxis: {  //y轴
								            title: {text: '课题个数'}, //y轴标题
											lineWidth: 2 //基线宽度
								        },
								        tooltip: {
								            formatter: function() { //格式化鼠标滑向图表数据点时显示的提示框
								                var s;
								                if (this.point.name) { // 饼状图
								                    s = '<b>' + this.point.name + '</b>: <br>' + this.y+ '个(' + twoDecimal(this.percentage) + '%)';
								                } else {
								                    s = '' + this.x + ': ' + this.y + '个';
								                }
								                return s;
								            }
								        },
								        labels: { //图表标签
								            items: [{
								                html: 'Project num of PVR',
								                style: {
								                    left: '48px',
								                    top: '8px'
								                }
								            }]
								        },
										exporting: {
											enabled: false  //设置导出按钮不可用
										},
										credits: { 
											text: 'www.17sucai.com',
											href: 'http://www.17sucai.com'
										},
								        series: [{ //数据列
								            type: 'column',
								            name: 'DTV',
								            data: [8.4, 9.8, 11.4, 15.6, 15.6, 15.6, 15.6, 15.6, 15.6, 15.6, 15.6, 15.6]
								        },
								        {
								            type: 'column',
								            name: 'Monitor',
								            data: [9.2, 7.8, 10.2, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8]
								        },
								        {
								            type: 'column',
								            name: 'MFM',
								            data: [6.5, 9.4, 13.2, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6]
								        },
								        {
								            type: 'column',
								            name: 'Hotel',
								            data: [6.5, 9.4, 13.2, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6, 18.6]
								        },
								        {
								            type: 'spline',
								            name: '总数',
								            data: [30, 9, 11.6, 17, 17, 17, 17, 17, 17, 17, 17, 40]
								        },
								        {
								            type: 'pie', //饼状图
								            name: 'Sum of PVR Project',
								            data: [{
								                name: 'DTV',
								                y: 45.2,
								                color: '#4572A7' 
								            },
								            {
								                name: 'MFM',
								                y: 44,
								                color: '#AA4643' 
								            },
								             {
								                name: 'Monitor',
								                y: 44,
								                color: '#AA4643' 
								            },
								            {
								                name: 'Hotel',
								                y: 47.7,
								                color: '#89A54E' 
								            }],
								            center: [100, 80],  //饼状图坐标
								            size: 100,  //饼状图直径大小
								            dataLabels: {
								                enabled: false  //不显示饼状图数据标签
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
								</script> -->
						</td>
					<td width="12.5%"></td>
					</tr>
					<tr>
					<td colspan="3" align="center">
						<br/>
						<font style="font-weight:bold;">2015~2016 Monthly Number of PRA model</font>
						<br/>
					</td>
					</tr>
					<tr>
					<td width="12.5%"></td>
					<td>
					
					
						<%
							DefactAllDAO ddao=new DefactAllDAO();
						%>
						  
						  
						  
						  
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
						<div id='canvasDiv'></div>  
					</td>
					<td width="12.5%"></td>
					</tr>
					
		<tr bgcolor="lightgrey" Height="100px">
			
			<td  colspan="3" bgcolor="lightblue">
			<center>
				<ul id="navigation">
					<li><a href="#">Home</a>|</li>
					<li><a href="#">About us</a>|</li>
					
					
					<li><a href="#">F.A.Q.</a>|</li>
					<li><a href="#">Contacts</a></li>
				</ul>
				
				<p>Copyright &copy;. 2016 All rights reserved. Design from <a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72

" target="_blank" title="Free Templates">TSDR S/W Group SE Lab &nbsp;(Q&A)</a></p>																														</center>																																																													<div class="inner_copy"><a href="http://www.beautifullife.info/">beautiful</a><a href="http://www.grungemagazine.com/">grunge</a></div>
			</td>
			
		</tr>
	</table>
	
</body>
</html>
