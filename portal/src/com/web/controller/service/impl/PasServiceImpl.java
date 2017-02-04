package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Pas;
import com.web.controller.service.PasService;

@Service
@Transactional
public class PasServiceImpl extends BaseDaoImpl<Pas> implements PasService {

	@SuppressWarnings("unchecked")
	@Override
	public List<Pas> findPasList(Integer curPage, Integer pageSize,String keyword,String parentSelect,String childSelect,String milestone, String startdate,String enddate,String orderItem, String orderKey) {
		Integer start=(curPage-1)*pageSize;
		String where = "";
		/*
		 * orderItem search
		 */
		if(!keyword.equals("")){
			where=where+"where (p.pjtName like'%"+keyword+"%' or p.devModelName like'%"+keyword+"%' or p.sWEM like'%"+keyword+"%' ) ";
		}
		else{
			where=where+"where p.pjtName like'%%'";
		}
		
		/*
		 * milestone search
		 */
		if(!milestone.equals("")){
			if(milestone.equals("PIA")){
				where+="and p.pIAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("PVR")){
				where+="and p.pVRPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("PRA")){
				where+="and p.pRAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
			else if(milestone.equals("choose")){
				where+="";
			}
		}
		/*
		 * parentSelect, childSelect search
		 */
		if(!parentSelect.equals("null")){
			if(parentSelect.equals("pl")){
				if(!childSelect.equals("null"))
				where+="and p.sWEM like '%"+childSelect+"%'";
				//System.out.println(where);
			}
			else if(parentSelect.equals("ps")){
				if(!childSelect.equals("null"))
				where+="and p.pjtStatus like '%"+childSelect+"%'";
			}
			else if(parentSelect.equals("spt")){
				if(!childSelect.equals("null"))
				where+="and p.projType like '%"+childSelect+"%'";
			}
			else if(parentSelect.equals("ms")){
				if(!childSelect.equals("null"))
				where+="and p.milestone like '%"+childSelect+"%'";
			}
			else if(parentSelect.equals("pg")){
				if(!childSelect.equals("null"))
				where+="and p.product like '%"+childSelect+"%'";
			}
			else if(parentSelect.equals("choose")){
				//where+="aPRAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
		}
		if(orderKey.equals("")&&orderItem.equals("")){
			return getSession().createQuery("FROM Pas p "+where+"  ORDER BY  p.pIAPlanDate DESC, p.pRAPlanDate DESC, p.pLMTotal DESC, p.pLMOpened DESC")
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		else{
			return getSession().createQuery("FROM Pas p "+where+" ORDER BY "+ orderItem + " "+orderKey)
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		
	}

	
}
