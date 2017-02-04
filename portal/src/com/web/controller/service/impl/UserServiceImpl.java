package com.web.controller.service.impl;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.impl.BaseDaoImpl;
import com.web.controller.entity.User;
import com.web.controller.service.UserService;

@Service
@Transactional
public class UserServiceImpl extends BaseDaoImpl<User> implements UserService{

	public User findByLoginNameAndPassword(String loginName, String password) {
		String md5Digest = DigestUtils.md5Hex(password);
		return (User)getSession().createQuery(//
				"FROM User u WHERE u.loginName=? and u.password=?")//
				.setParameter(0, loginName)//
				.setParameter(1, md5Digest)
				.uniqueResult();
	}

	@Deprecated
	public String findPwdById(Long id) {
		// TODO Auto-generated method stub
		User user= (User) getSession().createQuery(//
				"FROM User u WHERE u.id=?")//
				.setParameter(0, id)//
				.uniqueResult();
		return user.getPassword();
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findUserList(Integer curpage,Integer pageSize) {
		// TODO Auto-generated method stub
		Integer start=(curpage-1)*pageSize;
		return getSession().createQuery("FROM User u")
				.setFirstResult(start)
				.setMaxResults(pageSize)
				.list();
	}
	
}
