package com.web.controller.service.impl;

import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Service;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Privilege;
import com.web.controller.service.PrivilegeService;
@Service
public class PrivilegeServiceImpl extends BaseDaoImpl<Privilege> implements PrivilegeService {

	public List<Privilege> findTopList() {
		return getSession().createQuery(//
				"FROM Privilege p WHERE p.parent IS NULL")//
				.list();
	}

	public Collection<String> getAllPrivilegeUrls() {
		return getSession().createQuery(//
				"SELECT DISTINCT p.url FROM Privilege p WHERE p.url IS NOT NULL")//
				.list();
	}



}
