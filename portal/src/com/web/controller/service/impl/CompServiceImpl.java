package com.web.controller.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedHashMap;
import java.util.Map;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Comp;
import com.web.controller.service.CompService;

@Service
@Transactional
public class CompServiceImpl extends BaseDaoImpl<Comp> implements CompService {
	public Map<String, Integer> getCompList(String projectname,String modelname) {
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		String pjthql = "";
		String tablename="";
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		if(modelname.length()==0){
			if(projectname.indexOf(",",0)!=-1){
				String a[] = projectname.split(",");
				
				for(int i=0;i<a.length;i++){
					pjthql+=" ProjectName like '%"+a[i]+"%' or";
				}
				pjthql=pjthql.substring(0,pjthql.length()-3);
			}
			else{
				pjthql=" ProjectName like '%"+projectname+"%'";
			}
			tablename="comp_total";
		}
		else{
			pjthql=" ModelCode like '%"+modelname+"%'";
			tablename="comp_model";
		}
		try{
			conn=getConn();
			stmt=conn.createStatement();
			String sql="select Component, sum(Total) as Total, sum(COUNT) as COUNT from "+tablename+" where "+pjthql+" group by Component order by Total  desc, Component  limit 40";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			while(rs.next()){				
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//return resultName;
		}
		finally	{
			try{
				if(rs!=null){
					rs.close();
					rs=null;
				}
				if(stmt!=null){
					stmt.close();
					stmt=null;
				}
				if(conn!=null){
					conn.close();
					conn=null;
				}				
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return map;
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
