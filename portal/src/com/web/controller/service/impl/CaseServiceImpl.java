package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Case;
import com.web.controller.service.CaseService;
@Service
@Transactional
public class CaseServiceImpl extends BaseDaoImpl<Case>  implements CaseService{

	@SuppressWarnings("unchecked")
	@Override
	public List<Case> findCaseList(Integer curPage,Integer pageSize,String keyword, String orderItem, String orderKey) {
		Integer start=(curPage-1)*pageSize;
		if("".equals(orderItem)){			
			return getSession().createQuery("FROM Case c WHERE c.prodType LIKE '%" +keyword+ "%' OR c.chipset LIKE '%" +keyword+ "%' OR c.model LIKE '%" +keyword+ "%'   OR c.description LIKE '%" +keyword+ "%'  OR c.occurTime LIKE '%" +keyword+ "%'  OR c.occurSite LIKE '%" +keyword+ "%' ORDER BY c.confirmy ASC, c.id DESC")
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		else {
			return getSession().createQuery("FROM Case c WHERE c.prodType LIKE '%" +keyword+ "%' OR c.chipset LIKE '%" +keyword+ "%' OR c.model LIKE '%" +keyword+ "%'   OR c.description LIKE '%" +keyword+ "%'  OR c.occurTime LIKE '%" +keyword+ "%'  OR c.occurSite LIKE '%" +keyword+ "%'  OR c.occurPhase LIKE '%" +keyword+ "%' ORDER BY "+orderItem+" "+orderKey)
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
	}

	@Override
	public void updateById(Long id, String item, String value) {
		getSession().createQuery("Update Case c SET c."+item+" = ? WHERE c.id=?")//
		.setParameter(0, value)
		.setParameter(1, id).executeUpdate();
		getSession().flush();
		this.getSession().clear(); //2016-11-26 wuliying add to clear session
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Case> findDistinctModel() {
		return getSession().createQuery("FROM Case c GROUP BY c.model").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Case> findDistinctType() {
		return getSession().createQuery("FROM Case c GROUP BY c.prodType").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Case> findDistinctChip() {
		return getSession().createQuery("FROM Case c GROUP BY c.chipset").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Case> findModelList(String keyword,String item) {
		if("".equals(keyword))
			return getSession().createQuery("FROM Case").list();
		else
			return getSession().createQuery("FROM Case c WHERE  c."+item+" ='" +keyword+"'").list();
	
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getDTVCount() {
		
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.prodType like '%DTV%'").list();
		Long dtvTotal = Long.valueOf(list.size());
		return dtvTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getMFMCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.prodType like '%MFM%'").list();
		Long mfmTotal = Long.valueOf(list.size());
		return mfmTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getHotelCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.prodType like '%HTV%'").list();
		Long hotelTotal = Long.valueOf(list.size());
		return hotelTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getMonitorCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.prodType like '%Monitor%'").list();
		Long monitorTotal = Long.valueOf(list.size());
		return monitorTotal;
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public Long getAPPCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.prodType like '%APP%'").list();
		Long appTotal = Long.valueOf(list.size());
		return appTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getNonCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.chipset like '%XL%'").list();
		Long nonTotal = Long.valueOf(list.size());
		return nonTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getOrsayCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.chipset like '%NT%' OR c.chipset like '%X1%' OR c.chipset like '%x1%'").list();
		Long orsayTotal = Long.valueOf(list.size());
		return orsayTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getTizenCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.chipset like '%JAZZ%' OR c.chipset like '%jazz%' OR c.chipset like '%Hawk%' OR c.chipset like '%HAWK%'  OR c.chipset like '%hawk%' OR c.chipset like '%Hawk%'  OR c.chipset like '%GOLF%'  OR c.chipset like '%Golf%'  OR c.chipset like '%golf%'").list();
		Long tizenTotal = Long.valueOf(list.size());
		return tizenTotal;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Long getMarketCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.occurPhase like '%市场%'").list();
		Long marketTotal = Long.valueOf(list.size());
		return marketTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getMPCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.occurPhase like '%MP%'").list();
		Long mpTotal = Long.valueOf(list.size());
		return mpTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getTechCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.improvedType like '%Tech%'").list();
		Long techTotal = Long.valueOf(list.size());
		return techTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getTestCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.improvedType like '%Test%'").list();
		Long testTotal = Long.valueOf(list.size());
		return testTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getProcCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.improvedType like '%Process%'").list();
		Long procTotal = Long.valueOf(list.size());
		return procTotal;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getToolCount() {
		List<Case> list = getSession().createQuery("FROM Case c WHERE  c.improvedType like '%Tool%'").list();
		Long toolTotal = Long.valueOf(list.size());
		return toolTotal;
	}
	

}
