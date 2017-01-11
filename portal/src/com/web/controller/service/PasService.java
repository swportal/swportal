package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;


public interface PasService extends BaseDao<Pas>{

	List<Pas> findPasList(Integer curPage, Integer pageSize,String keyword,String projectname,String city,String state,String milestone, String startdate,String enddate, String orderKey) ;
}
