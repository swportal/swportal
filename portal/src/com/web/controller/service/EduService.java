package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Education;


public interface EduService extends BaseDao<Education>{

	void updateById(Long id,String item,String value);

	List<Education> findEduList(Integer curPage,Integer pageSize,String keyword,String orderItem,String orderKey);

	Long getToolCount();

	Long getTechCount();

	Long getProcCount();

	List<Education> findTraineeTopList();

	Long getExtCount();

	Long getIntCount();

	void updateByIds(String item, String value);

}
