package com.web.controller.service.impl;

import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Model;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;
import com.web.controller.service.ModelService;
import com.web.controller.service.PasService;

@Service
@Transactional
public class ModelServiceImpl extends BaseDaoImpl<Model> implements ModelService {

	@Override
	public List<Model> findModelList(Integer curPage, Integer pageSize,
			String where) {
		Integer start=(curPage-1)*pageSize;
		return getSession().createQuery("FROM Model m "+where+"")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}

	@Override
	public List<Model> findAllWhere(String where) {
		return getSession().createQuery("FROM Model m "+where+"")
				.list();
	}

	
}