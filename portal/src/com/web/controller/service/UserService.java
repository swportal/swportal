package com.web.controller.service;

import java.util.List;

import com.web.controller.Base.BaseDao;
import com.web.controller.entity.User;
public interface UserService extends BaseDao<User>{
	User findByLoginNameAndPassword(String loginName, String password);	
	@Deprecated
	String findPwdById(Long id);
	List<User> findUserList(Integer curpage,Integer pageSize);
}
