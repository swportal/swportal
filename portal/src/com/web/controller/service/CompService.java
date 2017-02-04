package com.web.controller.service;

import java.util.Map;
import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Comp;


public interface CompService extends BaseDao<Comp>{
	Map<String, Integer> getCompList(String projectname,String modelname);
}
