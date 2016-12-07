package com.web.controller.entity;

import java.util.Collection;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;


//@Entity
//@Table(name="T_USER")
//@Id
//@GeneratedValue
//@Column(length=32)
public class User  implements java.io.Serializable,Comparable<User>{
	@Autowired
	private HttpServletRequest request;
	private Long id;	
	private String name;	
	private String loginName;
	private String password;
	private String gender;
	private String phoneNumber;
	private String email;
	private String description;
	private Set<Role> roles = new TreeSet<Role>();
	private ServletContext servletContext;
	/**
	 * 判断本用户是否有指定名称的权限
	 * @param name
	 * @return
	 */
	public boolean hasPrivilegeByName(String name){
		//超级管理员有所有的权限
		if(isAdmin()){
			return true;
		}
		//普通用户判断是否含有这个权限
		for(Role role:roles){
			for(Privilege priv:role.getPrivileges()){
				if(priv.getName().equals(name)){
					return true;
				}
			}
		}
		return false;
	}
	
	public boolean hasPrivilegeByUrl(String privUrl){
		//超级管理员有所有的权限
		if(isAdmin()){
			return true;
		}
		//去掉后面的参数
    	int pos = privUrl.indexOf("?");
    	if(pos>-1){
    		privUrl =  privUrl.substring(0,pos);
    	}
    	
    	//去掉UI后缀
    	if(privUrl.endsWith("UI")){
    		privUrl = privUrl.substring(0,privUrl.length()-2);
    	}   	
    	
    	/*Collection<String> allPrivilegeUrls = (Collection<String>) request.getSession().getServletContext().getAttribute("allPrivilegeUrls");  
    	Iterator i = allPrivilegeUrls.iterator();
    	while(i.hasNext()){
    		String nString=(String)i.next();
    		System.out.println(nString);
    	}
    	
    	if(!allPrivilegeUrls.contains(privUrl)){
    		return true;
    	}
    	else{*/
			//普通用户判断是否含有这个权限
			for(Role role:roles){
				for(Privilege priv:role.getPrivileges()){
					if(privUrl.equals(priv.getUrl())){
						return true;
					}
				}
			}
			return false;
		}
	//}
	
	public boolean isAdmin(){
		return "admin".equals(loginName);
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public String toString(){
		return "用户ID:"+this.id+" 用户名称:"+this.name;
	}
	
	public int compareTo(User user) {
		if(this.id>user.id){
			return 1;
		}
		else if(this.id < user.id){
			return -1;
		}
		else{
			return this.name.compareTo(user.name);
		}
	}
}
