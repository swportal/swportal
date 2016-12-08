<%@ page contentType="text/html;charset=gb2312"%>
 <%
 String content = request.getParameter("content");
 out.println(java.net.URLDecoder.decode(content,"UTF-8"));
 out.println("ÖÐÎÄ");
 %>