<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%@ taglib uri="myjstl" prefix="c"%>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>

<!DOCTYPE HTML>
<html>
  <head>
  <title>Set Privilege</title>
  <!-- Loading Bootstrap -->
<%--  <link href="<%=request.getContextPath()%>/FlatUI/dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">--%>
	   
  <script language="javascript" src="<%=request.getContextPath()%>/js/jquery_treeview/jquery.treeview.js"></script>
  <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/style/blue/file.css" />
  <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery_treeview/jquery.treeview.css" />
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/mainpagestyle.css" />
  
  <style type="text/css">
			ul,li{
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
  
    <script type="text/javascript">
	    function saveRole(){
	    	var form=document.forms[0];	 	    	
	    	form.action="${role.id }"==""? "/portal/role/addRole":"/portal/role/updateRole"; 
	    	form.method="post";
	    	form.submit();    	
	    }    	
   </script>
   
   <script type="text/javascript">
		$(function(){
			// 指定事件处理函数
			$("[name=privilegeIds]").click(function(){
				
				// 当选中或取消一个权限时，也同时选中或取消所有的下级权限
				$(this).siblings("ul").find("input").attr("checked", this.checked);
				
				// 当选中一个权限时，也要选中所有的直接上级权限
				if(this.checked == true){
					$(this).parents("li").children("input").attr("checked", true);
				}
				
			});
		});
	</script>
  </head>  
  <body>
  
  
<div id="navtop">
		<ul class="navtop-skin">			
			<li>
					&nbsp;&nbsp;
					<strong>| Set Privilege For ${role.name } |</strong>&nbsp;&nbsp;&nbsp;
			</li>
		</ul>
</div>
<br/>
<div align="center">
 <form action="/portal/role/setPrivilege">
 <input type="hidden" name="id" value="${role.id }">
 

        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder" style="width:80%">
            <div class="ItemBlock" >
                <table cellpadding="0" cellspacing="0" class="mainForm">
					<!--表头-->
					<thead>
						<tr align="LEFT" valign="MIDDLE" id="TableTitle" border="1px">
							<td width="300px" style="padding-left: 7px;">
								<!-- 如果把全选元素的id指定为selectAll，并且有函数selectAll()，就会有错。因为有一种用法：可以直接用id引用元素 -->
								<input type="checkbox" id=cbSelectAll  onClick="$('[name=privilegeIds]').attr('checked', this.checked)"/>
								<label for="cbSelectAll"><font face="Arial" size="2" style="font-weight:normal">All</font></label>
							</td>
						</tr>
					</thead>
                   
			   		<!--显示数据列表-->
					<tbody id="TableData">
						<tr class="TableDetail1">
							<!-- 显示权限树 -->
							<td>
							<ul id="tree">
							<c:forEach items="${topPrivilegeList}" var="p">
							<li>
								<input type = "checkbox" name="privilegeIds" value="${p.id}" id="cb_${p.id}"
									<c:forEach items="${privilegeIds}" varStatus="va"><c:if test="${privilegeIds[va.index]==p.id}">checked</c:if></c:forEach>/>
								<label for="cb_${p.id}"><span class="folder"><font face="Arial" size="2" style="font-weight:normal">${p.name }</font></span></label>
								<ul>
									<c:forEach items="${p.children }" var="c">
									<li>
										<input type = "checkbox" name="privilegeIds" value="${c.id}" id="cb_${c.id}"
											<c:forEach items="${privilegeIds}" varStatus="va"><c:if test="${privilegeIds[va.index]==c.id}">checked</c:if></c:forEach>/>
										<label for="cb_${c.id}"><span class="folder"><font face="Arial" size="2" style="font-weight:normal">${c.name }</font></span></label>
										<ul>
											<c:forEach items="${c.children }" var="cc">
											<li>
												<input type = "checkbox" name="privilegeIds" value="${cc.id}" id="cb_${cc.id}"
												<c:forEach items="${privilegeIds}" varStatus="va"><c:if test="${privilegeIds[va.index]==cc.id}">checked</c:if></c:forEach>/>
												<label for="cb_${cc.id}"><span class="folder"><font face="Arial" size="2" style="font-weight:normal">${cc.name }</font></span></label>
											</li>
											</c:forEach>
										</ul>
									</li>
									</c:forEach>
								</ul>				
	   						</li>
	   						</c:forEach>
							</ul>
							</td>
						</tr>
					</tbody>
                </table>
            </div>
        </div>
        
         <script language="javascript">
        	$("#tree").treeview();
        </script>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
<%--            <input type="image" src="${pageContext.request.contextPath}/style/images/save.png"/>--%>
<%--            <a href="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/style/images/goBack.png"/></a>--%>
            <input type="submit"  value="Save" style="color:#000000;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  &nbsp;&nbsp;
			<input type="button"  onclick="javascript:history.go(-1);" value="Back" style="color:#000000;  border-radius:5px; vertical-align:middle;height:30px;  width:60px; "/>  
        </div>
    </s:form>
</div>	  
  </body>
</html>
