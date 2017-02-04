package com.web.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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

import com.web.controller.entity.Model;
import com.web.controller.service.ModelService;

@SuppressWarnings("deprecation")
@Controller
@RequestMapping("/model")
public class modelController {
	@Resource
	private ModelService modelService;
	
	@RequestMapping("/getModel")
	public String getModel( String projectname,HttpServletRequest request,HttpServletResponse response){		
		request.setAttribute("projectname", projectname);
		return "/modelController/modelManager"; 
	}
	
	@RequestMapping(value="/findModelList",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void findModelList(Integer curPage,String projectname,HttpServletRequest request,HttpServletResponse response){
		String where="where m.pjtName like'%"+projectname+"%'";
		
		
		List<Model> modelList = new ArrayList<Model>();
		List<Model> whereList = new ArrayList<Model>();
		Integer pageSize=10;
		
		modelList = modelService.findModelList(curPage,pageSize,where);	
		whereList = modelService.findAllWhere(where);	
		Integer totalpage=(whereList.size()%pageSize==0)?(whereList.size()/pageSize):(whereList.size()/pageSize+1);
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("modelList", modelList);
		        JSONObject memberpage = new JSONObject();
		        memberpage.put("curpage", curPage);
		        memberpage.put("totalpage", totalpage);
		        members.add(member);     
		        members.add(memberpage);    
		        out.write(members.toString());
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		        out.flush();
		        out.close();    
		    }      
		 
		    out.flush();
		    out.close(); 
		//modelList = modelService.findModelList(keyword);
		//return modelList; 
	}
	
	
	
	@RequestMapping(value = "DownModel", method = RequestMethod.GET)
	@ResponseBody
	public void DownModel(String projectname,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		List<Model> modelList = new ArrayList<Model>();
		String where="where m.pjtName like'%"+projectname+"%'";
		modelList = modelService.findAllWhere(where);	
		//modelList=modelService.findModelList(1, modelService.findAll().size(), keyword,projectname,city,state,milestone,startdate,enddate,orderKey);
		
		String fname = "Model List";
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
        c3.setCellValue(new HSSFRichTextString("Dev. Type"));   
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
        
        for(int i=0;i<modelList.size();i++){
					row=sheet.createRow((int)i+2);
					Model model = (Model)modelList.get(i);
					row.createCell((short)0).setCellValue(new HSSFRichTextString(i+1+""));
					row.createCell((short)1).setCellValue(new HSSFRichTextString(model.getDevModelName()));
					row.createCell((short)2).setCellValue(new HSSFRichTextString(model.getMilestone()));
					row.createCell((short)3).setCellValue(new HSSFRichTextString(model.getDevType()));
					row.createCell((short)4).setCellValue(new HSSFRichTextString(model.getpIAPlanDate()));
					row.createCell((short)5).setCellValue(new HSSFRichTextString(model.getpIAActualDate()));
					row.createCell((short)6).setCellValue(new HSSFRichTextString(model.getpVRPlanDate())); 
					row.createCell((short)7).setCellValue(new HSSFRichTextString(model.getpVRActualDate()));
					row.createCell((short)8).setCellValue(new HSSFRichTextString(model.getpRAPlanDate()));
					row.createCell((short)9).setCellValue(new HSSFRichTextString(model.getpRAActualDate()));
					row.createCell((short)10).setCellValue(new HSSFRichTextString(String.valueOf(model.getpLMTotal())));
					row.createCell((short)11).setCellValue(new HSSFRichTextString(String.valueOf(model.getpLMClosed())));
					row.createCell((short)12).setCellValue(new HSSFRichTextString(String.valueOf(model.getpLMResolved())));
					row.createCell((short)13).setCellValue(new HSSFRichTextString(String.valueOf(model.getpLMOpened())));

		}
		try{   
	        workbook.write(response.getOutputStream());  
	    }  
	    catch (Exception e)  {  
	        e.printStackTrace();  
	    }  
	}
}
