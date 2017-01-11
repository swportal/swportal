package com.web.controller.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Defect;
import com.web.controller.entity.Defectdaily;
import com.web.controller.entity.Defectinfo;
import com.web.controller.service.DefectService;
import com.web.controller.service.DefectdailyService;
import com.web.controller.service.DefectinfoService;

@Service
@Transactional
public class DefectdailyServiceImpl extends BaseDaoImpl<Defectdaily> implements DefectdailyService {
	@Deprecated
	public List<String> getDailyData(String projectname,String modelname) {
		List<String> listDaily=new ArrayList<String>();
		int Day1=0,Day2=0,Day3=0,Day4=0,Day5=0,Day6=0,Day7=0,Day8=0,Day9=0,Day10=0,
			Day11=0,Day12=0,Day13=0,Day14=0,Day15=0,Day16=0,Day17=0,Day18=0,Day19=0,Day20=0,
			Day21=0,Day22=0,Day23=0,Day24=0,Day25=0,Day26=0,Day27=0,Day28=0,Day29=0,Day30=0,
			Day31=0,Day32=0,Day33=0,Day34=0,Day35=0,Day36=0,Day37=0,Day38=0,Day39=0,Day40=0,
			Day41=0,Day42=0,Day43=0,Day44=0,Day45=0,Day46=0,Day47=0,Day48=0,Day49=0,Day50=0,
			Day51=0,Day52=0,Day53=0,Day54=0,Day55=0,Day56=0,Day57=0,Day58=0,Day59=0,Day60=0;
		int ResolveDay1=0,ResolveDay2=0,ResolveDay3=0,ResolveDay4=0,ResolveDay5=0,ResolveDay6=0,ResolveDay7=0,ResolveDay8=0,ResolveDay9=0,ResolveDay10=0,
			ResolveDay11=0,ResolveDay12=0,ResolveDay13=0,ResolveDay14=0,ResolveDay15=0,ResolveDay16=0,ResolveDay17=0,ResolveDay18=0,ResolveDay19=0,ResolveDay20=0,
			ResolveDay21=0,ResolveDay22=0,ResolveDay23=0,ResolveDay24=0,ResolveDay25=0,ResolveDay26=0,ResolveDay27=0,ResolveDay28=0,ResolveDay29=0,ResolveDay30=0,
			ResolveDay31=0,ResolveDay32=0,ResolveDay33=0,ResolveDay34=0,ResolveDay35=0,ResolveDay36=0,ResolveDay37=0,ResolveDay38=0,ResolveDay39=0,ResolveDay40=0,
			ResolveDay41=0,ResolveDay42=0,ResolveDay43=0,ResolveDay44=0,ResolveDay45=0,ResolveDay46=0,ResolveDay47=0,ResolveDay48=0,ResolveDay49=0,ResolveDay50=0,
			ResolveDay51=0,ResolveDay52=0,ResolveDay53=0,ResolveDay54=0,ResolveDay55=0,ResolveDay56=0,ResolveDay57=0,ResolveDay58=0,ResolveDay59=0,ResolveDay60=0;
		
		String pjthql = "";
		if(modelname.length()==0){
			if(projectname.indexOf(",",0)!=-1){
				String a[] = projectname.split(",");
				
				for(int i=0;i<a.length;i++){
					pjthql+=" d.projectName like '%"+a[i]+"%' or";
				}
				pjthql=pjthql.substring(0,pjthql.length()-3);
			}
			else{
				pjthql=" d.projectName like '%"+projectname+"%'";
			}
		}
		else{
			pjthql=" d.projectName like '%%'";
		}
		
		
		
		List<Defectdaily> defectList = getSession().createQuery("FROM Defectdaily d WHERE d.modelCode like '%"+modelname+"%' and ("+pjthql+")")
				.list();
		for(Defectdaily daily:defectList){
			Day1 +=daily.getDay1();
			Day2 +=daily.getDay2();
			Day3 +=daily.getDay3();
			Day4 +=daily.getDay4();
			Day5 +=daily.getDay5();
			Day6 +=daily.getDay6();
			Day7 +=daily.getDay7();
			Day8 +=daily.getDay8();
			Day9 +=daily.getDay9();
			Day10 +=daily.getDay10();
			Day11 +=daily.getDay11();
			Day12 +=daily.getDay12();
			Day13 +=daily.getDay13();
			Day14 +=daily.getDay14();
			Day15 +=daily.getDay15();
			Day16 +=daily.getDay16();
			Day17 +=daily.getDay17();
			Day18 +=daily.getDay18();
			Day19 +=daily.getDay19();
			Day20 +=daily.getDay20();
			Day21 +=daily.getDay21();
			Day22 +=daily.getDay22();
			Day23 +=daily.getDay23();
			Day24 +=daily.getDay24();
			Day25 +=daily.getDay25();
			Day26 +=daily.getDay26();
			Day27 +=daily.getDay27();
			Day28 +=daily.getDay28();
			Day29 +=daily.getDay29();
			Day30 +=daily.getDay30();
			Day31 +=daily.getDay31();
			Day32 +=daily.getDay32();
			Day33 +=daily.getDay33();
			Day34 +=daily.getDay34();
			Day35 +=daily.getDay35();
			Day36 +=daily.getDay36();
			Day37 +=daily.getDay37();
			Day38 +=daily.getDay38();
			Day39 +=daily.getDay39();
			Day40 +=daily.getDay40();
			Day41 +=daily.getDay41();
			Day42 +=daily.getDay42();
			Day43 +=daily.getDay43();
			Day44 +=daily.getDay44();
			Day45 +=daily.getDay45();
			Day46 +=daily.getDay46();
			Day47 +=daily.getDay47();
			Day48 +=daily.getDay48();
			Day49 +=daily.getDay49();
			Day50 +=daily.getDay50();
			Day51 +=daily.getDay51();
			Day52 +=daily.getDay52();
			Day53 +=daily.getDay53();
			Day54 +=daily.getDay54();
			Day55 +=daily.getDay55();
			Day56 +=daily.getDay56();
			Day57 +=daily.getDay57();
			Day58 +=daily.getDay58();
			Day59 +=daily.getDay59();
			Day60 +=daily.getDay60();
			
			
			ResolveDay1 +=daily.getResolveDay1();
			ResolveDay2 +=daily.getResolveDay2();
			ResolveDay3 +=daily.getResolveDay3();
			ResolveDay4 +=daily.getResolveDay4();
			ResolveDay5 +=daily.getResolveDay5();
			ResolveDay6 +=daily.getResolveDay6();
			ResolveDay7 +=daily.getResolveDay7();
			ResolveDay8 +=daily.getResolveDay8();
			ResolveDay9 +=daily.getResolveDay9();
			ResolveDay10 +=daily.getResolveDay10();
			ResolveDay11 +=daily.getResolveDay11();
			ResolveDay12 +=daily.getResolveDay12();
			ResolveDay13 +=daily.getResolveDay13();
			ResolveDay14 +=daily.getResolveDay14();
			ResolveDay15 +=daily.getResolveDay15();
			ResolveDay16 +=daily.getResolveDay16();
			ResolveDay17 +=daily.getResolveDay17();
			ResolveDay18 +=daily.getResolveDay18();
			ResolveDay19 +=daily.getResolveDay19();
			ResolveDay20 +=daily.getResolveDay20();
			ResolveDay21 +=daily.getResolveDay21();
			ResolveDay22 +=daily.getResolveDay22();
			ResolveDay23 +=daily.getResolveDay23();
			ResolveDay24 +=daily.getResolveDay24();
			ResolveDay25 +=daily.getResolveDay25();
			ResolveDay26 +=daily.getResolveDay26();
			ResolveDay27 +=daily.getResolveDay27();
			ResolveDay28 +=daily.getResolveDay28();
			ResolveDay29 +=daily.getResolveDay29();
			ResolveDay30 +=daily.getResolveDay30();
			ResolveDay31 +=daily.getResolveDay31();
			ResolveDay32 +=daily.getResolveDay32();
			ResolveDay33 +=daily.getResolveDay33();
			ResolveDay34 +=daily.getResolveDay34();
			ResolveDay35 +=daily.getResolveDay35();
			ResolveDay36 +=daily.getResolveDay36();
			ResolveDay37 +=daily.getResolveDay37();
			ResolveDay38 +=daily.getResolveDay38();
			ResolveDay39 +=daily.getResolveDay39();
			ResolveDay40 +=daily.getResolveDay40();
			ResolveDay41 +=daily.getResolveDay41();
			ResolveDay42 +=daily.getResolveDay42();
			ResolveDay43 +=daily.getResolveDay43();
			ResolveDay44 +=daily.getResolveDay44();
			ResolveDay45 +=daily.getResolveDay45();
			ResolveDay46 +=daily.getResolveDay46();
			ResolveDay47 +=daily.getResolveDay47();
			ResolveDay48 +=daily.getResolveDay48();
			ResolveDay49 +=daily.getResolveDay49();
			ResolveDay50 +=daily.getResolveDay50();
			ResolveDay51 +=daily.getResolveDay51();
			ResolveDay52 +=daily.getResolveDay52();
			ResolveDay53 +=daily.getResolveDay53();
			ResolveDay54 +=daily.getResolveDay54();
			ResolveDay55 +=daily.getResolveDay55();
			ResolveDay56 +=daily.getResolveDay56();
			ResolveDay57 +=daily.getResolveDay57();
			ResolveDay58 +=daily.getResolveDay58();
			ResolveDay59 +=daily.getResolveDay59();
			ResolveDay60 +=daily.getResolveDay60();
			
		}
		
		listDaily.add(Day1+"");
		listDaily.add(Day2+"");
		listDaily.add(Day3+"");
		listDaily.add(Day4+"");
		listDaily.add(Day5+"");
		listDaily.add(Day6+"");
		listDaily.add(Day7+"");
		listDaily.add(Day8+"");
		listDaily.add(Day9+"");
		listDaily.add(Day10+"");
		listDaily.add(Day11+"");
		listDaily.add(Day12+"");
		listDaily.add(Day13+"");
		listDaily.add(Day14+"");
		listDaily.add(Day15+"");
		listDaily.add(Day16+"");
		listDaily.add(Day17+"");
		listDaily.add(Day18+"");
		listDaily.add(Day19+"");
		listDaily.add(Day20+"");
		listDaily.add(Day21+"");
		listDaily.add(Day22+"");
		listDaily.add(Day23+"");
		listDaily.add(Day24+"");
		listDaily.add(Day25+"");
		listDaily.add(Day26+"");
		listDaily.add(Day27+"");
		listDaily.add(Day28+"");
		listDaily.add(Day29+"");
		listDaily.add(Day30+"");
		listDaily.add(Day31+"");
		listDaily.add(Day32+"");
		listDaily.add(Day33+"");
		listDaily.add(Day34+"");
		listDaily.add(Day35+"");
		listDaily.add(Day36+"");
		listDaily.add(Day37+"");
		listDaily.add(Day38+"");
		listDaily.add(Day39+"");
		listDaily.add(Day40+"");
		listDaily.add(Day41+"");
		listDaily.add(Day42+"");
		listDaily.add(Day43+"");
		listDaily.add(Day44+"");
		listDaily.add(Day45+"");
		listDaily.add(Day46+"");
		listDaily.add(Day47+"");
		listDaily.add(Day48+"");
		listDaily.add(Day49+"");
		listDaily.add(Day50+"");
		listDaily.add(Day51+"");
		listDaily.add(Day52+"");
		listDaily.add(Day53+"");
		listDaily.add(Day54+"");
		listDaily.add(Day55+"");
		listDaily.add(Day56+"");
		listDaily.add(Day57+"");
		listDaily.add(Day58+"");
		listDaily.add(Day59+"");
		listDaily.add(Day60+"");
		
		listDaily.add(ResolveDay1+"");
		listDaily.add(ResolveDay2+"");
		listDaily.add(ResolveDay3+"");
		listDaily.add(ResolveDay4+"");
		listDaily.add(ResolveDay5+"");
		listDaily.add(ResolveDay6+"");
		listDaily.add(ResolveDay7+"");
		listDaily.add(ResolveDay8+"");
		listDaily.add(ResolveDay9+"");
		listDaily.add(ResolveDay10+"");
		listDaily.add(ResolveDay11+"");
		listDaily.add(ResolveDay12+"");
		listDaily.add(ResolveDay13+"");
		listDaily.add(ResolveDay14+"");
		listDaily.add(ResolveDay15+"");
		listDaily.add(ResolveDay16+"");
		listDaily.add(ResolveDay17+"");
		listDaily.add(ResolveDay18+"");
		listDaily.add(ResolveDay19+"");
		listDaily.add(ResolveDay20+"");
		listDaily.add(ResolveDay21+"");
		listDaily.add(ResolveDay22+"");
		listDaily.add(ResolveDay23+"");
		listDaily.add(ResolveDay24+"");
		listDaily.add(ResolveDay25+"");
		listDaily.add(ResolveDay26+"");
		listDaily.add(ResolveDay27+"");
		listDaily.add(ResolveDay28+"");
		listDaily.add(ResolveDay29+"");
		listDaily.add(ResolveDay30+"");
		listDaily.add(ResolveDay31+"");
		listDaily.add(ResolveDay32+"");
		listDaily.add(ResolveDay33+"");
		listDaily.add(ResolveDay34+"");
		listDaily.add(ResolveDay35+"");
		listDaily.add(ResolveDay36+"");
		listDaily.add(ResolveDay37+"");
		listDaily.add(ResolveDay38+"");
		listDaily.add(ResolveDay39+"");
		listDaily.add(ResolveDay40+"");
		listDaily.add(ResolveDay41+"");
		listDaily.add(ResolveDay42+"");
		listDaily.add(ResolveDay43+"");
		listDaily.add(ResolveDay44+"");
		listDaily.add(ResolveDay45+"");
		listDaily.add(ResolveDay46+"");
		listDaily.add(ResolveDay47+"");
		listDaily.add(ResolveDay48+"");
		listDaily.add(ResolveDay49+"");
		listDaily.add(ResolveDay50+"");
		listDaily.add(ResolveDay51+"");
		listDaily.add(ResolveDay52+"");
		listDaily.add(ResolveDay53+"");
		listDaily.add(ResolveDay54+"");
		listDaily.add(ResolveDay55+"");
		listDaily.add(ResolveDay56+"");
		listDaily.add(ResolveDay57+"");
		listDaily.add(ResolveDay58+"");
		listDaily.add(ResolveDay59+"");
		listDaily.add(ResolveDay60+"");
		return listDaily;
		
	}

	@Override
	public List<Defectdaily> findDailyData(String where) {
		return getSession().createQuery("FROM Defectdaily "+ where)
				.list();
	}
	
	public ResultSet getResultSet(String where){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		
		String sql = "select * from defects_infor_daily "+where; 
		System.out.println(sql);
		//String sql = "select top "+len+" * from person where pid >= ? order by pid";
		
		try {
			pstmt = conn.prepareStatement(sql);			
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return rs;
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

