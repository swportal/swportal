package com.web.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.controller.entity.Defect;
import com.web.controller.service.DefectService;
import com.web.controller.service.DefectinfoService;

@Controller
@RequestMapping("/defect")
public class defectController {
	@Resource
	private DefectService defectService;
	@Resource
	private DefectinfoService defectinfoService;
	/*
	 * 从pas首页链接到defect详细页面
	 */
	@RequestMapping("/getDefect")
	public String getDefect( String projectname, String item,HttpServletRequest request,HttpServletResponse response){
		request.setAttribute("projectname", projectname);
		request.setAttribute("modelname","");
		request.setAttribute("item", item);
		return "/defectController/defectManager";
	}
	/*
	 * 从model列表链接到defect详细页面	
	 */
	@RequestMapping("/getDefectFromModel")
	public String getDefectFromModel( String projectname,String modelname , String item,HttpServletRequest request,HttpServletResponse response){
		request.setAttribute("projectname", projectname);
		
		if(modelname.length()!=0){
			request.setAttribute("modelname",modelname);
		}
		else{
			request.setAttribute("modelname","");
		}
			
		request.setAttribute("item", item);
		return "/defectController/defectManager";
	}
	/*
	 * 从defect info页面饼图链接到defect详细页面	
	 */
	@RequestMapping("/getDefectFromPie")
	public String getDefectFromPie( String projectname,Integer codeid, String item,HttpServletRequest request,HttpServletResponse response){
		request.setAttribute("projectname", projectname);
		
		if(codeid!=0){
			request.setAttribute("modelname", defectinfoService.getNameById(codeid));
		}
		else{
			request.setAttribute("modelname","");
		}
			
		request.setAttribute("item", item);
		return "/defectController/defectManager";
	}
	
	@RequestMapping(value="/findDefectList",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void findDefectList(Integer curpage,String projectname,String modelname,String item,String orderItem, String orderKey,HttpServletRequest request,HttpServletResponse response){
		int total=0;
		String a[] = projectname.split(",");
		String pjstr="";
		for(int i=0;i<a.length;i++){
			pjstr+=" k.pROJECTNAME LIKE '%"+ a[i]+"%' OR";
		}
		pjstr="("+ pjstr.substring(0,pjstr.length()-2)+")";
		
		if(modelname==null||modelname.length()==0||"null".equals(modelname))
			modelname="";
		
		String where="";
		
		if("".equals(orderItem)){		
			if ("".equals(item)){			
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by k.sERIOUSNESS" ;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' AND k.sTATUS != 'Closed' AND k.sTATUS != 'Resolved' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by k.sERIOUSNESS" ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Closed%' order by k.sERIOUSNESS" ;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Resolved%' order by k.sERIOUSNESS" ;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%A%' order by k.sERIOUSNESS" ;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%B%' order by k.sERIOUSNESS" ;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%C%' order by k.sERIOUSNESS" ;
			}
		}
		else{
			if ("".equals(item)){			
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by " +orderItem+" "+orderKey;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' AND k.sTATUS != 'Closed' AND k.sTATUS != 'Resolved' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by " +orderItem+" "+orderKey ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Closed%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Resolved%' order by " +orderItem+" "+orderKey;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%A%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%B%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%C%' order by " +orderItem+" "+orderKey;
			}
		}
		
		Integer pageSize=13;
		total=defectService.findDefectCount(where);
		Integer totalpage=(total%pageSize==0)?(total/pageSize):(total/pageSize+1);
		
		
		List<Defect> defectList = defectService.findDefectList(curpage,pageSize,where);
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("defectList", defectList);
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
	}
		
	

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "DownDefect", method = RequestMethod.GET)
	@ResponseBody
	public void DownDefect(String projectname,String modelname,String item,String orderItem, String orderKey,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		int total=0;
		String a[] = projectname.split(",");
		String pjstr="";
		for(int i=0;i<a.length;i++){
			pjstr+=" k.pROJECTNAME LIKE '%"+ a[i]+"%' OR";
		}
		pjstr="("+ pjstr.substring(0,pjstr.length()-2)+")";
		
		if(modelname==null||modelname.length()==0||"null".equals(modelname))
			modelname="";
		
		String where="";
		
		if("".equals(orderItem)){		
			if ("".equals(item)){			
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by k.sERIOUSNESS" ;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' AND k.sTATUS != 'Closed' AND k.sTATUS != 'Resolved' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by k.sERIOUSNESS" ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Closed%' order by k.sERIOUSNESS" ;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Resolved%' order by k.sERIOUSNESS" ;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%A%' order by k.sERIOUSNESS" ;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%B%' order by k.sERIOUSNESS" ;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%C%' order by k.sERIOUSNESS" ;
			}
		}
		else{
			if ("".equals(item)){			
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by " +orderItem+" "+orderKey;
			}
			else if("Opened".equals(item)){ //Opened
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' AND k.sTATUS != 'Closed' AND k.sTATUS != 'Resolved' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' order by " +orderItem+" "+orderKey ;
			}
			
			else if ("Closed".equals(item)){ //Closed
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Closed%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("Resolved".equals(item)){ //Resolved
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sTATUS LIKE '%Resolved%' order by " +orderItem+" "+orderKey;
			}
			
			else if("A".equals(item)){ //A
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%A%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("B".equals(item)){ //B
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%B%' order by " +orderItem+" "+orderKey;
			}
			
			else if ("C".equals(item)){ //C
				where="where "+pjstr+"  AND k.mODELCODE LIKE '%"+modelname+"%'  AND k.sTATUS != 'PLM_Deleted' and k.sTATUS != 'Not_Related' and k.pLMFLAG='Y' AND k.sERIOUSNESS LIKE '%C%' order by " +orderItem+" "+orderKey;
			}
		}
		total=defectService.findDefectCount(where);
		List<Defect> defectList = null;
		defectList=defectService.findDefectList(1, total,where);
		
		String fname = "Defect List";
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
        
        for(int i=0;i<defectList.size();i++){
					row=sheet.createRow((int)i+1);
					Defect defect = (Defect)defectList.get(i);
					row.createCell((short)0).setCellValue(new HSSFRichTextString(defect.getiD()));
					row.createCell((short)1).setCellValue(new HSSFRichTextString(defect.gethEADLINE().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)2).setCellValue(new HSSFRichTextString(defect.getsERIOUSNESS().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)3).setCellValue(new HSSFRichTextString(defect.getmODELCODE().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)4).setCellValue(new HSSFRichTextString(defect.getsUBCOMPONENTNAME().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)5).setCellValue(new HSSFRichTextString(defect.getsUBMITTEDTIME().replaceAll("<", " &lt;").replaceAll(">", " &gt;"))); // 2016-11-18 PLATFORMDEVELOPER->SUBMITTEDTIME wuliying
					row.createCell((short)6).setCellValue(new HSSFRichTextString(defect.getpRODUCTDEVELOPER().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)7).setCellValue(new HSSFRichTextString(defect.getdEFECTSOLVEDVERSION().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)8).setCellValue(new HSSFRichTextString(defect.getrEQUESTER().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)9).setCellValue(new HSSFRichTextString(defect.getsTATUS().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));
					row.createCell((short)10).setCellValue(new HSSFRichTextString(defect.getsTATEOWNER().replaceAll("<", " &lt;").replaceAll(">", " &gt;")));

		}
		try{   
	        workbook.write(response.getOutputStream());  
	    }  
	    catch (Exception e)  {  
	        e.printStackTrace();  
	    }  
	} 
}
