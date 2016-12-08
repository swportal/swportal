package net.nw.vo;

import java.util.Map;

//import net.nw.dao.UserroleTransferDAO;
import net.nw.dao.UserrolesDAO;

public class Userroles {
	private int roleid;
	private String rolename;
	private Map<Integer,String> roles;
	
	public Userroles(){
		UserrolesDAO dao=new UserrolesDAO();
		//UserroleTransferDAO dao1=new UserroleTransferDAO();
		roles=dao.getRoles();
		//rolename=
	}
	
	public Map<Integer, String> getRoles() {
		return roles;
	}
	public void setRoles(Map<Integer, String> roles) {
		this.roles = roles;
	}
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	//public String idToName()
	//{
		
	//}
}
