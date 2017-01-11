package com.web.controller.entity;

public class Block implements java.io.Serializable{
	private Long id;
	private String projectName;
	private String component;
	private Long total;
	private Long cOUNT;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getComponent() {
		return component;
	}
	public void setComponent(String component) {
		this.component = component;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public Long getcOUNT() {
		return cOUNT;
	}
	public void setcOUNT(Long cOUNT) {
		this.cOUNT = cOUNT;
	}
	
	
	
	
	
}
