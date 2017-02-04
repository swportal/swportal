package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Server;
import com.web.controller.service.ServerService;

@Service
public class ServerServiceImpl  extends BaseDaoImpl<Server> implements ServerService{

	@SuppressWarnings("unchecked")
	@Override
	@Deprecated
	public List<Server> findServerList(String keyword) {
		// TODO Auto-generated method stub
		return getSession().createQuery("FROM Server s WHERE s.ip LIKE '%" +keyword+ "%' OR s.name LIKE '%" +keyword+ "%'  OR s.useFor LIKE '%" +keyword+ "%' OR s.manager LIKE '%" +keyword+ "%' ")
				.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Server> findServerList(Integer curPage, Integer pageSize,String keyword) {
		Integer start=(curPage-1)*pageSize;
		return getSession().createQuery("FROM Server s WHERE s.ip LIKE '%" +keyword+ "%' OR s.name LIKE '%" +keyword+ "%'  OR s.useFor LIKE '%" +keyword+ "%' OR s.manager LIKE '%" +keyword+ "%' ")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}	
	
	

}
