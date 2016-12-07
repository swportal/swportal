package com.web.controller.Base;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

public interface BaseDao<T> {
	public void save(T entity);
	public void delete(Long id);
	public void update(T entity);
	public T getById(Long id);
	public List<T> getByIds(Long[] ids);
	public List<T> findAll();

}
