package net.nw.servlet;
import java.awt.JobAttributes;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts2.ServletActionContext;

import freemarker.ext.servlet.AllHttpScopesHashModel;

import net.nw.dao.Conn;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DownDefectServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//int currpage = Integer.parseInt(request.getParameter("currpage")==null?"1":request.getParameter("currpage"));
		String projectname=request.getParameter("projectname");	
		/*
		 * 2016-11-28 Wuliying add to apply multi project condition 
		 */
		String a[] = projectname.split(",");
		String pjstr="";
		for(int i=0;i<a.length;i++){
			pjstr+=" PROJECTNAME LIKE '%"+ a[i]+"%' OR";
		}
		
		pjstr="("+ pjstr.substring(0,pjstr.length()-2)+")";
		String modelname=request.getParameter("modelname");	
		/*
		 * 2016-11-28 Wuliying add to apply modelcode is 'NULL'
		 */
		if(modelname==null||modelname.length()==0||"null".equals(modelname))
			modelname="";
		String item=request.getParameter("item");
		String orderItem=request.getParameter("orderItem");
		String orderKey=request.getParameter("orderKey");
		String where=null;
		int total=0;
		/*if ("".equals(item)){		 //2016-11-18 change code to apply sort and keyword search--wuliying	
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y'" ;
		}
		else if("Opened".equals(item)){ //Opened
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' AND STATUS != 'Closed' AND STATUS != 'Resolved' and STATUS != 'Not_Related' and PLMFLAG='Y'" ;
		}
		else if ("Closed".equals(item)){ //Closed
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Closed%'" ;
		}
		else if ("Resolved".equals(item)){ //Resolved
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND STATUS LIKE '%Resolved%'" ;
		}
		else if("A".equals(item)){ //A
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%A%'" ;
		}
		else if ("B".equals(item)){ //B
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%B%'" ;
		}
		else if ("C".equals(item)){ //C
			where="where PROJECTNAME like '%"+projectname+"%'  AND STATUS != 'PLM_Deleted' and STATUS != 'Not_Related' and PLMFLAG='Y' AND SERIOUSNESS LIKE '%C%'" ;
		}*/
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
		response = ServletActionContext.getResponse();
		String fname = "defectlist";
		response.reset();// 清空输出流
		response.setHeader("Content-disposition","attachment; filename=" + fname + ".xls");// 设定输出文件头
		response.setContentType("application/msexcel");//EXCEL格式  Microsoft excel
		//创建workbook   
        HSSFWorkbook workbook = new HSSFWorkbook(); 
        HSSFCellStyle style = workbook.createCellStyle();  
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
	    HSSFFont f  = workbook.createFont();  
	    f.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);//加粗 
	    style.setFont(f);
	    style.setFillForegroundColor(HSSFColor.LIME.index);   
	    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        //创建sheet页  
        HSSFSheet sheet = workbook.createSheet("Defect List");   
        //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("ID"));   
        c0.setCellStyle(style); 
        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("Headline"));   
        c1.setCellStyle(style); 
        HSSFCell c2 = row.createCell(2);   
        c2.setCellValue(new HSSFRichTextString("Priority"));   
        c2.setCellStyle(style); 
        HSSFCell c3 = row.createCell(3);   
        c3.setCellValue(new HSSFRichTextString("ModelCode"));   
        c3.setCellStyle(style); 
        HSSFCell c4 = row.createCell(4);   
        c4.setCellValue(new HSSFRichTextString("Sub Component Name"));   
        c4.setCellStyle(style); 
        HSSFCell c5 = row.createCell(5);   
        c5.setCellValue(new HSSFRichTextString("Submitted Time"));   
        c5.setCellStyle(style); 
        HSSFCell c6 = row.createCell(6);   
        c6.setCellValue(new HSSFRichTextString("Developer"));   
        c6.setCellStyle(style); 
        HSSFCell c7 = row.createCell(7);   
        c7.setCellValue(new HSSFRichTextString("Defect Solved Ver."));   
        c7.setCellStyle(style); 
        HSSFCell c8 = row.createCell(8);   
        c8.setCellValue(new HSSFRichTextString("Requester"));   
        c8.setCellStyle(style); 
        HSSFCell c9 = row.createCell(9);   
        c9.setCellValue(new HSSFRichTextString("Status"));   
        c9.setCellStyle(style); 
        HSSFCell c10 = row.createCell(10);   
        c10.setCellValue(new HSSFRichTextString("State Owner"));   
        c10.setCellStyle(style); 
        
        ResultSet rs=null;

		total=this.getResultCount_1(where);
		rs = this.getResultSet_1(where);
		int i = 0;
		try {
			while (rs.next()) {
					row=sheet.createRow((int)++i);
					row.createCell((short)0).setCellValue(new HSSFRichTextString(rs.getString("ID")));
					row.createCell((short)1).setCellValue(new HSSFRichTextString(rs.getString("HEADLINE").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)2).setCellValue(new HSSFRichTextString(rs.getString("SERIOUSNESS").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)3).setCellValue(new HSSFRichTextString(rs.getString("MODELCODE").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)4).setCellValue(new HSSFRichTextString(rs.getString("SUBCOMPONENTNAME").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)5).setCellValue(new HSSFRichTextString(rs.getString("SUBMITTEDTIME").replaceAll("<", " &lt;").replaceAll(">", " &gt;"))); // 2016-11-18 PLATFORMDEVELOPER->SUBMITTEDTIME wuliying
					row.createCell((short)6).setCellValue(new HSSFRichTextString(rs.getString("PRODUCTDEVELOPER").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)7).setCellValue(new HSSFRichTextString(rs.getString("DEFECTSOLVEDVERSION").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)8).setCellValue(new HSSFRichTextString(rs.getString("REQUESTER").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)9).setCellValue(new HSSFRichTextString(rs.getString("STATUS").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)10).setCellValue(new HSSFRichTextString(rs.getString("STATEOWNER").replaceAll("<", " &lt;").replaceAll(">", " &gt;")));

				}
				rs.close();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		try {
			 workbook.write(response.getOutputStream());  
        } 
		catch (Exception e){  
	        e.printStackTrace();  
	    }  
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
	
	
	//private ResultSet getResultSet_1(int start,int len,String where){
	private ResultSet getResultSet_1(String where){
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
		
		//String sql = "select * from kona_db_copy "+where+" limit ?,?";
		String sql = "select * from kona_db_copy "+where; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			//pstmt.setInt(1, start);
			//pstmt.setInt(2, len);
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
