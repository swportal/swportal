package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.nw.vo.ProjectOngoing;

//import com.mysql.jdbc.Connection;

public class SearchProjectDAO {

	public List<String> getmainModels(String projectname)
	{
		Connection conn = null;
		Statement stmt=null;
		ResultSet rs=null;
		List<String> mainModels= new ArrayList<String>();
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from model where pname='' and roleid='"+projectname+"'";
			System.out.println(sql+"-------------------------------------------------");
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				mainModels.add(rs.getString("projectname"));
				mainModels.add(rs.getString("codename"));
			}
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//return resultName;
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
					rs=null;
				}
				if(stmt!=null){
					stmt.close();
					stmt=null;
				}
				if(conn!=null)
				{
					conn.close();
					conn=null;
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return mainModels;
		
	}
	
	public List<ProjectOngoing> findAll(String projectname) throws Exception{
		List<ProjectOngoing> all = new ArrayList<ProjectOngoing>() ;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from project_ongoing where PjtName like '%"+projectname+"%' order by PjtRegistrationDate";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
		ProjectOngoing pog1 = null ;
		
		while(rs.next())
		{
			pog1=new ProjectOngoing();
			pog1.setPjtName(rs.getString("PjtName"));
			pog1.setDevModelCode(rs.getString("DevModelName"));
			pog1.setPjtStatus(rs.getString("PjtStatus"));
			pog1.setDevPL(rs.getString("DevPL"));
			pog1.setSWEM(rs.getString("SWEM"));
			System.out.println(rs.getString("SWEM")+"??????????????????????????");
			pog1.setPVRPlanDate(rs.getString("PVRPlanDate"));
			pog1.setPVRActualDate(rs.getString("PVRActualDate"));
			pog1.setPRAPlanDate(rs.getString("PRAPlanDate"));
			pog1.setPRAActualDate(rs.getString("PRAActualDate"));
			pog1.setPLMTotal(rs.getInt("PLMTotal"));
			pog1.setPLMOpened(rs.getInt("PLMOpened"));
			pog1.setPLMResolved(rs.getInt("PLMResolved"));
			pog1.setPLMClosed(rs.getInt("PLMClosed"));
			
			pog1.setUpdateTime(rs.getString("UpdateTime"));
			//System.out.println(rs.getString("UpdateTime"));
			all.add(pog1);
			//System.out.println("projectid:"+rs.getInt("projectid"));
			
		}
		return all;
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		return all;
	}
	finally
	{
		try{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			if(stmt!=null){
				stmt.close();
				stmt=null;
			}
			if(conn!=null)
			{
				conn.close();
				conn=null;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	}
	
	public List<ProjectOngoing> findAll_PL(String PL) throws Exception{
		List<ProjectOngoing> all = new ArrayList<ProjectOngoing>() ;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from project_ongoing where DevPL like '%"+PL+"%' or SWEM like '%"+PL+"%' order by PjtRegistrationDate";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
		ProjectOngoing pog1 = null ;
		
		while(rs.next())
		{
			pog1=new ProjectOngoing();
			pog1.setPjtName(rs.getString("PjtName"));
			pog1.setDevModelCode(rs.getString("DevModelName"));
			pog1.setPjtStatus(rs.getString("PjtStatus"));
			pog1.setDevPL(rs.getString("DevPL"));
			pog1.setSWEM(rs.getString("SWEM"));
			pog1.setPVRPlanDate(rs.getString("PVRPlanDate"));
			pog1.setPVRActualDate(rs.getString("PVRActualDate"));
			pog1.setPRAPlanDate(rs.getString("PRAPlanDate"));
			pog1.setPRAActualDate(rs.getString("PRAActualDate"));
			pog1.setPLMTotal(rs.getInt("PLMTotal"));
			pog1.setPLMOpened(rs.getInt("PLMOpened"));
			pog1.setPLMResolved(rs.getInt("PLMResolved"));
			pog1.setPLMClosed(rs.getInt("PLMClosed"));
			
			pog1.setUpdateTime(rs.getString("UpdateTime"));
			//System.out.println(rs.getString("UpdateTime"));
			all.add(pog1);
			//System.out.println("projectid:"+rs.getInt("projectid"));
			
		}
		return all;
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		return all;
	}
	finally
	{
		try{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			if(stmt!=null){
				stmt.close();
				stmt=null;
			}
			if(conn!=null)
			{
				conn.close();
				conn=null;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	}
	
	
	public List<ProjectOngoing> findAll_status(String status) throws Exception{
		List<ProjectOngoing> all = new ArrayList<ProjectOngoing>() ;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from project_ongoing where PjtStatus like '%"+status+"%' order by PjtRegistrationDate";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
		ProjectOngoing pog1 = null ;
		
		while(rs.next())
		{
			pog1=new ProjectOngoing();
			pog1.setPjtName(rs.getString("PjtName"));
			pog1.setDevModelCode(rs.getString("DevModelName"));
			pog1.setPjtStatus(rs.getString("PjtStatus"));
			pog1.setDevPL(rs.getString("DevPL"));
			pog1.setSWEM(rs.getString("SWEM"));
			pog1.setPVRPlanDate(rs.getString("PVRPlanDate"));
			pog1.setPVRActualDate(rs.getString("PVRActualDate"));
			pog1.setPRAPlanDate(rs.getString("PRAPlanDate"));
			pog1.setPRAActualDate(rs.getString("PRAActualDate"));
			pog1.setPLMTotal(rs.getInt("PLMTotal"));
			pog1.setPLMOpened(rs.getInt("PLMOpened"));
			pog1.setPLMResolved(rs.getInt("PLMResolved"));
			pog1.setPLMClosed(rs.getInt("PLMClosed"));
			
			pog1.setUpdateTime(rs.getString("UpdateTime"));
			//System.out.println(rs.getString("UpdateTime"));
			all.add(pog1);
			//System.out.println("projectid:"+rs.getInt("projectid"));
			
		}
		return all;
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		return all;
	}
	finally
	{
		try{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			if(stmt!=null){
				stmt.close();
				stmt=null;
			}
			if(conn!=null)
			{
				conn.close();
				conn=null;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	}
	
	
	
	//@SuppressWarnings("null")
	public List<ProjectOngoing> findAll() throws Exception{
		List<ProjectOngoing> all = new ArrayList<ProjectOngoing>() ;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from project_ongoing order by PjtRegistrationDate ";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
		
			
			ProjectOngoing pog1 = null ;
		while(rs.next())
		{
			pog1=new ProjectOngoing();
			pog1.setPjtName(rs.getString("PjtName"));
			pog1.setDevModelCode(rs.getString("DevModelName"));
			pog1.setPjtStatus(rs.getString("PjtStatus"));
			pog1.setDevPL(rs.getString("DevPL"));
			pog1.setSWEM(rs.getString("SWEM"));
			pog1.setPVRPlanDate(rs.getString("PVRPlanDate"));
			pog1.setPVRActualDate(rs.getString("PVRActualDate"));
			pog1.setPRAPlanDate(rs.getString("PRAPlanDate"));
			pog1.setPRAActualDate(rs.getString("PRAActualDate"));
			pog1.setPLMTotal(rs.getInt("PLMTotal"));
			pog1.setPLMOpened(rs.getInt("PLMOpened"));
			pog1.setPLMResolved(rs.getInt("PLMResolved"));
			pog1.setPLMClosed(rs.getInt("PLMClosed"));
			
			pog1.setUpdateTime(rs.getString("UpdateTime").substring(0, 19));
			//System.out.println(rs.getString("UpdateTime").substring(0, 19));
			all.add(pog1);
			
		}
		return all;
	}
	catch(Exception ex)
	{
		ex.printStackTrace();
		return all;
	}
	finally
	{
		try{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			if(stmt!=null){
				stmt.close();
				stmt=null;
			}
			if(conn!=null)
			{
				conn.close();
				conn=null;
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	}
}
