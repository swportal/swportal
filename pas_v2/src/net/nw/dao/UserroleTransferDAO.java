package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class UserroleTransferDAO {

	public String idTOName(int id)
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String resultName = null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select roleid,rolename from userroles where roleid="+id;
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				resultName=rs.getString("rolename");
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
		return resultName;
	}
	
	
	public String idTOName_model(int id)
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String resultName = null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select codeid,ModelCode from defects_infor where codeid="+id;
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				resultName=rs.getString("ModelCode");
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
		return resultName;
	}
}
