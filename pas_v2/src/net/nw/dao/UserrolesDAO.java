package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import java.sql.Statement;
import java.util.Map;

public class UserrolesDAO {

	public Map<Integer,String> getRoles()
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select roleid,rolename from userroles;";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				map.put(rs.getInt("roleid"), rs.getString("rolename"));
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
}
