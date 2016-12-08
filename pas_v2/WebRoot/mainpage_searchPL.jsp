<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="net.nw.vo.*,net.nw.dao.SearchProjectDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<html>
<head>
<title>S/W Management Dev Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
<link rel="stylesheet" type="text/css" href="css/mainpagestyle.css" />



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
	<% 
	String PL=request.getParameter("PL");
	if(PL==null||PL==""){%>
	<script type="text/javascript">
	alert("Please input search contents!");
	
	</script>
	<% }
	else{}
	SearchProjectDAO dao=new  SearchProjectDAO(); 
	List<ProjectOngoing> all = dao.findAll_PL(PL) ;

	
	Iterator<ProjectOngoing> iter1 = all.iterator();
	Iterator<ProjectOngoing> iter = all.iterator();
	String UpdateTime;
	 %>
	 
	<%UpdateTime="no data!!!";//chushihua %>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" height="13%">
	
		<tr Height="13%" bgcolor="lightblue">
			<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mainpage.jsp"><img src="images/(zhaoxi.net).png" alt=""  /></a></td>
		    <td width="300" align="right">
				<!-- <ul id="menu">
					
				</ul> -->
			   <div id="div1" style="border: 1px black; " ></div> 
			</td>
			<td >
				
			</td>
		</tr>
		
		<tr Height="800"  >
		<td width="15%"></td>
			<td width="70%" bgcolor="#FFFCEC"  valign="top" bordercolor="blue">
			<br/>
			<form action="mainpage_searchproject.jsp" name="projectname" id="projectsearch">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search Project: &nbsp;&nbsp;<input type="text" name="projectname" id="projectname">
				&nbsp;&nbsp;&nbsp;<input type="submit" value="search"></input>
			</form>
			<br/>
			
			
			<form action="mainpage_searchPL.jsp" name="searchPL" id="searchPL">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search PL/EM:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="PL" id="plname">
				&nbsp;&nbsp;&nbsp;<input type="submit" value="search"></input> 
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">(*Support fuzzy Search)</font>
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
				
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="blue">Data update time:&nbsp;&nbsp;&nbsp;</font><font style="font-weight:bold;font-style:italic;"><%=UpdateTime %></font>
			</form>
			
			<br/>
			<center>
				<table  bordercolor="blue">
					<tr>
					<td colspan="9" height="60px" bgcolor="lightblue"> <font  style="font-weight:bold; backcolor='#dcdcb8';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Projects ongoing:</font></td>
					<td colspan="2" align="center" bgcolor="lightblue"><a href="mainpage.jsp">Show all projects</a></td></tr>
					<tr  bgcolor="#dcdcb8">
						<td align="center" height="60px" width="300px"> Project Name</td>
						<td align="center" height="60px" width="190px"> Project Status</td>
						<td align="center" bgcolor="grey" width="150px"> PL</td>
						<td align="center" bgcolor="grey" width="150px"> S/W EM</td>
						<td align="center"  width="120px"> PVR Plan</td>
						<td align="center"  width="120px"> PVR Actual</td>
						<td align="center" width="120px"> PRA Plan</td>
						<td align="center" width="120px"> PRA Actual</td>
						<td align="center" width="100px"> Total</td>
						<td align="center" width="100px"> Close</td>
						<td align="center" width="100px"> Doing</td>
						
					</tr>
					<%
						while(iter.hasNext()){
						ProjectOngoing p = iter.next() ;
					%>
					<tr >
						<td align="left" height="30px"> <a href="searchcode.action?projectname=<%=p.getPjtName() %>&SWEM=<%=p.getSWEM() %>&PVRPlan=<%=p.getPVRPlanDate() %>&PVRActual=<%=p.getPVRActualDate() %>&PRAPlan=<%=p.getPRAPlanDate() %>&PRAActual=<%=p.getPRAActualDate() %>"><font color="blue"><%= p.getPjtName() %></font></a></td>
						<td align="center" width="60px"> <%= p.getPjtStatus() %> </td>
						<td align="left" width="60px"> <%= p.getDevPL() %></td>
						<td align="left" width="60px"> <%= p.getSWEM() %></td>
						<% 
						DateFormat fmt=new SimpleDateFormat("yyyy/MM/dd");
						Date dt=new Date();
						String current=fmt.format(dt); 
						
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
						System.out.println("a:"+a);
						%>
						
						<td align="center" width="100px" > <%= p.getPVRPlanDate() %></td>
						<td align="center"> --</td>
						<%}} %>
						
						
						<% 
						String ActualMonth=p.getPRAPlanDate().substring(5,7);
						String Actualyear=p.getPRAPlanDate().substring(0,4);
						String ActualDay=p.getPRAPlanDate().substring(8,10);
						long b=-((Date.parse(current.substring(5,7)+'/'+current.substring(8,10)+'/'+current.substring(0,4))-Date.parse(ActualMonth+'/'+ActualDay+'/'+Actualyear)))/86400000;
						%>
						<!-- <%= b%> -->
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
						<%}} %>						
						

						<td align="center"> <%= p.getPLMTotal() %></td>
						<td align="center"> <%= p.getPLMClosed()+p.getPLMResolved() %></td>
						<td align="center"> <%= p.getPLMOpened() %></td>
					</tr>
					
					<%}%>
					
					
					<!-- 
					<tr border="1">
						<td align="center" height="30"> <a href="index_pie.jsp"><font color="blue">project2</font></a></td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
					</tr>
					
					<tr border="1">
						<td align="center" height="30"> <a href="index_pie.jsp"><font color="blue">project3</font></a></td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
						<td align="center"> --</td>
					</tr>
					-->
					<tr>
						<td align="center" height="30"> <font color="blue">...</font></td>
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
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr> 
				</table>
				</center>
			</td>
			<td width="15%"></td>
		</tr>
		<tr bgcolor="lightgrey" Height="100">
			
			<td  colspan="3">
			<center>
				<ul id="navigation">
					<li><a href="#">Home</a>|</li>
					<li><a href="#">About us</a>|</li>
					
					
					<li><a href="#">F.A.Q.</a>|</li>
					<li><a href="#">Contacts</a></li>
				</ul>
				
				<p>Copyright &copy;. All rights reserved. Design from <a href="http://mosaic.sec.samsung.net/club/club.menu.bbs.list.screen?p_club_id=14115&p_menu_id=76&p_group_id=72

" target="_blank" title="Free Templates">TSDR S/W Group</a></p>																														</center>																																																													<div class="inner_copy"><a href="http://www.beautifullife.info/">beautiful</a><a href="http://www.grungemagazine.com/">grunge</a></div>
			</td>
			
		</tr>
	</table>
</body>
</html>
