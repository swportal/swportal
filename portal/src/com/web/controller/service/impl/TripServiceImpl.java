package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Trip;
import com.web.controller.service.TripService;
@Service
@Transactional
public class TripServiceImpl extends BaseDaoImpl<Trip> implements TripService {
	/*
	@Override
	
	public List<Trip> findTripList(String keyword,String orderItem, String orderKey) {		
		if("".equals(orderItem)){			
			return getSession().createQuery("FROM Trip t WHERE t.name LIKE '%" +keyword+ "%' OR t.part LIKE '%" +keyword+ "%' OR t.destination LIKE '%" +keyword+ "%' ")
					.list();
		}
		else {
			return getSession().createQuery("FROM Trip t WHERE t.name LIKE '%" +keyword+ "%' OR t.part LIKE '%" +keyword+ "%' OR t.destination LIKE '%" +keyword+ "%' OR t.region LIKE '%" +keyword+ "%' ORDER BY "+orderItem+" "+orderKey)
					.list();
		}
	}
	*/
	@SuppressWarnings("unchecked")
	@Override
	public List<Trip> findTripList(Integer curPage,Integer pageSize, String keyword, String orderItem,String orderKey){
			Integer start=(curPage-1)*pageSize;
	
			if("".equals(orderItem)){			
				return getSession().createQuery("FROM Trip t WHERE t.name LIKE '%" +keyword+ "%' OR t.part LIKE '%" +keyword+ "%' OR t.destination LIKE '%" +keyword+ "%' OR t.region LIKE '%" +keyword+ "%'")
						.setFirstResult(start)
						.setMaxResults(pageSize)
						.list();
			}
			else {
				return getSession().createQuery("FROM Trip t WHERE t.name LIKE '%" +keyword+ "%' OR t.part LIKE '%" +keyword+ "%' OR t.destination LIKE '%" +keyword+ "%' OR t.region LIKE '%" +keyword+ "%' ORDER BY "+orderItem+" "+orderKey)
						.setFirstResult(start)
						.setMaxResults(pageSize)
						.list();
			}
	}

	@Transactional
	public void updateById(Long id, String item, String value) {
		getSession().createQuery("Update Trip t SET t."+item+" = ? WHERE t.id=?")//
		.setParameter(0, value)
		.setParameter(1, id).executeUpdate();
		getSession().flush();
		this.getSession().clear(); //2016-11-26 wuliying add to clear session
	}


}
