package net.nw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.sql.Statement;
import java.util.Map;

public class ModelcodesDAO {

	public Map<Integer,String> getCodes()
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select codeid,ModelCode from defects_infor;";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				map.put(rs.getInt("codeid"), rs.getString("ModelCode"));
				//System.out.println("codeid"+rs.getInt("codeid"));
			}
			//map.put(10, "All Models");
			return map;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return map;
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
	
	public Map<Integer,String> getCodes(String projectname)
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select distinct codeid,ModelCode from defects_infor where ProjectName= '"+projectname+"'";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				map.put(rs.getInt("codeid"), rs.getString("ModelCode"));
				//System.out.println("codeid"+rs.getInt("codeid"));
			}
			map.put(0, "All");
			return map;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return map;
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
	
	public Map<Integer,String> getNames()
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		//int i=1;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select distinct codeid, ModelCode from defects_infor;";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				map.put(rs.getInt("codeid"), rs.getString("ModelCode"));
				//i++;
				//System.out.println("codeid"+rs.get//Int("codeid"));
			}
			return map;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return map;
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
		public String getNameById(int codeid)
		{		
			String modelname=null;
			Connection conn=null;
			PreparedStatement pstmt = null;
			ResultSet rs=null;
			//int i=1;
			try{
				conn=Conn.getConnection();
				
				String sql="select distinct ModelCode from defects_infor where codeid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, codeid);
				
				rs=pstmt.executeQuery();
				while(rs.next()){
					modelname=rs.getString("ModelCode");
				}				
				
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
				
			}
			finally
			{
				try{
					if(rs!=null)
					{
						rs.close();
						rs=null;
					}
					if(pstmt!=null){
						pstmt.close();
						pstmt=null;
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
			return modelname;
		}
		
	}