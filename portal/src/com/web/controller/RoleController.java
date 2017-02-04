package com.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.controller.entity.Privilege;
import com.web.controller.entity.Role;
import com.web.controller.service.PrivilegeService;
import com.web.controller.service.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
	//private Log log = LogFactory.getLog(this.getClass());
	@Resource
	private RoleService roleService;
	@Resource
	private PrivilegeService privilegeService;
	
	@RequestMapping("/addRole")
	public String addRole(Role role){
		roleService.save(role);
		return "redirect:/role/getAllRole";
	}
	
	@RequestMapping("/getRole")
	public String getRole(Long id,HttpServletRequest request){
		Role role = roleService.getById(id);
		request.setAttribute("role", role);
		return "/roleController/saveRole";
	}
	@RequestMapping("/updateRole")
	public String updateRole(Role role,HttpServletRequest request, HttpServletResponse response){
			/*
			 * 2016-12-26 wuliying add to avoid privilege null.
			 */
		    Role r = roleService.getById(role.getId());
		    List<Privilege> privilegeList = null;
			if(r.getPrivileges()!=null){
				Long[] privilegeIds  = new Long[r.getPrivileges().size()];
				int index = 0;
				for(Privilege priv:r.getPrivileges()){
					privilegeIds[index++]=priv.getId();
				}
				privilegeList = privilegeService.getByIds(privilegeIds);
				
			}
			role.setPrivileges(new HashSet<Privilege>(privilegeList));
			roleService.update(role);
			return "redirect:/role/getAllRole";
		//}
		//else{
			//return "/roleController/error";
		//}	
	}
	@RequestMapping("/toAddRole")
	public String toAddRole(){
		return "/roleController/saveRole";
	}
	
	@RequestMapping("/delRole")
	public void delRole(Long id,HttpServletResponse response){
		String result = "{\"result\":\"success\"}";
		roleService.delete(id);
		PrintWriter out = null;
	    response.setContentType("application/json");
	    try {
	    	out=response.getWriter();
	        out.write(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	@RequestMapping("/getAllRole")
	public String getAllRole(HttpServletRequest request){
		List<Role> roles = roleService.findAll();
		request.setAttribute("roles", roles);		
		//log.fatal("this is fatal info");
		return "/roleController/roleManager";
	}	
	@RequestMapping("/setPrivilegeUI")
	public String setPrivilegeUI(Long id, Long[] privilegeIds,HttpServletRequest request){
		Role role = roleService.getById(id);
		request.setAttribute("role", role);
		
		if(role.getPrivileges()!=null){
			privilegeIds = new Long[role.getPrivileges().size()];
			int index = 0;
			for(Privilege priv:role.getPrivileges()){
				privilegeIds[index++]=priv.getId();
			}
			
		}
		request.setAttribute("privilegeIds", privilegeIds);
		
		//准备数据privilegeList
		List<Privilege> privilegeList = privilegeService.findAll();
		request.setAttribute("privilegeList",privilegeList);
		return "/roleController/setPrivilegeUI";
	}
	@RequestMapping("/setPrivilege")
	public String setPrivilege(Long id, Long[] privilegeIds, HttpServletRequest request){
		Role role = roleService.getById(id);
		List<Privilege> privilegeList = privilegeService.getByIds(privilegeIds);
		role.setPrivileges(new HashSet<Privilege>(privilegeList));
		roleService.update(role);		
		return "redirect:/role/getAllRole";
	}
}
