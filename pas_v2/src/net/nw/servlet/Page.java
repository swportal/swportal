package net.nw.servlet;
/**
 * @author QQ:373672872
 *	∑÷“≥Entity
 */
public class Page {
	
	
	private int total;
	
	private int currpage;
	
	private int pagesize;
	
	private int pagecount;
	
	private int start;
	
	private String projectname;
	private String where;
	
	

	public String getWhere() {
		return where;
	}


	public void setWhere(String where) {
		this.where = where;
	}


	public Page(int total, int currpage, int pagesize, String where ) {
		this.setTotal(total);
		this.setCurrpage(currpage);
		this.setPagesize(pagesize);
		this.setWhere(where);
	}
	
	
	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCurrpage() {
		return currpage;
	}
	public void setCurrpage(int currpage) {
		this.currpage = currpage;
	}
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
	public int getPagecount() {
		
		this.setPagecount();
		return pagecount;
	}
	
	public void setPagecount(){
		this.pagecount = (total % pagesize == 0) ? total / pagesize : total / pagesize + 1;
	}
	public void setPagecount(int pagecount) {
		this.pagecount = pagecount;
	}
	public int getStart() {
		
		this.setStart();
		return start;
	}
	
	public void setStart(){
		this.start = (this.getCurrpage()-1)*this.getPagesize();
	}
	public void setStart(int start) {
		this.start = start;
	}
}

