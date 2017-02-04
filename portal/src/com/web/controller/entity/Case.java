package com.web.controller.entity;

public class Case implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private Long id;
	private String prodType;
	private String chipset;
	private String model;
	//Defect Info.
	private String description;
	private String occurTime;
	private String occurSite;
	private String occurPhase;
	private String occurType; //add 2016/11/04 by wuliying
	private String version;
	//Reason Info.
	private String rootReason;
	private String unknownReason;
	//Countermeasure
	private String measureDev;
	private String measureTest;
	private String measureType;//add 2016/11/04 by wuliying
	//Mgmt. Method
	private String personINCharge;
	private String propagation;
	private String gmapRegister;
	private String improvedType;
	private String checklistUpdate;
	private String tcUpdate;//add 2016/11/04 by wuliying
	private String plmRegister;
	private String report;
	private String filename;
	private String ip;
	private String uploadTime;
	private String confirmy;
	public String getOccurType() {
		return occurType;
	}
	public void setOccurType(String occurType) {
		this.occurType = occurType;
	}
	public String getTcUpdate() {
		return tcUpdate;
	}
	public void setTcUpdate(String tcUpdate) {
		this.tcUpdate = tcUpdate;
	}
	
	public String getMeasureType() {
		return measureType;
	}
	public void setMeasureType(String measureType) {
		this.measureType = measureType;
	}
	
	public String getConfirmy() {
		return confirmy;
	}
	public void setConfirmy(String confirmy) {
		this.confirmy = confirmy;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getPersonINCharge() {
		return personINCharge;
	}
	public void setPersonINCharge(String personINCharge) {
		this.personINCharge = personINCharge;
	}
	public String getPropagation() {
		return propagation;
	}
	public void setPropagation(String propagation) {
		this.propagation = propagation;
	}
	
	
	public String getGmapRegister() {
		return gmapRegister;
	}
	public void setGmapRegister(String gmapRegister) {
		this.gmapRegister = gmapRegister;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getChipset() {
		return chipset;
	}
	public void setChipset(String chipset) {
		this.chipset = chipset;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getOccurTime() {
		return occurTime;
	}
	public void setOccurTime(String occurTime) {
		this.occurTime = occurTime;
	}
	public String getOccurSite() {
		return occurSite;
	}
	public void setOccurSite(String occurSite) {
		this.occurSite = occurSite;
	}
	public String getOccurPhase() {
		return occurPhase;
	}
	public void setOccurPhase(String occurPhase) {
		this.occurPhase = occurPhase;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getRootReason() {
		return rootReason;
	}
	public void setRootReason(String rootReason) {
		this.rootReason = rootReason;
	}
	public String getUnknownReason() {
		return unknownReason;
	}
	public void setUnknownReason(String unknownReason) {
		this.unknownReason = unknownReason;
	}
	public String getMeasureDev() {
		return measureDev;
	}
	public void setMeasureDev(String measureDev) {
		this.measureDev = measureDev;
	}
	public String getMeasureTest() {
		return measureTest;
	}
	public void setMeasureTest(String measureTest) {
		this.measureTest = measureTest;
	}
	public String getImprovedType() {
		return improvedType;
	}
	public void setImprovedType(String improvedType) {
		this.improvedType = improvedType;
	}
	public String getChecklistUpdate() {
		return checklistUpdate;
	}
	public void setChecklistUpdate(String checklistUpdate) {
		this.checklistUpdate = checklistUpdate;
	}
	public String getPlmRegister() {
		return plmRegister;
	}
	public void setPlmRegister(String plmRegister) {
		this.plmRegister = plmRegister;
	}
	
	
}
