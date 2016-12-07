package com.web.controller.util;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.entity.Privilege;
import com.web.controller.entity.User;


@Controller
public class Installer {
	@Resource
	private SessionFactory sessionFactory;
	
	@Transactional
	public void install(){
		Session session =  sessionFactory.getCurrentSession();
		
		//保存超级管理员用户
		User user = new User();
		user.setLoginName("admin");
		user.setName("administrator");
		user.setPassword(DigestUtils.md5Hex("admin1234"));
		session.save(user);
		// --------------------------------------------------------------
		//保存权限数据
		Privilege menu, menu1,menu2,menu3, menu4, menu5;
		
		//各種展示系統
		menu  =  new Privilege("DashBoard", null,null);
		menu1 =  new Privilege("PAS", "/pas_v2/",menu);
		menu2 =  new Privilege("Marketing Issue Info.", "/portal/market/getIssueList",menu);
		menu3 =  new Privilege("Schedule", "/portal/user/calendar",menu);

		session.save(menu);
		session.save(menu1);
		session.save(menu2);
		session.save(menu3);
		
		//公共信息查询
		menu  =  new Privilege("Public Info.", null,null);
		menu1 =  new Privilege("Training Mgmt.", "/portal/edu/getEduList",menu);
		menu2 =  new Privilege("Server Info.", "/portal/server/getAllServer",menu);
		menu3 =  new Privilege("Business Trip Info.", "/portal/trip/getBizList",menu);
		session.save(menu);
		session.save(menu1);
		session.save(menu2);
		session.save(menu3);
			
				
		//系統權限管理， 人員管理		
		menu =  new Privilege("System Mgmt.", null,null);
		menu1 =  new Privilege("Role Management", "/portal/role/getAllRole",menu);
		menu2 =  new Privilege("User Management", "/portal/user/getAllUser",menu);
		session.save(menu);
		session.save(menu1);
		session.save(menu2);
		
		session.save(new Privilege("Role List", "/portal/role/getAllRole",menu1));
		session.save(new Privilege("Role Delete", "/portal/role/delRole",menu1));
		session.save(new Privilege("Role Add", "/portal/role/toAddRole",menu1));
		session.save(new Privilege("Role Update", "/portal/role/getRole",menu1));
		session.save(new Privilege("Set Priviledge", "/portal/role/setPrivilegeUI",menu1));
		
		
		session.save(new Privilege("User List", "/portal/user/getAllUser",menu2));
		session.save(new Privilege("User Delete", "/portal/user/delUser",menu2));
		session.save(new Privilege("User Add", "/portal/user/toAddUser",menu2));
		session.save(new Privilege("User Update", "/portal/user/getUser",menu2));
		session.save(new Privilege("Init Password", "/portal/user/initPassword",menu2));
	}
	public static void main(String[] args){
		ApplicationContext ac = new ClassPathXmlApplicationContext("config/spring-hibernate.xml");
		Installer installer = (Installer) ac.getBean("installer");
		installer.install();
		
	}
}
