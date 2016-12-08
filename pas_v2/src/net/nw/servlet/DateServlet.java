package net.nw.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.nw.dao.ModelcodesDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class DateServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	private ModelcodesDAO mcd = new ModelcodesDAO();
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int[] ResolveDay = new int[400];
		int[] Day = new int[400];
		//int ResolveDay1=0,ResolveDay2=0,ResolveDay3=0,ResolveDay4=0,ResolveDay5=0,ResolveDay6=0,ResolveDay7=0;
		//int ResolveDay8=0,ResolveDay9=0,ResolveDay10=0,ResolveDay11=0,ResolveDay12=0,ResolveDay13=0,ResolveDay14=0,ResolveDay15=0,ResolveDay16=0,ResolveDay17=0,ResolveDay18=0,ResolveDay19=0,ResolveDay20=0;
		
		String where = "where";
		String and = null;
		Long daysBetween = 0L;
		String currdate= request.getParameter("currdate");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today=sdf.format(date);
		
		try {
			Date d1 =sdf.parse(currdate);
			Date d2 =sdf.parse(today);
			daysBetween = (d2.getTime()-d1.getTime()+1000000)/(3600*24*1000);
			System.out.println(daysBetween);
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		//System.out.println(currdate +" "+todayString);
		
		
		String projectname=request.getParameter("projectname");	
		String codeid = request.getParameter("modelname");
		System.out.println(codeid);
		String a[] = projectname.split(",");
		for(int i=0;i<(a.length);i++){
			where=where+" ProjectName='"+a[i]+"' or ";
			
		}
		where=where.substring(0,where.length()-3);
		
		if(codeid.length()==1){			
		}
		else{			
			//where=" and ModelCode like '%"+mcd.getNameById(Integer.parseInt(codeid))+"%'";
			where=" where ModelCode ='"+mcd.getNameById(Integer.parseInt(codeid))+"'";
		}
		
		
		response.reset();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html"); 
		JSONArray members = new JSONArray();
		PrintWriter out= response.getWriter();
		
		
		ResultSet rs=null;
		rs = this.getResultSet(where,codeid);
	
		try {				
			while (rs.next()) {	
				for(int i=0;i<60;i++){
					Day[i]+=rs.getInt("Day"+(i+1+daysBetween.intValue()));
					ResolveDay[i]+=rs.getInt("ResolveDay"+(i+1+daysBetween.intValue()));
				}
			}	
			JSONObject member = new JSONObject();				
			JSONArray listDay = new JSONArray();
			JSONArray listResolveDay = new JSONArray();
			 for(int i=1;i<=60;i++){
				 listDay.add(Day[60-i]);
				 listResolveDay.add(ResolveDay[60-i]);					
			 }
			// member.put("name", "Submit");
			 member.put("listDay", listDay);
			 member.put("listResolveDay", listResolveDay);	
			 member.put("daysBetween", daysBetween.intValue());
			 members.add(member);
			out.write(members.toString());
			rs.close();
		} 
		catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally{
			if(out!=null){
				out.flush();
				out.close();	
			}
		}	
				
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doGet(request, response);
		
	}
	
	@Deprecated
	private void print(HttpServletRequest request, HttpServletResponse response,String xmlDOM) throws IOException{
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		PrintWriter out = response.getWriter();
		out.print(xmlDOM);
		out.close();
	}
	
	
	private ResultSet getResultSet(String where,String codeid){
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
		
		String sql = "select * from defects_infor_daily "+where; 
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
	
	
	private Connection getConn() throws ClassNotFoundException, SQLException{
		
		String driver = "com.mysql.jdbc.Driver"; 
        String url="jdbc:mysql://109.110.100.56/tsdr_project";
    	String user="root";
    	String password="";
		Class.forName(driver);
		System.out.println("��ݿ�����");
		return DriverManager.getConnection(url,user,password);
		
	}

}
