package com.web.controller.service;

import java.sql.ResultSet;
import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Defectdaily;


public interface DefectdailyService extends BaseDao<Defectdaily>{

	List<String> getDailyData(String projectname,String modelname);

	List<Defectdaily> findDailyData(String where);

	ResultSet getResultSet(String where);

}
