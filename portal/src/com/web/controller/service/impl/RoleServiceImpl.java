package com.web.controller.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.dao.RoleDao;
import com.web.controller.dao.UserDao;
import com.web.controller.entity.Page;
import com.web.controller.entity.Role;
import com.web.controller.entity.User;
import com.web.controller.service.RoleService;
import com.web.controller.service.UserService;

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
