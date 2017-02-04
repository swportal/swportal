package com.web.controller.service.impl;

import java.util.List;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Model;
import com.web.controller.service.ModelService;

@Service
@Transactional
public class ModelServiceImpl extends BaseDaoImpl<Model> implements ModelService {

	@SuppressWarnings("unchecked")
	@Override
	public List<Model> findModelList(Integer curPage, Integer pageSize,
			String where) {
		Integer start=(curPage-1)*pageSize;
		return getSession().createQuery("FROM Model m "+where+"")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Model> findAllWhere(String where) {
		return getSession().createQuery("FROM Model m "+where+"")
				.list();
	}

	
}
