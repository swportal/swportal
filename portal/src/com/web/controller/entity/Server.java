package com.web.controller.entity;

public class Server implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private Long id;
	private String ip;
	private String name;
	private String useFor;
	private Long cpuCount;
	private Long cpuNumber;
	private Long memCount;
	private String memSize;
	private Long hddCount;
	private String hddType;
	private String hddSize;
	private String osVersion;
	private String manager;
	
	public String getMemSize() {
		return memSize;
	}
	public void setMemSize(String memSize) {
		this.memSize = memSize;
	}
	public String getHddSize() {
		return hddSize;
	}
	public void setHddSize(String hddSize) {
		this.hddSize = hddSize;
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
	public String getUseFor() {
		return useFor;
	}
	public void setUseFor(String useFor) {
		this.useFor = useFor;
	}
	public Long getCpuCount() {
		return cpuCount;
	}
	public void setCpuCount(Long cpuCount) {
		this.cpuCount = cpuCount;
	}
	public Long getCpuNumber() {
		return cpuNumber;
	}
	public void setCpuNumber(Long cpuNumber) {
		this.cpuNumber = cpuNumber;
	}
	public Long getMemCount() {
		return memCount;
	}
	public void setMemCount(Long memCount) {
		this.memCount = memCount;
	}
	
	public Long getHddCount() {
		return hddCount;
	}
	public void setHddCount(Long hddCount) {
		this.hddCount = hddCount;
	}
	public String getHddType() {
		return hddType;
	}
	public void setHddType(String hddType) {
		this.hddType = hddType;
	}
	
	public String getOsVersion() {
		return osVersion;
	}
	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}

	
}
