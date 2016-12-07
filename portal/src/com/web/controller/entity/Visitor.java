package com.web.controller.entity;

public class Visitor implements java.io.Serializable {
	private Long id;
	private String ip;
	private String name;
	private String part;
	private String grade;
	private String visitTime;
	private String visitDate;
	private Long visitFreq;
	public Long getVisitFreq() {
		return visitFreq;
	}
	public void setVisitFreq(Long visitFreq) {
		this.visitFreq = visitFreq;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getVisitDate() {
		return visitDate;
	}
	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVisitTime() {
		return visitTime;
	}
	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}
	
}
