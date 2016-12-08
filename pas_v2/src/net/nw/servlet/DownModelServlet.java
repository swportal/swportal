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
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts2.ServletActionContext;

import freemarker.ext.servlet.AllHttpScopesHashModel;

import net.nw.dao.Conn;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DownModelServlet extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String projectname=request.getParameter("projectname");			
		
		String where="where PjtName like '%"+projectname+"%'";
		
		response = ServletActionContext.getResponse();
		String fname = "Project List";
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
        HSSFSheet sheet = workbook.createSheet("Model List");   
        //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("NO"));   
        c0.setCellStyle(style); 
        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("Model Name"));   
        c1.setCellStyle(style); 
        HSSFCell c2 = row.createCell(2);   
        c2.setCellValue(new HSSFRichTextString("Milestone"));   
        c2.setCellStyle(style); 
        HSSFCell c3 = row.createCell(3);   
        c3.setCellValue(new HSSFRichTextString("Pjt. Type"));   
        c3.setCellStyle(style); 
        HSSFCell c4 = row.createCell(4);   
        c4.setCellValue(new HSSFRichTextString("PIA"));   
        c4.setCellStyle(style); 
        HSSFCell c5 = row.createCell(6);   
        c5.setCellValue(new HSSFRichTextString("PVR"));   
        c5.setCellStyle(style); 
        HSSFCell c6 = row.createCell(8);   
        c6.setCellValue(new HSSFRichTextString("PRA"));   
        c6.setCellStyle(style); 
        HSSFCell c7 = row.createCell(10);   
        c7.setCellValue(new HSSFRichTextString("Defects"));   
        c7.setCellStyle(style); 
        
        
        HSSFRow row1 = sheet.createRow(1);   
        HSSFCell c10 = row1.createCell(4);   
        c10.setCellValue(new HSSFRichTextString("Plan"));   
        c10.setCellStyle(style);         
        HSSFCell c11 = row1.createCell(5);   
        c11.setCellValue(new HSSFRichTextString("Actual"));   
        c11.setCellStyle(style); 
        
        HSSFCell c12 = row1.createCell(6);   
        c12.setCellValue(new HSSFRichTextString("Plan"));   
        c12.setCellStyle(style);         
        HSSFCell c13 = row1.createCell(7);   
        c13.setCellValue(new HSSFRichTextString("Actual"));   
        c13.setCellStyle(style); 
        
        HSSFCell c14 = row1.createCell(8);   
        c14.setCellValue(new HSSFRichTextString("Plan"));   
        c14.setCellStyle(style);         
        HSSFCell c15 = row1.createCell(9);   
        c15.setCellValue(new HSSFRichTextString("Actual"));   
        c15.setCellStyle(style); 
        
        HSSFCell c16 = row1.createCell(10);   
        c16.setCellValue(new HSSFRichTextString("Total"));   
        c16.setCellStyle(style);         
        HSSFCell c17 = row1.createCell(11);   
        c17.setCellValue(new HSSFRichTextString("Closed"));   
        c17.setCellStyle(style); 
        HSSFCell c18 = row1.createCell(12);   
        c18.setCellValue(new HSSFRichTextString("Resolved"));   
        c18.setCellStyle(style);         
        HSSFCell c19 = row1.createCell(13);   
        c19.setCellValue(new HSSFRichTextString("Opened"));   
        c19.setCellStyle(style); 
        
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)0,  (short)0)); //起始行，终止行，起始列，终止列
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)1,  (short)1));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)2,  (short)2));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)3,  (short)3));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)4,  (short)5));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)6,  (short)7));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)8,  (short)9));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)10,  (short)13));
        
        ResultSet rs=null;

		//rs = this.getResultSet_1(where);
		rs = this.getResultSet_1(where);
		int i = 0;
		try {
			while (rs.next()) {
					row=sheet.createRow((int)++i+1);
					row.createCell((short)0).setCellValue(new HSSFRichTextString(i+""));
					row.createCell((short)1).setCellValue(new HSSFRichTextString(rs.getString("DevModelName")));
					row.createCell((short)2).setCellValue(new HSSFRichTextString(rs.getString("Milestone")));
					row.createCell((short)3).setCellValue(new HSSFRichTextString(rs.getString("ProjType")));
					row.createCell((short)4).setCellValue(new HSSFRichTextString(rs.getString("PIAPlanDate")));
					row.createCell((short)5).setCellValue(new HSSFRichTextString(rs.getString("PIAActualDate"))); 
					row.createCell((short)6).setCellValue(new HSSFRichTextString(rs.getString("PVRPlanDate")));
					row.createCell((short)7).setCellValue(new HSSFRichTextString(rs.getString("PVRActualDate")));
					row.createCell((short)8).setCellValue(new HSSFRichTextString(rs.getString("PRAPlanDate")));
					row.createCell((short)9).setCellValue(new HSSFRichTextString(rs.getString("PRAActualDate")));
					row.createCell((short)10).setCellValue(new HSSFRichTextString(rs.getString("PLMTotal")));
					row.createCell((short)11).setCellValue(new HSSFRichTextString(rs.getString("PLMClosed")));
					row.createCell((short)12).setCellValue(new HSSFRichTextString(rs.getString("PLMResolved")));
					row.createCell((short)13).setCellValue(new HSSFRichTextString(rs.getString("PLMOpened")));

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
		String sql = "select * from project_model_ongoing "+where+" order by PLMTotal desc";
		System.out.println(sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}	
	
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

}
