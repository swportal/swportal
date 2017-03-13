<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Open Defect List</title>
<style type="text/css">
 	a{
				TEXT-DECORATION:none;
	}
    #pagefix {
       		 position: fixed;
       		 bottom: 0;
       		 margin-left:800
    }
    tr{
    	margin-left:800px;
    		}
    td {overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }
    .navtop-right{
				float:right;
				position:relative;
				right:9%;
	}	
     
</style>
<style type="text/css"> 
			#footer{
	    		 position:absolute;
	    		 bottom: 30px;
	    		 margin-left :800px;
	    	}
	.linear{ 
		width:100%; 
		height:100%; 
		FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#15A216,endColorStr=#fafafa); /*IE*/  
		background:-moz-linear-gradient(top,#A0C0E5,#2A4B73);/*火狐*/ 
		background:-webkit-gradient(linear, 0% 0%, 0% 100%,from(#A0C0E5), to(#2A4B73));/*谷歌*/ 
		background-image: -webkit-gradient(linear,left bottom,left top,color-start(0, #15A216),color-stop(1, #fafafa));/* Safari & Chrome*/ 
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#A0C0E5', endColorstr='#2A4B73'); /*IE6 & IE7*/ 
		-ms-filter: "progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#A0C0E5', endColorstr='#2A4B73')"; /* IE8 */ 
	} 
</style> 

<style>a{TEXT-DECORATION:none}a:hover{TEXT-DECORATION:none}</style>  <%-- 2016-12-27 wuliying change underline->none--%>
<meta http-equiv="Content-Type" content="text/html; charset =UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" /> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ichart/ichart.1.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js" ></script>

<script type="text/javascript">	
	var f2=0;
	var f4=0;
	var f5=0;
	var f9=0;
	var pn=1;	
	
	var orderitm;
	var orderk;
	function sort(iRow, iCol){
		var table=document.getElementById("tableDefect");
		var ascChar = "▲";
       	var descChar = "▼";
        var nullstr="";
        var rows=table.tHead.rows;		
        //alert(rows[0].cells[2].innerHTML);
        for (var i = 0; i < rows.length; i++) {
			 for(var j=0;j<rows[i].cells.length;j++){//取得第几行下面的td个数，再次循环遍历该行下面的td元素
				 if(i==iRow&&j==iCol){	
					 if(iCol==2){
						 document.getElementById("priority").innerHTML="";
						 document.getElementById("subcomp").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("submit").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("status").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 rows[0].cells[4].innerHTML=rows[0].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[5].innerHTML=rows[0].cells[5].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[9].innerHTML=rows[0].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						
					 }
					 if(iCol==4){
						 document.getElementById("subcomp").innerHTML="";
						 document.getElementById("priority").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("submit").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("status").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 rows[0].cells[2].innerHTML=rows[0].cells[2].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[5].innerHTML=rows[0].cells[5].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[9].innerHTML=rows[0].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						
					 }
					 if(iCol==5){
						 document.getElementById("submit").innerHTML="";
						 document.getElementById("priority").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("subcomp").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("status").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 rows[0].cells[2].innerHTML=rows[0].cells[2].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[4].innerHTML=rows[0].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[9].innerHTML=rows[0].cells[9].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						
					 }
					 if(iCol==9){
						 document.getElementById("status").innerHTML="";
						 document.getElementById("priority").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("subcomp").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 document.getElementById("submit").innerHTML="<img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10/>";
						 rows[0].cells[2].innerHTML=rows[0].cells[2].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[5].innerHTML=rows[0].cells[5].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 rows[0].cells[4].innerHTML=rows[0].cells[4].innerHTML.replace(descChar,nullstr).replace(ascChar,nullstr);
						 
					 }
				 }
				 else{
					
				 }		
			}
     	}
    	var th = rows[iRow].cells[iCol];	 	
     	//alert(iRow);
     	if (th.innerHTML.indexOf(ascChar) == -1 && th.innerHTML.indexOf(descChar) == -1) {
            th.innerHTML += "<font size=1 color='#2c3e50'>"+descChar+"</font>";
			 //alert(th.innerHTML);
        }
        
       //判断上一次排列的列和现在需要排列的是否同一个。        
       if (table.sortCol == iCol) {		            	
       	if(iCol==2){
       		f2++;
       		if(f2%2!=0){
       			load(1,"SERIOUSNESS","ASC");
      			 th.innerHTML=th.innerHTML.replace(descChar, ascChar);
       			
       		}
       		else{
       			load(1,"SERIOUSNESS","DESC");
       			th.innerHTML=th.innerHTML.replace(ascChar, descChar);
       		}
       	}
       	if(iCol==4){
       		f4++;
       		if(f4%2!=0){
       			load(1,"SUBCOMPONENTNAME","ASC");
      			 th.innerHTML=th.innerHTML.replace(descChar, ascChar);
       			
       		}
       		else{
       			load(1,"SUBCOMPONENTNAME","DESC");
       			th.innerHTML=th.innerHTML.replace(ascChar, descChar);
       		}
       	}
       	if(iCol==5){
       		f5++;
       		if(f5%2!=0){
       			load(1,"SUBMITTEDTIME","ASC");
      			 th.innerHTML=th.innerHTML.replace(descChar, ascChar);
       			
       		}
       		else{
       			load(1,"SUBMITTEDTIME","DESC");
       			th.innerHTML=th.innerHTML.replace(ascChar, descChar);
       		}
       	}
       	if(iCol==9){
       		f9++;
       		if(f9%2!=0){
       			load(1,"STATUS","ASC");
       			th.innerHTML=th.innerHTML.replace(descChar, ascChar);
       		}
       		else{
       			load(1,"STATUS","DESC");
       			 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
       		}
       	}
       	
       } 
       else {
            if(iCol==2){
            	load(1,"SERIOUSNESS","DESC");
           	 	th.innerHTML=th.innerHTML.replace(ascChar, descChar);
           		 f2=0;
           	
            }
            else if(iCol==4){
            	load(1,"SUBCOMPONENTNAME","DESC");
           	 	th.innerHTML=th.innerHTML.replace(ascChar, descChar);
           		f4=0;
            }
            else if(iCol==5){
            	load(1,"SUBMITTEDTIME","DESC");
           	 	th.innerHTML=th.innerHTML.replace(ascChar, descChar);
           		f5=0;
            }
            else if(iCol==9){
            	load(1,"STATUS","DESC");
            	 th.innerHTML=th.innerHTML.replace(ascChar, descChar);
            	f9=0;
            }
        }
     
       table.sortCol = iCol;
	}
	function load(cur,orderItem,orderKey){
		
		pn=cur;
		orderitm=orderItem;
		orderk=orderKey;
		
		 var projectname="<%=request.getAttribute("projectname")%>";
		 var modelname="<%=request.getAttribute("modelname")%>";
		 //var modelname="";
		 var item="<%=request.getAttribute("item")%>";
		 var down="";
		 //alert(1);
		 down = down + "<a href='/portal/defect/DownDefect?projectname="+projectname+"&modelname="+modelname+"&item="+item+"&orderItem="+orderItem+"&orderKey="+orderKey+"'  title='Data Download'>	<img src='<%=request.getContextPath()%>/style/images/excel6.jpg'   width=20px height=20px /> </a>";
		 document.getElementById("downservlet").innerHTML=down;
		 //alert(orderKey);
		 $.getJSON("/portal/defect/findDefectList?projectname="+projectname+"&modelname="+modelname+"&item="+item+"&curpage="+cur+"&orderItem="+orderItem+"&orderKey="+orderKey+"&rn="+Math.random(),function(data){		
	           var str="";	           
	           curpage=data[1].curpage;
 			   totalpage=data[1].totalpage; 
 			   //alert(totalpage);
			 	$.each(data[0].defectList,function(i){
			 		var d=data[0].defectList[i];
			 		//alert(d);
			 		str+="";
			 		str+="<tr bordercolor='#DEDEDE' style='height:35px'>";
			 		 var fontStyle="<font color=black size=2>";
			 		if(data[0].defectList[i].sTATUS=="Closed")
			 			fontStyle="<font color=gray size=2>";
			 		if(data[0].defectList[i].sTATUS!="Closed"&&data[0].defectList[i].sTATUS!="Resolved"&&data[0].defectList[i].sERIOUSNESS=='A')
			 			fontStyle="<font color=red size=2>";
			 		
				 	str+="<td align='center'>"+fontStyle+ data[0].defectList[i].iD+"</font></td>"; 
				 	str+="<td><div style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;' title='"+data[0].defectList[i].hEADLINE.replace('\'','&#39;')+"'> "+fontStyle+"&nbsp;"+data[0].defectList[i].hEADLINE +"</font></div></td>"; 
					str+="<td  align='center'> "+fontStyle+"&nbsp;"+data[0].defectList[i].sERIOUSNESS +"</font></td>"; 
				 	str+="<td align='center'>"+fontStyle+ data[0].defectList[i].mODELCODE+"</font></td>";  
		  			if(data[0].defectList[i].sUBCOMPONENTNAME.length==0){
		  				str+="<td align='center'>"+fontStyle+"-</font></td>";     						
		  			}	  					
		  			else{
		  				str+="<td align='center'>"+fontStyle+ data[0].defectList[i].sUBCOMPONENTNAME+"</font></td>";
		  			}
		  			if(data[0].defectList[i].sUBMITTEDTIME.length==0){
		  				str+="<td align='center'>"+fontStyle+"-</font></td>";     						
		  			}	  					
		  			else{
		  				str+="<td align='center'>"+fontStyle+ data[0].defectList[i].sUBMITTEDTIME+"</font></td>";
		  			}
		  			if(data[0].defectList[i].pRODUCTDEVELOPER.length==0){
		  				str+= "<td align='center'>"+fontStyle+"-</font></td>";     						
		  			}	  					
		  			else{
		  				str+= "<td align='center'>"+fontStyle+ data[0].defectList[i].pRODUCTDEVELOPER+"</font></td>";
		  			}
		  			if(data[0].defectList[i].dEFECTSOLVEDVERSION.length==0){
		  				str+= "<td align='center'>"+fontStyle+"-</font></td>";     						
		  			}	  					
		  			else{
		  				str+="<td align='center' style='overflow: hidden;text-overflow: ellipsis;'>"+fontStyle+data[0].defectList[i].dEFECTSOLVEDVERSION+"</font></td>";
		  			}
					str+= "<td align='center'>"+fontStyle+data[0].defectList[i].rEQUESTER+"</font></td>";
		  			str+= "<td align='center'>"+fontStyle+data[0].defectList[i].sTATUS+"</font></td>";
		  			str+= "<td align='center'>"+fontStyle+data[0].defectList[i].sTATEOWNER+"</font></td></tr>";
			 	});
	  		 
	  		   
	  			$("#tableDefect tbody").html("");
				$("#tableDefect tbody").html(str);
				var firstpagehtml; 
				var prevpagehtml; 
				var nextpagehtml;
				var lastpagehtml;
				if((curpage-0)<=1){
					firstpagehtml="<a><<</a>&nbsp;&nbsp;&nbsp;";
					prevpagehtml = "<a><</a>";
				}else{
					firstpagehtml="<a onclick='load(1"+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'><<</font></a>&nbsp;&nbsp;&nbsp;";
					prevpagehtml = "<a onclick='load("+(curpage-1)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><</a>";
				}
				if(curpage < totalpage){
					nextpagehtml = "<a onclick='load("+(curpage+1)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);' href='javascript:void(0);'>></a>&nbsp;&nbsp;&nbsp;";
					lastpagehtml="<a onclick='load("+(totalpage)+",\""+orderItem+"\",\""+orderKey+"\");' href='javascript:void(0);'><font color='#3498db'>>></font></a> ";
				}else{
					nextpagehtml = "<a>></a>&nbsp;&nbsp;&nbsp;";
					lastpagehtml = "<a>>></a>";
				}
				 var html2="";		
				 html2 = html2 + "<table><tr  bgcolor='white' bordercolor='white'><td height='60px'>"+firstpagehtml+prevpagehtml+"&nbsp;&nbsp;&nbsp;"+curpage+"&nbsp;/&nbsp;"+totalpage+"&nbsp;"+"&nbsp;&nbsp;"+nextpagehtml+lastpagehtml+"</td></tr>";
				 html2 = html2+"</table>";
				 document.getElementById("footer").innerHTML=html2;
		});
	}
	 
	
	</script>







</head>
  
  

<%--  <body onload="AjaxTest(1,null);" > --%>
<body onload="load(1,'SERIOUSNESS','ASC');" >
 	 <br/>
 	 <div style="position:relative;"> 
 	 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Project Name: <%=request.getAttribute("projectname") %> 
 	 	<div id="downservlet" style="position:absolute; z-index:2; left:1700px; top:0px">
	 	 	
	  	</div>
	 </div>
	<br/>
	
	<center>				
		<%-- <div id="div"> </div>--%>
		<table id = "tableDefect"  border-radius='5px' bordercolor='#DEDEDE'   cellspacing='0px' style='table-layout:fixed;width:1750px;   border-collapse:collapse' border='2px'>
			<thead>
				<tr bgcolor='#d2e9ff' bordercolor='#DEDEDE'>
		           <td align='center' width='130px' height='40px'  ><font color='#333333'  face='Arial' size='2' style='font-weight:bold;'>ID</font></td>
		           <td align='center' width='580px' height='40px' ><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Headline</font></td>
		           <td align='center' width='70px' height='40px'   onClick="javascript:sort(0,2)"><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Priority&nbsp;<div id='priority' style='display:inline;'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
		           <td align='center' width='130px' height='40px' ><font color='#333333'  face='Arial' size='2' style='font-weight:bold;'>ModelCode</font></td>
		           <td align='center' width='160px' height='40px'   onClick="javascript:sort(0,4)"><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Sub Component <br/>Name&nbsp;<div id='subcomp' style='display:inline;'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
		  		   <td align='center' width='85px' height='60px'  onClick="javascript:sort(0,5)"><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Submitted<br> Time&nbsp;<div id='submit' style='display:inline;'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
		  		   <td align='center' width='85px' height='40px' ><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Developer</font></td>
		  		   <td align='center' width='160px' height='40px' ><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Defect Solved Ver.</font></td>
		  		   <td align='center' width='85px' height='40px' ><font color='#333333'  face='Arial' size='2' style='font-weight:bold;'>Requester</font></td>
		  		   <td align='center' width='70px' height='40px'   onClick="javascript:sort(0,9)"><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>Status&nbsp;<div id='status' style='display:inline;'><img src='<%=request.getContextPath()%>/style/images/arrow.png' width=8 height=10 padding-top=3px/></div></font></td>
		  		   <td align='center' width='80px' height='40px' ><font color='#333333' face='Arial' size='2' style='font-weight:bold;'>State Owner</font></td> 		
		  		</tr>
			</thead>
			<tbody></tbody>
		</table>
  	</center> 
	
	<div id="footer"></div>		
  </body>
</html>
