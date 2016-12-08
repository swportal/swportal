package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;




public class ProjectStatusDAO {
	/**
	 * author:xuxingping
	 * date:2016/02/27
	 */
	public ProjectStatusDAO(){
		
	}
	public ResultSet getResultSet(String Product){
		
		Connection conn = null;
		
		ResultSet rs = null;
		
		Statement stmt=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from project_status where Product='"+Product+"' ";
			System.out.println(sql+"-------------------------------------------------");
			rs=stmt.executeQuery(sql);	
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//return resultName;
		}
		
		//return listTotal;
		return rs;
		
	} 
	
	
public ResultSet getResultSet_Delay(){
		
		Connection conn = null;
		
		ResultSet rs = null;
		
		Statement stmt=null;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from plm_model_info where ( (plm_model_info.`PVR Plan Date` < curdate() and plm_model_info.`PVR Actual Date`is null) or (plm_model_info.`PRA Plan Date` < curdate() and plm_model_info.`PRA Actual Date`is null) or (plm_model_info.`SRA Plan Date` < curdate() and plm_model_info.`SRA Actual Date`is null) ) and plm_model_info.`Pjt. Status`!='Drop' and plm_model_info.`SRA Status`!='Drop' and plm_model_info.`Pjt. Registration Date`>'2015-10-25'";
			System.out.println(sql+"++++++++++++++++++++++++++++++++++");
			rs=stmt.executeQuery(sql);	
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			//return resultName;
		}
		
		//return listTotal;
		return rs;
		
	} 
	
}
