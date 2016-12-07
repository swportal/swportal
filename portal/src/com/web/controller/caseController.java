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

import com.web.controller.entity.Case;
import com.web.controller.service.CaseService;

@Controller
@RequestMapping("/case")
public class caseController {
	@Resource
	private CaseService caseService;
	
	@RequestMapping("/caseTop")
	public String caseTop(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/caseTop"; 
	}
	
	@RequestMapping("/caseType")
	public String caseType(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/caseType"; 
	}
	@RequestMapping("/caseChip")
	public String caseChip(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/caseChip"; 
	}
	@RequestMapping("/casePhase")
	public String casePhase(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/casePhase"; 
	}
	@RequestMapping("/caseImprove")
	public String caseImprove(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/caseImprove"; 
	}
	@RequestMapping("/getCaseList")
	public String getCaseList(HttpServletRequest request,HttpServletResponse response){		
		return "/caseController/caseManager"; 
	}
	
	@RequestMapping(value="/findCaseList")
	@ResponseBody
	public void findCaseList(Integer curpage,String keyword, String orderItem, String orderKey,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Case> caseList = null;
		List<Case> caseList2 = null;
		Integer pageSize=7;
		Integer totalpage=(caseService.findAll().size()%pageSize==0)?(caseService.findAll().size()/pageSize):(caseService.findAll().size()/pageSize+1);
		
		caseList = caseService.findCaseList(curpage,pageSize,keyword, orderItem, orderKey);
		if(keyword.length()!=0){
			caseList2=caseService.findCaseList(1,caseService.findAll().size(),keyword, orderItem, orderKey);
			totalpage=(caseList2.size()%pageSize==0)?(caseList2.size()/pageSize):(caseList2.size()/pageSize+1);
		}
		 JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("caseList", caseList);
		       
		        member.put("curpage", curpage);
		        member.put("totalpage", totalpage);
		        members.add(member);     
		        out.write(members.toString());
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		        out.flush();
		        out.close();    
		    }      
		 
		    out.flush();
		    out.close();  
		//return eduList; 
		
		List<Case> models=null;
		models=caseService.findDistinctModel();
		request.getSession().setAttribute("models", models);
		
		List<Case> types=null;
		types=caseService.findDistinctType();
		request.getSession().setAttribute("types", types);
		
		List<Case> chips=null;
		chips=caseService.findDistinctChip();
		request.getSession().setAttribute("chips", chips);
		
		//String a ="";
		
		//return caseList; 
	}
	
	@RequestMapping(value="/findModelList",produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Case> findModelList(String keyword,String item,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}		
		List<Case> modelList=null;
		modelList=caseService.findModelList(keyword,item);		
		//String a ="";		
		return modelList; 
	}
	
	@RequestMapping("/addCase")
	public String addCase(Case issue,HttpServletResponse response){	
		if(issue.getProdType()==null)
			issue.setProdType("");
		if(issue.getChipset()==null)
			issue.setChipset("");
		if(issue.getModel()==null)
			issue.setModel("");
		if(issue.getDescription()==null)
			issue.setDescription("");
		if(issue.getOccurTime()==null)
			issue.setOccurTime("");
		if(issue.getOccurSite()==null)
			issue.setOccurSite("");
		if(issue.getOccurPhase()==null)
			issue.setOccurPhase("MP");
		if(issue.getOccurType()==null)
			issue.setOccurType("SW");
		if(issue.getVersion()==null)
			issue.setVersion("");
		if(issue.getRootReason()==null)
			issue.setRootReason("");
		if(issue.getUnknownReason()==null)
			issue.setUnknownReason("");
		if(issue.getMeasureDev()==null)
			issue.setMeasureDev("");
		if(issue.getMeasureTest()==null)
			issue.setMeasureTest("");
		if(issue.getMeasureType()==null)
			issue.setMeasureType("SW->SW");
		if(issue.getPersonINCharge()==null)
			issue.setPersonINCharge("");
		if(issue.getPropagation()==null)
			issue.setPropagation("");
		if(issue.getGmapRegister()==null)
			issue.setGmapRegister("");
		if(issue.getImprovedType()==null)
			issue.setImprovedType("Process");
		if(issue.getChecklistUpdate()==null)
			issue.setChecklistUpdate("");
		if(issue.getTcUpdate()==null)
			issue.setTcUpdate("");
		if(issue.getPlmRegister()==null)
			issue.setPlmRegister("");
		if(issue.getReport()==null)
			issue.setReport("http://mosaic.sec.samsung.net/club/club.menu.docs.list.screen?p_club_id=31153&p_menu_id=48&p_group_id=47#2:5EC3");
		if(issue.getFilename()==null)
			issue.setFilename("");
		if(issue.getIp()==null)
			issue.setIp("");
		if(issue.getUploadTime()==null)
			issue.setUploadTime("");
		if(issue.getConfirmy()==null)
			issue.setConfirmy("N");
		caseService.save(issue);
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
	    
		return "redirect:/case/getCaseList";
	}
	
	@RequestMapping("/delCaseList")
	public void delCaseList(Long[] ids,HttpServletResponse response){	
		String result = "{\"result\":\"success\"}";
		List<Case> caseList = caseService.getByIds(ids);
		for(Case issue:caseList){
			caseService.delete(issue.getId());
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
	
	@RequestMapping("/updateCase")
	public String updateCase(Long id,String item,String value,HttpServletResponse response){
		//String result = "{\"result\":\"success\"}";
		try {
			URLDecoder.decode(value,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		caseService.updateById(id,item,value);
		
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
		return "redirect:/case/getCaseList";
	}
	@RequestMapping("/confirmCase")
	public String confirmCase(Long id,String item,HttpServletResponse response){
		//String result = "{\"result\":\"success\"}";
		if("Y".equals(caseService.getById(id).getConfirmy()))
			caseService.updateById(id,item,"N");
		else
			caseService.updateById(id,item,"Y");
		
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
		return "redirect:/case/getCaseList";
	}
	
	@RequestMapping("/changeUrl")
	public String changeUrl(Long id, HttpServletRequest request){
		request.setAttribute("id",id);
		//request.setAttribute("item",item);
		//request.setAttribute("value",value);
		//System.out.println(id);
		return "/caseController/caseURL"; 
	}	
	
	@RequestMapping("/getCaseType")
	@ResponseBody
	public void getCaseType(HttpServletRequest request,HttpServletResponse response){
		Long dtvCount = caseService.getDTVCount();
		Long mfmCount = caseService.getMFMCount();
		Long hotelCount = caseService.getHotelCount();
		Long monitorCount = caseService.getMonitorCount();
		Long appCount = caseService.getAPPCount();
		int typeTotal = caseService.findAll().size();
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
	            member.put("dtvCount", dtvCount);
	            member.put("mfmCount", mfmCount);
	            member.put("hotelCount",hotelCount);
	            member.put("monitorCount",monitorCount);
	            member.put("appCount",appCount);
	            member.put("total",typeTotal);
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
	
	@RequestMapping("/getChipset")
	@ResponseBody
	public void getChipset(HttpServletRequest request,HttpServletResponse response){
		Long nonCount = caseService.getNonCount();
		Long orsayCount = caseService.getOrsayCount();
		Long tizenCount = caseService.getTizenCount();
		Long chipmonCount = caseService.getMonitorCount();
		int chipTotal = caseService.findAll().size();
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
	            member.put("nonCount", nonCount);
	            member.put("orsayCount", orsayCount);
	            member.put("tizenCount",tizenCount);
	            member.put("chipmonCount",chipmonCount);
	            member.put("total",chipTotal);
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
	@RequestMapping("/getOccurPhase")
	@ResponseBody
	public void getOccurPhase(HttpServletRequest request,HttpServletResponse response){
		Long marketCount = caseService.getMarketCount();
		Long mpCount = caseService.getMPCount();
		int phaseTotal = caseService.findAll().size();
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
	            member.put("marketCount", marketCount);
	            member.put("mpCount", mpCount);
	            member.put("total",phaseTotal);
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
	
	@RequestMapping("/getImprove")
	@ResponseBody
	public void getImprove(HttpServletRequest request,HttpServletResponse response){
		Long techCount = caseService.getTechCount();
		Long testCount = caseService.getTestCount();
		Long procCount = caseService.getProcCount();
		Long toolCount = caseService.getToolCount();
		int phaseTotal = caseService.findAll().size();
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
	            member.put("testCount", testCount);
	            member.put("procCount", procCount);
	            member.put("toolCount", toolCount);
	            member.put("total",phaseTotal);
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
	

	/*
	 * 2014-11-24 wuliying
	 * upload ui
	 */
	
	@RequestMapping("/toUpload")
	public String toUpload(Long id, HttpServletRequest request){
		/*
		 * 2016-11-24 add for list files by wuliying
		 */
		String fileStr = caseService.getById(id).getFilename();
		String	timeStr = caseService.getById(id).getUploadTime();
		String	ipStr = caseService.getById(id).getIp();
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
		return "/caseController/toUpload"; 
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
		        File uploadFile = new File(ctxPath+File.separator+"upload"+File.separator+"case"+File.separator + realFileName);
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
			
			String origFile=caseService.getById(id).getFilename(); //原来有没有文件？
			if(origFile.length()==0){	//原来没有文件， 去掉前面的,
				/*
				 * 2016-11-24 add by wuliying
				 */
				fileStr = fileStr.substring(1,fileStr.length());
				timeStr = timeStr.substring(1,timeStr.length());
				ipStr = ipStr.substring(1,ipStr.length());
			}
			else{//原来有文件， 直接加
				fileStr = caseService.getById(id).getFilename() + fileStr;
				timeStr = caseService.getById(id).getUploadTime() + timeStr;
				ipStr = caseService.getById(id).getIp() + ipStr;
			}
			
			caseService.updateById(id,"filename",fileStr);
	        caseService.updateById(id,"uploadTime",timeStr);
	        caseService.updateById(id,"ip",ipStr);   
	        
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
        return "/caseController/toUpload";
		//return "/caseController/success";  //2016-11-24 wuliying  change for reload the upload page 
	}
	/*
	 * 2014-11-24 wuliying
	 * Delete function
	 */
	@RequestMapping("/delete/{fileName:.*}")  
    public String delete(@PathVariable("fileName") String fileName,Long id,HttpServletRequest request, HttpServletResponse response) throws Exception { 
		String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));
        File delFile = new File(ctxPath+File.separator+"upload"+File.separator+"case"+File.separator + fileName);
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
        return "/caseController/toUpload";
	}
	
	public void deleteFile(File file, String fileName, Long id,List<String> fileList,List<String> timeList,List<String> ipList) { 
		file.delete();
		
        //删除前当前filename， uploadtime， ip
        String	fileStr = caseService.getById(id).getFilename();
        String	timeStr = caseService.getById(id).getUploadTime();
        String	ipStr = caseService.getById(id).getIp();
       
        
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
		caseService.updateById(id,"filename", fileup);
		caseService.updateById(id,"uploadTime",timeup);
		caseService.updateById(id,"ip",ipup);
	}
	@Deprecated
	public List<String> loadFiles(HttpServletRequest request) {  
        List<String> files = new ArrayList<String>();  
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")));

        File file = new File(ctxPath+File.separator+"upload"+File.separator+"case"+File.separator);
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
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")))+File.separator+"upload"+File.separator+"case"+File.separator;
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
		list=caseService.getById(id).getFilename().split(",");
		list2=caseService.getById(id).getUploadTime().split(",");
		for(int i=0;i<list.length;i++){
			fileList.add(list[i]);
		}
		for(int i=0;i<list2.length;i++){
			timeList.add(list2[i]);
		}
		request.setAttribute("files", fileList);
		request.setAttribute("times", timeList);
		return "/caseController/success"; 
	}	
	
	@RequestMapping(value = "importExec", method = RequestMethod.GET)
	@ResponseBody
	public void importExec(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String fname = "Failed Case List";
		response.reset();// 清空输出流
		response.setHeader("Content-disposition","attachment; filename=" + fname + ".xls");// 设定输出文件头
		response.setContentType("application/vnd.ms-excel");//EXCEL格式  Microsoft excel
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
        HSSFSheet sheet = workbook.createSheet("Failed Case Mgmt.");   
        //创建单元格  
        HSSFRow row = sheet.createRow(0);   
        HSSFCell c0 = row.createCell(0);   
        c0.setCellValue(new HSSFRichTextString("No")); 
        c0.setCellStyle(style); 
        
        HSSFCell c1 = row.createCell(1);   
        c1.setCellValue(new HSSFRichTextString("Status"));   
        c1.setCellStyle(style);  

        HSSFCell c2 = row.createCell(2);   
        c2.setCellValue(new HSSFRichTextString("Prod. Type")); 
        c2.setCellStyle(style);  

        HSSFCell c3 = row.createCell(3);   
        c3.setCellValue(new HSSFRichTextString("Chipset")); 
        c3.setCellStyle(style);  

        HSSFCell c4 = row.createCell(4);   
        c4.setCellValue(new HSSFRichTextString("Model"));  
        c4.setCellStyle(style);  

        HSSFCell c5 = row.createCell(5);   
        c5.setCellValue(new HSSFRichTextString("Defect")); 
        c5.setCellStyle(style);  

        HSSFCell c6 = row.createCell(11);   
        c6.setCellValue(new HSSFRichTextString("Reason")); 
        c6.setCellStyle(style);  
        
        HSSFCell c7 = row.createCell(13);   
        c7.setCellValue(new HSSFRichTextString("Countermeasure")); 
        c7.setCellStyle(style);  
        HSSFCell c8 = row.createCell(16);   
        c8.setCellValue(new HSSFRichTextString("Mgmt. Method")); 
        c8.setCellStyle(style);
        HSSFCell c9 = row.createCell(23);   
        c9.setCellValue(new HSSFRichTextString("Report")); 
        c9.setCellStyle(style);
       

        HSSFRow row1 = sheet.createRow(1);   
      
        HSSFCell c10 = row1.createCell(5); 
        c10.setCellValue(new HSSFRichTextString("Description"));   
        c10.setCellStyle(style);  
        HSSFCell c11 = row1.createCell(6); 
        c11.setCellValue(new HSSFRichTextString("Time "));   
        c11.setCellStyle(style);  
        HSSFCell c12 = row1.createCell(7); 
        c12.setCellValue(new HSSFRichTextString("Site"));   
        c12.setCellStyle(style); 
        HSSFCell c13 = row1.createCell(8); 
        c13.setCellValue(new HSSFRichTextString("Phase")); 
        c13.setCellStyle(style); 
        
        HSSFCell c14 = row1.createCell(9); 
        c14.setCellValue(new HSSFRichTextString("Type"));
        c14.setCellStyle(style); 
        
        HSSFCell c15 = row1.createCell(10); 
        c15.setCellValue(new HSSFRichTextString("SW Ver."));   
        c15.setCellStyle(style); 
        
        HSSFCell c16 = row1.createCell(11); 
        c16.setCellValue(new HSSFRichTextString("Root Reason"));   
        c16.setCellStyle(style); 
        HSSFCell c17 = row1.createCell(12); 
        c17.setCellValue(new HSSFRichTextString("No Found Reason"));   
        c17.setCellStyle(style); 
        HSSFCell c18 = row1.createCell(13); 
        c18.setCellValue(new HSSFRichTextString("Dev. Team"));   
        c18.setCellStyle(style); 
        HSSFCell c19 = row1.createCell(14); 
        c19.setCellValue(new HSSFRichTextString("Test Team"));   
        c19.setCellStyle(style); 
        HSSFCell c20 = row1.createCell(15); 
        c20.setCellValue(new HSSFRichTextString("Type"));   
        c20.setCellStyle(style); 
        HSSFCell c21 = row1.createCell(16); 
        c21.setCellValue(new HSSFRichTextString("Person In Charge"));   
        c21.setCellStyle(style); 
        HSSFCell c22 = row1.createCell(17); 
        c22.setCellValue(new HSSFRichTextString("Propagation?"));   
        c22.setCellStyle(style); 
        HSSFCell c23 = row1.createCell(18); 
        c23.setCellValue(new HSSFRichTextString("G-MAP Register?"));   
        c23.setCellStyle(style); 
        HSSFCell c24 = row1.createCell(19); 
        c24.setCellValue(new HSSFRichTextString("Improved Type"));   
        c24.setCellStyle(style); 
        HSSFCell c25 = row1.createCell(20); 
        c25.setCellValue(new HSSFRichTextString("Checklist Update?"));   
        c25.setCellStyle(style); 
        HSSFCell c26 = row1.createCell(21); 
        c26.setCellValue(new HSSFRichTextString("TC Update?"));   
        c26.setCellStyle(style); 
        HSSFCell c27 = row1.createCell(22); 
        c27.setCellValue(new HSSFRichTextString("PLM Register?"));   
        c27.setCellStyle(style); 
        HSSFCell c28 = row1.createCell(23); 
        c28.setCellValue(new HSSFRichTextString("Report"));   
        c28.setCellStyle(style); 

        
       
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)0,  (short)0));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)1,  (short)1));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)2,  (short)2));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)3,  (short)3));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)4,  (short)4));
        

        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)5,  (short)10));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)11,  (short)12));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)13,  (short)15));
        sheet.addMergedRegion(new CellRangeAddress(0, 0,(short)16,  (short)22));
        sheet.addMergedRegion(new CellRangeAddress(0, 1,(short)23,  (short)23));
       
        List<Case> caseList =  caseService.findAll();
        for(int i=0;i<caseList.size();i++){
        	row=sheet.createRow((int)i+2);
        	Case c = (Case)caseList.get(i);
        	row.createCell((short)0).setCellValue(new HSSFRichTextString(i+1+""));
        	row.createCell((short)1).setCellValue(new HSSFRichTextString(c.getConfirmy()));
        	row.createCell((short)2).setCellValue(new HSSFRichTextString(c.getProdType()));
        	row.createCell((short)3).setCellValue(new HSSFRichTextString(c.getChipset()));
        	row.createCell((short)4).setCellValue(new HSSFRichTextString(c.getModel()));
        	row.createCell((short)5).setCellValue(new HSSFRichTextString(c.getDescription()));
        	row.createCell((short)6).setCellValue(new HSSFRichTextString(c.getOccurTime()));
        	row.createCell((short)7).setCellValue(new HSSFRichTextString(c.getOccurSite()));
        	row.createCell((short)8).setCellValue(new HSSFRichTextString(c.getOccurPhase()));
        	row.createCell((short)9).setCellValue(new HSSFRichTextString(c.getOccurType()));
        	
        	row.createCell((short)10).setCellValue(new HSSFRichTextString(c.getVersion()));
        	row.createCell((short)11).setCellValue(new HSSFRichTextString(c.getRootReason()));
        	row.createCell((short)12).setCellValue(new HSSFRichTextString(c.getUnknownReason()));
        	row.createCell((short)13).setCellValue(new HSSFRichTextString(c.getMeasureDev()));
        	row.createCell((short)14).setCellValue(new HSSFRichTextString(c.getMeasureTest()));
        	row.createCell((short)15).setCellValue(new HSSFRichTextString(c.getMeasureType()));
        	row.createCell((short)16).setCellValue(new HSSFRichTextString(c.getPersonINCharge()));
        	row.createCell((short)17).setCellValue(new HSSFRichTextString(c.getPropagation()));
        	row.createCell((short)18).setCellValue(new HSSFRichTextString(c.getGmapRegister()));
        	row.createCell((short)19).setCellValue(new HSSFRichTextString(c.getImprovedType()));
        	row.createCell((short)20).setCellValue(new HSSFRichTextString(c.getChecklistUpdate()));
        	row.createCell((short)21).setCellValue(new HSSFRichTextString(c.getTcUpdate()));
        	row.createCell((short)22).setCellValue(new HSSFRichTextString(c.getPlmRegister()));
        	row.createCell((short)23).setCellValue(new HSSFRichTextString(c.getReport()));
        }
        
        try{   
	          workbook.write(response.getOutputStream());  
	    }  
	    catch (Exception e){  
	        e.printStackTrace();  
	    }  
	}
}
