package net.nw.servlet;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.validator.Var;

import net.nw.dao.Conn;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class AjaxServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int currpage = Integer.parseInt(request.getParameter("currpage")==null?"1":request.getParameter("currpage"));
		String projectname=request.getParameter("projectname");
		String city=request.getParameter("city");
		String milestone=request.getParameter("milestone");
		String startdate=request.getParameter("startdate");
		String enddate=request.getParameter("enddate");
		String state=request.getParameter("state");
		String keyword=request.getParameter("keyword");
		String orderKey=request.getParameter("orderKey");
		request.setAttribute("curr",currpage);
		//System.out.println(state);
		//projectname="LM";
		int total=0;
		String where="";
		if(!projectname.equals("")){
			where=where+"where (PjtName like'%"+projectname+"%' or DevModelName like'%"+projectname+"%' or SWEM like'%"+projectname+"%' ) ";
		}
		else{
			where=where+"where PjtName like'%%'";
		}
		
		if(!state.equals("null")){
			if(state.equals("pl")){
				if(!city.equals("null"))
				where+="and SWEM like '%"+city+"%'";
				//System.out.println(where);
			}
			else if(state.equals("ps")){
				if(!city.equals("null"))
				where+="and PjtStatus like '%"+city+"%'";
			}
			else if(state.equals("spt")){
				if(!city.equals("null"))
				where+="and ProjType like '%"+city+"%'";
			}
			else if(state.equals("ms")){
				if(!city.equals("null"))
				where+="and Milestone like '%"+city+"%'";
			}
			else if(state.equals("pg")){
				if(!city.equals("null"))
				where+="and Product like '%"+city+"%'";
			}
			else if(state.equals("choose")){
				//where+="aPRAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
		}
		
		if(!milestone.equals("null")){
			if(milestone.equals("PIA")){
				where+="and PIAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("PVR")){
				where+="and PVRPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("PRA")){
				where+="and PRAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("choose")){
				where+="";
			}
		}
		if("null".equals(keyword))
			keyword="";
		if("null".equals(orderKey))
			orderKey="";
		total=this.getResultCount_1(where);
		/*
		if(projectname.equals("null") ){
			total = this.getResultCount();
		}
		else{
			total = this.getResultCount(projectname);
		}
		*/
		//System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+total);
		int pagesize = 20;
		//System.out.println(where);
		Page page = new Page(total,currpage,pagesize,where);
		
		StringBuffer xmlDOM = new StringBuffer();
		ResultSet rs=null;
		//	ResultSet rs_count=null;
		//System.out.println(page.getWhere());
		total=this.getResultCount_1(page.getWhere());
		rs = this.getResultSet_1(page.getStart(),page.getPagesize(),page.getWhere(),keyword,orderKey);
		//rs_count = this.getResultSet_mcount();
		
		
		xmlDOM.append("<root>");
		try {
			
			xmlDOM.append("<projects>");
			while (rs.next()) {
				xmlDOM.append("<project>");
				xmlDOM.append("<PjtName>" + rs.getString("PjtName") + "</PjtName>");
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
			//System.out.println("*********************************///////////////////////////�����ɹ�");
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
	 * @author Wu Liying
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
	
	
	private ResultSet getResultSet_1(int start,int len,String where,String keyword,String orderKey){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		try {
			conn = getConn();
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}	
		if(orderKey.equals("")&&keyword.equals("")){
			sql = "select * from project_ongoing "+where+" order by  PIAPlanDate DESC, PRAPlanDate DESC, PLMTotal DESC, PLMOpened DESC limit ?,?"; 
		}
		else{
			sql = "select * from project_ongoing "+where+" order by "+ keyword + " "+orderKey + "  limit ?,?";
		}
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			//System.out.println("start&&&&&"+start);
			//System.out.println(len);
			
			rs = pstmt.executeQuery();
			//pstmt.close();
			//conn.close();
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
		String sql = "select count(*) from project_ongoing "+where;
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
		//System.out.println("��ݿ�����");
		return DriverManager.getConnection(url,user,password);
		
	}
	@Deprecated
	private int getResultCount(String projectname){
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
		String sql = "select count(*) from project_ongoing where PjtName like '%"+projectname+"%'";
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
	
	@Deprecated
	private ResultSet getResultSet(String sql){
		Connection conn = null;
		
		ResultSet rs = null;
		
		Statement stmt=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			//String sql="select * from defects_infor ";
			rs=stmt.executeQuery(sql);	
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//return resultName;
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
					rs=null;
				}
				if(stmt!=null){
					stmt.close();
					stmt=null;
				}
				if(conn!=null)
				{
					conn.close();
					conn=null;
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		//return listTotal;
		return rs;
	}
	
	/**
	 * @author QQ:373672872
	 * @return 
	 */
	
	@Deprecated
	private int getResultCount(){
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
		String sql = "select count(*) from project_ongoing";
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
	
	@Deprecated
	private ResultSet getResultSet(int start,int len){
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
		
		String sql = "select * from project_ongoing order by projectid limit ?,?"; 
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			
			pstmt.setInt(1, start);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}
	
	
	@Deprecated
	private ResultSet getResultSet(int start,int len,String projectname){
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
		
		String sql = "select * from project_ongoing where PjtName like '%"+projectname+"%' order by PLMTotal desc limit ?,?"; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			
			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}
	@Deprecated
	private ResultSet getResultSet_mcount() {
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
		
		String sql = "select * from project_ongoing "; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		return rs;
	}

}
