package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Defect;
import com.web.controller.service.DefectService;

@Service
@Transactional
public class DefectServiceImpl extends BaseDaoImpl<Defect> implements DefectService {

	@Override
	public int findDefectCount(String where) {
		// TODO Auto-generated method stub
		return getSession().createQuery("FROM Defect k "+where+"").list().size();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Defect> findDefectList(Integer curPage, Integer pageSize,String where) {
		Integer start=(curPage-1)*pageSize;
		return getSession().createQuery("FROM Defect k "+where+"")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}
}

