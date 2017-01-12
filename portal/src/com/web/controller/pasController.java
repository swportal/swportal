package com.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;
import com.web.controller.entity.Trip;
import com.web.controller.service.PasService;
import com.web.controller.service.PasService;

@Controller
@RequestMapping("/pas")
public class pasController {
	@Resource
	private PasService pasService;
	
	@RequestMapping("/getPasList")
	public String getPasList(HttpServletRequest request,HttpServletResponse response){		
		return "/pasController/pasManager"; 
	}
	
	@RequestMapping(value="/findPasList",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void findPasList(Integer curPage,String keyword,String projectname,String city,String state,String milestone, String startdate,String enddate, String orderKey,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Pas> pasList = new ArrayList<Pas>();
		List<Pas> pasList2 = new ArrayList<Pas>(); //有关键字的情况
		Integer pageSize=20;
		Integer totalpage=(pasService.findAll().size()%pageSize==0)?(pasService.findAll().size()/pageSize):(pasService.findAll().size()/pageSize+1);
		pasList = pasService.findPasList(curPage,pageSize,keyword,projectname,city,state,milestone,startdate,enddate,orderKey);	
		if(projectname.length()!=0||milestone.length()!=0){  //有筛选条件， 就要更新list和total page
			pasList2=pasService.findPasList(1, pasService.findAll().size(), keyword,projectname,city,state,milestone,startdate,enddate,orderKey);
			totalpage=(pasList2.size()%pageSize==0)?(pasList2.size()/pageSize):(pasList2.size()/pageSize+1);
		}
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("pasList", pasList);
		        JSONObject memberpage = new JSONObject();
		        memberpage.put("curpage", curPage);
		        memberpage.put("totalpage", totalpage);
		        JSONObject memberupdatetime = new JSONObject();
		        memberupdatetime.put("updatetime",pasService.findAll().get(1).getUpdateTime().substring(0,19));
		        members.add(member);     
		        members.add(memberpage);  
		        members.add(memberupdatetime);
		        out.write(members.toString());
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		        out.flush();
		        out.close();    
		    }      
		 
		    out.flush();
		    out.close(); 
		//pasList = pasService.findPasList(keyword);
		//return pasList; 
	}
	
	
	@RequestMapping(value="/getCity",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void getCity(String state,HttpServletRequest request,HttpServletResponse response){
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 try {
			 	out= response.getWriter();
		        
		        if ("spt".equals(state)){
		        	JSONObject member = new JSONObject();
		        	member.put("city", "Basic");
		        	members.add(member);
		        	member.put("city", "Deriv");
		        	members.add(member);
		        } 
		        else if("pg".equals(state)){
		        	JSONObject member = new JSONObject();
		        	member.put("city", "HD");
		        	members.add(member);
		        	member.put("city", "LM");
		        	members.add(member);
		        	member.put("city", "MFM");
		        	members.add(member);
		        	member.put("city", "UT");
		        	members.add(member);
		        	member.put("city", "QT");
		        	members.add(member);
		        }
		        else if("ps".equals(state)){
		        	JSONObject member = new JSONObject();
		        	member.put("city", "Normal In Prog.");
		        	members.add(member);
		        	member.put("city", "Delay in Prog.");
		        	members.add(member);
		        	member.put("city", "Normal Compl.");
		        	members.add(member);
		        	member.put("city", "Delay Compl.");
		        	members.add(member);
		        }
		        else if("ms".equals(state)){
		        	JSONObject member = new JSONObject();
		        	member.put("city", "PIA");
		        	members.add(member);
		        	member.put("city", "PVR");
		        	members.add(member);
		        	member.put("city", "PRA");
		        	members.add(member);
		        	member.put("city", "SRA");
		        	members.add(member);
		        }
		        
		        out.write(members.toString());
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		        out.flush();
		        out.close();    
		    }      
		 
		    out.flush();
		    out.close(); 
	}
	
	@RequestMapping(value = "DownProject", method = RequestMethod.GET)
	@ResponseBody
	public void DownProject(String keyword,String projectname,String city,String state,String milestone, String startdate,String enddate, String orderKey,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Pas> pasList = null;
		pasList=pasService.findPasList(1, pasService.findAll().size(), keyword,projectname,city,state,milestone,startdate,enddate,orderKey);
		
		String fname = "Project List";
		response.reset();// 清空输出流
		response.setHeader("Content-disposition","attachment; filename=" + fname + ".xls");// 设定输出文件头
		response.setContentType("application/msexcel");//EXCEL格式  Microsoft excel
		//创建workbook   
        HSSFWorkbook workbook = new HSSFWorkbook(); 
        HSSFCellStyle style = workbook.createCellStyle();  
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
	    HSSFFont f  = workbook.createFont();  
	   // f.setColor(HSSFColor.RED.index);
	    f.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);//加粗 
	    style.setFont(f);
	    style.setFillForegroundColor(HSSFColor.LIME.index);   
	    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        //创建sheet页  
        HSSFSheet sheet = workbook.createSheet("Project List");   
      //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("NO"));   
        c0.setCellStyle(style); 
        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("Pjt. Name"));   
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
        HSSFCell c8 = row.createCell(14);   
        c8.setCellValue(new HSSFRichTextString("Dev PL"));   
        c8.setCellStyle(style); 
        HSSFCell c9 = row.createCell(15);   
        c9.setCellValue(new HSSFRichTextString("SW PL"));   
        c9.setCellStyle(style); 
        
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
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)14,  (short)14));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)15,  (short)15));
        
        for(int i=0;i<pasList.size();i++){
					row=sheet.createRow((int)i+2);
					Pas pas = (Pas)pasList.get(i);
					row.createCell((short)0).setCellValue(new HSSFRichTextString(i+1+""));
					row.createCell((short)1).setCellValue(new HSSFRichTextString(pas.getPjtName()));
					row.createCell((short)2).setCellValue(new HSSFRichTextString(pas.getMilestone()));
					row.createCell((short)3).setCellValue(new HSSFRichTextString(pas.getProjType()));
					row.createCell((short)4).setCellValue(new HSSFRichTextString(pas.getpIAPlanDate()));
					row.createCell((short)5).setCellValue(new HSSFRichTextString(pas.getpIAActualDate()));
					row.createCell((short)6).setCellValue(new HSSFRichTextString(pas.getpVRPlanDate())); 
					row.createCell((short)7).setCellValue(new HSSFRichTextString(pas.getpVRActualDate()));
					row.createCell((short)8).setCellValue(new HSSFRichTextString(pas.getpRAPlanDate()));
					row.createCell((short)9).setCellValue(new HSSFRichTextString(pas.getpRAActualDate()));
					row.createCell((short)10).setCellValue(new HSSFRichTextString(String.valueOf(pas.getpLMTotal())));
					row.createCell((short)11).setCellValue(new HSSFRichTextString(String.valueOf(pas.getpLMClosed())));
					row.createCell((short)12).setCellValue(new HSSFRichTextString(String.valueOf(pas.getpLMResolved())));
					row.createCell((short)13).setCellValue(new HSSFRichTextString(String.valueOf(pas.getpLMOpened())));
					row.createCell((short)14).setCellValue(new HSSFRichTextString(pas.getDevPL()));
					row.createCell((short)15).setCellValue(new HSSFRichTextString(pas.getsWEM()));

		}
		try{   
	        workbook.write(response.getOutputStream());  
	    }  
	    catch (Exception e)  {  
	        e.printStackTrace();  
	    }  
	}
}