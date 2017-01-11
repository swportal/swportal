package com.web.controller.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Pas;
import com.web.controller.entity.Server;
import com.web.controller.service.PasService;

@Service
@Transactional
public class PasServiceImpl extends BaseDaoImpl<Pas> implements PasService {

	@Override
	public List<Pas> findPasList(Integer curPage, Integer pageSize,String keyword,String projectname,String city,String state,String milestone, String startdate,String enddate, String orderKey) {
		Integer start=(curPage-1)*pageSize;
		String where = "";
		/*
		 * keyword search
		 */
		if(!projectname.equals("")){
			where=where+"where (p.pjtName like'%"+projectname+"%' or p.devModelName like'%"+projectname+"%' or p.sWEM like'%"+projectname+"%' ) ";
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
		 * state, city search
		 */
		if(!state.equals("null")){
			if(state.equals("pl")){
				if(!city.equals("null"))
				where+="and p.sWEM like '%"+city+"%'";
				//System.out.println(where);
			}
			else if(state.equals("ps")){
				if(!city.equals("null"))
				where+="and p.pjtStatus like '%"+city+"%'";
			}
			else if(state.equals("spt")){
				if(!city.equals("null"))
				where+="and p.projType like '%"+city+"%'";
			}
			else if(state.equals("ms")){
				if(!city.equals("null"))
				where+="and p.milestone like '%"+city+"%'";
			}
			else if(state.equals("pg")){
				if(!city.equals("null"))
				where+="and p.product like '%"+city+"%'";
			}
			else if(state.equals("choose")){
				//where+="aPRAPlanDate between '"+startdate+"' and '"+enddate+"'";
			}
		}
		if(orderKey.equals("")&&keyword.equals("")){
			return getSession().createQuery("FROM Pas p "+where+"  ORDER BY  p.pIAPlanDate DESC, p.pRAPlanDate DESC, p.pLMTotal DESC, p.pLMOpened DESC")
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		else{
			return getSession().createQuery("FROM Pas p "+where+" ORDER BY "+ keyword + " "+orderKey)
					.setFirstResult(start)
					.setMaxResults(pageSize)
					.list();
		}
		
	}

	
}
