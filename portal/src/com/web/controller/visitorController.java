package com.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.controller.entity.Trip;
import com.web.controller.entity.Visitor;
import com.web.controller.service.VisitorService;

@Controller
@RequestMapping("/visitor")
public class visitorController {
	
	@Resource
	private VisitorService visitorService;
	
	@RequestMapping("/getVisitorList")
	public String getVisitorList(HttpServletRequest request,HttpServletResponse response){		
		return "/visitorController/visitorManager"; 
	}

	
	@RequestMapping(value="/findVisitorList",produces="application/json;charset=UTF-8")
	@ResponseBody
	/*
	public List<Visitor> findVisitorList(String keyword,String orderItem, String orderKey,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Visitor> visitorList = null;
		visitorList = visitorService.findVisitorList(keyword,orderItem,orderKey);
		return visitorList; 
	}*/
	
	public void findVisitorList(Integer curpage,String keyword,String orderItem, String orderKey,HttpServletRequest request,HttpServletResponse response){
		try {
			URLDecoder.decode(keyword,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Trip> visitorList = null;
		List<Trip> visitorList2 = null;
		Integer pageSize=12;
		Integer totalvisit = visitorService.totalVisitor().intValue();
		Integer totalpage=(totalvisit%pageSize==0)?(totalvisit/pageSize):(totalvisit/pageSize+1);
		visitorList = visitorService.findVisitorList(curpage,pageSize,keyword, orderItem,orderKey);	
		if(keyword.length()!=0){
			visitorList2=visitorService.findVisitorList(1, visitorService.findAll().size(), keyword, orderItem, orderKey);
			totalpage=(visitorList2.size()%pageSize==0)?(visitorList2.size()/pageSize):(visitorList2.size()/pageSize+1);
		}
		
		JSONArray members = new JSONArray();
		 PrintWriter out= null;
		 
		 try {
			 	out= response.getWriter();
		        JSONObject member = new JSONObject();
		        member.put("visitorList", visitorList);
		        JSONObject memberpage = new JSONObject();
		        memberpage.put("curpage", curpage);
		        memberpage.put("totalpage", totalpage);
		        memberpage.put("totalvisit", totalvisit);
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
	
	@RequestMapping("/updateVisitor")
	public void updateVisitor(HttpServletRequest request,HttpServletResponse response){
		 boolean flag1=false;
		 boolean flag2=false;
		 //boolean flag3=false;
		 System.out.println(request.getRemoteHost());
		 System.out.println(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
		 System.out.println(new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
		 Date date=new Date();//取时间  
		 Calendar calendar = new GregorianCalendar();  
		 calendar.setTime(date);  
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd"); 
		 String curdate = formatter.format(calendar.getTime());
		 
		 
		 String ip=request.getRemoteHost();
		 List<Visitor> allVisitors = visitorService.findAll();
		 for(Visitor vis:allVisitors){
			 if(ip.equals(vis.getIp())){
				 flag1=true;  //有IP
				 if(curdate.equals(vis.getVisitDate())){
					 flag2=true;  // 有IP，有当天记录
					 break;
				 }
				 else
					 flag2=false;  //有IP， 无当天记录
			 }
			 else{}
				 //flag1=false;  //无IP， 新增
		 }
		 
		 if(flag1==false){  //没有IP
			 Visitor visitor = new Visitor();
			 String s=request.getRemoteHost();
			 visitor.setIp(s);
			 if(s.equals("127.0.0.1"))
				 visitor.setName("Localhost");
			 else
				 visitor.setName("***");
			 visitor.setPart("***");
			 visitor.setGrade("***");
			 visitor.setVisitTime(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
			 visitor.setVisitDate(new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
			 visitor.setVisitFreq(Long.parseLong(1+""));
			 visitorService.save(visitor);
		 }
		 else{   //有IP
			 if(flag2==true){  //有当天记录， 更新日期即可
				 	 Long visitnew=visitorService.getByIp(ip).getVisitFreq()+1;
					 visitorService.updateByIP(request.getRemoteHost(),new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()),new SimpleDateFormat("yyyy/MM/dd").format(new Date()),visitnew);
			 }
			 else{  //无当天记录， 新增
				 Visitor visitornew = new Visitor();
				 Visitor visitor=visitorService.getById(visitorService.getByIp(request.getRemoteHost()).getId());
				 visitornew.setIp(request.getRemoteHost());
				 visitornew.setName(visitor.getName());
				 visitornew.setPart(visitor.getPart());
				 visitornew.setGrade(visitor.getGrade());
				 visitornew.setVisitTime(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
				 visitornew.setVisitDate(new SimpleDateFormat("yyyy/MM/dd").format(new Date()));
				 visitornew.setVisitFreq(Long.parseLong(1+""));
				 visitorService.save(visitornew);
			 }
		 }
		 /*Long totalToday = visitorService.todayVisitor();
		 request.getSession().setAttribute("today", totalToday);
		 Long total = visitorService.totalVisitor();
		 request.getSession().setAttribute("total", total);*/
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
		    } catch (IOException e) {
		        e.printStackTrace();
		    }	   
		 
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/getVisitorCount")
	@ResponseBody
	public void getVisitorCount(HttpServletRequest request,HttpServletResponse response){
		Date date=new Date();//取时间  
		Calendar calendar = new GregorianCalendar();  
		calendar.setTime(date);  
		calendar.add(calendar.DATE,-29);//把日期往后增加一天.整数往后推,负数往前移动  
		date=calendar.getTime(); //这个时间就是日期往后推一天的结果   
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd"); 
		String[] curdate = new String[30];
		curdate[0]=formatter.format(calendar.getTime());
		for(int i = 1 ;i<30;i++){
			calendar.add(calendar.DATE,+1);//把日期往后增加一天.整数往后推,负数往前移动  
			curdate[i] =formatter.format(calendar.getTime());
		}
		
		List<Long> sw1Count = new ArrayList<Long>();
		List<Long> sw2Count = new ArrayList<Long>();
		List<Long> swCount = new ArrayList<Long>();
		List<Long> seCount = new ArrayList<Long>();
		List<Long> monCount = new ArrayList<Long>();
		List<Long> sqaCount = new ArrayList<Long>();
		List<Long> total = new ArrayList<Long>();
		
		for(int i=0;i<30;i++){
			sw1Count.add(visitorService.getSW1Count(curdate[i]));
			sw2Count.add(visitorService.getSW2Count(curdate[i]));
			swCount.add(visitorService.getSWCount(curdate[i]));
			seCount.add(visitorService.getSECount(curdate[i]));
			monCount.add(visitorService.getMONCount(curdate[i]));
			sqaCount.add(visitorService.getSQACount(curdate[i]));
			total.add(visitorService.getSW1Count(curdate[i])+visitorService.getSW2Count(curdate[i])+visitorService.getSWCount(curdate[i])+visitorService.getSECount(curdate[i])+visitorService.getMONCount(curdate[i])+visitorService.getSQACount(curdate[i]));
		}
		

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
	            member.put("sw1Count", sw1Count);
	            member.put("sw2Count", sw2Count);
	            member.put("swCount", swCount);
	            member.put("seCount", seCount);
	            member.put("monCount", monCount);
	            member.put("sqaCount", sqaCount);
	            member.put("total", total);
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
	
	
}
