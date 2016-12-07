package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Case;

public interface CaseService  extends BaseDao<Case>{

	List<Case> findCaseList(Integer curPage,Integer pageSize,String keyword, String orderItem, String orderKey);
	void updateById(Long id,String item,String value);
	List<Case> findDistinctModel();	
	List<Case> findDistinctType();
	List<Case> findDistinctChip();
	List<Case> findModelList(String keyword,String item);
	Long getDTVCount();
	Long getMFMCount();
	Long getHotelCount();
	Long getMonitorCount();
	Long getAPPCount();
	Long getNonCount();
	Long getOrsayCount();
	Long getTizenCount();
	Long getMarketCount();
	Long getMPCount();
	Long getTechCount();
	Long getTestCount();
	Long getProcCount();
	Long getToolCount();
}
