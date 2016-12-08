package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.sql.Statement;
import java.util.Map;
import net.nw.vo.Modelcodes;
//import net.nw.vo.Modelcodes;
import net.nw.vo.ProjectOngoing;

public class SelectCodeDAO {

	public Map<Integer,String> getCodes(Modelcodes mc)
	{
		Map<Integer,String> map=new HashMap<Integer,String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select distinct codeid,ProjectName from defects_infor where codeid= '"+mc.getCodeid()+"'";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				map.put(rs.getInt("codeid"), rs.getString("ProjectName"));
				//System.out.println("projectid:"+rs.getInt("projectid"));
				
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
