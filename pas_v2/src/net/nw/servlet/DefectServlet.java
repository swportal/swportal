package net.nw.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;


public class DefectServlet extends HttpServlet {
	
	private static final long	serialVersionUID	= 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int curpage = Integer.parseInt(request.getParameter("curpage"));
		String projectname=request.getParameter("projectname");	
		/*
		 * 2016-11-26 Wuliying add to apply multi project and  modelcode is 'NULL'
		 */
		String a[] = projectname.split(",");
		String pjstr="";
		for(int i=0;i<a.length;i++){
			pjstr+=" PROJECTNAME LIKE '%"+ a[i]+"%' OR";
		}
		
		pjstr="("+ pjstr.substring(0,pjstr.length()-2)+")";
		
		String modelname=request.getParameter("modelname");	
		if(modelname==null||modelname.length()==0||"null".equals(modelname))
			modelname="";
		String item=request.getParameter("item");  //A?B?C?Closed?Opened?Resolved?
		String orderItem=request.getParameter("orderItem");
		String orderKey=request.getParameter("orderKey");
		String where=null;
		int total=0;
		ResultSet rs=null;

		
		//2016-11-17 add SERIOUSNESS sort
		if("".equals(orderItem)){		
			if ("".equals(item)){			
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' order by SERIOUSNESS" ;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' AND STATUS != 'Closed' AND STATUS != 'Resolved' and STATUS != 'Not_Related' and PLMFLAG='Y' order by SERIOUSNESS" ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Closed%' order by SERIOUSNESS" ;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Resolved%' order by SERIOUSNESS" ;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%A%' order by SERIOUSNESS" ;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%B%' order by SERIOUSNESS" ;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%C%' order by SERIOUSNESS" ;
			}
		}
		else{
			if ("".equals(item)){			
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' order by " +orderItem+" "+orderKey;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' AND STATUS != 'Closed' AND STATUS != 'Resolved' and STATUS != 'Not_Related' and PLMFLAG='Y' order by " +orderItem+" "+orderKey ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Closed%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Resolved%' order by " +orderItem+" "+orderKey;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%A%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%B%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND MODELCODE LIKE '%"+modelname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%C%' order by " +orderItem+" "+orderKey;
			}
		}
		
		//total=this.getResultCount_1(page.getWhere());
			
		//StringBuffer xmlDOM = new StringBuffer();
		//total=this.getResultCount_1(where);
		
		//int pagesize = 13;
		//Page page = new Page(total,currpage,pagesize,where);
		total=this.getResultCount_1(where);
		Integer pageSize=13;
		Integer totalpage=(total%pageSize==0)?(total/pageSize):(total/pageSize+1);
		Integer start=(curpage-1)*pageSize;
		
		
		
		rs = this.getResultSet_1(start,pageSize,where);
		//rs = this.getResultSet_1(where);  //2016-11-17 change for page
		response = ServletActionContext.getResponse();
		JSONArray json = new JSONArray();
		JSONArray jsonlist = new JSONArray();
		
		try {
			while (rs.next()) {
					JSONObject jo = new JSONObject();
					jo.put("id", rs.getString("ID"));
					jo.put("headline", rs.getString("HEADLINE").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("seriousness", rs.getString("SERIOUSNESS").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("modelcode", rs.getString("MODELCODE").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("subcomponentname", rs.getString("SUBCOMPONENTNAME").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					//String orig= rs.getString("SUBMITTEDTIME").replaceAll("<", " &lt;").replaceAll(">", " &gt;");
					/*String begin= orig.substring(orig.length()-2,orig.length());
					String mid= orig.substring(3,5);
					String end=orig.substring(0,2);					
					StringBuffer changedate = new StringBuffer("20");
					
					changedate.append(begin).append("-").append(mid).append("-").append(end);*/
					//	append("-").append(end).append("-20").append(begin);
					//java.sql.Date date=java.sql.Date.valueOf(String.valueOf(changedate));
					
					jo.put("submittime",  rs.getString("SUBMITTEDTIME").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					//jo.put("platformsolvedversion", rs.getString("PLATFORMSOLVEDVERSION").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("productdeveloper", rs.getString("PRODUCTDEVELOPER").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("defectsolvedversion", rs.getString("DEFECTSOLVEDVERSION").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("requester", rs.getString("REQUESTER").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("status", rs.getString("STATUS").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jo.put("stateowner", rs.getString("STATEOWNER").replaceAll("<", " &lt;").replaceAll(">", " &gt;"));
					jsonlist.add(jo);
			}
			rs.close();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		JSONObject jo2 = new JSONObject();
		jo2.put("curpage", curpage);
		jo2.put("totalpage",totalpage);
		json.add(jsonlist);
		json.add(jo2);
		try {
            System.out.println(json.toString());
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		//this.print(request, response, xmlDOM.toString());
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doGet(request, response);
		
	}
	

	private void print(HttpServletRequest request, HttpServletResponse response,String xmlDOM) throws IOException{
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		PrintWriter out = response.getWriter();
		out.print(xmlDOM);
		out.close();
	}
	
	
	private ResultSet getResultSet_1(int start,int len,String where){
	//private ResultSet getResultSet_1(String where){
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
		
		String sql = "select * from kona_db_copy "+where+" limit ?,?";
		//String sql = "select * from kona_db_copy "+where; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, start);
			pstmt.setInt(2, len);
			//System.out.println("start&&&&&"+start);
			//System.out.println(len);
			
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
		String sql = "select count(*) from kona_db_copy "+where;
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
