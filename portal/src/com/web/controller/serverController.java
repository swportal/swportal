package com.web.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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

import com.web.controller.entity.Server;
import com.web.controller.service.ServerService;

@SuppressWarnings("deprecation")
@Controller
@RequestMapping("/server")
public class serverController {
	@Resource
	private ServerService serverService;
	
	@RequestMapping("/getServerList")
	public String getServerList(HttpServletRequest request,HttpServletResponse response){		
		return "/serverController/serverManager"; 
	}
	
	@RequestMapping(value="/findServerList",produces="application/json;charset=UTF-8")
	@ResponseBody
	/*public List<Server> findServerList(String keyword,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Server> serverList = null;
		serverList = serverService.findServerList(keyword);
		return serverList; 
	}*/
	
	public void findServerList(Integer curPage,String keyword,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Server> serverList = null;
		List<Server> serverList2 = null; //有关键字的情况
		Integer pageSize=20;
		Integer totalpage=(serverService.findAll().size()%pageSize==0)?(serverService.findAll().size()/pageSize):(serverService.findAll().size()/pageSize+1);
		serverList = serverService.findServerList(curPage,pageSize,keyword);	
		if(keyword.length()!=0){
			serverList2=serverService.findServerList(1, serverService.findAll().size(), keyword);
			totalpage=(serverList2.size()%pageSize==0)?(serverList2.size()/pageSize):(serverList2.size()/pageSize+1);
		}
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("serverList", serverList);
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
		//serverList = serverService.findServerList(keyword);
		//return serverList; 
	}
	@RequestMapping(value = "importExec", method = RequestMethod.GET)
	@ResponseBody
	public void importExec(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String fname = "serverlist";
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
        HSSFSheet sheet = workbook.createSheet("Server Info.");   
        //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("No"));   
        c0.setCellStyle(style);  

        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("IP")); 
        c1.setCellStyle(style);  

        HSSFCell c2 = row.createCell(2);   
        c2.setCellValue(new HSSFRichTextString("Server Name")); 
        c2.setCellStyle(style);  

        HSSFCell c3 = row.createCell(3);   
        c3.setCellValue(new HSSFRichTextString("Server Usage"));  
        c3.setCellStyle(style);  

        HSSFCell c4 = row.createCell(4);   
        c4.setCellValue(new HSSFRichTextString("CPU")); 
        c4.setCellStyle(style);  

        HSSFCell c5 = row.createCell(6);   
        c5.setCellValue(new HSSFRichTextString("Memory")); 
        c5.setCellStyle(style);  
        
        HSSFCell c6 = row.createCell(8);   
        c6.setCellValue(new HSSFRichTextString("HDD")); 
        c6.setCellStyle(style);  
        
        HSSFCell c7 = row.createCell(11);   
        c7.setCellValue(new HSSFRichTextString("OS Version")); 
        c7.setCellStyle(style);  
        
        HSSFCell c8 = row.createCell(12);   
        c8.setCellValue(new HSSFRichTextString("Manager")); 
        c8.setCellStyle(style);

        HSSFRow row1 = sheet.createRow(1);   
        HSSFCell c9 = row1.createCell(4); 
        c9.setCellValue(new HSSFRichTextString("Count"));   
        c9.setCellStyle(style);  
        HSSFCell c10 = row1.createCell(5); 
        c10.setCellValue(new HSSFRichTextString("Core Num."));   
        c10.setCellStyle(style);  
        HSSFCell c11 = row1.createCell(6); 
        c11.setCellValue(new HSSFRichTextString("Count"));   
        c11.setCellStyle(style);  
        HSSFCell c12 = row1.createCell(7); 
        c12.setCellValue(new HSSFRichTextString("Size (GB)"));   
        c12.setCellStyle(style); 
        HSSFCell c13 = row1.createCell(8); 
        c13.setCellValue(new HSSFRichTextString("Count"));   
        c13.setCellStyle(style);  
        HSSFCell c14 = row1.createCell(9); 
        c14.setCellValue(new HSSFRichTextString("Type"));   
        c14.setCellStyle(style);  
        HSSFCell c15 = row1.createCell(10); 
        c15.setCellValue(new HSSFRichTextString("Size (GB)"));   
        c15.setCellStyle(style);    
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)0,  (short)0));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)1,  (short)1));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)2,  (short)2));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)3,  (short)3));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)4,  (short)5));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)6,  (short)7));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)8,  (short)10));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)11,  (short)11));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)12,  (short)12));
       
        //List<Server> serverList =  serverService.findServerList("");
        List<Server> serverList =  serverService.findAll();
        for(int i=0;i<serverList.size();i++){
        	row=sheet.createRow((int)i+2);
        	Server server = (Server)serverList.get(i);
        	row.createCell((short)0).setCellValue(new HSSFRichTextString(i+1+""));
        	row.createCell((short)1).setCellValue(new HSSFRichTextString(server.getIp()));
        	row.createCell((short)2).setCellValue(new HSSFRichTextString(server.getName()));
        	row.createCell((short)3).setCellValue(new HSSFRichTextString(server.getUseFor()));
        	row.createCell((short)4).setCellValue(new HSSFRichTextString(String.valueOf(server.getCpuCount())));
        	row.createCell((short)5).setCellValue(new HSSFRichTextString(server.getCpuNumber()+""));
        	row.createCell((short)6).setCellValue(new HSSFRichTextString(server.getMemCount()+""));
        	row.createCell((short)7).setCellValue(new HSSFRichTextString(server.getMemSize()));
        	row.createCell((short)8).setCellValue(new HSSFRichTextString(server.getHddCount()+""));
        	row.createCell((short)9).setCellValue(new HSSFRichTextString(server.getHddType()));
        	row.createCell((short)10).setCellValue(new HSSFRichTextString(server.getHddSize()));
        	row.createCell((short)11).setCellValue(new HSSFRichTextString(server.getOsVersion()));
        	row.createCell((short)12).setCellValue(new HSSFRichTextString(server.getManager()));
        }
        
        try{   
	       /* File file = new File("d:/student.xls");
	        if(!file.exists())    
	        {    
	            try {    
	                file.createNewFile();    
	            } catch (IOException e) {    
	                // TODO Auto-generated catch block    
	                e.printStackTrace();    
	            }    
	        } */
	        //FileOutputStream  stream= new FileOutputStream(file); 
	        //workbook.write(stream); 
	        workbook.write(response.getOutputStream());  
		    // 第六步，将文件存到指定位置  
		    //stream.close();
	    }  
	    catch (Exception e)  
	    {  
	        e.printStackTrace();  
	    }  
	}
}
