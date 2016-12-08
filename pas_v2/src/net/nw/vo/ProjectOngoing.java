package net.nw.vo;

import java.util.Date;

public class ProjectOngoing {
	private String PjtName;
	public String getPjtName() {
		return PjtName;
	}
	public void setPjtName(String pjtName) {
		PjtName = pjtName;
	}
	public String getDevModelCode() {
		return DevModelCode;
	}
	public void setDevModelCode(String devModelCode) {
		DevModelCode = devModelCode;
	}
	public String getDevPL() {
		return DevPL;
	}
	public void setDevPL(String devPL) {
		DevPL = devPL;
	}
	/**
	 * 
	 */
	private String DevModelCode;
	private String DevPL;
	private String SWEM;
	public String getSWEM() {
		return SWEM;
	}
	public void setSWEM(String sWEM) {
		SWEM = sWEM;
	}
	private String PVRPlanDate;
	private String PVRActualDate;
	private String PRAPlanDate;
	private String PRAActualDate;
	private String UpdateTime;
	private String PjtStatus;
	public String getPjtStatus() {
		return PjtStatus;
	}
	public void setPjtStatus(String pjtStatus) {
		PjtStatus = pjtStatus;
	}
	public String getUpdateTime() {
		return UpdateTime;
	}
	public void setUpdateTime(String updateTime) {
		UpdateTime = updateTime;
	}
	private int PLMTotal;
	private int PLMOpened;
	
	public String getPVRPlanDate() {
		return PVRPlanDate;
	}
	public void setPVRPlanDate(String pVRPlanDate) {
		PVRPlanDate = pVRPlanDate;
	}
	public String getPVRActualDate() {
		return PVRActualDate;
	}
	public void setPVRActualDate(String pVRActualDate) {
		PVRActualDate = pVRActualDate;
	}
	public String getPRAPlanDate() {
		return PRAPlanDate;
	}
	public void setPRAPlanDate(String pRAPlanDate) {
		PRAPlanDate = pRAPlanDate;
	}
	public String getPRAActualDate() {
		return PRAActualDate;
	}
	public void setPRAActualDate(String pRAActualDate) {
		PRAActualDate = pRAActualDate;
	}
	public int getPLMTotal() {
		return PLMTotal;
	}
	public void setPLMTotal(int pLMTotal) {
		PLMTotal = pLMTotal;
	}
	public int getPLMOpened() {
		return PLMOpened;
	}
	public void setPLMOpened(int pLMOpened) {
		PLMOpened = pLMOpened;
	}
	public int getPLMResolved() {
		return PLMResolved;
	}
	public void setPLMResolved(int pLMResolved) {
		PLMResolved = pLMResolved;
	}
	public int getPLMClosed() {
		return PLMClosed;
	}
	public void setPLMClosed(int pLMClosed) {
		PLMClosed = pLMClosed;
	}
	private int PLMResolved;
	private int PLMClosed;
	
	
	//private String SW/EM;
	
	
	
	
	


}
