package com.web.controller.entity;

import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

public class Role  implements java.io.Serializable,Comparable<Role>{
	private static final long serialVersionUID = 1L;
	private Long id;
	private String name;
	private String description;
	private Set<User> users = new TreeSet<User>();
	private Set<Privilege> privileges = new HashSet<Privilege>();
	
	
	public Set<Privilege> getPrivileges() {
		return privileges;
	}
	public void setPrivileges(Set<Privilege> privileges) {
		this.privileges = privileges;
	}
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String toString() {
		return "岗位ID:"+this.id+" 岗位名称:"+this.name;
	}
	public int compareTo(Role role) {
		if(this.id>role.id){
			return 1;
		}
		else if(this.id < role.id){
			return -1;
		}
		else{
			return this.name.compareTo(role.name);
		}
	}
}
