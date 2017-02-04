package com.web.controller.service;

import java.util.Map;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Block;


public interface BlockService extends BaseDao<Block>{
	Map<String, Integer> getBlockList(String projectname,String modelname);

}
