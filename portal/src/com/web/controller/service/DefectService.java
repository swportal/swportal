package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Defect;


public interface DefectService extends BaseDao<Defect>{

	List<Defect> findDefectList(Integer curPage, Integer pageSize,String where) ;

	int findDefectCount(String where);
}
