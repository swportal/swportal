package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Model;


public interface ModelService extends BaseDao<Model>{

	List<Model> findModelList(Integer curPage, Integer pageSize, String where);

	List<Model> findAllWhere(String where);
}
