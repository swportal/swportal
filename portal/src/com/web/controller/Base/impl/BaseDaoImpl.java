package com.web.controller.Base.impl;

import java.lang.reflect.ParameterizedType;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.Base.BaseDao;


@SuppressWarnings("unchecked")
@Transactional
public class BaseDaoImpl<T> implements BaseDao<T> {

	@Resource
	private SessionFactory sessionFactory;
	private Class<T> clazz = null;

	public BaseDaoImpl() {
		// 使用反射技术得到T的真实类型
		ParameterizedType pt = (ParameterizedType) this.getClass()
				.getGenericSuperclass();// 获取当前new的对象的泛型的父类类型
		this.clazz = (Class<T>) pt.getActualTypeArguments()[0];
		//System.out.println("clazz===>" + clazz.getName());
		//System.out.println("clazz===>" + clazz.getSimpleName());
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	@Transactional
	public void save(T entity) {
		getSession().save(entity);
		getSession().flush();
	}
	@Transactional
	public void merge(T entity) {
		getSession().merge(entity);
		getSession().flush();
	}
	@Transactional
	public void update(T entity) {
		getSession().clear(); //2016-12-26 wuliying add to make sure role privilege maintain
		getSession().update(entity);
		getSession().flush();		
		/*String hql = "UPDATE User u SET u.userName=? ,u.age=? WHERE u.id=?";
		Query query =  sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, String.valueOf(user.getUserName()));
		query.setString(1, String.valueOf(user.getAge()));
		query.setString(2, String.valueOf(user.getId()));		
		query.executeUpdate();*/
	}
	
	@Transactional
	public void delete(Long id) {
		Object obj = getById(id);
		if (obj != null) {
			getSession().delete(obj);
			getSession().flush();
		}
		/*String hql = "DELETE "+  clazz.getSimpleName()+" e WHERE e.id=?";
		Query query =  getSession().createQuery(hql);
		query.setString(0, String.valueOf(id));		
		query.executeUpdate();*/
	}

	public List<T> findAll() {
		return getSession().createQuery(//
				"FROM " + clazz.getSimpleName()).//
				list();
	}

	public T getById(Long id) {
		if (id == null)
			return null;
		else
			return (T) getSession().get(clazz, id);
	}

	public List<T> getByIds(Long[] ids) {
		if (ids == null || ids.length == 0) {
			return Collections.EMPTY_LIST;
		} else {
			return getSession().createQuery(//
					"FROM " + clazz.getSimpleName() + " WHERE id IN (:ids)")//
					.setParameterList("ids", ids).list();
		}
	}

	
}
