package net.nw.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import net.nw.dao.DefactAllDAO;
import net.nw.dao.ModelDAO;
import net.nw.dao.UserLoginDAO;
import net.nw.dao.UserroleTransferDAO;
import net.nw.vo.Modelcodes;
import net.nw.vo.Users;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SelectCityAction extends ActionSupport implements RequestAware,SessionAware,ModelDriven<Users>,ServletResponseAware,ServletRequestAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Users user=new Users();
	private Modelcodes mc;
	private String randomCode;
	public String getRandomCode() {
		return randomCode;
	}
	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}
	private Map<String,Object> request;
	private UserLoginDAO uld= new UserLoginDAO();
	private UserroleTransferDAO utd= new UserroleTransferDAO();
	
	
	private HttpServletResponse response;
	private HttpServletRequest request1;
	private Map<String, Object> session;
	public String login()
	{
		if(uld.usersLogin(user))
		{
			
			ModelDAO moddao=new ModelDAO();
			List<String>mainModels=moddao.getmainModels(user.getRoleid());
			session.put("mainModels", mainModels);
			
			DefactAllDAO dad=new DefactAllDAO();
			List<Integer> listTotal1= dad.getAll();
			List<Integer> listTotal2= dad.getAll_type();
			List<String> listTotal3 = dad.getDateSelect();
			//foreach(Integer s in listTotal1)
	          //{
	            // Console.WriteLine(s);
	           //}
			System.out.println("listTotal1中内容："+listTotal1.get(0));
			request.put("Total", listTotal1.get(0));
			request.put("TotalA", listTotal1.get(1));
			request.put("TotalB", listTotal1.get(2));
			request.put("TotalC", listTotal1.get(3));
			request.put("TotalN", listTotal1.get(4));
			
			
			request.put("Total_type", listTotal2.get(0));
			request.put("Opened", listTotal2.get(1));
			request.put("Resolved", listTotal2.get(2));
			request.put("Closed", listTotal2.get(3));
			
			request.put("OpenedA", listTotal2.get(4));
			request.put("OpenedB", listTotal2.get(5));
			request.put("OpenedC", listTotal2.get(6));
			request.put("OpenedN", listTotal2.get(7));
			
			request.put("ResolvedA", listTotal2.get(8));
			request.put("ResolvedB", listTotal2.get(9));
			request.put("ResolvedC", listTotal2.get(10));
			request.put("ResolvedN", listTotal2.get(11));
			
			request.put("ClosedA", listTotal2.get(12));
			request.put("ClosedB", listTotal2.get(13));
			request.put("ClosedC", listTotal2.get(14));
			request.put("ClosedN", listTotal2.get(15));
			
			request.put("SQAPLMTotalDelay", listTotal2.get(16));
			request.put("SQAPLMTotalDelay30", listTotal2.get(17));
			request.put("SQAPLMTotalDelay60", listTotal2.get(18));
			
			//最近七天数据
			request.put("Total_Date_0", listTotal3.get(0));
			request.put("Total_unclosed_0", (Integer.parseInt(listTotal3.get(0))-Integer.parseInt(listTotal3.get(1)))+"");
			request.put("SelectDate_0", listTotal3.get(2));
			
			request.put("Total_Date_1", listTotal3.get(3));
			request.put("Total_unclosed_1", (Integer.parseInt(listTotal3.get(3))-Integer.parseInt(listTotal3.get(4)))+"");
			request.put("SelectDate_1", listTotal3.get(5));
			
			request.put("Total_Date_2", listTotal3.get(6));
			request.put("Total_unclosed_2", (Integer.parseInt(listTotal3.get(6))-Integer.parseInt(listTotal3.get(7)))+"");
			request.put("SelectDate_2", listTotal3.get(8));
			
			request.put("Total_Date_3", listTotal3.get(9));
			request.put("Total_unclosed_3", (Integer.parseInt(listTotal3.get(9))-Integer.parseInt(listTotal3.get(10)))+"");
			request.put("SelectDate_3", listTotal3.get(11));
			
			request.put("Total_Date_4", listTotal3.get(12));
			request.put("Total_unclosed_4", (Integer.parseInt(listTotal3.get(12))-Integer.parseInt(listTotal3.get(13)))+"");
			request.put("SelectDate_4", listTotal3.get(14));
			
			request.put("Total_Date_5", listTotal3.get(15));
			request.put("Total_unclosed_5", (Integer.parseInt(listTotal3.get(15))-Integer.parseInt(listTotal3.get(16)))+"");
			request.put("SelectDate_5", listTotal3.get(17));
			
			request.put("Total_Date_6", listTotal3.get(18));
			request.put("Total_unclosed_6", (Integer.parseInt(listTotal3.get(18))-Integer.parseInt(listTotal3.get(19)))+"");
			request.put("SelectDate_6", listTotal3.get(20));
			
			
			
			System.out.println("用户名："+user.getUsername());
			System.out.println("密码："+user.getPassword());
			System.out.print("登录类型："+utd.idTOName(user.getRoleid()));
			//if(dao.usersLogin(user))
			{
				session.put("loginusername", user.getUsername());
				session.put("msg", utd.idTOName(user.getRoleid()));
				//session.put("loginusername", "nishishui");
			}
			return SUCCESS;
		}
		else{
			this.addActionMessage("用户名或密码错误！");
			return INPUT;
		}
	}
	public String logout()
	{
		session.put("loginusername", null);
		session.put("msg", null);
		
		ModelDAO moddao=new ModelDAO();
		List<String>mainModels=moddao.getmainModels(user.getRoleid());
		session.put("mainModels", mainModels);
		
		DefactAllDAO dad=new DefactAllDAO();
		List<Integer> listTotal1= dad.getAll();
		List<Integer> listTotal2= dad.getAll_type();
		List<String> listTotal3 = dad.getDateSelect();
		//foreach(Integer s in listTotal1)
          //{
            // Console.WriteLine(s);
           //}
		System.out.println("listTotal1中内容："+listTotal1.get(0));
		request.put("Total", listTotal1.get(0));
		request.put("TotalA", listTotal1.get(1));
		request.put("TotalB", listTotal1.get(2));
		request.put("TotalC", listTotal1.get(3));
		request.put("TotalN", listTotal1.get(4));
		
		
		request.put("Total_type", listTotal2.get(0));
		request.put("Opened", listTotal2.get(1));
		request.put("Resolved", listTotal2.get(2));
		request.put("Closed", listTotal2.get(3));
		
		request.put("OpenedA", listTotal2.get(4));
		request.put("OpenedB", listTotal2.get(5));
		request.put("OpenedC", listTotal2.get(6));
		request.put("OpenedN", listTotal2.get(7));
		
		request.put("ResolvedA", listTotal2.get(8));
		request.put("ResolvedB", listTotal2.get(9));
		request.put("ResolvedC", listTotal2.get(10));
		request.put("ResolvedN", listTotal2.get(11));
		
		request.put("ClosedA", listTotal2.get(12));
		request.put("ClosedB", listTotal2.get(13));
		request.put("ClosedC", listTotal2.get(14));
		request.put("ClosedN", listTotal2.get(15));
		
		request.put("SQAPLMTotalDelay", listTotal2.get(16));
		request.put("SQAPLMTotalDelay30", listTotal2.get(17));
		request.put("SQAPLMTotalDelay60", listTotal2.get(18));
		
		//最近七天数据
		request.put("Total_Date_0", listTotal3.get(0));
		request.put("Total_unclosed_0", (Integer.parseInt(listTotal3.get(0))-Integer.parseInt(listTotal3.get(1)))+"");
		request.put("SelectDate_0", listTotal3.get(2));
		
		request.put("Total_Date_1", listTotal3.get(3));
		request.put("Total_unclosed_1", (Integer.parseInt(listTotal3.get(3))-Integer.parseInt(listTotal3.get(4)))+"");
		request.put("SelectDate_1", listTotal3.get(5));
		
		request.put("Total_Date_2", listTotal3.get(6));
		request.put("Total_unclosed_2", (Integer.parseInt(listTotal3.get(6))-Integer.parseInt(listTotal3.get(7)))+"");
		request.put("SelectDate_2", listTotal3.get(8));
		
		request.put("Total_Date_3", listTotal3.get(9));
		request.put("Total_unclosed_3", (Integer.parseInt(listTotal3.get(9))-Integer.parseInt(listTotal3.get(10)))+"");
		request.put("SelectDate_3", listTotal3.get(11));
		
		request.put("Total_Date_4", listTotal3.get(12));
		request.put("Total_unclosed_4", (Integer.parseInt(listTotal3.get(12))-Integer.parseInt(listTotal3.get(13)))+"");
		request.put("SelectDate_4", listTotal3.get(14));
		
		request.put("Total_Date_5", listTotal3.get(15));
		request.put("Total_unclosed_5", (Integer.parseInt(listTotal3.get(15))-Integer.parseInt(listTotal3.get(16)))+"");
		request.put("SelectDate_5", listTotal3.get(17));
		
		request.put("Total_Date_6", listTotal3.get(18));
		request.put("Total_unclosed_6", (Integer.parseInt(listTotal3.get(18))-Integer.parseInt(listTotal3.get(19)))+"");
		request.put("SelectDate_6", listTotal3.get(20));
		
		System.out.println("用户名："+user.getUsername());
		System.out.println("密码："+user.getPassword());
		System.out.print("登录类型："+utd.idTOName(user.getRoleid()));
		//if(dao.usersLogin(user))
		{
			session.put("loginusername", user.getUsername());
			session.put("msg", utd.idTOName(user.getRoleid()));
			session.put("loginusername", "nishishui");
		}
		
	
		
		return "logout";
	}
	public String login_select()
	{
		/*if(uld.usersLogin(user))
		{
			
			ModelDAO moddao=new ModelDAO();
			List<String>mainModels=moddao.getmainModels(user.getRoleid());
			session.put("mainModels", mainModels);*/
			
			DefactAllDAO dad=new DefactAllDAO();
			List<Integer> listTotal1= dad.getAll_select(mc);
			//foreach(Integer s in listTotal1)
	          //{
	            // Console.WriteLine(s);
	           //}
			System.out.println("listTotal1中内容："+listTotal1.get(0));
			request.put("Total", listTotal1.get(0));
			request.put("TotalA", listTotal1.get(1));
			request.put("TotalB", listTotal1.get(2));
			request.put("TotalC", listTotal1.get(3));
			
			System.out.println("用户名："+user.getUsername());
			System.out.println("密码："+user.getPassword());
			System.out.print("登录类型："+utd.idTOName(user.getRoleid()));
			//if(dao.usersLogin(user))
			{
				//request.put("msg", utd.idTOName(user.getRoleid()));
			}
			return SUCCESS;
		/*}
		else{
			this.addActionMessage("用户名或密码错误！");
			return INPUT;
		}*/
	}
	
	public Users getModel() {
		// TODO Auto-generated method stub
		return user;
	}
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		//request.put("msg", "SAMSUNG");
		return super.execute();
	}
	public void setRequest(Map<String, Object> request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
	//对登录进行验证
	public void validateLogin()
	{
		if(uld.usersLogin(user)){
			if(!randomCode.equalsIgnoreCase(session.get("randomCode").toString()))
			{
				this.addFieldError("random_error","验证码不正确！");
				return;
			}
		}
	}
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}
	public void setServletRequest(HttpServletRequest request1) {
		// TODO Auto-generated method stub
		this.request1=request1;
	}
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session=session;
	}

}
