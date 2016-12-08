package net.nw.servlet;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.nw.dao.Conn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ModelServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int currpage = Integer.parseInt(request.getParameter("currpage")==null?"1":request.getParameter("currpage"));
		String projectname=request.getParameter("projectname");		
		int total=0;
		String where="where PjtName like'%"+projectname+"%'";
		
		
		
		total=this.getResultCount_1(where);
		
		int pagesize = 10;
		Page page = new Page(total,currpage,pagesize,where);
		
		StringBuffer xmlDOM = new StringBuffer();
		ResultSet rs=null;

		total=this.getResultCount_1(page.getWhere());
		rs = this.getResultSet_1(page.getStart(),page.getPagesize(),page.getWhere());
	
		
		
		xmlDOM.append("<root>");
		try {
			
			xmlDOM.append("<projects>");
			while (rs.next()) {
				xmlDOM.append("<project>");
				xmlDOM.append("<DevModelName>" + rs.getString("DevModelName") + "</DevModelName>");
				xmlDOM.append("<PIA>" + rs.getString("PIA") + "</PIA>");
				xmlDOM.append("<PVR>" + rs.getString("PVR") + "</PVR>");
				xmlDOM.append("<PRA>" + rs.getString("PRA") + "</PRA>");
				xmlDOM.append("<SRA>" + rs.getString("SRA") + "</SRA>");
				xmlDOM.append("<Product>" + rs.getString("Product") + "</Product>");
				xmlDOM.append("<ProjType>" + rs.getString("ProjType") + "</ProjType>");
				xmlDOM.append("<Milestone>" + rs.getString("Milestone") + "</Milestone>");
				xmlDOM.append("<DevType>" + rs.getString("DevType") + "</DevType>");
				xmlDOM.append("<PjtStatus>" + rs.getString("PjtStatus") + "</PjtStatus>");
				xmlDOM.append("<DevPL>" + rs.getString("DevPL") + "</DevPL>");
				xmlDOM.append("<SWEM>" + rs.getString("SWEM") + "</SWEM>");
				xmlDOM.append("<PIAPlanDate>" + rs.getString("PIAPlanDate") + "</PIAPlanDate>");
				xmlDOM.append("<PIAActualDate>" + rs.getString("PIAActualDate") + "</PIAActualDate>");
				xmlDOM.append("<PVRPlanDate>" + rs.getString("PVRPlanDate") + "</PVRPlanDate>");
				xmlDOM.append("<PVRActualDate>" + rs.getString("PVRActualDate") + "</PVRActualDate>");
				xmlDOM.append("<PRAPlanDate>" + rs.getString("PRAPlanDate") + "</PRAPlanDate>");
				xmlDOM.append("<PRAActualDate>" + rs.getString("PRAActualDate") + "</PRAActualDate>");
				xmlDOM.append("<PLMTotal>" + rs.getString("PLMTotal") + "</PLMTotal>");
				xmlDOM.append("<PLMOpened>" + rs.getString("PLMOpened") + "</PLMOpened>");
				xmlDOM.append("<PLMResolved>" + rs.getString("PLMResolved") + "</PLMResolved>");
				xmlDOM.append("<PLMClosed>" + rs.getString("PLMClosed") + "</PLMClosed>");
				xmlDOM.append("</project>");
			}
			rs.close();
			xmlDOM.append("</projects>");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		xmlDOM.append("<page>");
		xmlDOM.append("<currpage>"+page.getCurrpage()+"</currpage>");
		xmlDOM.append("<pagecount>"+page.getPagecount()+"</pagecount>");
		xmlDOM.append("</page>");
		xmlDOM.append("</root>");
		
		this.print(request, response, xmlDOM.toString());

	}

	
	


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doGet(request, response);
		
	}
	
	/**
	 * @category 
	 * @author QQ:373672872
	 * @param request
	 * @param response
	 * @param xmlDOM
	 * @throws IOException
	 */
	private void print(HttpServletRequest request, HttpServletResponse response,String xmlDOM) throws IOException{
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		PrintWriter out = response.getWriter();
		out.print(xmlDOM);
		out.close();
	}
	
	/**
	 * @author QQ:373672872
	 *
	 * @return ResultSet
	 */
	
	
	private ResultSet getResultSet_1(int start,int len,String where){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		String sql = "select * from project_model_ongoing "+where+" order by PLMTotal desc limit ?,?"; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			System.out.println("start&&&&&"+start);
			System.out.println(len);
			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		//System.out.println("successsssssssssssssssssssssssssssss");
		return rs;
	}
	
	
	
	private int getResultCount_1(String where){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		String sql = "select count(*) from project_model_ongoing "+where;
		System.out.println(sql);
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		try {
			while(rs.next()){
				count = rs.getInt(1);
			}
			stmt.close();
			rs.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return count;
	}
	
	/**
	 * @author QQ:373672872
	 * @return 
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private Connection getConn() throws ClassNotFoundException, SQLException{
		
		//String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String driver = "com.mysql.jdbc.Driver"; 
		//String url = "jdbc:sqlserver://127.0.0.1:1433;database=persondb";
		
	        String url="jdbc:mysql://109.110.100.56/tsdr_project";
	    	String user="root";
	    	String password="";
		
		Class.forName(driver);
		System.out.println("��ݿ�����");
		return DriverManager.getConnection(url,user,password);
		
	}

}
