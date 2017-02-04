package com.web.controller.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Defect;
import com.web.controller.entity.Defectinfo;
import com.web.controller.service.DefectinfoService;

@Service
@Transactional
public class DefectinfoServiceImpl extends BaseDaoImpl<Defectinfo> implements DefectinfoService {

	@SuppressWarnings("unchecked")
	@Override
	public List<Defect> findDefectinfoList(Integer curPage, Integer pageSize,String where) {
		Integer start=(curPage-1)*pageSize;
		return getSession().createQuery("FROM Defectinfo i "+where+"")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<Integer, String> getCodes(String projectname) {
		String pjthql = "";
		if(projectname.indexOf(",",0)!=-1){
			String a[] = projectname.split(",");
			
			for(int i=0;i<a.length;i++){
				pjthql+=" i.projectName like '%"+a[i]+"%' or";
			}
			pjthql=pjthql.substring(0,pjthql.length()-3);
		}
		else{
			pjthql=" i.projectName like '%"+projectname+"%'";
		}
		
		List<Defectinfo> infoList = getSession().createQuery("FROM Defectinfo i WHERE "+pjthql)
				//.setFirstResult(0)
				//.setMaxResults(1)
				.list();
		Map<Integer,String> map=new HashMap<Integer,String>();
		for(Defectinfo info:infoList){
			map.put(info.getCodeid(), info.getModelCode());
		}
		map.put(0, "All");
		return map;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> getDefectData(String projectname,String modelname) {
		List<Integer> listData=new ArrayList<Integer>();
		int Total=0,TotalA=0,TotalB=0,TotalC=0,TotalN=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int SQAPLMTotalDelay=0, SQAPLMTotalDelay30=0,SQAPLMTotalDelay60=0;
		int SQAPLMTotalA=0,SQAPLMOpenedA=0,SQAPLMClosedA=0,SQAPLMResolvedA=0;
		int SQAPLMTotalBC=0,SQAPLMOpenedBC=0,SQAPLMClosedBC=0,SQAPLMResolvedBC=0;
		String pjthql = "";
		if(projectname.indexOf(",",0)!=-1){
			String a[] = projectname.split(",");
			
			for(int i=0;i<a.length;i++){
				pjthql+=" i.projectName like '%"+a[i]+"%' or";
			}
			pjthql=pjthql.substring(0,pjthql.length()-3);
		}
		else{
			pjthql=" i.projectName like '%"+projectname+"%'";
		}
		
		List<Defectinfo> dataList = getSession().createQuery("FROM Defectinfo i WHERE  i.modelCode like '%"+modelname+"%' and ("+pjthql+")")
				.list();
		
		for(Defectinfo info:dataList){
			Total +=info.getPlmtotal();
			
			TotalA+=info.getPlmtotalA();
			TotalB+=info.getPlmtotalB();
			TotalC+=info.getPlmtotalC();
			TotalN+=info.getPlmtotalN();   //4
			
			Opened+=info.getPlmopened();
			Resolved+=info.getPlmresolved();
			Closed+=info.getPlmclosed();   //7
			
			OpenedA+=info.getPlmopenedA();
			OpenedB+=info.getPlmopenedB();
			OpenedC+=info.getPlmopenedC();
			OpenedN+=info.getPlmopenedN();  //11
			
			ResolvedA+=info.getResolvedA();
			ResolvedB+=info.getResolvedB();
			ResolvedC+=info.getResolvedC();
			ResolvedN+=info.getResolvedN();  //15
			
			ClosedA+=info.getClosedA();
			ClosedB+=info.getClosedB();
			ClosedC+=info.getClosedC();
			ClosedN+=info.getClosedN();  //19
			
			SQAPLMTotalDelay+=info.getSqaplmtotalDelay();
			SQAPLMTotalDelay30+=info.getSqaplmdelay30();
			SQAPLMTotalDelay60+=info.getSqaplmdelay60();   //22
			
			SQAPLMTotalA +=info.getSqaplmtotalA();
			SQAPLMOpenedA+=info.getSqaplmopenedA();
			SQAPLMResolvedA+=info.getSqaplmresolvedA();
			SQAPLMClosedA+=info.getSqaplmclosedA(); //26
			
			SQAPLMTotalBC +=(info.getSqaplmtotalB()+info.getSqaplmtotalC());
			SQAPLMOpenedBC+=(info.getSqaplmopenedB()+info.getSqaplmopenedC());
			SQAPLMResolvedBC+=(info.getSqaplmresolvedB()+info.getSqaplmresolvedC());
			SQAPLMClosedBC+=(info.getSqaplmclosedB()+info.getSqaplmclosedC()); //30
		}
		listData.add(Total);
		listData.add(TotalA);
		listData.add(TotalB);
		listData.add(TotalC);
		listData.add(TotalN);
		
		listData.add(Opened);
		listData.add(Resolved);
		listData.add(Closed);
		
		listData.add(OpenedA);
		listData.add(OpenedB);
		listData.add(OpenedC);
		listData.add(OpenedN); //11
		
		listData.add(ResolvedA);
		listData.add(ResolvedB);
		listData.add(ResolvedC);
		listData.add(ResolvedN);
		
		listData.add(ClosedA);
		listData.add(ClosedB);
		listData.add(ClosedC);
		listData.add(ClosedN);//19
		
		listData.add(SQAPLMTotalDelay);
		listData.add(SQAPLMTotalDelay30);
		listData.add(SQAPLMTotalDelay60);
		
		listData.add(SQAPLMTotalA);
		listData.add(SQAPLMOpenedA);
		listData.add(SQAPLMResolvedA);
		listData.add(SQAPLMClosedA); //26
		
		
		listData.add(SQAPLMTotalBC);
		listData.add(SQAPLMOpenedBC);
		listData.add(SQAPLMResolvedBC);
		listData.add(SQAPLMClosedBC);
		
		return listData;
	}

	@Override
	public String getNameById(int parseInt) {
		 Defectinfo  defect= (Defectinfo)getSession().createQuery("FROM Defectinfo i where i.codeid=?")
				.setParameter(0,parseInt)
				.setFirstResult(0)
				.setMaxResults(1)
				.uniqueResult();
		
		return defect.getModelCode();
		
	}

	@Override
	public List<String> getDailyData(String projectname, String modelname) {
		int[] ResolveDay = new int[400];
		int[] Day = new int[400];
		String where = "where";
		//String currdate= request.getParameter("currdate");
		
		String a[] = projectname.split(",");
		for(int i=0;i<(a.length);i++){
			where=where+" ProjectName='"+a[i]+"' or ";
			
		}
		where=where.substring(0,where.length()-3);
		if(modelname.length()==0){			
		}
		else{
			where=" where ModelCode ='"+modelname+"'";
		}
		
		List<String> listDaily = new ArrayList<String>();
		 ResultSet rs=null;
		 rs=getResultSet(where);
		 try {
			 while (rs.next()) {	
					for(int i=0;i<60;i++){
						Day[i]+=rs.getInt("Day"+(i+1));
						ResolveDay[i]+=rs.getInt("ResolveDay"+(i+1));
					}
			}
			 for(int i=1;i<=60;i++){
				 listDaily.add(Day[60-i]+"");
				 listDaily.add(ResolveDay[60-i]+"");	
			 }
			 rs.close();
		 } 
		 catch (Exception e) {
			System.out.println(e.getMessage());
		 }
		 finally{
			 
		}		
		return listDaily;
	}

	
	public ResultSet getResultSet(String where){
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
		
		String sql = "select * from defects_infor_daily "+where; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}
	
	
	private Connection getConn() throws ClassNotFoundException, SQLException{
		
		String driver = "com.mysql.jdbc.Driver"; 
        String url="jdbc:mysql://109.110.100.56/tsdr_project";
    	String user="root";
    	String password="";
		Class.forName(driver);
		return DriverManager.getConnection(url,user,password);
		
	}
	
}

