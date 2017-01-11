package com.web.controller.service;

import java.util.List;

import net.sf.json.JSONArray;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Model;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;


public interface ModelService extends BaseDao<Model>{

	List<Model> findModelList(Integer curPage, Integer pageSize, String where);

	List<Model> findAllWhere(String where);
}
