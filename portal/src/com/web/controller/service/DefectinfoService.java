package com.web.controller.service;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Defect;
import com.web.controller.entity.Defectinfo;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;


public interface DefectinfoService extends BaseDao<Defectinfo>{

	List<Defect> findDefectinfoList(Integer curPage, Integer pageSize,String where) ;

	Map<Integer, String> getCodes(String projectname);

	List<Integer> getDefectData(String projectname,String modelname);

	String getNameById(int parseInt);

	List<String> getDailyData(String projectname, String modelname);
	ResultSet getResultSet(String where);
	//int findDefectCount(String where);
}
