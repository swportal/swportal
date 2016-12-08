package net.nw.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conn {

	private static String dbUrl="jdbc:mysql://109.110.100.56/tsdr_project";
	private static String dbUser="root";
	private static String dbPwd="";
	//静态代码块在构造函数执行之前执行
	static
	{
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		
	}
	
	public static Connection getConnection() throws Exception{
		return DriverManager.getConnection(dbUrl,dbUser,dbPwd);
	}
}
