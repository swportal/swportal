package com.web.controller.service;

import java.util.Collection;
import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Privilege;

public interface PrivilegeService extends BaseDao<Privilege>{

	List<Privilege> findTopList();

	Collection<String> getAllPrivilegeUrls();


}
