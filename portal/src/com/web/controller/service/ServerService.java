package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Server;


public interface ServerService extends BaseDao<Server>{
	@Deprecated
	List<Server> findServerList(String keyword);

	List<Server> findServerList(Integer curPage, Integer pageSize,
			String keyword);
}
