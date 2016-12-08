<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>基本模版</title> 
<style type="text/css"> 
body { 
    text-decoration: none; 
    width: 100%; 
    height: 100%; 
    text-align: center; 
}
 
.head { 
    width: 100%; 
    height: 50px; 
    background-color: lightblue; 
}
 
.bottom { 
    width: 100%; 
    height: 30px; 
    background-color: lightblue; 
}
 
.leftBox { 
    width: 200px; 
    height: 1000px; 
    background-color: lightblue; 
    clear:both; 
    float: left; 
}
.rightBox { 
    width: 100px; 
    height: 850px; 
    background-color: green; 
    clear:both;
    float: right; 
}
 
.content { 
    width: 800px; 
    height: 975px; 
    
} 
.hengxian{
		width:100%;
		height:50px;
		background-color:red;
}

.shuxian{
		width:50px;
		height:500px;
		
}
</style> 


</head> 
<body> 
    <div class="head"> 
        <tiles:insertAttribute name="HEADER"/> 
    </div> 
    <div class="leftBox"> 
        <tiles:insertAttribute name="SIDEBAR"/> 
    </div> 
    <table>
    <tr>
    
    
   
    
    <td>
    <div class="content"> 
    	
        	<tiles:insertAttribute name="CONTENT1"/> 
        
    </div> 
    </td>
    
    </tr>
    </table>
    
    <div class="bottom"> 
        <tiles:insertAttribute name="FOOTER"/> 
    </div>
</body> 
</html>
