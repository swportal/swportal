package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Education;
import com.web.controller.service.EduService;

@Service
@Transactional
public class EduServiceImpl extends BaseDaoImpl<Education> implements EduService{
	
	

	@SuppressWarnings("unchecked")
	@Override
	public Long getToolCount() {
		List<Education> list = getSession().createQuery("FROM Education e WHERE  e.cateclass like '%Tool%'").list();
		Long toolTotal = Long.valueOf(list.size());
		return toolTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getTechCount() {
		List<Education> list = getSession().createQuery("FROM Education e WHERE  e.cateclass like '%Tech.%'").list();
		Long techTotal = Long.valueOf(list.size());
		return techTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getProcCount() {
		List<Education> list = getSession().createQuery("FROM Education e WHERE  e.cateclass like '%Proc.%'").list();
		Long procTotal = Long.valueOf(list.size());
		return procTotal;
	}
	
	@Override
	public void updateByIds(String item, String value) {
		getSession().createQuery("Update Education e SET e."+item+" = ?")//
		.setParameter(0, value)
		.executeUpdate();
		getSession().flush();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getExtCount() {
		List<Education> list = getSession().createQuery("FROM Education e WHERE  e.category like '%External%'").list();
		Long extTotal = Long.valueOf(list.size());
		return extTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getIntCount() {
		List<Education> list = getSession().createQuery("FROM Education e WHERE  e.category like '%Internal%'").list();
		Long intTotal = Long.valueOf(list.size());
		return intTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Education> findEduList(Integer curPage,Integer pageSize,String keyword, String orderItem,String orderKey) {
		
		Integer start=(curPage-1)*pageSize;
		if("".equals(orderItem)){			
			return getSession().createQuery("FROM Education e WHERE e.contents LIKE '%" +keyword+ "%' OR e.trainerName LIKE '%" +keyword+ "%'   OR e.department LIKE '%" +keyword+ "%'  OR e.traineeObject LIKE '%" +keyword+ "%'")
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		else {
			return getSession().createQuery("FROM Education e WHERE e.contents LIKE '%" +keyword+ "%' OR e.trainerName LIKE '%" +keyword+ "%'   OR e.department LIKE '%" +keyword+ "%'  OR e.traineeObject LIKE '%" +keyword+ "%' ORDER BY "+orderItem+" "+orderKey)
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Education> findTraineeTopList() {
		List<Education> traineeList = getSession().createQuery("FROM Education e ORDER BY e.trainerEvaluation DESC").list();
		return traineeList;
	}
	
	@Transactional
	public void updateById(Long id, String item, String value) {
		//System.out.println(id+item+value);
		getSession().createQuery("Update Education e SET e."+item+" = ? WHERE e.id=?")//
		.setParameter(0, value)
		.setParameter(1, id).executeUpdate();
		getSession().flush();
		this.getSession().clear(); //2016-11-26 wuliying add to clear session 

	}
	
}
