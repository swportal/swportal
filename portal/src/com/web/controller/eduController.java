package com.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.web.controller.entity.Education;
import com.web.controller.service.EduService;

@SuppressWarnings("deprecation")
@Controller
@RequestMapping("/edu")
public class eduController {
	@Resource
	private EduService eduService;
	@RequestMapping("/eduTop")
	public String eduTop(HttpServletRequest request,HttpServletResponse response){		
		return "/eduController/eduTop"; 
	}
	
	@RequestMapping("/eduBL")
	public String eduBL(HttpServletRequest request,HttpServletResponse response){		
		return "/eduController/eduBL"; 
	}
	@RequestMapping("/eduMD")
	public String eduMD(HttpServletRequest request,HttpServletResponse response){		
		return "/eduController/eduMD"; 
	}
	@RequestMapping("/eduBR")
	public String eduBR(HttpServletRequest request,HttpServletResponse response){		
		return "/eduController/eduBR"; 
	}
	
	@RequestMapping("/getEduList")
	public String getEduList(HttpServletRequest request,HttpServletResponse response){		
		return "/eduController/eduManager"; 
	}
	
	@RequestMapping(value="/getAllEdu",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Education> getAllEdu(HttpServletRequest request,HttpServletResponse response){
		List<Education> eduList = eduService.findAll();			
		return eduList; 
	}
	/*
	@RequestMapping(value="/findEduList",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Education> findEduList(Long curpage,String keyword, String orderItem, String orderKey, HttpServletRequest request,HttpServletResponse response){
		System.out.println(curpage);
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Education> eduList = null;
		eduList = eduService.findEduList(curpage,keyword, orderItem,orderKey);	
		
		return eduList; 
	}*/
	
	@RequestMapping(value="/findEduList")
	@ResponseBody
	public void findEduList(Integer curpage,String keyword, String orderItem, String orderKey, HttpServletRequest request,HttpServletResponse response){
		System.out.println(curpage);
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Education> eduList = null;
		List<Education> eduList2 = null;
		Integer pageSize=12;
		Integer totalpage=(eduService.findAll().size()%pageSize==0)?(eduService.findAll().size()/pageSize):(eduService.findAll().size()/pageSize+1);
		eduList = eduService.findEduList(curpage,pageSize,keyword, orderItem,orderKey);	
		if(keyword.length()!=0){
			eduList2=eduService.findEduList(1, eduService.findAll().size(), keyword, orderItem, orderKey);
			totalpage=(eduList2.size()%pageSize==0)?(eduList2.size()/pageSize):(eduList2.size()/pageSize+1);
		}
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("eduList", eduList);
		        JSONObject memberpage = new JSONObject();
		        memberpage.put("curpage", curpage);
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
		//return eduList; 
	}
	
	@RequestMapping(value = "importExec", method = RequestMethod.GET)
	@ResponseBody
	public void importExec(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String fname = "training list";
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
        HSSFSheet sheet = workbook.createSheet("Trainning Mgmt.");   
        //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("No"));   
        c0.setCellStyle(style);  

        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("Category")); 
        c1.setCellStyle(style);  

        HSSFCell c2 = row.createCell(3);   
        c2.setCellValue(new HSSFRichTextString("Title/Contents")); 
        c2.setCellStyle(style);  

        HSSFCell c3 = row.createCell(4);   
        c3.setCellValue(new HSSFRichTextString("Trainer"));  
        c3.setCellStyle(style);  

        HSSFCell c4 = row.createCell(6);   
        c4.setCellValue(new HSSFRichTextString("Schedule")); 
        c4.setCellStyle(style);  

        HSSFCell c5 = row.createCell(8);   
        c5.setCellValue(new HSSFRichTextString("Trainee")); 
        c5.setCellStyle(style);  
        
        HSSFCell c6 = row.createCell(10);   
        c6.setCellValue(new HSSFRichTextString("Training Mat.")); 
        c6.setCellStyle(style);  
       

        HSSFRow row1 = sheet.createRow(1);   
        HSSFCell c7 = row1.createCell(4); 
        c7.setCellValue(new HSSFRichTextString("Name"));   
        c7.setCellStyle(style);  
        HSSFCell c8 = row1.createCell(5); 
        c8.setCellValue(new HSSFRichTextString("Department"));   
        c8.setCellStyle(style);  
        HSSFCell c9 = row1.createCell(6); 
        c9.setCellValue(new HSSFRichTextString("Date"));   
        c9.setCellStyle(style);  
        HSSFCell c10 = row1.createCell(7); 
        c10.setCellValue(new HSSFRichTextString("Duration"));   
        c10.setCellStyle(style); 
       
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)0,  (short)0));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)1,  (short)2));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)3,  (short)3));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)4,  (short)5));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)6,  (short)7));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)8,  (short)9));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)10,  (short)10));
       
        List<Education> eduList =  eduService.findAll();
        for(int i=0;i<eduList.size();i++){
        	row=sheet.createRow((int)i+2);
        	Education edu = (Education)eduList.get(i);
        	row.createCell((short)0).setCellValue(new HSSFRichTextString(i+1+""));
        	row.createCell((short)1).setCellValue(new HSSFRichTextString(edu.getCategory()));
        	row.createCell((short)2).setCellValue(new HSSFRichTextString(edu.getCateclass()));
        	row.createCell((short)3).setCellValue(new HSSFRichTextString(edu.getContents()));
        	row.createCell((short)4).setCellValue(new HSSFRichTextString(edu.getTrainerName()));
        	row.createCell((short)5).setCellValue(new HSSFRichTextString(edu.getDepartment()));
        	row.createCell((short)6).setCellValue(new HSSFRichTextString(edu.getSchedule()));
        	row.createCell((short)7).setCellValue(new HSSFRichTextString(edu.getDuration()));
        	row.createCell((short)8).setCellValue(new HSSFRichTextString(edu.getTraineeObject()));
        	row.createCell((short)9).setCellValue(new HSSFRichTextString(edu.getTraineeTotal()));
        	row.createCell((short)10).setCellValue(new HSSFRichTextString(edu.getMaterials()));
        }
        
        try{   
	          workbook.write(response.getOutputStream());  
	    }  
	    catch (Exception e){  
	        e.printStackTrace();  
	    }  
	}
	
	@RequestMapping("/toAddEdu")
	public String toAddEdu(HttpServletRequest request){		
		return "/eduController/saveEdu";
	}
	
	@RequestMapping("/addEdu")
	public String addEdu(Education edu,HttpServletResponse response){	
		if(edu.getCategory()==null)
			edu.setCategory("Internal");
		if(edu.getType()==null)
			edu.setType("");
		if(edu.getCateclass()==null)
			edu.setCateclass("Tech.");
		
		
		
		if(edu.getContents()==null)
			edu.setContents("");
		
		if(edu.getTrainerName()==null)
			edu.setTrainerName("");
		if(edu.getDepartment()==null)
			edu.setDepartment("SW Group");
		
		if(edu.getSchedule()==null)
			edu.setSchedule("");
		if(edu.getDuration()==null)
			edu.setDuration("");
		
		 
		
		if(edu.getTrainee()==null)
			edu.setTrainee("");		
		if(edu.getTraineeObject()==null)
			edu.setTraineeObject("SW Group");
		if(edu.getTraineeTotal()==null)
			edu.setTraineeTotal("");
		if(edu.getCoverage()==null)
			edu.setCoverage("");
		
		if(edu.getTrainingTime()==null)
			edu.setTrainingTime("");
		if(edu.getTrainingDiffculty()==null)
			edu.setTrainingDiffculty("");
		if(edu.getTrainerEvaluation()==null)
			edu.setTrainerEvaluation("");
		
		if(edu.getMaterials()==null)
			edu.setMaterials("http://mosaic.sec.samsung.net/club/club.menu.docs.list.screen?p_club_id=31153&p_menu_id=15&p_group_id=14&&#1:C76F");
		if(edu.getFilename()==null)
			edu.setFilename("");
		if(edu.getIp()==null)
			edu.setIp("");
		if(edu.getUploadTime()==null)
			edu.setUploadTime("");
		eduService.save(edu);
		
		JSONObject data = new JSONObject();
		try {
			data.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
	    try {
	    	out=response.getWriter();
	        out.write(data.toString());
	       
			return null;
	    } catch (IOException e) {
	        e.printStackTrace();
	    } finally{
	    	 out.flush();
			 out.close();	
	    }
	    
		return "redirect:/edu/getAllEdu";
	}
	
	@RequestMapping("/updateEdu")
	public String updateEdu(Long id,String item,String value,HttpServletResponse response){
		//String result = "{\"result\":\"success\"}";
		try {
			URLDecoder.decode(value,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		eduService.updateById(id,item,value);
		
		JSONObject data = new JSONObject();
		try {
			data.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
	    try {
	    	out=response.getWriter();
	        out.write(data.toString());
	        out.flush();
			out.close();	
			return null;
	    } catch (IOException e) {
	        e.printStackTrace();
	    }	   
		return "redirect:/edu/getAllEdu";
	}
	@RequestMapping("/delEduList")
	public void delEduList(Long[] ids,HttpServletResponse response){
		String result = "{\"result\":\"success\"}";
		List<Education> edulistEducations = eduService.getByIds(ids);
		for(Education edu:edulistEducations){
			eduService.delete(edu.getId());
		}
		
		PrintWriter out = null;
	    response.setContentType("application/json");
	    try {
	    	out=response.getWriter();
	        out.write(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}	
	
	@RequestMapping("/delEdu")
	public void delEdu(Long id,HttpServletResponse response){
		String result = "{\"result\":\"success\"}";
		eduService.delete(id);
		PrintWriter out = null;
	    response.setContentType("application/json");
	    try {
	    	out=response.getWriter();
	        out.write(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    //System.out.println("---------------------------------------------------------------result");
	}	
	/*@RequestMapping("/changeUrl")
	public String changeUrl(Long id, String item, String value, HttpServletRequest request){
		request.setAttribute("id",id);
		request.setAttribute("item",item);
		request.setAttribute("value",value);
		//System.out.println(id);
		return "/eduController/eduURL"; 
	}	*/
	
	
	@RequestMapping("/getCategory")
	@ResponseBody
	public void getCategory(HttpServletRequest request,HttpServletResponse response){
		Long techCount = eduService.getTechCount();
		Long procCount = eduService.getProcCount();
		Long toolCount = eduService.getToolCount();
		int categoryTotal = eduService.findAll().size();
    	//request.getSession().setAttribute("eduTotal", categoryTotal);
		response.reset();
	    response.setCharacterEncoding("UTF-8");
	    //response.setContentType("application/json;charset=utf-8");
	    response.setContentType("text/html");
	     
	    JSONArray members = new JSONArray();
	    PrintWriter out= null;
	    try {
	    		out= response.getWriter();
	            JSONObject member = new JSONObject();
	            member.put("techCount", techCount);
	            member.put("procCount", procCount);
	            member.put("toolCount",toolCount);
	            member.put("total",categoryTotal);
	            members.add(member);               
	            out.write(members.toString());
	         
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        out.flush();
	        out.close();    
	    }      
	 
	    out.flush();
	    out.close();    
	}
	
	@RequestMapping("/getEduPart")
	@ResponseBody
	public void getEduPart(HttpServletRequest request,HttpServletResponse response){
		Long intCount = eduService.getIntCount();
		Long extCount = eduService.getExtCount();
		
		response.reset();
	    response.setCharacterEncoding("UTF-8");
	    //response.setContentType("application/json;charset=utf-8");
	    response.setContentType("text/html");
	     
	    JSONArray members = new JSONArray();
	    PrintWriter out= null;
	    try {
	    		out= response.getWriter();
	            JSONObject member = new JSONObject();
	            member.put("intCount", intCount);
	            member.put("extCount", extCount);	           
	            members.add(member);               
	            out.write(members.toString());
	         
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        out.flush();
	        out.close();    
	    }      
	 
	    out.flush();
	    out.close();    
	}
	
	@RequestMapping(value="/getTrainee",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Education> getTrainee(HttpServletRequest request,HttpServletResponse response){
		
		List<Education> traineeList = null;
		/*if(keyword.length()==0){
			eduList = eduService.findAll();		
		}			
		else{*/
		traineeList = eduService.findTraineeTopList();		
		//}			
		return traineeList; 
	}
	
	
	
	@RequestMapping("/changeUrl")
	public String changeUrl(HttpServletRequest request){
		//request.setAttribute("id",id);
		//request.setAttribute("item",item);
		List<Education> edu = eduService.findAll();
		String url=edu.get(0).getMaterials();
		request.setAttribute("value",url);
		//System.out.println(id);
		return "/eduController/eduURL"; 
	}	
	
	@RequestMapping("/updateUrl")
	public String updateUrl(String value,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(value,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		eduService.updateByIds("materials",value);
		request.setAttribute("url", value);
		JSONObject data = new JSONObject();
		try {
			data.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
	    try {
	    	out=response.getWriter();
	        out.write(data.toString());
	        out.flush();
			out.close();	
			return null;
	    } catch (IOException e) {
	        e.printStackTrace();
	    }	   
		return "redirect:/edu/getAllEdu";
		
	}	
	
	@RequestMapping("/getUrl")
	public void getUrl(HttpServletRequest request,HttpServletResponse response){
		/*List<Education> edu = eduService.findAll();
		request.setAttribute("url",edu.get(0).getMaterials());*/
		String result = "{\"url\":url}";
		
		PrintWriter out = null;
	    response.setContentType("application/json");
	    try {
	    	out=response.getWriter();
	        out.write(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
		
	}	
	/*
	@RequestMapping(value = "/upload", method = RequestMethod.POST)  
	public String upload(@RequestParam("file") MultipartFile image, Long id,HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		// 转型为MultipartHttpRequest  
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
        // 根据前台的name名称得到上传的文件  
        MultipartFile file = multipartRequest.getFile("file");  
        // 获得文件名：  
        String realFileName = file.getOriginalFilename();  
        // 获取路径  
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));

        File dirPath = new File(ctxPath+File.separator+"upload"+File.separator+"training"+File.separator);
        System.out.println("路径" + dirPath);  
      
        if (!dirPath.exists()) {  
            dirPath.mkdir();  
        } 
        else{
            System.out.println("文件夹已经存在");
        }
        File uploadFile = new File(dirPath +File.separator+ realFileName);  
        FileCopyUtils.copy(file.getBytes(), uploadFile);  
        request.setAttribute("files", loadFiles(request));  
        
        eduService.updateById(id,"filename",realFileName);
        eduService.updateById(id,"ip",request.getRemoteHost());
        request.setAttribute("ip", request.getRemoteHost());
        //List<String> a = loadFiles(request);
		return "/eduController/success"; 
	}
	*/
	
	@RequestMapping("/toUpload")
	public String toUpload(Long id, HttpServletRequest request){
		/*
		 * 2016-11-24 add for list files by wuliying
		 */
		String fileStr = eduService.getById(id).getFilename();
		String	timeStr = eduService.getById(id).getUploadTime();
		String	ipStr = eduService.getById(id).getIp();
		List<String> fileList = new ArrayList<String>(); 
		List<String> timeList = new ArrayList<String>(); 
		List<String> ipList = new ArrayList<String>(); 
		if(fileStr.length()!=0){        
			String[] list = null;
			String[] list2 = null;
			String[] list3 = null;
						
			list=fileStr.split(",");		
			list2=timeStr.split(",");
			list3=ipStr.split(",");
			
			for(int i=0;i<list.length;i++){				
				fileList.add(list[i]);
			}
			for(int i=0;i<list2.length;i++){	
				timeList.add(list2[i]);
			}
			for(int i=0;i<list3.length;i++){	
				ipList.add(list3[i]);
			}
		}			
		request.setAttribute("files", fileList);
		request.setAttribute("times", timeList);
		request.setAttribute("ips", ipList);
		
		
		request.setAttribute("id",id);
		return "/eduController/toUpload"; 
	}	
	
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)  
	public String upload(@RequestParam("files") MultipartFile files[], Long id,HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		String realFileName = "";
		String fileStr = "";
		String timeStr = "";
		String ipStr = "";
		//定义存放 file list和time list和ip list的 List
        /*
		 * 2016-11-24 add by wuliying(timeList，ipList)
		 */
		List<String> fileList = new ArrayList<String>(); 
        List<String> timeList = new ArrayList<String>(); 
        List<String> ipList = new ArrayList<String>(); 
		/*
		 * 2016-11-24 add by wuliying
		 */
		SimpleDateFormat formatter = null; 
        formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss"); 
		if(files!=null&&files.length>0){
			for(int i = 0;i<files.length;i++){
				MultipartFile file=files[i];
				realFileName = file.getOriginalFilename(); 
				if("".equals(realFileName)) continue;
				 
				String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));
		        File uploadFile = new File(ctxPath+File.separator+"upload"+File.separator+"training"+File.separator + realFileName);
		        if(uploadFile.exists()){
		        	deleteFile(uploadFile,realFileName,id,fileList,timeList,ipList);
		        }
				try{
					/*
					 * 2016-11-24 add time,ip
					 */
					fileStr+=","+realFileName;
					timeStr+=","+formatter.format(new Date());
					ipStr+=","+request.getRemoteHost();
					System.out.println("路径" + uploadFile);  
			        FileCopyUtils.copy(file.getBytes(), uploadFile);
				}
				catch(Exception e){
					e.printStackTrace();
				}
			} //for
			
			String origFile=eduService.getById(id).getFilename(); //原来有没有文件？
			if(origFile.length()==0){	//原来没有文件， 去掉前面的,
				/*
				 * 2016-11-24 add by wuliying
				 */
				fileStr = fileStr.substring(1,fileStr.length());
				timeStr = timeStr.substring(1,timeStr.length());
				ipStr = ipStr.substring(1,ipStr.length());
			}
			else{//原来有文件， 直接加
				fileStr = eduService.getById(id).getFilename() + fileStr;
				timeStr = eduService.getById(id).getUploadTime() + timeStr;
				ipStr = eduService.getById(id).getIp() + ipStr;
			}
			
			eduService.updateById(id,"filename",fileStr);
	        eduService.updateById(id,"uploadTime",timeStr);
	        eduService.updateById(id,"ip",ipStr);   
	        
	        fileList.clear();
        	timeList.clear();
        	ipList.clear();
	        
			String[] list = null;
			String[] list2 = null;
			String[] list3 = null;
			
			list=fileStr.split(",");
			list2=timeStr.split(",");
			list3=ipStr.split(",");
			
			for(int i=0;i<list.length;i++){
				fileList.add(list[i]);
			}
			for(int i=0;i<list2.length;i++){
				timeList.add(list2[i]);
			}
			for(int i=0;i<list3.length;i++){
				ipList.add(list3[i]);
			}
			request.setAttribute("files", fileList);
			request.setAttribute("times", timeList);
			request.setAttribute("ips", ipList);        
	        request.setAttribute("id", id);  //防止id丢失
		}//if
        return "/eduController/toUpload";
		//return "/eduController/success";  //2016-11-24 wuliying  change for reload the upload page 
	}
	/*
	 * 2014-11-24 wuliying
	 * Delete function
	 */
	@RequestMapping("/delete/{fileName:.*}")  
    public String delete(@PathVariable("fileName") String fileName,Long id,HttpServletRequest request, HttpServletResponse response) throws Exception { 
		String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));
        File delFile = new File(ctxPath+File.separator+"upload"+File.separator+"training"+File.separator + fileName);
        //System.out.println(delFile);
        //存不带， 的list,传给前台
        List<String> fileList = new ArrayList<String>(); 
        List<String> timeList = new ArrayList<String>(); 
        List<String> ipList = new ArrayList<String>(); 
        
		if(delFile.exists()){
			deleteFile(delFile,fileName,id,fileList,timeList,ipList);

			request.setAttribute("files", fileList);
			request.setAttribute("times", timeList);
			request.setAttribute("ips", ipList);
	        request.setAttribute("id", id);
		}
        return "/eduController/toUpload";
	}
	
	public void deleteFile(File file, String fileName, Long id,List<String> fileList,List<String> timeList,List<String> ipList) { 
		file.delete();
		
        //删除前当前filename， uploadtime， ip
        String	fileStr = eduService.getById(id).getFilename();
        String	timeStr = eduService.getById(id).getUploadTime();
        String	ipStr = eduService.getById(id).getIp();
       
        
		String[] list = null;
		String[] list2 = null;
		String[] list3 = null;
		
		list=fileStr.split(",");		
		list2=timeStr.split(",");
		list3=ipStr.split(",");
		
		Integer ind=0;
		//存数据库的字符串
		String fileup="";
		String timeup="";
		String ipup="";
		StringBuffer files= new StringBuffer("");
		StringBuffer times= new StringBuffer("");
		StringBuffer ips= new StringBuffer("");
		for(int i=0;i<list.length;i++){
			if(fileName.equals(list[i])){
				ind=i;
				continue;
			}
			fileList.add(list[i]);
			files.append(",").append(list[i]);
		}
		for(int i=0;i<list2.length;i++){
			if(i==ind) continue;
			timeList.add(list2[i]);
			times.append(",").append(list2[i]);
		}
		for(int i=0;i<list3.length;i++){
			if(i==ind) continue;
			ipList.add(list3[i]);
			ips.append(",").append(list3[i]);
		}
		//去掉前面的，
		if(files.length()!=0&&times.length()!=0&&ips.length()!=0){
			fileup=(String)files.substring(1,files.length());
			timeup=(String)times.substring(1,times.length());
			ipup=(String)ips.substring(1,ips.length());
		}
		eduService.updateById(id,"filename", fileup);
		eduService.updateById(id,"uploadTime",timeup);
		eduService.updateById(id,"ip",ipup);
	}
	
	public List<String> loadFiles(HttpServletRequest request) {  
        List<String> files = new ArrayList<String>();  
        /*String ctxPath = request.getSession().getServletContext()  
        		 .getRealPath("/download/training/")  
                 + "/" ; 
        File file = new File(ctxPath);  */
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));

        File file = new File(ctxPath+File.separator+"upload"+File.separator+"training"+File.separator);
        
        if (file.exists()) {  
            File[] fs = file.listFiles();  
            String fname = null;  
            for (File f : fs) {  
                if (f.isFile()) {  
                    fname=f.getName();  
                    files.add(fname);  
                }  
            }  
        }  
        return files;  
    }  
	@RequestMapping("/download/{fileName:.*}")  
    public void download(@PathVariable("fileName") String fileName,  
            HttpServletRequest request, HttpServletResponse response)  
            throws Exception {  
        response.setContentType("text/html;charset=utf-8");  
        java.io.BufferedInputStream bis = null;  
        java.io.BufferedOutputStream bos = null;  
       /* String ctxPath = request.getSession().getServletContext()  
        		 .getRealPath("/download/training/")  
                 + "/" ; 
        String downLoadPath = ctxPath + fileName;  */
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")))+File.separator+"upload"+File.separator+"training"+File.separator;
        String downLoadPath = ctxPath + fileName;  
        System.out.println(downLoadPath);  
        try {  
            long fileLength = new File(downLoadPath).length();  
            response.setContentType("application/x-msdownload;");  
            response.setHeader("Content-disposition", "attachment; filename="
            		+java.net.URLEncoder.encode(fileName, "UTF-8").replace("+","%20"));
                   // + new String(fileName.getBytes("ISO8859-1"), "utf-8"));  
            response.setHeader("Content-Length", String.valueOf(fileLength));  
            bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
            bos = new BufferedOutputStream(response.getOutputStream());  
            byte[] buff = new byte[2048];  
            int bytesRead;  
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
                bos.write(buff, 0, bytesRead);  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (bis != null)  
                bis.close();  
            if (bos != null)  
                bos.close();  
        }  
    }  
	/*
	 * 2016-11-24 wuliying add times items
	 */
	@RequestMapping("/getFileList")
	public String getFileList(Long id, HttpServletRequest request){
		List<String> fileList = new ArrayList<String>(); 
		List<String> timeList = new ArrayList<String>();
		String[] list = null;
		String[] list2 = null;
		list=eduService.getById(id).getFilename().split(",");
		list2=eduService.getById(id).getUploadTime().split(",");
		for(int i=0;i<list.length;i++){
			fileList.add(list[i]);
		}
		for(int i=0;i<list2.length;i++){
			timeList.add(list2[i]);
		}
		request.setAttribute("files", fileList);
		request.setAttribute("times", timeList);
		
		return "/eduController/success"; 
	}	
}
