package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import net.nw.vo.Users;

public class UserLoginDAO {

	public boolean usersLogin(Users u)
	{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		boolean flag=false;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select userid,username,roleid from users where username='"+u.getUsername()+"' and password= '"+u.getPassword()+"' and roleid= '"+u.getRoleid()+"'";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				flag=true;
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
		return flag;
		
	}
	
}
