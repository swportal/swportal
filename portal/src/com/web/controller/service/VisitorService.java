package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Trip;
import com.web.controller.entity.Visitor;

public interface VisitorService  extends BaseDao<Visitor>{
	@Deprecated
	List<Visitor> findVisitorList(String keyword,String orderItem,String orderKey);

	void updateByIP(String ip,String time,String date,Long visitcount);

	Long todayVisitor();

	Long totalVisitor();

	Long getSW1Count(String curdate);

	Long getSW2Count(String curdate);

	Long getSWCount(String curdate);

	Long getSECount(String curdate);

	Long getMONCount(String curdate);

	Long getSQACount(String curdate);

	Visitor getByIp(String remoteHost);

	List<Trip> findVisitorList(Integer curpage, Integer pageSize,String keyword, String orderItem, String orderKey);

}
