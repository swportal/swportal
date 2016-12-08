package net.nw.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

//import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import net.nw.vo.Modelcodes;

public class DefactAllDAO {
	/**
	 * 
	 */
	private String projectname;
	

	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}

	public List<Integer> getAll()//����Model A��B,C�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,TotalA=0,TotalB=0,TotalC = 0,TotalN=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor ";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				TotalA+=rs.getInt("PLMTotalA");
				TotalB+=rs.getInt("PLMTotalB");
				TotalC+=rs.getInt("PLMTotalC");
				TotalN+=rs.getInt("PLMTotalN");
				
			}
			listTotal.add(Total);
			listTotal.add(TotalA);
			listTotal.add(TotalB);
			listTotal.add(TotalC);
			listTotal.add(TotalN);
			
			
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
		return listTotal;
	}
	//String projectname1= ActionContext.getRequest.getParameter("projectname");
	public List<Integer> getAll_select(Modelcodes mc)//����Model A B C�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,TotalA=0,TotalB=0,TotalC = 0,TotalN=0;
		System.out.println("ִ��getAll_select����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			if(mc.getCodeid()!=0){
				String sql="select * from defects_infor where codeid=' "+mc.getCodeid()+"'";
				rs=stmt.executeQuery(sql);
			}
			else if(mc.getCodeid()==0) 
				{
					String sql="select * from defects_infor ";
			//System.out.println("20160125:"+sql);
					rs=stmt.executeQuery(sql);
				}
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				TotalA+=rs.getInt("PLMTotalA");
				TotalB+=rs.getInt("PLMTotalB");
				TotalC+=rs.getInt("PLMTotalC");
				TotalN+=rs.getInt("PLMTotalN");
			}
			listTotal.add(Total);
			listTotal.add(TotalA);
			listTotal.add(TotalB);
			listTotal.add(TotalC);
			listTotal.add(TotalN);
			
			
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
		return listTotal;
	}
	
	
	public List<Integer> getAll_select_projectname(String projectname)//����Model A B C�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,TotalA=0,TotalB=0,TotalC = 0,TotalN=0;
		System.out.println("ִ��getAll_select_projectname����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			
				String sql="select * from defects_infor where ProjectName=' "+projectname+"'";
				rs=stmt.executeQuery(sql);
			
			
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				TotalA+=rs.getInt("PLMTotalA");
				TotalB+=rs.getInt("PLMTotalB");
				TotalC+=rs.getInt("PLMTotalC");
				TotalN+=rs.getInt("PLMTotalN");
			}
			listTotal.add(Total);
			listTotal.add(TotalA);
			listTotal.add(TotalB);
			listTotal.add(TotalC);
			listTotal.add(TotalN);
			
			
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
		return listTotal;
	}
	
	public List<Integer> getAll_type_select(Modelcodes mc)//����Model Opened. Resolved,Closed�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int SQAPLMTotalDelay=0, SQAPLMTotalDelay30=0,SQAPLMTotalDelay60=0;
		int SQAPLMTotalA=0,SQAPLMOpenedA=0,SQAPLMClosedA=0,SQAPLMResolvedA=0;
		int SQAPLMTotalBC=0,SQAPLMOpenedBC=0,SQAPLMClosedBC=0,SQAPLMResolvedBC=0;
		int  SelectDate=0;
		System.out.println("ִ��getAll_type_select����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			if(mc.getCodeid()!=0){
			String sql="select * from defects_infor where codeid=' "+mc.getCodeid()+"' order by SelectDate asc limit 1";
			rs=stmt.executeQuery(sql);
			}
			else if(mc.getCodeid()==0){
					String sql="select * from defects_infor order by SelectDate asc limit 1";
					rs=stmt.executeQuery(sql);
				}
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				Opened+=rs.getInt("PLMOpened");
				Resolved+=rs.getInt("PLMResolved");
				Closed+=rs.getInt("PLMClosed");
				
				OpenedA+=rs.getInt("PLMOpenedA");
				OpenedB+=rs.getInt("PLMOpenedB");
				OpenedC+=rs.getInt("PLMOpenedC");
				OpenedN+=rs.getInt("PLMOpenedN");
				
				ResolvedA+=rs.getInt("PLMResolvedA");
				ResolvedB+=rs.getInt("PLMResolvedB");
				ResolvedC+=rs.getInt("PLMResolvedC");
				ResolvedN+=rs.getInt("PLMResolvedN");
				
				ClosedA+=rs.getInt("PLMClosedA");
				ClosedB+=rs.getInt("PLMClosedB");
				ClosedC+=rs.getInt("PLMClosedC");
				ClosedN+=rs.getInt("PLMClosedN");
				
				SQAPLMTotalDelay+=rs.getInt("SQAPLMTotalDelay");
				SQAPLMTotalDelay30+=rs.getInt("SQAPLMDelay30");
				SQAPLMTotalDelay60+=rs.getInt("SQAPLMDelay60");
				
				SQAPLMTotalA +=rs.getInt("SQAPLMTotalA");
				//System.out.println(rs.getInt("SQAPLMTotalA")+"**************************");
				SQAPLMOpenedA+=rs.getInt("SQAPLMOpenedA");
				SQAPLMResolvedA+=rs.getInt("SQAPLMResolvedA");
				SQAPLMClosedA+=rs.getInt("SQAPLMClosedA");
				
				SQAPLMTotalBC +=(rs.getInt("SQAPLMTotalB")+rs.getInt("SQAPLMTotalC"));
				//System.out.println(rs.getInt("SQAPLMTotalBC")+"**************************");
				SQAPLMOpenedBC+=(rs.getInt("SQAPLMOpenedB")+rs.getInt("SQAPLMOpenedC"));
				SQAPLMResolvedBC+=(rs.getInt("SQAPLMResolvedB")+rs.getInt("SQAPLMResolvedC"));
				SQAPLMClosedBC+=(rs.getInt("SQAPLMClosedB")+rs.getInt("SQAPLMClosedC"));
				
				SelectDate=Integer.parseInt(rs.getDate("SelectDate").toString().substring(0, 4)+rs.getDate("SelectDate").toString().substring(5,7)+rs.getDate("SelectDate").toString().substring(8, 10));
				//System.out.println(SelectDate+"++++++++++++++++++++++++++++++++++666666666666666");
				
				
			}
			listTotal.add(Total);
			listTotal.add(Opened);
			listTotal.add(Resolved);
			listTotal.add(Closed);
			
			listTotal.add(OpenedA);
			listTotal.add(OpenedB);
			listTotal.add(OpenedC);
			listTotal.add(OpenedN);
			
			listTotal.add(ResolvedA);
			listTotal.add(ResolvedB);
			listTotal.add(ResolvedC);
			listTotal.add(ResolvedN);
			
			listTotal.add(ClosedA);
			listTotal.add(ClosedB);
			listTotal.add(ClosedC);
			listTotal.add(ClosedN);
			
			listTotal.add(SQAPLMTotalDelay);
			listTotal.add(SQAPLMTotalDelay30);
			listTotal.add(SQAPLMTotalDelay60);
			
			listTotal.add(SQAPLMTotalA);
			listTotal.add(SQAPLMOpenedA);
			listTotal.add(SQAPLMResolvedA);
			listTotal.add(SQAPLMClosedA);
			listTotal.add(SelectDate);
			
			listTotal.add(SQAPLMTotalBC);
			listTotal.add(SQAPLMOpenedBC);
			listTotal.add(SQAPLMResolvedBC);
			listTotal.add(SQAPLMClosedBC);
			
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
		return listTotal;
	}
	
	
	public List<Integer> getAll_type_select_project(String projectname)//��ѡ��������Model�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,TotalA=0,TotalB=0,TotalC=0,TotalN=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int SQAPLMTotalDelay=0, SQAPLMTotalDelay30=0,SQAPLMTotalDelay60=0;
		int SQAPLMTotalA=0,SQAPLMOpenedA=0,SQAPLMClosedA=0,SQAPLMResolvedA=0;
		int SQAPLMTotalBC=0,SQAPLMOpenedBC=0,SQAPLMClosedBC=0,SQAPLMResolvedBC=0;
		int  SelectDate=0;
		System.out.println("ִ��getAll_type_select_project����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where ProjectName='"+projectname+"'";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				
				TotalA+=rs.getInt("PLMTotalA");
				TotalB+=rs.getInt("PLMTotalB");
				TotalC+=rs.getInt("PLMTotalC");
				TotalN+=rs.getInt("PLMTotalN");   //4
				
				Opened+=rs.getInt("PLMOpened");
				Resolved+=rs.getInt("PLMResolved");
				Closed+=rs.getInt("PLMClosed");   //7
				
				OpenedA+=rs.getInt("PLMOpenedA");
				OpenedB+=rs.getInt("PLMOpenedB");
				OpenedC+=rs.getInt("PLMOpenedC");
				OpenedN+=rs.getInt("PLMOpenedN");  //11
				
				ResolvedA+=rs.getInt("PLMResolvedA");
				ResolvedB+=rs.getInt("PLMResolvedB");
				ResolvedC+=rs.getInt("PLMResolvedC");
				ResolvedN+=rs.getInt("PLMResolvedN");  //15
				
				ClosedA+=rs.getInt("PLMClosedA");
				ClosedB+=rs.getInt("PLMClosedB");
				ClosedC+=rs.getInt("PLMClosedC");
				ClosedN+=rs.getInt("PLMClosedN");  //19
				
				SQAPLMTotalDelay+=rs.getInt("SQAPLMTotalDelay");
				SQAPLMTotalDelay30+=rs.getInt("SQAPLMDelay30");
				SQAPLMTotalDelay60+=rs.getInt("SQAPLMDelay60");   //22
				
				SQAPLMTotalA +=rs.getInt("SQAPLMTotalA");
				System.out.println("SQAPLMTotalA:666666**************************"+SQAPLMTotalA);
				SQAPLMOpenedA+=rs.getInt("SQAPLMOpenedA");
				SQAPLMResolvedA+=rs.getInt("SQAPLMResolvedA");
				SQAPLMClosedA+=rs.getInt("SQAPLMClosedA");
				System.out.println("SQAPLMTotalA:666666**************************"+SQAPLMTotalA+" "+SQAPLMResolvedA+" "+SQAPLMClosedA);
				
				SQAPLMTotalBC +=(rs.getInt("SQAPLMTotalB")+rs.getInt("SQAPLMTotalC"));
				SQAPLMOpenedBC+=(rs.getInt("SQAPLMOpenedB")+rs.getInt("SQAPLMOpenedC"));
				SQAPLMResolvedBC+=(rs.getInt("SQAPLMResolvedB")+rs.getInt("SQAPLMResolvedC"));
				SQAPLMClosedBC+=(rs.getInt("SQAPLMClosedB")+rs.getInt("SQAPLMClosedC"));
				System.out.println("SQAPLMTotalBC:666666**************************"+SQAPLMTotalBC+" "+SQAPLMResolvedBC+" "+SQAPLMClosedBC);
				SelectDate=Integer.parseInt(rs.getDate("SelectDate").toString().substring(0, 4)+rs.getDate("SelectDate").toString().substring(5,7)+rs.getDate("SelectDate").toString().substring(8, 10));
				//System.out.println(SelectDate+"++++++++++++++++++++++++++++++++++666666666666666");
				
			}
			listTotal.add(Total);
			
			listTotal.add(TotalA);
			listTotal.add(TotalB);
			listTotal.add(TotalC);
			listTotal.add(TotalN);
			
			listTotal.add(Opened);
			listTotal.add(Resolved);
			listTotal.add(Closed);
			
			listTotal.add(OpenedA);
			listTotal.add(OpenedB);
			listTotal.add(OpenedC);
			listTotal.add(OpenedN);
			
			listTotal.add(ResolvedA);
			listTotal.add(ResolvedB);
			listTotal.add(ResolvedC);
			listTotal.add(ResolvedN);
			
			listTotal.add(ClosedA);
			listTotal.add(ClosedB);
			listTotal.add(ClosedC);
			listTotal.add(ClosedN);//19
			
			listTotal.add(SQAPLMTotalDelay);
			listTotal.add(SQAPLMTotalDelay30);
			listTotal.add(SQAPLMTotalDelay60);
			
			listTotal.add(SQAPLMTotalA);
			listTotal.add(SQAPLMOpenedA);
			listTotal.add(SQAPLMResolvedA);
			listTotal.add(SQAPLMClosedA);
			
			listTotal.add(SelectDate);
			
			listTotal.add(SQAPLMTotalBC);
			listTotal.add(SQAPLMOpenedBC);
			listTotal.add(SQAPLMResolvedBC);
			listTotal.add(SQAPLMClosedBC);
			
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
		return listTotal;
	}
	
	
	public List<Integer> getAll_type_select_project_multi(String projectname)//��ѡ��������Model�������
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,TotalA=0,TotalB=0,TotalC=0,TotalN=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int SQAPLMTotalDelay=0, SQAPLMTotalDelay30=0,SQAPLMTotalDelay60=0;
		int SQAPLMTotalA=0,SQAPLMOpenedA=0,SQAPLMClosedA=0,SQAPLMResolvedA=0;
		int SQAPLMTotalBC=0,SQAPLMOpenedBC=0,SQAPLMClosedBC=0,SQAPLMResolvedBC=0;
		int  SelectDate=0;
		System.out.println("ִ��getAll_type_select_project����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where ";
			projectname=projectname.substring(0,projectname.length()); //ǰ���Ѿ�ȥ�����һ��','
			System.out.println(projectname);
			String a[] = projectname.split(",");
			System.out.println("a����ĳ���"+a.length);
			for(int i=0;i<(a.length);i++){
				sql=sql+"ProjectName='"+a[i]+"' or ";
				
			}
			sql=sql.substring(0,sql.length()-3);
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				
				TotalA+=rs.getInt("PLMTotalA");
				TotalB+=rs.getInt("PLMTotalB");
				TotalC+=rs.getInt("PLMTotalC");
				TotalN+=rs.getInt("PLMTotalN");   //4
				
				Opened+=rs.getInt("PLMOpened");
				Resolved+=rs.getInt("PLMResolved");
				Closed+=rs.getInt("PLMClosed");   //7
				
				OpenedA+=rs.getInt("PLMOpenedA");
				OpenedB+=rs.getInt("PLMOpenedB");
				OpenedC+=rs.getInt("PLMOpenedC");
				OpenedN+=rs.getInt("PLMOpenedN");  //11
				
				ResolvedA+=rs.getInt("PLMResolvedA");
				ResolvedB+=rs.getInt("PLMResolvedB");
				ResolvedC+=rs.getInt("PLMResolvedC");
				ResolvedN+=rs.getInt("PLMResolvedN");  //15
				
				ClosedA+=rs.getInt("PLMClosedA");
				ClosedB+=rs.getInt("PLMClosedB");
				ClosedC+=rs.getInt("PLMClosedC");
				ClosedN+=rs.getInt("PLMClosedN");  //19
				
				SQAPLMTotalDelay+=rs.getInt("SQAPLMTotalDelay");
				SQAPLMTotalDelay30+=rs.getInt("SQAPLMDelay30");
				SQAPLMTotalDelay60+=rs.getInt("SQAPLMDelay60");   //22
				
				SQAPLMTotalA +=rs.getInt("SQAPLMTotalA");
				//System.out.println("SQAPLMTotalA:666666**************************"+SQAPLMTotalA);
				SQAPLMOpenedA+=rs.getInt("SQAPLMOpenedA");
				SQAPLMResolvedA+=rs.getInt("SQAPLMResolvedA");
				SQAPLMClosedA+=rs.getInt("SQAPLMClosedA");
				
				SQAPLMTotalBC +=(rs.getInt("SQAPLMTotalB")+rs.getInt("SQAPLMTotalC"));
				//System.out.println(rs.getInt("SQAPLMTotalBC")+"**************************");
				SQAPLMOpenedBC+=(rs.getInt("SQAPLMOpenedB")+rs.getInt("SQAPLMOpenedC"));
				SQAPLMResolvedBC+=(rs.getInt("SQAPLMResolvedB")+rs.getInt("SQAPLMResolvedC"));
				SQAPLMClosedBC+=(rs.getInt("SQAPLMClosedB")+rs.getInt("SQAPLMClosedC"));
				
				SelectDate=Integer.parseInt(rs.getDate("SelectDate").toString().substring(0, 4)+rs.getDate("SelectDate").toString().substring(5,7)+rs.getDate("SelectDate").toString().substring(8, 10));
				//System.out.println(SelectDate+"++++++++++++++++++++++++++++++++++666666666666666");
				
			}
			listTotal.add(Total);
			
			listTotal.add(TotalA);
			listTotal.add(TotalB);
			listTotal.add(TotalC);
			listTotal.add(TotalN);
			
			listTotal.add(Opened);
			listTotal.add(Resolved);
			listTotal.add(Closed);
			
			listTotal.add(OpenedA);
			listTotal.add(OpenedB);
			listTotal.add(OpenedC);
			listTotal.add(OpenedN);
			
			listTotal.add(ResolvedA);
			listTotal.add(ResolvedB);
			listTotal.add(ResolvedC);
			listTotal.add(ResolvedN);
			
			listTotal.add(ClosedA);
			listTotal.add(ClosedB);
			listTotal.add(ClosedC);
			listTotal.add(ClosedN);//19
			
			listTotal.add(SQAPLMTotalDelay);
			listTotal.add(SQAPLMTotalDelay30);
			listTotal.add(SQAPLMTotalDelay60);
			
			listTotal.add(SQAPLMTotalA);
			listTotal.add(SQAPLMOpenedA);
			listTotal.add(SQAPLMResolvedA);
			listTotal.add(SQAPLMClosedA);
			
			listTotal.add(SelectDate);
			
			listTotal.add(SQAPLMTotalBC);
			listTotal.add(SQAPLMOpenedBC);
			listTotal.add(SQAPLMResolvedBC);
			listTotal.add(SQAPLMClosedBC);
			
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
		return listTotal;
	}
	
	
	public List<Integer> getAll_type()//
	{
		List<Integer> listTotal=new ArrayList<Integer>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int Total=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int SQAPLMTotalDelay=0, SQAPLMTotalDelay30=0,SQAPLMTotalDelay60=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor ";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total +=rs.getInt("PLMTotal");
				Opened+=rs.getInt("PLMOpened");
				Resolved+=rs.getInt("PLMResolved");
				Closed+=rs.getInt("PLMClosed");
				
				OpenedA+=rs.getInt("PLMOpenedA");
				OpenedB+=rs.getInt("PLMOpenedB");
				OpenedC+=rs.getInt("PLMOpenedC");
				OpenedN+=rs.getInt("PLMOpenedN");
				
				ResolvedA+=rs.getInt("PLMResolvedA");
				ResolvedB+=rs.getInt("PLMResolvedB");
				ResolvedC+=rs.getInt("PLMResolvedC");
				ResolvedN+=rs.getInt("PLMResolvedN");
				
				ClosedA+=rs.getInt("PLMClosedA");
				ClosedB+=rs.getInt("PLMClosedB");
				ClosedC+=rs.getInt("PLMClosedC");
				ClosedN+=rs.getInt("PLMClosedN");
				
				SQAPLMTotalDelay+=rs.getInt("SQAPLMTotalDelay");
				SQAPLMTotalDelay30+=rs.getInt("SQAPLMDelay30");
				SQAPLMTotalDelay60+=rs.getInt("SQAPLMDelay60");
				
			}
			listTotal.add(Total);
			listTotal.add(Opened);
			listTotal.add(Resolved);
			listTotal.add(Closed);
			
			listTotal.add(OpenedA);
			listTotal.add(OpenedB);
			listTotal.add(OpenedC);
			listTotal.add(OpenedN);
			
			listTotal.add(ResolvedA);
			listTotal.add(ResolvedB);
			listTotal.add(ResolvedC);
			listTotal.add(ResolvedN);
			
			listTotal.add(ClosedA);
			listTotal.add(ClosedB);
			listTotal.add(ClosedC);
			listTotal.add(ClosedN);
			
			listTotal.add(SQAPLMTotalDelay);
			listTotal.add(SQAPLMTotalDelay30);
			listTotal.add(SQAPLMTotalDelay60);
			
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
		return listTotal;
	}
	
	//��ȡ7�����
	public List<String> getDailyData(Modelcodes mc)
	{
		List<String> listTotal=new ArrayList<String>();
		UserroleTransferDAO utd1=new UserroleTransferDAO();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate="";
		
		//int Total=0,Opened=0,Closed=0,SelectDate = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		int Day1=0,Day2=0,Day3=0,Day4=0,Day5=0,Day6=0,Day7=0;
		int Day8=0,Day9=0,Day10=0,Day11=0,Day12=0,Day13=0,Day14=0,Day15=0,Day16=0,Day17=0,Day18=0,Day19=0,Day20=0;
		int Day21=0,Day22=0,Day23=0,Day24=0,Day25=0,Day26=0,Day27=0;
		int Day28=0,Day29=0,Day30=0,Day31=0,Day32=0,Day33=0,Day34=0,Day35=0,Day36=0,Day37=0,Day38=0,Day39=0,Day40=0;
		int Day41=0,Day42=0,Day43=0,Day44=0,Day45=0,Day46=0,Day47=0;
		int Day48=0,Day49=0,Day50=0,Day51=0,Day52=0,Day53=0,Day54=0,Day55=0,Day56=0,Day57=0,Day58=0,Day59=0,Day60=0;
		
		int ResolveDay1=0,ResolveDay2=0,ResolveDay3=0,ResolveDay4=0,ResolveDay5=0,ResolveDay6=0,ResolveDay7=0;
		int ResolveDay8=0,ResolveDay9=0,ResolveDay10=0,ResolveDay11=0,ResolveDay12=0,ResolveDay13=0,ResolveDay14=0,ResolveDay15=0,ResolveDay16=0,ResolveDay17=0,ResolveDay18=0,ResolveDay19=0,ResolveDay20=0;
		int ResolveDay21=0,ResolveDay22=0,ResolveDay23=0,ResolveDay24=0,ResolveDay25=0,ResolveDay26=0,ResolveDay27=0;
		int ResolveDay28=0,ResolveDay29=0,ResolveDay30=0,ResolveDay31=0,ResolveDay32=0,ResolveDay33=0,ResolveDay34=0,ResolveDay35=0,ResolveDay36=0,ResolveDay37=0,ResolveDay38=0,ResolveDay39=0,ResolveDay40=0;
		int ResolveDay41=0,ResolveDay42=0,ResolveDay43=0,ResolveDay44=0,ResolveDay45=0,ResolveDay46=0,ResolveDay47=0;
		int ResolveDay48=0,ResolveDay49=0,ResolveDay50=0,ResolveDay51=0,ResolveDay52=0,ResolveDay53=0,ResolveDay54=0,ResolveDay55=0,ResolveDay56=0,ResolveDay157=0,ResolveDay58=0,ResolveDay59=0,ResolveDay60=0;
		
		int[] ResolveDay = new int[60];
		int[] Day = new int[60];
		System.out.println("ִ�� getDailyData(Modelcodes mc)����");
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			if(mc.getCodeid()!=0){
			String sql="select * from defects_infor_daily where ModelCode='"+utd1.idTOName_model(mc.getCodeid())+"' ";
			
			System.out.println(sql);
			rs=stmt.executeQuery(sql);}
			else if(mc.getCodeid()==0)
			{
				String sql="select * from defects_infor_daily " ;
				
				System.out.println(sql);
				
				rs=stmt.executeQuery(sql);
			}
			
			while(rs.next())
			{
				Day1 +=rs.getInt("Day1");
				Day2 +=rs.getInt("Day2");
				Day3 +=rs.getInt("Day3");
				Day4 +=rs.getInt("Day4");
				Day5 +=rs.getInt("Day5");
				Day6 +=rs.getInt("Day6");
				Day7 +=rs.getInt("Day7");
				Day8 +=rs.getInt("Day8");
				Day9 +=rs.getInt("Day9");
				Day10 +=rs.getInt("Day10");
				Day11 +=rs.getInt("Day11");
				Day12 +=rs.getInt("Day12");
				Day13 +=rs.getInt("Day13");
				Day14 +=rs.getInt("Day14");
				Day15 +=rs.getInt("Day15");
				Day16 +=rs.getInt("Day16");
				Day17 +=rs.getInt("Day17");
				Day18 +=rs.getInt("Day18");
				Day19 +=rs.getInt("Day19");
				Day20 +=rs.getInt("Day20");
				for(int i=0;i<40;i++){
					Day[i]+=rs.getInt("Day"+(i+21));
				}
				
				
				ResolveDay1 +=rs.getInt("ResolveDay1");
				ResolveDay2 +=rs.getInt("ResolveDay2");
				ResolveDay3 +=rs.getInt("ResolveDay3");
				ResolveDay4 +=rs.getInt("ResolveDay4");
				ResolveDay5 +=rs.getInt("ResolveDay5");
				ResolveDay6 +=rs.getInt("ResolveDay6");
				ResolveDay7 +=rs.getInt("ResolveDay7");
				ResolveDay8 +=rs.getInt("ResolveDay8");
				ResolveDay9 +=rs.getInt("ResolveDay9");
				ResolveDay10 +=rs.getInt("ResolveDay10");
				ResolveDay11 +=rs.getInt("ResolveDay11");
				ResolveDay12 +=rs.getInt("ResolveDay12");
				ResolveDay13 +=rs.getInt("ResolveDay13");
				ResolveDay14 +=rs.getInt("ResolveDay14");
				ResolveDay15 +=rs.getInt("ResolveDay15");
				ResolveDay16 +=rs.getInt("ResolveDay16");
				ResolveDay17 +=rs.getInt("ResolveDay17");
				ResolveDay18 +=rs.getInt("ResolveDay18");
				ResolveDay19 +=rs.getInt("ResolveDay19");
				ResolveDay20 +=rs.getInt("ResolveDay20");
				for(int i=0;i<40;i++){
					ResolveDay[i]+=rs.getInt("ResolveDay"+(i+21));
				}
				
				//selectDate=rs.getDate("SelectDate").toString();
				
				
				
				selectDate=rs.getDate("SelectDate").toString();
				
				
				
			}
			listTotal.add(Day1+"");
			listTotal.add(Day2+"");
			listTotal.add(Day3+"");
			listTotal.add(Day4+"");
			listTotal.add(Day5+"");
			listTotal.add(Day6+"");
			listTotal.add(Day7+"");
			listTotal.add(Day8+"");
			listTotal.add(Day9+"");
			listTotal.add(Day10+"");
			listTotal.add(Day11+"");
			listTotal.add(Day12+"");
			listTotal.add(Day13+"");
			listTotal.add(Day14+"");
			listTotal.add(Day15+"");
			
			
			
			listTotal.add(ResolveDay1+"");
			listTotal.add(ResolveDay2+"");
			listTotal.add(ResolveDay3+"");
			listTotal.add(ResolveDay4+"");
			listTotal.add(ResolveDay5+"");
			listTotal.add(ResolveDay6+"");
			listTotal.add(ResolveDay7+"");
			listTotal.add(ResolveDay8+"");
			listTotal.add(ResolveDay9+"");
			listTotal.add(ResolveDay10+"");
			listTotal.add(ResolveDay11+"");
			listTotal.add(ResolveDay12+"");
			listTotal.add(ResolveDay13+"");
			listTotal.add(ResolveDay14+"");
			listTotal.add(ResolveDay15+"");
			
			listTotal.add(selectDate.toString());
			
			listTotal.add(Day16+"");
			listTotal.add(Day17+"");
			listTotal.add(Day18+"");
			listTotal.add(Day19+"");
			listTotal.add(Day20+"");
			
			listTotal.add(ResolveDay16+"");
			listTotal.add(ResolveDay17+"");
			listTotal.add(ResolveDay18+"");
			listTotal.add(ResolveDay19+"");
			listTotal.add(ResolveDay20+"");
			for(int i=0;i<40;i++){
				listTotal.add(Day[i]+"");
			}
			for(int i=0;i<40;i++){
				listTotal.add(ResolveDay[i]+"");
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
		return listTotal;
	}
	
	public List<String> getDailyData(String projectname)//��ȡ��ѡ��������Model��������������
	{
		List<String> listTotal=new ArrayList<String>();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate="";
		
		int Day1=0,Day2=0,Day3=0,Day4=0,Day5=0,Day6=0,Day7=0;
		int Day8=0,Day9=0,Day10=0,Day11=0,Day12=0,Day13=0,Day14=0,Day15=0,Day16=0,Day17=0,Day18=0,Day19=0,Day20=0;
		int ResolveDay1=0,ResolveDay2=0,ResolveDay3=0,ResolveDay4=0,ResolveDay5=0,ResolveDay6=0,ResolveDay7=0;
		int ResolveDay8=0,ResolveDay9=0,ResolveDay10=0,ResolveDay11=0,ResolveDay12=0,ResolveDay13=0,ResolveDay14=0,ResolveDay15=0,ResolveDay16=0,ResolveDay17=0,ResolveDay18=0,ResolveDay19=0,ResolveDay20=0;
		System.out.println("ִ�� getDailyData(String projectname)����");
		int[] ResolveDay = new int[60];
		int[] Day = new int[60];
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor_daily where ProjectName='"+projectname+"'";
			
			System.out.println(sql);
			
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Day1 +=rs.getInt("Day1");
				Day2 +=rs.getInt("Day2");
				Day3 +=rs.getInt("Day3");
				Day4 +=rs.getInt("Day4");
				Day5 +=rs.getInt("Day5");
				Day6 +=rs.getInt("Day6");
				Day7 +=rs.getInt("Day7");
				Day8 +=rs.getInt("Day8");
				Day9 +=rs.getInt("Day9");
				Day10 +=rs.getInt("Day10");
				Day11 +=rs.getInt("Day11");
				Day12 +=rs.getInt("Day12");
				Day13 +=rs.getInt("Day13");
				Day14 +=rs.getInt("Day14");
				Day15 +=rs.getInt("Day15");
				Day16 +=rs.getInt("Day16");
				Day17 +=rs.getInt("Day17");
				Day18 +=rs.getInt("Day18");
				Day19 +=rs.getInt("Day19");
				Day20 +=rs.getInt("Day20");
				int j=21;
				//System.out.println("0101011111111111111111111111111111111"+rs.getInt("Day"+60));
				for(int i=0;i<40;i++){
					Day[i]+=rs.getInt("Day"+(i+21));
				}
				
				ResolveDay1 +=rs.getInt("ResolveDay1");
				ResolveDay2 +=rs.getInt("ResolveDay2");
				ResolveDay3 +=rs.getInt("ResolveDay3");
				ResolveDay4 +=rs.getInt("ResolveDay4");
				ResolveDay5 +=rs.getInt("ResolveDay5");
				ResolveDay6 +=rs.getInt("ResolveDay6");
				ResolveDay7 +=rs.getInt("ResolveDay7");
				ResolveDay8 +=rs.getInt("ResolveDay8");
				ResolveDay9 +=rs.getInt("ResolveDay9");
				ResolveDay10 +=rs.getInt("ResolveDay10");
				ResolveDay11 +=rs.getInt("ResolveDay11");
				ResolveDay12 +=rs.getInt("ResolveDay12");
				ResolveDay13 +=rs.getInt("ResolveDay13");
				ResolveDay14 +=rs.getInt("ResolveDay14");
				ResolveDay15 +=rs.getInt("ResolveDay15");
				ResolveDay16 +=rs.getInt("ResolveDay16");
				ResolveDay17 +=rs.getInt("ResolveDay17");
				ResolveDay18 +=rs.getInt("ResolveDay18");
				ResolveDay19 +=rs.getInt("ResolveDay19");
				ResolveDay20 +=rs.getInt("ResolveDay20");
				for(int i=0;i<40;i++){
					ResolveDay[i]+=rs.getInt("ResolveDay"+(i+21));
				}
				//selectDate=rs.getDate("SelectDate").toString();
				
				
				
				selectDate=rs.getDate("SelectDate").toString();
				
				
				
			}
			listTotal.add(Day1+"");
			listTotal.add(Day2+"");
			listTotal.add(Day3+"");
			listTotal.add(Day4+"");
			listTotal.add(Day5+"");
			listTotal.add(Day6+"");
			listTotal.add(Day7+"");
			listTotal.add(Day8+"");
			listTotal.add(Day9+"");
			listTotal.add(Day10+"");
			listTotal.add(Day11+"");
			listTotal.add(Day12+"");
			listTotal.add(Day13+"");
			listTotal.add(Day14+"");
			listTotal.add(Day15+"");
			
			
			listTotal.add(ResolveDay1+"");
			listTotal.add(ResolveDay2+"");
			listTotal.add(ResolveDay3+"");
			listTotal.add(ResolveDay4+"");
			listTotal.add(ResolveDay5+"");
			listTotal.add(ResolveDay6+"");
			listTotal.add(ResolveDay7+"");
			listTotal.add(ResolveDay8+"");
			listTotal.add(ResolveDay9+"");
			listTotal.add(ResolveDay10+"");
			listTotal.add(ResolveDay11+"");
			listTotal.add(ResolveDay12+"");
			listTotal.add(ResolveDay13+"");
			listTotal.add(ResolveDay14+"");
			listTotal.add(ResolveDay15+"");
			
			listTotal.add(selectDate.toString());
			
			listTotal.add(Day16+"");
			listTotal.add(Day17+"");
			listTotal.add(Day18+"");
			listTotal.add(Day19+"");
			listTotal.add(Day20+"");
			
			listTotal.add(ResolveDay16+"");
			listTotal.add(ResolveDay17+"");
			listTotal.add(ResolveDay18+"");
			listTotal.add(ResolveDay19+"");
			listTotal.add(ResolveDay20+"");
			for(int i=0;i<40;i++){
				listTotal.add(Day[i]+"");
			}
			for(int i=0;i<40;i++){
				listTotal.add(ResolveDay[i]+"");
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
		return listTotal;
	}
	
	public List<String> getDailyData_multi(String projectname)//��ȡ��ѡ��������Model��������������
	{
		List<String> listTotal=new ArrayList<String>();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate="";
		
		int Day1=0,Day2=0,Day3=0,Day4=0,Day5=0,Day6=0,Day7=0;
		int Day8=0,Day9=0,Day10=0,Day11=0,Day12=0,Day13=0,Day14=0,Day15=0,Day16=0,Day17=0,Day18=0,Day19=0,Day20=0;
		int ResolveDay1=0,ResolveDay2=0,ResolveDay3=0,ResolveDay4=0,ResolveDay5=0,ResolveDay6=0,ResolveDay7=0;
		int ResolveDay8=0,ResolveDay9=0,ResolveDay10=0,ResolveDay11=0,ResolveDay12=0,ResolveDay13=0,ResolveDay14=0,ResolveDay15=0,ResolveDay16=0,ResolveDay17=0,ResolveDay18=0,ResolveDay19=0,ResolveDay20=0;
		System.out.println("ִ�� getDailyData(String projectname)����");
		int[] ResolveDay = new int[60];
		int[] Day = new int[60];
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor_daily where ";
			String a[] = projectname.split(",");
			System.out.println("a����ĳ���"+a.length);
			for(int i=0;i<(a.length);i++){
				sql=sql+"ProjectName='"+a[i]+"' or ";
				
			}
			sql=sql.substring(0,sql.length()-3);
			System.out.println(sql);
			
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Day1 +=rs.getInt("Day1");
				Day2 +=rs.getInt("Day2");
				Day3 +=rs.getInt("Day3");
				Day4 +=rs.getInt("Day4");
				Day5 +=rs.getInt("Day5");
				Day6 +=rs.getInt("Day6");
				Day7 +=rs.getInt("Day7");
				Day8 +=rs.getInt("Day8");
				Day9 +=rs.getInt("Day9");
				Day10 +=rs.getInt("Day10");
				Day11 +=rs.getInt("Day11");
				Day12 +=rs.getInt("Day12");
				Day13 +=rs.getInt("Day13");
				Day14 +=rs.getInt("Day14");
				Day15 +=rs.getInt("Day15");
				Day16 +=rs.getInt("Day16");
				Day17 +=rs.getInt("Day17");
				Day18 +=rs.getInt("Day18");
				Day19 +=rs.getInt("Day19");
				Day20 +=rs.getInt("Day20");
				int j=21;
				//System.out.println("0101011111111111111111111111111111111"+rs.getInt("Day"+60));
				for(int i=0;i<40;i++){
					Day[i]+=rs.getInt("Day"+(i+21));
				}
				
				ResolveDay1 +=rs.getInt("ResolveDay1");
				ResolveDay2 +=rs.getInt("ResolveDay2");
				ResolveDay3 +=rs.getInt("ResolveDay3");
				ResolveDay4 +=rs.getInt("ResolveDay4");
				ResolveDay5 +=rs.getInt("ResolveDay5");
				ResolveDay6 +=rs.getInt("ResolveDay6");
				ResolveDay7 +=rs.getInt("ResolveDay7");
				ResolveDay8 +=rs.getInt("ResolveDay8");
				ResolveDay9 +=rs.getInt("ResolveDay9");
				ResolveDay10 +=rs.getInt("ResolveDay10");
				ResolveDay11 +=rs.getInt("ResolveDay11");
				ResolveDay12 +=rs.getInt("ResolveDay12");
				ResolveDay13 +=rs.getInt("ResolveDay13");
				ResolveDay14 +=rs.getInt("ResolveDay14");
				ResolveDay15 +=rs.getInt("ResolveDay15");
				ResolveDay16 +=rs.getInt("ResolveDay16");
				ResolveDay17 +=rs.getInt("ResolveDay17");
				ResolveDay18 +=rs.getInt("ResolveDay18");
				ResolveDay19 +=rs.getInt("ResolveDay19");
				ResolveDay20 +=rs.getInt("ResolveDay20");
				for(int i=0;i<40;i++){
					ResolveDay[i]+=rs.getInt("ResolveDay"+(i+21));
				}
				//selectDate=rs.getDate("SelectDate").toString();
				
				
				
				selectDate=rs.getDate("SelectDate").toString();
				
				
				
			}
			listTotal.add(Day1+"");
			listTotal.add(Day2+"");
			listTotal.add(Day3+"");
			listTotal.add(Day4+"");
			listTotal.add(Day5+"");
			listTotal.add(Day6+"");
			listTotal.add(Day7+"");
			listTotal.add(Day8+"");
			listTotal.add(Day9+"");
			listTotal.add(Day10+"");
			listTotal.add(Day11+"");
			listTotal.add(Day12+"");
			listTotal.add(Day13+"");
			listTotal.add(Day14+"");
			listTotal.add(Day15+"");
			
			
			listTotal.add(ResolveDay1+"");
			listTotal.add(ResolveDay2+"");
			listTotal.add(ResolveDay3+"");
			listTotal.add(ResolveDay4+"");
			listTotal.add(ResolveDay5+"");
			listTotal.add(ResolveDay6+"");
			listTotal.add(ResolveDay7+"");
			listTotal.add(ResolveDay8+"");
			listTotal.add(ResolveDay9+"");
			listTotal.add(ResolveDay10+"");
			listTotal.add(ResolveDay11+"");
			listTotal.add(ResolveDay12+"");
			listTotal.add(ResolveDay13+"");
			listTotal.add(ResolveDay14+"");
			listTotal.add(ResolveDay15+"");
			
			listTotal.add(selectDate.toString());
			
			listTotal.add(Day16+"");
			listTotal.add(Day17+"");
			listTotal.add(Day18+"");
			listTotal.add(Day19+"");
			listTotal.add(Day20+"");
			
			listTotal.add(ResolveDay16+"");
			listTotal.add(ResolveDay17+"");
			listTotal.add(ResolveDay18+"");
			listTotal.add(ResolveDay19+"");
			listTotal.add(ResolveDay20+"");
			for(int i=0;i<40;i++){
				listTotal.add(Day[i]+"");
			}
			for(int i=0;i<40;i++){
				listTotal.add(ResolveDay[i]+"");
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
		return listTotal;
	}
	
	
	public List<String> getDateSelect(Modelcodes mc)//
	{
		List<String> listTotal=new ArrayList<String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate;
		
		int Total=0,Opened=0,Closed=0,SelectDate = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where to_days(now())-to_days(SelectDate)<7 and codeid=' "+mc.getCodeid()+"' order by SelectDate asc";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total =rs.getInt("PLMTotal");
				//Opened+=rs.getInt("Opened");
				//Resolved+=rs.getInt("Resolved");
				Closed=rs.getInt("PLMClosed");
				selectDate=rs.getDate("SelectDate").toString();
				
				listTotal.add(Total+"");
				
				listTotal.add(Closed+"");
				listTotal.add(selectDate);
				
				
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
		return listTotal;
	}
	
	
	
	public List<String> getDateSelect(String projectname)//
	{
		List<String> listTotal=new ArrayList<String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate;
		
		int Total=0,Opened=0,Closed=0,SelectDate = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where to_days(now())-to_days(SelectDate)<7 and ProjectName=' "+projectname+"' order by SelectDate asc";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total =rs.getInt("PLMTotal");
				
				Closed=rs.getInt("PLMClosed");
				selectDate=rs.getDate("SelectDate").toString();
				
				listTotal.add(Total+"");
				
				listTotal.add(Closed+"");
				listTotal.add(selectDate);
				
				
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
		return listTotal;
	}
	//��ѯĳ���Ƿ������
	public boolean isDataNull(int id,Modelcodes mc)
	{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		boolean flag_0=false;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where to_days(now())-to_days(SelectDate)="+id+" and codeid=' "+mc.getCodeid()+"' order by SelectDate asc";
			
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				
				flag_0=true;
				//System.out.println("��"+id+flag_0);
				
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
		
		
			return flag_0;
	}
	
	public List<String> getDateSelect()//��������������
	{
		List<String> listTotal=new ArrayList<String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String selectDate;
		int Total=0,Opened=0,Closed=0,Resolved = 0,OpenedA=0,OpenedB=0,OpenedC=0,OpenedN=0, ResolvedA=0,ResolvedB=0,ResolvedC=0,ResolvedN=0,ClosedA=0,ClosedB=0,ClosedC=0,ClosedN=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from defects_infor where to_days(now())-to_days(SelectDate)<7 order by SelectDate asc";
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				Total =rs.getInt("PLMTotal");
				
				Closed =rs.getInt("PLMClosed");
				selectDate=rs.getDate("PLMSelectDate").toString();
				
				listTotal.add(Total+"");
				
				listTotal.add(Closed+"");
				listTotal.add(selectDate);
				
				
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
		return listTotal;
	}
	
	
	public int getNum(String product, int month)
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Plan Date`)) as 'DTV 1�¼ƻ�PRA��Ŀ' from plm_model_info  where month(plm_model_info.`PRA Plan Date`)=" + month+ " and year(plm_model_info.`PRA Plan Date`)=2015 and Product like '%"+product+"%'";
			//System.out.println("ssssssss"+sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	public int getNum_Actual(String product, int month)
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Actual Date`)) as 'DTV 1��ʵ��PRA��Ŀ' from plm_model_info where month(plm_model_info.`PRA Plan Date`)=" + month+ " and plm_model_info.`PRA Actual Date`<= plm_model_info.`PRA Plan Date` and year(plm_model_info.`PRA Plan Date`)=2015 and Product like '%"+product+"%'";
			//System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	
	public int getNum_2016(String product, int month)//
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Plan Date`)) as 'DTV 1�¼ƻ�PRA��Ŀ' from plm_model_info  where month(plm_model_info.`PRA Plan Date`)=" + month+ " and year(plm_model_info.`PRA Plan Date`)=2016 and Product like '%"+product+"%'";
			//System.out.println("ssssssss"+sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	public int getNum_2016_smart(String product, int month)//
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Plan Date`)) as 'DTV 1�¼ƻ�PRA��Ŀ' from plm_model_info  where month(plm_model_info.`PRA Plan Date`)=" + month+ " and year(plm_model_info.`PRA Plan Date`)=2016 and Product like '%"+product+"%' and (plm_model_info.`Pjt. Name` like '%JAZZ%' or plm_model_info.`Pjt. Name` like '%HAWK%')";


			//System.out.println("ssssssss"+sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	public int getNum_2016_entry(String product, int month)//
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Plan Date`)) as 'DTV 1�¼ƻ�PRA��Ŀ' from plm_model_info  where month(plm_model_info.`PRA Plan Date`)=" + month+ " and year(plm_model_info.`PRA Plan Date`)=2016 and Product like '%"+product+"%' and (plm_model_info.`Pjt. Name` like '%NT%' or plm_model_info.`Pjt. Name` like '%XL%')";


			//System.out.println("ssssssss"+sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	public int getNum_Actual_2016(String product, int month)
	{
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int number=0;
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select count(month(plm_model_info.`PRA Actual Date`)) as 'DTV 1��ʵ��PRA��Ŀ' from plm_model_info where month(plm_model_info.`PRA Plan Date`)=" + month+ " and plm_model_info.`PRA Actual Date`<= plm_model_info.`PRA Plan Date` and year(plm_model_info.`PRA Plan Date`)=2016 and Product like '%"+product+"%'";
			//System.out.println(sql);
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				number =rs.getInt(1);
			
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
		return number;
	}
	
	/*
	 * @author:wly
	 * time: 2016.02
	 */
	public Map<String,Integer> getAllComponent(String projectname)//��ȡ��ѡ�����component�������
	{
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from comp_total where ProjectName='"+projectname+"' limit 40";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);

			while(rs.next())
			{
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
				System.out.println("mapmapmap"+rs.getString("Component")+rs.getInt("COUNT"));
				
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
		return map;
	}
	
	public Map<String,Integer> getAllComponent_multi(String projectname)//��ȡ��ѡ�����component�������
	{
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		List<String> listTotal=new ArrayList<String>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		int []Count=new int[40];
		//int ii=0;
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select Component, sum(Total) as Total, sum(COUNT) as COUNT from comp_total where ";
			String a[] = projectname.split(",");
			System.out.println("a����ĳ���"+a.length);
			for(int i=0;i<(a.length);i++){
				sql=sql+"ProjectName='"+a[i]+"' or ";
				
			}
			sql=sql.substring(0,sql.length()-3)+" group by Component order by Total desc,Component limit 40 ";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);

			while(rs.next())
			{
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
				//System.out.println("mapmapmap"+rs.getString("Component")+rs.getInt("COUNT"));
					//ii=0;
					//listTotal.add(rs.getInt("COUNT")+"");
					//System.out.println(rs.getInt("COUNT"));
					//ii++;
				
				
			}	
			System.out.println("Count[0]="+Count[0]);
			System.out.println("Count[37]="+Count[37]);
			System.out.println("Count[38]="+Count[38]);
			System.out.println("Count[39]="+Count[39]);
			
			
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
		return map;
	}
	public Map<String,Integer> getAllComponent(Modelcodes mc)//��ȡ��ѡ�����model��component�������
	{
		UserroleTransferDAO utd1=new UserroleTransferDAO();
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			if(mc.getCodeid()!=0){
			String sql="select * from comp_model where ModelCode='"+utd1.idTOName_model(mc.getCodeid())+"' limit 40";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);
			}
			else if(mc.getCodeid()==0){
				String sql="select * from comp_model limit 40";
				System.out.println(sql);
				rs=stmt.executeQuery(sql);
			}

			while(rs.next())
			{
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
				//System.out.println("mapmapmap"+rs.getString("Component")+rs.getInt("COUNT"));
				
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
		return map;
	}

	public Map<String,Integer> getAllBlock(String projectname)//��ȡ��ѡ�����Block�������
	{
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			String sql="select * from block_total where ProjectName='"+projectname+"'";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);

			while(rs.next())
			{
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
				//System.out.println("Blockmap "+rs.getString("Component")+" "+rs.getInt("COUNT"));
				
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
		return map;
	}
	
	
		public Map<String,Integer> getAllBlock_multi(String projectname)//��ȡ��ѡ�����component�������
		{
			LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
			List<String> listTotal=new ArrayList<String>();
			Connection conn=null;
			Statement stmt=null;
			ResultSet rs=null;		
			int []Count=new int[40];
			int ii=0;
			
			try{
				conn=Conn.getConnection();
				stmt=conn.createStatement();
				String sql="select Component, sum(Total) as Total, sum(COUNT) as COUNT from block_total where ";
				String a[] = projectname.split(",");
				System.out.println("a����ĳ���"+a.length);
				for(int i=0;i<(a.length);i++){
					sql=sql+"ProjectName='"+a[i]+"' or ";
					
				}
				sql=sql.substring(0,sql.length()-3)+"group by Component order by Total desc,Component ";
				//sql=sql.substring(0,sql.length()-3);
				
				System.out.println(sql);
				rs=stmt.executeQuery(sql);

				while(rs.next())
				{
					map.put(rs.getString("Component"), rs.getInt("COUNT"));
					//System.out.println("mapmapmap"+rs.getString("Component")+rs.getInt("COUNT"));
					//listTotal.add(rs.getInt("COUNT")+"");
						
					
				}	
				//System.out.println("Count[39]="+Count[39]);
				
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
			return map;
		}
	
	
	public Map<String,Integer> getAllBlock(Modelcodes mc)//��ȡ��ѡ�����model��Block�������
	{
		UserroleTransferDAO utd1=new UserroleTransferDAO();
		LinkedHashMap <String,Integer> map=new LinkedHashMap<String,Integer>();		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;		
		
		try{
			conn=Conn.getConnection();
			stmt=conn.createStatement();
			if(mc.getCodeid()!=0){
			String sql="select * from block_model where ModelCode='"+utd1.idTOName_model(mc.getCodeid())+"'";
			System.out.println(sql);
			rs=stmt.executeQuery(sql);}
			else if(mc.getCodeid()==0){
				String sql="select * from block_model";
				System.out.println(sql);
				rs=stmt.executeQuery(sql);
			}

			while(rs.next())
			{
				map.put(rs.getString("Component"), rs.getInt("COUNT"));
				//System.out.println("mapmapmap"+rs.getString("Component")+rs.getInt("COUNT"));
				
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
		return map;
	}
}
