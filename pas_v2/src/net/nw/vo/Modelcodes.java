package net.nw.vo;

import java.util.List;
import java.util.Map;

//import net.nw.dao.UserroleTransferDAO;
import net.nw.dao.ModelcodesDAO;
import net.nw.dao.UserrolesDAO;

public class Modelcodes {
	private int codeid;
	private int projectid;
	public int getProjectid() {
		return projectid;
	}


	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}


	private String ProjectName;
	


	public String getProjectName() {
		return ProjectName;
	}


	public void setProjectName(String projectName) {
		ProjectName = projectName;
	}


	public String getModelCode() {
		return ModelCode;
	}


	public void setModelCode(String modelCode) {
		ModelCode = modelCode;
	}


	private String ModelCode;
	private Map<Integer,String> codes;
	private Map<Integer,String> names;
	
	public Modelcodes(){
		ModelcodesDAO dao=new ModelcodesDAO();
		//UserroleTransferDAO dao1=new UserroleTransferDAO();
		codes=dao.getCodes();
		names=dao.getNames();		//rolename=
	}
	
	
	public Map<Integer, String> getNames() {
		return names;
	}


	public void setNames(Map<Integer, String> names) {
		this.names = names;
	}


	public int getCodeid() {
		return codeid;
	}

	public void setCodeid(int codeid) {
		this.codeid = codeid;
	}
	
	

	public void setCodes(Map<Integer, String> codes) {
		this.codes = codes;
	}
	
	
	public Map<Integer, String> getCodes() {
		return codes;
	}
	
	
	//public String idToName()
	//{
		
	//}
}
