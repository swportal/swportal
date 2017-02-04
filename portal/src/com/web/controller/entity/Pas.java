package com.web.controller.entity;

public class Pas implements java.io.Serializable{	
	private static final long serialVersionUID = 1L;
	private Long projectid;
	private Long modelNum;
	private String product;
	private String pjtName;
	private String devModelName;
	private String devType;
	private String projType;
	private String pjtRegistrationDate;
	private String updateTime;
	private String milestone;
	private String pjtStatus;
	private String devPL;
	private String sWEM;
	private String dIAPlanDate;
	private String dIAActualDate;
	private String pIAPlanDate;
	private String pIAActualDate;
	private String dVRPlanDate;
	private String dVRActualDate;
	private String pVRPlanDate;
	private String pVRActualDate;
	
	private String pRAPlanDate;
	private String pRAActualDate;
	private String sRAPlanDate;
	private String sRAActualDate;
	private String bPAPlanDate;
	private String bPAActualDate;
	private String bIAPlanDate;
	private String bIAActualDate;
	private String bCAPlanDate;
	private String bCAActualDate;
	
	private String dIA;
	private String pIA;
	private String pVR;
	private String pRA;
	private String sRA;
	
	private Long pLMTotal;
	private Long pLMOpened;
	private Long pLMResolved;
	private Long pLMClosed;
	private Long waiting;
	private Long doing;
	private Long requested;
	private Long reviewed;
	public Long getProjectid() {
		return projectid;
	}
	public void setProjectid(Long projectid) {
		this.projectid = projectid;
	}
	public Long getModelNum() {
		return modelNum;
	}
	public void setModelNum(Long modelNum) {
		this.modelNum = modelNum;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getPjtName() {
		return pjtName;
	}
	public void setPjtName(String pjtName) {
		this.pjtName = pjtName;
	}
	public String getDevModelName() {
		return devModelName;
	}
	public void setDevModelName(String devModelName) {
		this.devModelName = devModelName;
	}
	public String getDevType() {
		return devType;
	}
	public void setDevType(String devType) {
		this.devType = devType;
	}
	public String getProjType() {
		return projType;
	}
	public void setProjType(String projType) {
		this.projType = projType;
	}
	public String getPjtRegistrationDate() {
		return pjtRegistrationDate;
	}
	public void setPjtRegistrationDate(String pjtRegistrationDate) {
		this.pjtRegistrationDate = pjtRegistrationDate;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getMilestone() {
		return milestone;
	}
	public void setMilestone(String milestone) {
		this.milestone = milestone;
	}
	public String getPjtStatus() {
		return pjtStatus;
	}
	public void setPjtStatus(String pjtStatus) {
		this.pjtStatus = pjtStatus;
	}
	public String getDevPL() {
		return devPL;
	}
	public void setDevPL(String devPL) {
		this.devPL = devPL;
	}
	public String getsWEM() {
		return sWEM;
	}
	public void setsWEM(String sWEM) {
		this.sWEM = sWEM;
	}
	public String getdIAPlanDate() {
		return dIAPlanDate;
	}
	public void setdIAPlanDate(String dIAPlanDate) {
		this.dIAPlanDate = dIAPlanDate;
	}
	public String getdIAActualDate() {
		return dIAActualDate;
	}
	public void setdIAActualDate(String dIAActualDate) {
		this.dIAActualDate = dIAActualDate;
	}
	public String getpIAPlanDate() {
		return pIAPlanDate;
	}
	public void setpIAPlanDate(String pIAPlanDate) {
		this.pIAPlanDate = pIAPlanDate;
	}
	public String getpIAActualDate() {
		return pIAActualDate;
	}
	public void setpIAActualDate(String pIAActualDate) {
		this.pIAActualDate = pIAActualDate;
	}
	public String getdVRPlanDate() {
		return dVRPlanDate;
	}
	public void setdVRPlanDate(String dVRPlanDate) {
		this.dVRPlanDate = dVRPlanDate;
	}
	public String getdVRActualDate() {
		return dVRActualDate;
	}
	public void setdVRActualDate(String dVRActualDate) {
		this.dVRActualDate = dVRActualDate;
	}
	public String getpVRPlanDate() {
		return pVRPlanDate;
	}
	public void setpVRPlanDate(String pVRPlanDate) {
		this.pVRPlanDate = pVRPlanDate;
	}
	public String getpVRActualDate() {
		return pVRActualDate;
	}
	public void setpVRActualDate(String pVRActualDate) {
		this.pVRActualDate = pVRActualDate;
	}
	public String getpRAPlanDate() {
		return pRAPlanDate;
	}
	public void setpRAPlanDate(String pRAPlanDate) {
		this.pRAPlanDate = pRAPlanDate;
	}
	public String getpRAActualDate() {
		return pRAActualDate;
	}
	public void setpRAActualDate(String pRAActualDate) {
		this.pRAActualDate = pRAActualDate;
	}
	public String getsRAPlanDate() {
		return sRAPlanDate;
	}
	public void setsRAPlanDate(String sRAPlanDate) {
		this.sRAPlanDate = sRAPlanDate;
	}
	public String getsRAActualDate() {
		return sRAActualDate;
	}
	public void setsRAActualDate(String sRAActualDate) {
		this.sRAActualDate = sRAActualDate;
	}
	public String getbPAPlanDate() {
		return bPAPlanDate;
	}
	public void setbPAPlanDate(String bPAPlanDate) {
		this.bPAPlanDate = bPAPlanDate;
	}
	public String getbPAActualDate() {
		return bPAActualDate;
	}
	public void setbPAActualDate(String bPAActualDate) {
		this.bPAActualDate = bPAActualDate;
	}
	public String getbIAPlanDate() {
		return bIAPlanDate;
	}
	public void setbIAPlanDate(String bIAPlanDate) {
		this.bIAPlanDate = bIAPlanDate;
	}
	public String getbIAActualDate() {
		return bIAActualDate;
	}
	public void setbIAActualDate(String bIAActualDate) {
		this.bIAActualDate = bIAActualDate;
	}
	public String getbCAPlanDate() {
		return bCAPlanDate;
	}
	public void setbCAPlanDate(String bCAPlanDate) {
		this.bCAPlanDate = bCAPlanDate;
	}
	public String getbCAActualDate() {
		return bCAActualDate;
	}
	public void setbCAActualDate(String bCAActualDate) {
		this.bCAActualDate = bCAActualDate;
	}
	public String getdIA() {
		return dIA;
	}
	public void setdIA(String dIA) {
		this.dIA = dIA;
	}
	public String getpIA() {
		return pIA;
	}
	public void setpIA(String pIA) {
		this.pIA = pIA;
	}
	public String getpVR() {
		return pVR;
	}
	public void setpVR(String pVR) {
		this.pVR = pVR;
	}
	public String getpRA() {
		return pRA;
	}
	public void setpRA(String pRA) {
		this.pRA = pRA;
	}
	public String getsRA() {
		return sRA;
	}
	public void setsRA(String sRA) {
		this.sRA = sRA;
	}
	public Long getpLMTotal() {
		return pLMTotal;
	}
	public void setpLMTotal(Long pLMTotal) {
		this.pLMTotal = pLMTotal;
	}
	public Long getpLMOpened() {
		return pLMOpened;
	}
	public void setpLMOpened(Long pLMOpened) {
		this.pLMOpened = pLMOpened;
	}
	public Long getpLMResolved() {
		return pLMResolved;
	}
	public void setpLMResolved(Long pLMResolved) {
		this.pLMResolved = pLMResolved;
	}
	public Long getpLMClosed() {
		return pLMClosed;
	}
	public void setpLMClosed(Long pLMClosed) {
		this.pLMClosed = pLMClosed;
	}
	public Long getWaiting() {
		return waiting;
	}
	public void setWaiting(Long waiting) {
		this.waiting = waiting;
	}
	public Long getDoing() {
		return doing;
	}
	public void setDoing(Long doing) {
		this.doing = doing;
	}
	public Long getRequested() {
		return requested;
	}
	public void setRequested(Long requested) {
		this.requested = requested;
	}
	public Long getReviewed() {
		return reviewed;
	}
	public void setReviewed(Long reviewed) {
		this.reviewed = reviewed;
	}
	
	
	
}
