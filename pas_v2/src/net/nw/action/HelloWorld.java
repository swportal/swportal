package net.nw.action;

import java.util.Date;

public class HelloWorld {
	private String name;
	private String result;
	int aa;
	Date date;
	
	public Date getDate() {
		return date;
		//date.
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getName() {
		return name;
		
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getResult() {
		return result;
		
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	public String execute()
	{
		this.result="Hello!"+this.name+".";
		return "success";
	}
}
