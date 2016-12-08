package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

//import com.mysql.jdbc.Connection;

public class ModelDAO {

	public List<String> getmainModels(int roleid)
	{
		Connection conn = null;
		Statement stmt=null;
		ResultSet rs=null;
		List<String> mainModels= new ArrayList<String>();
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from model where pname='' and roleid='"+roleid+"'";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				mainModels.add(rs.getString("title"));
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
}
