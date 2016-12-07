package com.web.controller.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Case;
import com.web.controller.entity.Education;
import com.web.controller.entity.Trip;
import com.web.controller.entity.Visitor;
import com.web.controller.service.VisitorService;
@Service
@Transactional
public class VisitorServiceImpl extends BaseDaoImpl<Visitor> implements VisitorService {

	@Override
	public List<Trip> findVisitorList(Integer curpage, Integer pageSize,String keyword, String orderItem, String orderKey){
		Integer start=(curpage-1)*pageSize;
	
		if("".equals(orderItem)){			
			return getSession().createQuery("FROM Visitor v WHERE (v.ip LIKE '%" +keyword+ "%' OR v.part LIKE '%" +keyword+ "%' OR v.grade LIKE '%" +keyword+ "%') AND v.visitTime !=''")
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		else {
			return getSession().createQuery("FROM Visitor v WHERE (v.ip LIKE '%" +keyword+ "%' OR v.part LIKE '%" +keyword+ "%'  OR v.grade LIKE '%" +keyword+ "%') AND v.visitTime !='' ORDER BY "+orderItem+" "+orderKey)
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
	}

	@Override
	public Long getSW1Count(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.part like '%System S/W R&D 1Part%' AND v.visitDate like '%"+curdate+"%'").list();
		Long sw1Count = Long.valueOf(list.size());
		return sw1Count;
	}

	@Override
	public Long getSW2Count(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.part like '%System S/W R&D 2Part%' AND v.visitDate like '%"+curdate+"%'").list();
		Long sw2Count = Long.valueOf(list.size());
		return sw2Count;
	}

	@Override
	public Long getSWCount(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.part like '%SW Group%' AND v.visitDate like '%"+curdate+"%'").list();
		Long swCount = Long.valueOf(list.size());
		return swCount;
	}

	@Override
	public Long getSECount(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.part like '%SE%' AND v.visitDate like '%"+curdate+"%'").list();
		Long seCount = Long.valueOf(list.size());
		return seCount;
	}

	@Override
	public Long getMONCount(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.part like '%Mon%' AND v.visitDate like '%"+curdate+"%'").list();
		Long monCount = Long.valueOf(list.size());
		return monCount;
	}

	@Override
	public Long getSQACount(String curdate) {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.visitDate like '%"+curdate+"%' and (v.part not like '%Mon%' and v.part not like '%SE%' and v.part not like '%SW Group%' and v.part not like '%System S/W R&D 2Part%' and v.part not like '%System S/W R&D 1Part%')").list();
		Long sqaCount = Long.valueOf(list.size());
		return sqaCount;
	}

	@Deprecated
	public List<Visitor> findVisitorList(String keyword,String orderItem,String orderKey) {
		if("".equals(orderItem)){	
			return getSession().createQuery("FROM Visitor v WHERE (v.ip LIKE '%" +keyword+ "%' OR v.part LIKE '%" +keyword+ "%' OR v.grade LIKE '%" +keyword+ "%') AND v.visitTime !=''").list();
		}
		else{
			return getSession().createQuery("FROM Visitor v WHERE (v.ip LIKE '%" +keyword+ "%' OR v.part LIKE '%" +keyword+ "%'  OR v.grade LIKE '%" +keyword+ "%') AND v.visitTime !='' ORDER BY "+orderItem+" "+orderKey).list();
		}
	}

	@Override
	public void updateByIP(String ip,String time,String date,Long visitcount) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		getSession().createQuery("Update Visitor v SET v.visitTime = ?, v.visitDate=? , v.visitFreq=? WHERE v.ip=? and  v.visitDate like'%"+df.format(new Date())+"%'")//
		.setParameter(0, time)
		.setParameter(1, date)
		.setParameter(2, visitcount)
		.setParameter(3, ip).executeUpdate();
		getSession().flush();
		
	}

	@Override
	public Long todayVisitor() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.visitDate like'%"+df.format(new Date())+"%'").list();
		Long count = Long.valueOf(list.size());
		return count;
	}

	@Override
	public Long totalVisitor() {
		List<Visitor> list = getSession().createQuery("FROM Visitor v WHERE  v.visitTime !=''").list();
		Long total = Long.valueOf(list.size());
		return total;
	}

	@Override
	public Visitor getByIp(String remoteHost) {
		return (Visitor) getSession().createQuery("FROM Visitor v WHERE  v.ip like '%"+remoteHost+"%' ORDER BY v.visitDate DESC").setMaxResults(1).uniqueResult();
	}
	
}
