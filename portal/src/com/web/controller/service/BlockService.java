package com.web.controller.service;

import java.util.List;
import java.util.Map;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Block;
import com.web.controller.entity.Comp;
import com.web.controller.entity.Defect;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;


public interface BlockService extends BaseDao<Block>{
	Map<String, Integer> getBlockList(String projectname,String modelname);

}
