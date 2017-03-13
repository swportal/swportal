package com.web.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.web.controller.service.BlockService;
import com.web.controller.service.CompService;
import com.web.controller.service.DefectService;
import com.web.controller.service.DefectinfoService;

@Controller
@RequestMapping("/defectinfo")
public class defectinfoController {
	@Resource
	private DefectService defectService;
	@Resource
	private DefectinfoService defectinfoService;
	@Resource
	private CompService compService;
	@Resource
	private BlockService blockService;
		
	@RequestMapping("/toDefectPage")
	public String toDefectPage( String projectname, Integer codeid,HttpServletRequest request,HttpServletResponse response){
		request.setAttribute("projectname", projectname);
		if(codeid==null){
			codeid=0;
			request.setAttribute("codeid", 0);
		}
		else
			request.setAttribute("codeid", codeid);
		Map<Integer,String> ma = defectinfoService.getCodes(projectname);
		request.setAttribute("mapcode", ma);  //获取projectname下的model(defects_infor表格)
		String modelname="";
		if(codeid==0){
		}
		else{
			modelname=defectinfoService.getNameById(codeid);
		}
		/*
		 * 获取两个饼图数据
		 */
		List<Integer> listTotal=defectinfoService.getDefectData(projectname,modelname);
		List<String> listDaily= defectinfoService.getDailyData(projectname,modelname);	
		Map<String,Integer> mapComp = compService.getCompList(projectname,modelname);
		/*
		 * 获取component top10数据
		 */
		List<String> listCompName=new ArrayList<String>();
		List<String> listCompNum=new ArrayList<String>();
		
		Set<String> keys=mapComp.keySet();
		Iterator<String> iterCompName=keys.iterator();		
		while(iterCompName.hasNext()){
			listCompName.add(iterCompName.next());
		}
	
		Collection<Integer> values=mapComp.values();
		Iterator<Integer> iterCompNum=values.iterator();
		while(iterCompNum.hasNext()){
			listCompNum.add(iterCompNum.next()+"");
		}
		/*
		 * 获取block top10数据
		 */
		Map<String,Integer> mapBlock = blockService.getBlockList(projectname,modelname);
		List<String> listBlockName=new ArrayList<String>();
		List<String> listBlockNum=new ArrayList<String>();
		
		Set<String> keys2=mapBlock.keySet();
		Iterator<String> iterBlockName=keys2.iterator();		
		while(iterBlockName.hasNext()){
			listBlockName.add(iterBlockName.next());
		}
	
		Collection<Integer> values2=mapBlock.values();
		Iterator<Integer> iterBlockNum=values2.iterator();
		while(iterBlockNum.hasNext()){
			listBlockNum.add(iterBlockNum.next()+"");
		}
		
		
		
		requestPut(listTotal,listDaily,listCompName,listCompNum,listBlockName,listBlockNum,request);
		
		return "/defectinfoController/defectinfoManager";
	}
	
	@RequestMapping(value="/getDefectinfo",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void getDefectinfo( String projectname, Integer codeid,HttpServletRequest request,HttpServletResponse response){
		JSONArray members = new JSONArray();
		JSONObject memberlistTotal = new JSONObject();
		JSONObject memberlistDay = new JSONObject();
		JSONObject memberlistResolvedDay = new JSONObject();
		
		
		JSONObject memberlistCompName = new JSONObject();
		JSONObject memberlistCompNum = new JSONObject();
		JSONObject memberlistBlockName = new JSONObject();
		JSONObject memberlistBlockNum = new JSONObject();
		String modelname="";
		if(codeid==0){
		}
		else{
			modelname=defectinfoService.getNameById(codeid);
		}
		/*
		 * 获取两个饼图数据
		 */
		List<Integer> listTotal=defectinfoService.getDefectData(projectname,modelname);
		List<String> listDaily= defectinfoService.getDailyData(projectname,modelname);		
		memberlistTotal.put("listTotal", listTotal);
		members.add(memberlistTotal);   
		List<String> listDay= new ArrayList<String>();
		List<String> listResolvedDay= new ArrayList<String>();
		for(int i=0;i<120;){
			listDay.add(listDaily.get(i));
			listResolvedDay.add(listDaily.get(i+1));
			i=i+2;
		}
		memberlistDay.put("listDay", listDay);
		memberlistResolvedDay.put("listResolvedDay", listResolvedDay);
		members.add(memberlistDay);
		members.add(memberlistResolvedDay);
		/*
		 * 获取component top10数据
		 */
		Map<String,Integer> mapComp = compService.getCompList(projectname,modelname);
		List<String> listCompName=new ArrayList<String>();
		//List<String> listCompNum=new ArrayList<String>();
		
		Set<String> keys=mapComp.keySet();
		Iterator<String> iterCompName=keys.iterator();	
		Collection<Integer> values=mapComp.values();
		Iterator<Integer> iterCompNum=values.iterator();
		int i=0;
		int sum=0;
		while(iterCompNum.hasNext()&&i++<4){
			Integer num=iterCompNum.next();
			sum+=num;
		}
		if(sum==0){
			for(int j=0;j<40;j++){
				listCompName.add(" ");
			}
		}
		else{
			while(iterCompName.hasNext()){
				listCompName.add(iterCompName.next());
			}
		}
		
		memberlistCompName.put("listCompName", listCompName);
		members.add(memberlistCompName);
		
		 
		
		/*while(iter1.hasNext()){
			Integer num=iter1.next();
			memberlistCompNum.put("listCompNum", num);
     		members.add(memberlistCompNum);
		}*/
		
		iterCompNum=values.iterator();
		while(iterCompNum.hasNext()){
			Integer num=iterCompNum.next();
			if(num==0)
				memberlistCompNum.put("listCompNum", null);
			else
				memberlistCompNum.put("listCompNum", num);
			members.add(memberlistCompNum);
		}
		members.add(sum);
		
		/*
		 * 获取block top10数据
		 */	
		
		Map<String,Integer> mapBlock= blockService.getBlockList(projectname,modelname);
		List<String> listBlockName=new ArrayList<String>();
		
		Set<String> keysBlock=mapBlock.keySet();
		Iterator<String> iterBlockName=keysBlock.iterator();	
		Collection<Integer> valuesBlock=mapBlock.values();
		Iterator<Integer> iterBlockNum=valuesBlock.iterator();
		
		
		if(sum==0){
			for(int j=0;j<40;j++){
				listBlockName.add(" ");
			}
		}
		else{
			while(iterBlockName.hasNext()){
				listBlockName.add(iterBlockName.next());
			}
		}
		memberlistBlockName.put("listBlockName", listBlockName);
		members.add(memberlistBlockName);
	
		
		/*while(iterBlockNum.hasNext()){
			listBlockNum.add(iterBlockNum.next()+"");
		}*/
		//memberlistBlockName.put("listBlockNum", listBlockNum);
		i=0;
		sum=0;
		while(iterBlockNum.hasNext()&&i++<4){
			Integer num=iterBlockNum.next();
			sum+=num;
		}
		iterBlockNum=valuesBlock.iterator();
		while(iterBlockNum.hasNext()){
			Integer num=iterBlockNum.next();
			if(num==0)
				memberlistBlockNum.put("listBlockNum", null);
			else
				memberlistBlockNum.put("listBlockNum", num);
			members.add(memberlistBlockNum);
		}
		members.add(sum);
		 
		PrintWriter out= null;
		try {
			 	out= response.getWriter();
		        out.write(members.toString());
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		        out.flush();
		        out.close();    
		    }      
		 
		    out.flush();
		    out.close();
		//requestPut(listTotal,listDaily,listCompName,listCompNum,listBlockName,listBlockNum,request);		
		//return "/defectinfoController/defectinfoManager";
	}
	
	@RequestMapping(value="/getDailyData",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void getDailyData( String projectname,String currdate,Integer codeid, HttpServletRequest request,HttpServletResponse response){		
		int[] ResolveDay = new int[400];
		int[] Day = new int[400];
		String where = "where";
		Long daysBetween = 0L;
		//String currdate= request.getParameter("currdate");
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
		
		String a[] = projectname.split(",");
		for(int i=0;i<(a.length);i++){
			where=where+" ProjectName='"+a[i]+"' or ";
		}
		where=where.substring(0,where.length()-3);
		
		if(codeid==0){			
		}
		else{			
			//where=" and ModelCode like '%"+mcd.getNameById(Integer.parseInt(codeid))+"%'";
			where=" where ModelCode ='"+defectinfoService.getNameById(codeid)+"'";
		}
		
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 ResultSet rs=null;
		 rs = defectinfoService.getResultSet(where);
		
			try {	
				out= response.getWriter();
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
			catch (Exception e) {
				System.out.println(e.getMessage());
			}finally{
				if(out!=null){
					out.flush();
					out.close();	
				}
			}	
	}
		
	
	@RequestMapping(value="/findDefectinfo",produces="application/json;charset=UTF-8")
	@ResponseBody
	public void findDefectinfo(Integer curpage,String projectname,String modelname,String item,String orderItem, String orderKey,HttpServletRequest request,HttpServletResponse response){
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
		//int t=defectService.findAll().size();
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
		List<Defect> defectList = new ArrayList<Defect>();
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
	 
	public void requestPut(List<Integer> listTotal,List<String> listDaily,List<String> listCompName,List<String> listCompNum,List<String> listBlockName,List<String> listBlockNum,HttpServletRequest request){
		/*
		 * 获取两个饼图数据
		 */
		request.setAttribute("Total", listTotal.get(0));
		request.setAttribute("TotalA", listTotal.get(1));
		request.setAttribute("TotalB", listTotal.get(2));
		request.setAttribute("TotalC", listTotal.get(3));
		request.setAttribute("TotalN", listTotal.get(4));
		
		request.setAttribute("Opened", listTotal.get(5));
		request.setAttribute("Resolved", listTotal.get(6));
		request.setAttribute("Closed", listTotal.get(7));
		
		request.setAttribute("OpenedA", listTotal.get(8));
		request.setAttribute("OpenedB", listTotal.get(9));
		request.setAttribute("OpenedC", listTotal.get(10));
		request.setAttribute("OpenedN", listTotal.get(11));
		
		request.setAttribute("ResolvedA", listTotal.get(12));
		request.setAttribute("ResolvedB", listTotal.get(13));
		request.setAttribute("ResolvedC", listTotal.get(14));
		request.setAttribute("ResolvedN", listTotal.get(15));
		
		request.setAttribute("ClosedA", listTotal.get(16));
		request.setAttribute("ClosedB", listTotal.get(17));
		request.setAttribute("ClosedC", listTotal.get(18));
		request.setAttribute("ClosedN", listTotal.get(19));
		
		request.setAttribute("SQAPLMTotalDelay", listTotal.get(20));
		request.setAttribute("SQAPLMTotalDelay30", listTotal.get(21));
		request.setAttribute("SQAPLMTotalDelay60", listTotal.get(22));
		
		request.setAttribute("SQAPLMTotalA", listTotal.get(23));
		request.setAttribute("SQAPLMOpenedA", listTotal.get(24));
		request.setAttribute("SQAPLMResolvedA", listTotal.get(25));
		request.setAttribute("SQAPLMClosedA", listTotal.get(26));
		
		request.setAttribute("SQAPLMTotalBC", listTotal.get(27));
		request.setAttribute("SQAPLMOpenedBC", listTotal.get(28));
		request.setAttribute("SQAPLMResolvedBC", listTotal.get(29));
		request.setAttribute("SQAPLMClosedBC", listTotal.get(30));
		
		/*
		 * 获取过去60天数据
		 */
		/*for(int i=1;i<=60;i++){
			request.setAttribute("Day"+i,listDaily.get(i-1) );
			request.setAttribute("ResolveDay"+i,listDaily.get(60+i-1) );
		}*/
		List<String> listDay= new ArrayList<String>();
		List<String> listResolvedDay= new ArrayList<String>();
		for(int i=0;i<120;){
			listDay.add(listDaily.get(i));
			listResolvedDay.add(listDaily.get(i+1));
			i=i+2;
		}
		
		for(int i=1;i<=60;i++){
			request.setAttribute("Day"+i, listDay.get(i-1));
			request.setAttribute("ResolveDay"+i, listResolvedDay.get(i-1));
		}
		
		/*
		 * 获取component top10数据
		 */
		if(("0".equals(listCompNum.get(0)))&&("0".equals(listCompNum.get(1)))&&("0".equals(listCompNum.get(2)))&&("0".equals(listCompNum.get(3)))){
			request.setAttribute("CompItem1", " ");
			request.setAttribute("CompClose1", " ");
			request.setAttribute("CompPending1", " ");
			request.setAttribute("CompRejected1", " ");
			request.setAttribute("CompResolved1", " ");
		}
		else{			
			if(listCompName.get(0).contains("NonSmartClosed"))
				request.setAttribute("CompItem1", listCompName.get(0).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem1", listCompName.get(0).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(0)))
				request.setAttribute("CompClose1", " ");
			else
				request.setAttribute("CompClose1", listCompNum.get(0));
			if("0".equals(listCompNum.get(1)))
				request.setAttribute("CompPending1", " ");
			else
			request.setAttribute("CompPending1", listCompNum.get(1));
			if("0".equals(listCompNum.get(2)))
				request.setAttribute("CompRejected1", " ");
			else
				request.setAttribute("CompRejected1", listCompNum.get(2));
			if("0".equals(listCompNum.get(3)))
				request.setAttribute("CompResolved1", " ");
			else
				request.setAttribute("CompResolved1", listCompNum.get(3));
			
		}
		
		
		if(("0".equals(listCompNum.get(4)))&&("0".equals(listCompNum.get(5)))&&("0".equals(listCompNum.get(6)))&&("0".equals(listCompNum.get(7)))){
			request.setAttribute("CompItem2", " ");
			request.setAttribute("CompClose2", " ");
			request.setAttribute("CompPending2", " ");
			request.setAttribute("CompRejected2", " ");
			request.setAttribute("CompResolved2", " ");
		}
		else{	
			if(listCompName.get(4).contains("NonSmartClosed"))
				request.setAttribute("CompItem2", listCompName.get(4).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem2", listCompName.get(4).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(4)))
				request.setAttribute("CompClose2", " ");
			else
				request.setAttribute("CompClose2", listCompNum.get(4));
			
			if("0".equals(listCompNum.get(5)))
				request.setAttribute("CompPending2", " ");
			else
				request.setAttribute("CompPending2", listCompNum.get(5));
			
			if("0".equals(listCompNum.get(6)))
				request.setAttribute("CompRejected2", " ");
			else
				request.setAttribute("CompRejected2", listCompNum.get(6));
			 
			if("0".equals(listCompNum.get(7)))
				request.setAttribute("CompResolved2", " ");
			else
				request.setAttribute("CompResolved2", listCompNum.get(7));	
			
		}
		
		if(("0".equals(listCompNum.get(8)))&&("0".equals(listCompNum.get(9)))&&("0".equals(listCompNum.get(10)))&&("0".equals(listCompNum.get(11)))){
			request.setAttribute("CompItem3", " ");
			request.setAttribute("CompClose3", " ");
			request.setAttribute("CompPending3", " ");
			request.setAttribute("CompRejected3", " ");
			request.setAttribute("CompResolved3", " ");
		}
		else{	
			if(listCompName.get(8).contains("NonSmartClosed"))
				request.setAttribute("CompItem3", listCompName.get(8).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem3", listCompName.get(8).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(8)))
				request.setAttribute("CompClose3", " ");
			else
				request.setAttribute("CompClose3", listCompNum.get(8));
			
			if("0".equals(listCompNum.get(9)))
				request.setAttribute("CompPending3", " ");
			else
				request.setAttribute("CompPending3", listCompNum.get(9));
			
			if("0".equals(listCompNum.get(10)))
				request.setAttribute("CompRejected3", " ");
			else
				request.setAttribute("CompRejected3", listCompNum.get(10));
			 
			if("0".equals(listCompNum.get(11)))
				request.setAttribute("CompResolved3", " ");
			else
				request.setAttribute("CompResolved3", listCompNum.get(11));
		}
		
		if(("0".equals(listCompNum.get(12)))&&("0".equals(listCompNum.get(13)))&&("0".equals(listCompNum.get(14)))&&("0".equals(listCompNum.get(15)))){
			request.setAttribute("CompItem4", " ");
			request.setAttribute("CompClose4", " ");
			request.setAttribute("CompPending4", " ");
			request.setAttribute("CompRejected4", " ");
			request.setAttribute("CompResolved4", " ");
		}
		else{	
			if(listCompName.get(12).contains("NonSmartClosed"))
				request.setAttribute("CompItem4", listCompName.get(12).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem4", listCompName.get(12).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(12)))
				request.setAttribute("CompClose4", " ");
			else
				request.setAttribute("CompClose4", listCompNum.get(12));
			
			if("0".equals(listCompNum.get(13)))
				request.setAttribute("CompPending4", " ");
			else
				request.setAttribute("CompPending4", listCompNum.get(13));
			
			if("0".equals(listCompNum.get(14)))
				request.setAttribute("CompRejected4", " ");
			else
				request.setAttribute("CompRejected4", listCompNum.get(14));
			 
			if("0".equals(listCompNum.get(15)))
				request.setAttribute("CompResolved4", " ");
			else
				request.setAttribute("CompResolved4", listCompNum.get(15));
		}
		
		
		if(("0".equals(listCompNum.get(16)))&&("0".equals(listCompNum.get(17)))&&("0".equals(listCompNum.get(18)))&&("0".equals(listCompNum.get(19)))){
			request.setAttribute("CompItem5", " ");
			request.setAttribute("CompClose5", " ");
			request.setAttribute("CompPending5", " ");
			request.setAttribute("CompRejected5", " ");
			request.setAttribute("CompResolved5", " ");
		}
		else{	
			if(listCompName.get(16).contains("NonSmartClosed"))
				request.setAttribute("CompItem5", listCompName.get(16).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem5", listCompName.get(16).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(16)))
				request.setAttribute("CompClose5", " ");
			else
				request.setAttribute("CompClose5", listCompNum.get(16));
			
			if("0".equals(listCompNum.get(17)))
				request.setAttribute("CompPending5", " ");
			else
				request.setAttribute("CompPending5", listCompNum.get(17));
			
			if("0".equals(listCompNum.get(18)))
				request.setAttribute("CompRejected5", " ");
			else
				request.setAttribute("CompRejected5", listCompNum.get(18));
			 
			if("0".equals(listCompNum.get(19)))
				request.setAttribute("CompResolved5", " ");
			else
				request.setAttribute("CompResolved5", listCompNum.get(19));
		}
		
		if(("0".equals(listCompNum.get(20)))&&("0".equals(listCompNum.get(21)))&&("0".equals(listCompNum.get(22)))&&("0".equals(listCompNum.get(23)))){
			request.setAttribute("CompItem6", " ");
			request.setAttribute("CompClose6", " ");
			request.setAttribute("CompPending6", " ");
			request.setAttribute("CompRejected6", " ");
			request.setAttribute("CompResolved6", " ");
		}
		else{	
			if(listCompName.get(20).contains("NonSmartClosed"))
				request.setAttribute("CompItem6", listCompName.get(20).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem6", listCompName.get(20).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(20)))
				request.setAttribute("CompClose6", " ");
			else
				request.setAttribute("CompClose6", listCompNum.get(20));
			
			if("0".equals(listCompNum.get(21)))
				request.setAttribute("CompPending6", " ");
			else
				request.setAttribute("CompPending6", listCompNum.get(21));
			
			if("0".equals(listCompNum.get(22)))
				request.setAttribute("CompRejected6", " ");
			else
				request.setAttribute("CompRejected6", listCompNum.get(22));
			 
			if("0".equals(listCompNum.get(23)))
				request.setAttribute("CompResolved6", " ");
			else
				request.setAttribute("CompResolved6", listCompNum.get(23));
		}
		
		if(("0".equals(listCompNum.get(24)))&&("0".equals(listCompNum.get(25)))&&("0".equals(listCompNum.get(26)))&&("0".equals(listCompNum.get(27)))){
			request.setAttribute("CompItem7", " ");
			request.setAttribute("CompClose7", " ");
			request.setAttribute("CompPending7", " ");
			request.setAttribute("CompRejected7", " ");
			request.setAttribute("CompResolved7", " ");
		}
		else{	
			if(listCompName.get(24).contains("NonSmartClosed"))
				request.setAttribute("CompItem7", listCompName.get(24).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem7", listCompName.get(24).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(24)))
				request.setAttribute("CompClose7", " ");
			else
				request.setAttribute("CompClose7", listCompNum.get(24));
			
			if("0".equals(listCompNum.get(25)))
				request.setAttribute("CompPending7", " ");
			else
				request.setAttribute("CompPending7", listCompNum.get(25));
			
			if("0".equals(listCompNum.get(26)))
				request.setAttribute("CompRejected7", " ");
			else
				request.setAttribute("CompRejected7", listCompNum.get(26));
			 
			if("0".equals(listCompNum.get(27)))
				request.setAttribute("CompResolved7", " ");
			else
				request.setAttribute("CompResolved7", listCompNum.get(27));
		}
	
		
		if(("0".equals(listCompNum.get(28)))&&("0".equals(listCompNum.get(29)))&&("0".equals(listCompNum.get(30)))&&("0".equals(listCompNum.get(31)))){
			request.setAttribute("CompItem8", " ");
			request.setAttribute("CompClose8", " ");
			request.setAttribute("CompPending8", " ");
			request.setAttribute("CompRejected8", " ");
			request.setAttribute("CompResolved8", " ");
		}
		else{	
			if(listCompName.get(28).contains("NonSmartClosed"))
				request.setAttribute("CompItem8", listCompName.get(28).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem8", listCompName.get(28).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(28)))
				request.setAttribute("CompClose8", " ");
			else
				request.setAttribute("CompClose8", listCompNum.get(28));
			
			if("0".equals(listCompNum.get(29)))
				request.setAttribute("CompPending8", " ");
			else
				request.setAttribute("CompPending8", listCompNum.get(29));
			
			if("0".equals(listCompNum.get(30)))
				request.setAttribute("CompRejected8", " ");
			else
				request.setAttribute("CompRejected8", listCompNum.get(30));
			 
			if("0".equals(listCompNum.get(31)))
				request.setAttribute("CompResolved8", " ");
			else
				request.setAttribute("CompResolved8", listCompNum.get(31));
		}
		
		if(("0".equals(listCompNum.get(32)))&&("0".equals(listCompNum.get(33)))&&("0".equals(listCompNum.get(34)))&&("0".equals(listCompNum.get(35)))){
			request.setAttribute("CompItem9", " ");
			request.setAttribute("CompClose9", " ");
			request.setAttribute("CompPending9", " ");
			request.setAttribute("CompRejected9", " ");
			request.setAttribute("CompResolved9", " ");
		}
		else{	
			if(listCompName.get(32).contains("NonSmartClosed"))
				request.setAttribute("CompItem9", listCompName.get(32).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem9", listCompName.get(32).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(32)))
				request.setAttribute("CompClose9", " ");
			else
				request.setAttribute("CompClose9", listCompNum.get(32));
			
			if("0".equals(listCompNum.get(33)))
				request.setAttribute("CompPending9", " ");
			else
				request.setAttribute("CompPending9", listCompNum.get(33));
			
			if("0".equals(listCompNum.get(34)))
				request.setAttribute("CompRejected9", " ");
			else
				request.setAttribute("CompRejected9", listCompNum.get(34));
			 
			if("0".equals(listCompNum.get(35)))
				request.setAttribute("CompResolved9", " ");
			else
				request.setAttribute("CompResolved9", listCompNum.get(35));

		}
		
		if(("0".equals(listCompNum.get(36)))&&("0".equals(listCompNum.get(37)))&&("0".equals(listCompNum.get(38)))&&("0".equals(listCompNum.get(39)))){
			request.setAttribute("CompItem10", " ");
			request.setAttribute("CompClose10", " ");
			request.setAttribute("CompPending10", " ");
			request.setAttribute("CompRejected10", " ");
			request.setAttribute("CompResolved10", " ");
		}
		else{	
			if(listCompName.get(36).contains("NonSmartClosed"))
				request.setAttribute("CompItem10", listCompName.get(36).replace("NonSmartClosed", ""));
			else 
				request.setAttribute("CompItem10", listCompName.get(36).replace("Closed", ""));
			
			if("0".equals(listCompNum.get(36)))
				request.setAttribute("CompClose10", " ");
			else
				request.setAttribute("CompClose10", listCompNum.get(36));
			
			
			if("0".equals(listCompNum.get(37)))
				request.setAttribute("CompPending10"," ");
			else
				request.setAttribute("CompPending10", listCompNum.get(37));
			
			if("0".equals(listCompNum.get(38)))
				request.setAttribute("CompRejected10", " ");
			else
				request.setAttribute("CompRejected10", listCompNum.get(38));
				
			if("0".equals(listCompNum.get(39)))
				request.setAttribute("CompResolved10", " ");
			else
				request.setAttribute("CompResolved10", listCompNum.get(39));
		}
		
		/*
		 * 获取block top10数据
		 */
		if(("0".equals(listBlockNum.get(0)))&&("0".equals(listBlockNum.get(1)))&&("0".equals(listBlockNum.get(2)))&&("0".equals(listBlockNum.get(3)))){
			request.setAttribute("BlockItem1", " ");
			request.setAttribute("BlockClose1", " ");
			request.setAttribute("BlockPending1", " ");
			request.setAttribute("BlockRejected1", " ");
			request.setAttribute("BlockResolved1", " ");
		}
		else{	
			request.setAttribute("BlockItem1", listBlockName.get(0).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(0)))
				request.setAttribute("BlockClose1", " ");
			else
				request.setAttribute("BlockClose1", listBlockNum.get(0));
			
			
			if("0".equals(listBlockNum.get(1)))
				request.setAttribute("BlockPending1"," ");
			else
				request.setAttribute("BlockPending1", listBlockNum.get(1));
			
			if("0".equals(listBlockNum.get(2)))
				request.setAttribute("BlockRejected1", " ");
			else
				request.setAttribute("BlockRejected1", listBlockNum.get(2));
				
			if("0".equals(listBlockNum.get(3)))
				request.setAttribute("BlockResolved1", " ");
			else
				request.setAttribute("BlockResolved1", listBlockNum.get(3));
		}
		
		if(("0".equals(listBlockNum.get(4)))&&("0".equals(listBlockNum.get(5)))&&("0".equals(listBlockNum.get(6)))&&("0".equals(listBlockNum.get(7)))){
			request.setAttribute("BlockItem2", " ");
			request.setAttribute("BlockClose2", " ");
			request.setAttribute("BlockPending2", " ");
			request.setAttribute("BlockRejected2", " ");
			request.setAttribute("BlockResolved2", " ");
		}
		else{	
			request.setAttribute("BlockItem2", listBlockName.get(4).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(4)))
				request.setAttribute("BlockClose2", " ");
			else
				request.setAttribute("BlockClose2", listBlockNum.get(4));
			
			
			if("0".equals(listBlockNum.get(5)))
				request.setAttribute("BlockPending2"," ");
			else
				request.setAttribute("BlockPending2", listBlockNum.get(5));
			
			if("0".equals(listBlockNum.get(6)))
				request.setAttribute("BlockRejected2", " ");
			else
				request.setAttribute("BlockRejected2", listBlockNum.get(6));
				
			if("0".equals(listBlockNum.get(7)))
				request.setAttribute("BlockResolved2", " ");
			else
				request.setAttribute("BlockResolved2", listBlockNum.get(7));
		}
		
		if(("0".equals(listBlockNum.get(8)))&&("0".equals(listBlockNum.get(9)))&&("0".equals(listBlockNum.get(10)))&&("0".equals(listBlockNum.get(11)))){
			request.setAttribute("BlockItem3", " ");
			request.setAttribute("BlockClose3", " ");
			request.setAttribute("BlockPending3", " ");
			request.setAttribute("BlockRejected3", " ");
			request.setAttribute("BlockResolved3", " ");
		}
		else{	
			request.setAttribute("BlockItem3", listBlockName.get(8).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(8)))
				request.setAttribute("BlockClose3", " ");
			else
				request.setAttribute("BlockClose3", listBlockNum.get(8));
			
			
			if("0".equals(listBlockNum.get(9)))
				request.setAttribute("BlockPending3"," ");
			else
				request.setAttribute("BlockPending3", listBlockNum.get(9));
			
			if("0".equals(listBlockNum.get(10)))
				request.setAttribute("BlockRejected3", " ");
			else
				request.setAttribute("BlockRejected3", listBlockNum.get(10));
				
			if("0".equals(listBlockNum.get(11)))
				request.setAttribute("BlockResolved3", " ");
			else
				request.setAttribute("BlockResolved3", listBlockNum.get(11));
		}
		
		if(("0".equals(listBlockNum.get(12)))&&("0".equals(listBlockNum.get(13)))&&("0".equals(listBlockNum.get(14)))&&("0".equals(listBlockNum.get(15)))){
			request.setAttribute("BlockItem4", " ");
			request.setAttribute("BlockClose4", " ");
			request.setAttribute("BlockPending4", " ");
			request.setAttribute("BlockRejected4", " ");
			request.setAttribute("BlockResolved4", " ");
		}
		else{	
			request.setAttribute("BlockItem4", listBlockName.get(12).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(12)))
				request.setAttribute("BlockClose4", " ");
			else
				request.setAttribute("BlockClose4", listBlockNum.get(12));
			
			
			if("0".equals(listBlockNum.get(13)))
				request.setAttribute("BlockPending4"," ");
			else
				request.setAttribute("BlockPending4", listBlockNum.get(13));
			
			if("0".equals(listBlockNum.get(14)))
				request.setAttribute("BlockRejected4", " ");
			else
				request.setAttribute("BlockRejected4", listBlockNum.get(14));
				
			if("0".equals(listBlockNum.get(15)))
				request.setAttribute("BlockResolved4", " ");
			else
				request.setAttribute("BlockResolved4", listBlockNum.get(15));
		}
		if(("0".equals(listBlockNum.get(16)))&&("0".equals(listBlockNum.get(17)))&&("0".equals(listBlockNum.get(18)))&&("0".equals(listBlockNum.get(19)))){
			request.setAttribute("BlockItem5", " ");
			request.setAttribute("BlockClose5", " ");
			request.setAttribute("BlockPending5", " ");
			request.setAttribute("BlockRejected5", " ");
			request.setAttribute("BlockResolved5", " ");
		}
		else{	
			request.setAttribute("BlockItem5", listBlockName.get(16).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(16)))
				request.setAttribute("BlockClose5", " ");
			else
				request.setAttribute("BlockClose5", listBlockNum.get(16));
			
			
			if("0".equals(listBlockNum.get(17)))
				request.setAttribute("BlockPending5"," ");
			else
				request.setAttribute("BlockPending5", listBlockNum.get(17));
			
			if("0".equals(listBlockNum.get(18)))
				request.setAttribute("BlockRejected5", " ");
			else
				request.setAttribute("BlockRejected5", listBlockNum.get(18));
				
			if("0".equals(listBlockNum.get(19)))
				request.setAttribute("BlockResolved5", " ");
			else
				request.setAttribute("BlockResolved5", listBlockNum.get(19));
		}
		if(("0".equals(listBlockNum.get(20)))&&("0".equals(listBlockNum.get(21)))&&("0".equals(listBlockNum.get(22)))&&("0".equals(listBlockNum.get(23)))){
			request.setAttribute("BlockItem6", " ");
			request.setAttribute("BlockClose6", " ");
			request.setAttribute("BlockPending6", " ");
			request.setAttribute("BlockRejected6", " ");
			request.setAttribute("BlockResolved6", " ");
		}
		else{	
			request.setAttribute("BlockItem6", listBlockName.get(20).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(20)))
				request.setAttribute("BlockClose6", " ");
			else
				request.setAttribute("BlockClose6", listBlockNum.get(20));
			
			
			if("0".equals(listBlockNum.get(21)))
				request.setAttribute("BlockPending6"," ");
			else
				request.setAttribute("BlockPending6", listBlockNum.get(21));
			
			if("0".equals(listBlockNum.get(22)))
				request.setAttribute("BlockRejected6", " ");
			else
				request.setAttribute("BlockRejected6", listBlockNum.get(22));
				
			if("0".equals(listBlockNum.get(23)))
				request.setAttribute("BlockResolved6", " ");
			else
				request.setAttribute("BlockResolved6", listBlockNum.get(23));
		}
		if(("0".equals(listBlockNum.get(24)))&&("0".equals(listBlockNum.get(25)))&&("0".equals(listBlockNum.get(26)))&&("0".equals(listBlockNum.get(27)))){
			request.setAttribute("BlockItem7", " ");
			request.setAttribute("BlockClose7", " ");
			request.setAttribute("BlockPending7", " ");
			request.setAttribute("BlockRejected7", " ");
			request.setAttribute("BlockResolved7", " ");
		}
		else{	
			request.setAttribute("BlockItem7", listBlockName.get(24).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(24)))
				request.setAttribute("BlockClose7", " ");
			else
				request.setAttribute("BlockClose7", listBlockNum.get(24));
			
			
			if("0".equals(listBlockNum.get(25)))
				request.setAttribute("BlockPending7"," ");
			else
				request.setAttribute("BlockPending7", listBlockNum.get(25));
			System.out.println( listBlockNum.get(25));
			
			if("0".equals(listBlockNum.get(26)))
				request.setAttribute("BlockRejected7", " ");
			else
				request.setAttribute("BlockRejected7", listBlockNum.get(26));
				
			if("0".equals(listBlockNum.get(27)))
				request.setAttribute("BlockResolved7", " ");
			else
				request.setAttribute("BlockResolved7", listBlockNum.get(27));
			System.out.println( listBlockNum.get(27));
		}
		
		if(("0".equals(listBlockNum.get(28)))&&("0".equals(listBlockNum.get(29)))&&("0".equals(listBlockNum.get(30)))&&("0".equals(listBlockNum.get(31)))){
			request.setAttribute("BlockItem8", " ");
			request.setAttribute("BlockClose8", " ");
			request.setAttribute("BlockPending8", " ");
			request.setAttribute("BlockRejected8", " ");
			request.setAttribute("BlockResolved8", " ");
		}
		else{	
			request.setAttribute("BlockItem8", listBlockName.get(28).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(28)))
				request.setAttribute("BlockClose8", " ");
			else
				request.setAttribute("BlockClose8", listBlockNum.get(28));
			
			
			if("0".equals(listBlockNum.get(29)))
				request.setAttribute("BlockPending8"," ");
			else
				request.setAttribute("BlockPending8", listBlockNum.get(29));
			
			if("0".equals(listBlockNum.get(30)))
				request.setAttribute("BlockRejected8", " ");
			else
				request.setAttribute("BlockRejected8", listBlockNum.get(30));
				
			if("0".equals(listBlockNum.get(31)))
				request.setAttribute("BlockResolved8", " ");
			else
				request.setAttribute("BlockResolved8", listBlockNum.get(31));
		}
		
		if(("0".equals(listBlockNum.get(32)))&&("0".equals(listBlockNum.get(33)))&&("0".equals(listBlockNum.get(34)))&&("0".equals(listBlockNum.get(35)))){
			request.setAttribute("BlockItem9", " ");
			request.setAttribute("BlockClose9", " ");
			request.setAttribute("BlockPending9", " ");
			request.setAttribute("BlockRejected9", " ");
			request.setAttribute("BlockResolved9", " ");
		}
		else{	
			request.setAttribute("BlockItem9", listBlockName.get(32).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(32)))
				request.setAttribute("BlockClose9", " ");
			else
				request.setAttribute("BlockClose9", listBlockNum.get(32));
			
			
			if("0".equals(listBlockNum.get(33)))
				request.setAttribute("BlockPending9"," ");
			else
				request.setAttribute("BlockPending9", listBlockNum.get(33));
			
			if("0".equals(listBlockNum.get(34)))
				request.setAttribute("BlockRejected9", " ");
			else
				request.setAttribute("BlockRejected9", listBlockNum.get(34));
				
			if("0".equals(listBlockNum.get(35)))
				request.setAttribute("BlockResolved9", " ");
			else
				request.setAttribute("BlockResolved9", listBlockNum.get(35));
		}
		
		if(("0".equals(listBlockNum.get(36)))&&("0".equals(listBlockNum.get(37)))&&("0".equals(listBlockNum.get(38)))&&("0".equals(listBlockNum.get(39)))){
			request.setAttribute("BlockItem10", " ");
			request.setAttribute("BlockClose10", " ");
			request.setAttribute("BlockPending10", " ");
			request.setAttribute("BlockRejected10", " ");
			request.setAttribute("BlockResolved10", " ");
		}
		else{	
			request.setAttribute("BlockItem10", listBlockName.get(36).replace("Closed", ""));
			
			if("0".equals(listBlockNum.get(36)))
				request.setAttribute("BlockClose10", " ");
			else
				request.setAttribute("BlockClose10", listBlockNum.get(36));
			
			
			if("0".equals(listBlockNum.get(37)))
				request.setAttribute("BlockPending10"," ");
			else
				request.setAttribute("BlockPending10", listBlockNum.get(37));
			
			if("0".equals(listBlockNum.get(38)))
				request.setAttribute("BlockRejected10", " ");
			else
				request.setAttribute("BlockRejected10", listBlockNum.get(38));
				
			if("0".equals(listBlockNum.get(39)))
				request.setAttribute("BlockResolved10", " ");
			else
				request.setAttribute("BlockResolved10", listBlockNum.get(39));
		}
	}
}
