package com.web.controller.service.impl;

import org.springframework.stereotype.Service;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.Role;
import com.web.controller.service.RoleService;

@Service
public class RoleServiceImpl extends BaseDaoImpl<Role> implements RoleService{	
	
	
	/*@Resource
	private RoleDao roleDao;
	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public void update(Role role) {		
		roleDao.update(role);
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public Role getById(Long id) {
		return roleDao.getById(id);
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public List<Role> findAll() {
		return roleDao.findAll();
	}

	public void delete(Long id) {
		roleDao.delete(id);
	}

	public void save(Role role) {
		roleDao.save(role);
	}

	public List<Role> getByIds(Long[] ids) {
		return roleDao.getByIds(ids);
	}*/
	
}
