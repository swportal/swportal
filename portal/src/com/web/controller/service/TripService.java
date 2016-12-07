package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Trip;

public interface TripService extends BaseDao<Trip>{

	//List<Trip> findTripList(String keyword, String orderItem, String orderKey);

	void updateById(Long id, String item, String value);

	List<Trip> findTripList(Integer curPage,Integer pageSize, String keyword, String orderItem,
			String orderKey);

}
