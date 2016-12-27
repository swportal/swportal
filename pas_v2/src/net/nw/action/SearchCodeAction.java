package net.nw.action;
//��Ҫ������ת��ʾ
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import net.nw.dao.DefactAllDAO;
import net.nw.dao.ModelDAO;
import net.nw.dao.ModelcodesDAO;
import net.nw.dao.SelectCodeDAO;
import net.nw.dao.UserLoginDAO;
import net.nw.dao.UserroleTransferDAO;
import net.nw.vo.Modelcodes;
import net.nw.vo.Users;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SearchCodeAction extends ActionSupport implements RequestAware,SessionAware,ModelDriven<Modelcodes>,ServletResponseAware,ServletRequestAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Users user=new Users();
	private Modelcodes mc=new Modelcodes();
	private String randomCode;
	public String getRandomCode() {
		return randomCode;
	}
	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}
	public SearchCodeAction(){
		
	}
	private Map<String,Object> request;
	private UserLoginDAO uld= new UserLoginDAO();
	private UserroleTransferDAO utd= new UserroleTransferDAO();
	
	
	private HttpServletResponse response;
	//
	private HttpServletRequest request1=ServletActionContext.getRequest();
	private Map<String, Object> session;
	
	public String searchCode(){
		
		String pn = request1.getParameter("projectname");
		System.out.println("pn:"+pn);
		
		String pjn = request1.getParameter("pn");
		String miles = request1.getParameter("ms");
		String sdate = request1.getParameter("sd");
		String edate = request1.getParameter("ed");
		String state = request1.getParameter("sta");
		String city = request1.getParameter("sel");
		String curp = request1.getParameter("cur");
		session.put("pn", pjn);
		session.put("ms", miles);
		session.put("sd", sdate);
		session.put("ed", edate);
		session.put("sta", state);
		session.put("sel", city);
		session.put("cur", curp);
		
		
		ModelcodesDAO mcd=new ModelcodesDAO();
		Map<Integer,String> ma=mcd.getCodes(pn); 
		session.put("mapcode",ma);
		session.put("projectname_session", request1.getParameter("projectname"));
		session.put("SWEM_session", request1.getParameter("SWEM"));
		session.put("PVRPlan_session", request1.getParameter("PVRPlan"));
		session.put("PVRActual_session", request1.getParameter("PVRActual"));
		session.put("PRAPlan_session", request1.getParameter("PRAPlan"));
		session.put("PRAActual_session", request1.getParameter("PRAActual"));
		//System.out.println("request1.getParameter("PRAActual")"+request1.getParameter("PRAActual"));
		
		DefactAllDAO dad=new DefactAllDAO();
		List<Integer> listTotal= dad.getAll_type_select_project(pn);
		
		
		request.put("Total", listTotal.get(0));
		request.put("TotalA", listTotal.get(1));
		request.put("TotalB", listTotal.get(2));
		request.put("TotalC", listTotal.get(3));
		request.put("TotalN", listTotal.get(4));
		
		request.put("Total", listTotal.get(0));
		request.put("Opened", listTotal.get(5));
		request.put("Resolved", listTotal.get(6));
		request.put("Closed", listTotal.get(7));
		
		request.put("OpenedA", listTotal.get(8));
		request.put("OpenedB", listTotal.get(9));
		request.put("OpenedC", listTotal.get(10));
		request.put("OpenedN", listTotal.get(11));
		
		request.put("ResolvedA", listTotal.get(12));
		request.put("ResolvedB", listTotal.get(13));
		request.put("ResolvedC", listTotal.get(14));
		request.put("ResolvedN", listTotal.get(15));
		
		request.put("ClosedA", listTotal.get(16));
		request.put("ClosedB", listTotal.get(17));
		request.put("ClosedC", listTotal.get(18));
		request.put("ClosedN", listTotal.get(19));
		
		request.put("SQAPLMTotalDelay", listTotal.get(20));
		request.put("SQAPLMTotalDelay30", listTotal.get(21));
		request.put("SQAPLMTotalDelay60", listTotal.get(22));
		
		request.put("SQAPLMTotalA", listTotal.get(23));
		request.put("SQAPLMOpenedA", listTotal.get(24));
		request.put("SQAPLMResolvedA", listTotal.get(25));
		request.put("SQAPLMClosedA", listTotal.get(26));
		
		request.put("SQAPLMTotalBC", listTotal.get(28));
		request.put("SQAPLMOpenedBC", listTotal.get(29));
		request.put("SQAPLMResolvedBC", listTotal.get(30));
		request.put("SQAPLMClosedBC", listTotal.get(31));
		
		if(listTotal.get(27)!=null)
			{
				
				request.put("SelectDate",listTotal.get(27).toString().substring(0, 4)+"/"+listTotal.get(27).toString().substring(4,6)+"/"+listTotal.get(27).toString().substring(6,8));
			//System.out.println("�����");
			}
		
		List<String> listTotal3= dad.getDailyData(pn);
		
		request.put("Day1", listTotal3.get(0));
		session.put("Day1_session", listTotal3.get(0));
		request.put("Day2", listTotal3.get(1));
		request.put("Day3", listTotal3.get(2));
		request.put("Day4", listTotal3.get(3));
		request.put("Day5", listTotal3.get(4));
		request.put("Day6", listTotal3.get(5));
		request.put("Day7", listTotal3.get(6));
		request.put("Day8", listTotal3.get(7));
		request.put("Day9", listTotal3.get(8));
		request.put("Day10", listTotal3.get(9));
		request.put("Day11", listTotal3.get(10));
		request.put("Day12", listTotal3.get(11));
		request.put("Day13", listTotal3.get(12));
		request.put("Day14", listTotal3.get(13));
		request.put("Day15", listTotal3.get(14));
		request.put("Day16", listTotal3.get(31));
		request.put("Day17", listTotal3.get(32));
		request.put("Day18", listTotal3.get(33));
		request.put("Day19", listTotal3.get(34));
		request.put("Day20", listTotal3.get(35));
		session.put("Day15_session", listTotal3.get(14));
		request.put("ResolveDay1", listTotal3.get(15));
		session.put("ResolveDay1_session", listTotal3.get(15));
		request.put("ResolveDay2", listTotal3.get(16));
		request.put("ResolveDay3", listTotal3.get(17));
		request.put("ResolveDay4", listTotal3.get(18));
		request.put("ResolveDay5", listTotal3.get(19));
		request.put("ResolveDay6", listTotal3.get(20));
		request.put("ResolveDay7", listTotal3.get(21));
		request.put("ResolveDay8", listTotal3.get(22));
		request.put("ResolveDay9", listTotal3.get(23));
		request.put("ResolveDay10", listTotal3.get(24));
		request.put("ResolveDay11", listTotal3.get(25));
		request.put("ResolveDay12", listTotal3.get(26));
		request.put("ResolveDay13", listTotal3.get(27));
		request.put("ResolveDay14", listTotal3.get(28));
		request.put("ResolveDay15", listTotal3.get(29));
		request.put("ResolveDay16", listTotal3.get(36));
		request.put("ResolveDay17", listTotal3.get(37));
		request.put("ResolveDay18", listTotal3.get(38));
		request.put("ResolveDay19", listTotal3.get(39));
		request.put("ResolveDay20", listTotal3.get(40));
		session.put("ResolveDay15_session", listTotal3.get(29));
		//System.out.println("ǰǰǰǰǰǰǰǰǰǰǰǰǰ");
		request.put("7daysselectdate", listTotal3.get(30));
		//System.out.println("ǰǰǰǰǰǰǰǰǰǰǰǰǰ");
		for(int i=0;i<40;i++){
			request.put("Day"+(i+21), listTotal3.get(41+i));
		}
		
		for(int i=0;i<40;i++){
			request.put("ResolveDay"+(i+21), listTotal3.get(81+i));
		}
		request.put("msg_codename", "All");
		request.put("msg_codename", "All");
		
				
		Map<String,Integer> map= dad.getAllComponent(pn);
		List<String> listTotal1=new ArrayList<String>();
		List<String> listTotal2=new ArrayList<String>();
		
		Set<String> keys=map.keySet();
		Iterator<String> iter=keys.iterator();		
		while(iter.hasNext()){
			listTotal1.add(iter.next());
		}
	
		Collection<Integer> values=map.values();
		Iterator<Integer> iter1=values.iterator();
		while(iter1.hasNext()){
			listTotal2.add(iter1.next()+"");
		}
		
	
		System.out.println(listTotal1.get(0)+listTotal2.get(0));
		
		if(("0".equals(listTotal2.get(0)))&&("0".equals(listTotal2.get(1)))&&("0".equals(listTotal2.get(2)))&&("0".equals(listTotal2.get(3)))){
			request.put("CompItem1", " ");
			request.put("CompClose1", " ");
			request.put("CompPending1", " ");
			request.put("CompRejected1", " ");
			request.put("CompResolved1", " ");
		}
		else{			
			if(listTotal1.get(0).contains("NonSmartClosed"))
				request.put("CompItem1", listTotal1.get(0).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem1", listTotal1.get(0).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(0)))
				request.put("CompClose1", " ");
			else
				request.put("CompClose1", listTotal2.get(0));
			if("0".equals(listTotal2.get(1)))
				request.put("CompPending1", " ");
			else
			request.put("CompPending1", listTotal2.get(1));
			if("0".equals(listTotal2.get(2)))
				request.put("CompRejected1", " ");
			else
				request.put("CompRejected1", listTotal2.get(2));
			if("0".equals(listTotal2.get(3)))
				request.put("CompResolved1", " ");
			else
				request.put("CompResolved1", listTotal2.get(3));
			
		}
		
		
		if(("0".equals(listTotal2.get(4)))&&("0".equals(listTotal2.get(5)))&&("0".equals(listTotal2.get(6)))&&("0".equals(listTotal2.get(7)))){
			request.put("CompItem2", " ");
			request.put("CompClose2", " ");
			request.put("CompPending2", " ");
			request.put("CompRejected2", " ");
			request.put("CompResolved2", " ");
		}
		else{	
			if(listTotal1.get(4).contains("NonSmartClosed"))
				request.put("CompItem2", listTotal1.get(4).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem2", listTotal1.get(4).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(4)))
				request.put("CompClose2", " ");
			else
				request.put("CompClose2", listTotal2.get(4));
			
			if("0".equals(listTotal2.get(5)))
				request.put("CompPending2", " ");
			else
				request.put("CompPending2", listTotal2.get(5));
			
			if("0".equals(listTotal2.get(6)))
				request.put("CompRejected2", " ");
			else
				request.put("CompRejected2", listTotal2.get(6));
			 
			if("0".equals(listTotal2.get(7)))
				request.put("CompResolved2", " ");
			else
				request.put("CompResolved2", listTotal2.get(7));	
			
		}
		
		if(("0".equals(listTotal2.get(8)))&&("0".equals(listTotal2.get(9)))&&("0".equals(listTotal2.get(10)))&&("0".equals(listTotal2.get(11)))){
			request.put("CompItem3", " ");
			request.put("CompClose3", " ");
			request.put("CompPending3", " ");
			request.put("CompRejected3", " ");
			request.put("CompResolved3", " ");
		}
		else{	
			if(listTotal1.get(8).contains("NonSmartClosed"))
				request.put("CompItem3", listTotal1.get(8).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem3", listTotal1.get(8).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(8)))
				request.put("CompClose3", " ");
			else
				request.put("CompClose3", listTotal2.get(8));
			
			if("0".equals(listTotal2.get(9)))
				request.put("CompPending3", " ");
			else
				request.put("CompPending3", listTotal2.get(9));
			
			if("0".equals(listTotal2.get(10)))
				request.put("CompRejected3", " ");
			else
				request.put("CompRejected3", listTotal2.get(10));
			 
			if("0".equals(listTotal2.get(11)))
				request.put("CompResolved3", " ");
			else
				request.put("CompResolved3", listTotal2.get(11));
		}
		
		if(("0".equals(listTotal2.get(12)))&&("0".equals(listTotal2.get(13)))&&("0".equals(listTotal2.get(14)))&&("0".equals(listTotal2.get(15)))){
			request.put("CompItem4", " ");
			request.put("CompClose4", " ");
			request.put("CompPending4", " ");
			request.put("CompRejected4", " ");
			request.put("CompResolved4", " ");
		}
		else{	
			if(listTotal1.get(12).contains("NonSmartClosed"))
				request.put("CompItem4", listTotal1.get(12).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem4", listTotal1.get(12).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(12)))
				request.put("CompClose4", " ");
			else
				request.put("CompClose4", listTotal2.get(12));
			
			if("0".equals(listTotal2.get(13)))
				request.put("CompPending4", " ");
			else
				request.put("CompPending4", listTotal2.get(13));
			
			if("0".equals(listTotal2.get(14)))
				request.put("CompRejected4", " ");
			else
				request.put("CompRejected4", listTotal2.get(14));
			 
			if("0".equals(listTotal2.get(15)))
				request.put("CompResolved4", " ");
			else
				request.put("CompResolved4", listTotal2.get(15));
		}
		
		
		if(("0".equals(listTotal2.get(16)))&&("0".equals(listTotal2.get(17)))&&("0".equals(listTotal2.get(18)))&&("0".equals(listTotal2.get(19)))){
			request.put("CompItem5", " ");
			request.put("CompClose5", " ");
			request.put("CompPending5", " ");
			request.put("CompRejected5", " ");
			request.put("CompResolved5", " ");
		}
		else{	
			if(listTotal1.get(16).contains("NonSmartClosed"))
				request.put("CompItem5", listTotal1.get(16).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem5", listTotal1.get(16).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(16)))
				request.put("CompClose5", " ");
			else
				request.put("CompClose5", listTotal2.get(16));
			
			if("0".equals(listTotal2.get(17)))
				request.put("CompPending5", " ");
			else
				request.put("CompPending5", listTotal2.get(17));
			
			if("0".equals(listTotal2.get(18)))
				request.put("CompRejected5", " ");
			else
				request.put("CompRejected5", listTotal2.get(18));
			 
			if("0".equals(listTotal2.get(19)))
				request.put("CompResolved5", " ");
			else
				request.put("CompResolved5", listTotal2.get(19));
		}
		
		if(("0".equals(listTotal2.get(20)))&&("0".equals(listTotal2.get(21)))&&("0".equals(listTotal2.get(22)))&&("0".equals(listTotal2.get(23)))){
			request.put("CompItem6", " ");
			request.put("CompClose6", " ");
			request.put("CompPending6", " ");
			request.put("CompRejected6", " ");
			request.put("CompResolved6", " ");
		}
		else{	
			if(listTotal1.get(20).contains("NonSmartClosed"))
				request.put("CompItem6", listTotal1.get(20).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem6", listTotal1.get(20).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(20)))
				request.put("CompClose6", " ");
			else
				request.put("CompClose6", listTotal2.get(20));
			
			if("0".equals(listTotal2.get(21)))
				request.put("CompPending6", " ");
			else
				request.put("CompPending6", listTotal2.get(21));
			
			if("0".equals(listTotal2.get(22)))
				request.put("CompRejected6", " ");
			else
				request.put("CompRejected6", listTotal2.get(22));
			 
			if("0".equals(listTotal2.get(23)))
				request.put("CompResolved6", " ");
			else
				request.put("CompResolved6", listTotal2.get(23));
		}
		
		if(("0".equals(listTotal2.get(24)))&&("0".equals(listTotal2.get(25)))&&("0".equals(listTotal2.get(26)))&&("0".equals(listTotal2.get(27)))){
			request.put("CompItem7", " ");
			request.put("CompClose7", " ");
			request.put("CompPending7", " ");
			request.put("CompRejected7", " ");
			request.put("CompResolved7", " ");
		}
		else{	
			if(listTotal1.get(24).contains("NonSmartClosed"))
				request.put("CompItem7", listTotal1.get(24).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem7", listTotal1.get(24).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(24)))
				request.put("CompClose7", " ");
			else
				request.put("CompClose7", listTotal2.get(24));
			
			if("0".equals(listTotal2.get(25)))
				request.put("CompPending7", " ");
			else
				request.put("CompPending7", listTotal2.get(25));
			
			if("0".equals(listTotal2.get(26)))
				request.put("CompRejected7", " ");
			else
				request.put("CompRejected7", listTotal2.get(26));
			 
			if("0".equals(listTotal2.get(27)))
				request.put("CompResolved7", " ");
			else
				request.put("CompResolved7", listTotal2.get(27));
		}
	
		
		if(("0".equals(listTotal2.get(28)))&&("0".equals(listTotal2.get(29)))&&("0".equals(listTotal2.get(30)))&&("0".equals(listTotal2.get(31)))){
			request.put("CompItem8", " ");
			request.put("CompClose8", " ");
			request.put("CompPending8", " ");
			request.put("CompRejected8", " ");
			request.put("CompResolved8", " ");
		}
		else{	
			if(listTotal1.get(28).contains("NonSmartClosed"))
				request.put("CompItem8", listTotal1.get(28).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem8", listTotal1.get(28).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(28)))
				request.put("CompClose8", " ");
			else
				request.put("CompClose8", listTotal2.get(28));
			
			if("0".equals(listTotal2.get(29)))
				request.put("CompPending8", " ");
			else
				request.put("CompPending8", listTotal2.get(29));
			
			if("0".equals(listTotal2.get(30)))
				request.put("CompRejected8", " ");
			else
				request.put("CompRejected8", listTotal2.get(30));
			 
			if("0".equals(listTotal2.get(31)))
				request.put("CompResolved8", " ");
			else
				request.put("CompResolved8", listTotal2.get(31));
		}
		
		if(("0".equals(listTotal2.get(32)))&&("0".equals(listTotal2.get(33)))&&("0".equals(listTotal2.get(34)))&&("0".equals(listTotal2.get(35)))){
			request.put("CompItem9", " ");
			request.put("CompClose9", " ");
			request.put("CompPending9", " ");
			request.put("CompRejected9", " ");
			request.put("CompResolved9", " ");
		}
		else{	
			if(listTotal1.get(32).contains("NonSmartClosed"))
				request.put("CompItem9", listTotal1.get(32).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem9", listTotal1.get(32).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(32)))
				request.put("CompClose9", " ");
			else
				request.put("CompClose9", listTotal2.get(32));
			
			if("0".equals(listTotal2.get(33)))
				request.put("CompPending9", " ");
			else
				request.put("CompPending9", listTotal2.get(33));
			
			if("0".equals(listTotal2.get(34)))
				request.put("CompRejected9", " ");
			else
				request.put("CompRejected9", listTotal2.get(34));
			 
			if("0".equals(listTotal2.get(35)))
				request.put("CompResolved9", " ");
			else
				request.put("CompResolved9", listTotal2.get(35));

		}
		
		if(("0".equals(listTotal2.get(36)))&&("0".equals(listTotal2.get(37)))&&("0".equals(listTotal2.get(38)))&&("0".equals(listTotal2.get(39)))){
			request.put("CompItem10", " ");
			request.put("CompClose10", " ");
			request.put("CompPending10", " ");
			request.put("CompRejected10", " ");
			request.put("CompResolved10", " ");
		}
		else{	
			if(listTotal1.get(36).contains("NonSmartClosed"))
				request.put("CompItem10", listTotal1.get(36).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem10", listTotal1.get(36).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(36)))
				request.put("CompClose10", " ");
			else
				request.put("CompClose10", listTotal2.get(36));
			
			
			if("0".equals(listTotal2.get(37)))
				request.put("CompPending10"," ");
			else
				request.put("CompPending10", listTotal2.get(37));
			
			if("0".equals(listTotal2.get(38)))
				request.put("CompRejected10", " ");
			else
				request.put("CompRejected10", listTotal2.get(38));
				
			if("0".equals(listTotal2.get(39)))
				request.put("CompResolved10", " ");
			else
				request.put("CompResolved10", listTotal2.get(39));
		}
		
		
		
		
		Map<String,Integer> map2= dad.getAllBlock(pn);
		List<String> listBlock1=new ArrayList<String>();
		List<String> listBlock2=new ArrayList<String>();
		
		Set<String> keysBlock=map2.keySet();
		Iterator<String> iterBlock1=keysBlock.iterator();		
		while(iterBlock1.hasNext()){
			listBlock1.add(iterBlock1.next());
		}
	
		Collection<Integer> valuesBlock=map2.values();
		Iterator<Integer> iterBlock2=valuesBlock.iterator();
		while(iterBlock2.hasNext()){
			listBlock2.add(iterBlock2.next()+"");
		}
		System.out.println(listBlock1.get(0)+" "+listBlock2.get(0));
		
		if(("0".equals(listBlock2.get(0)))&&("0".equals(listBlock2.get(1)))&&("0".equals(listBlock2.get(2)))&&("0".equals(listBlock2.get(3)))){
			request.put("BlockItem1", " ");
			request.put("BlockClose1", " ");
			request.put("BlockPending1", " ");
			request.put("BlockRejected1", " ");
			request.put("BlockResolved1", " ");
		}
		else{	
			request.put("BlockItem1", listBlock1.get(0).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(0)))
				request.put("BlockClose1", " ");
			else
				request.put("BlockClose1", listBlock2.get(0));
			
			
			if("0".equals(listBlock2.get(1)))
				request.put("BlockPending1"," ");
			else
				request.put("BlockPending1", listBlock2.get(1));
			
			if("0".equals(listBlock2.get(2)))
				request.put("BlockRejected1", " ");
			else
				request.put("BlockRejected1", listBlock2.get(2));
				
			if("0".equals(listBlock2.get(3)))
				request.put("BlockResolved1", " ");
			else
				request.put("BlockResolved1", listBlock2.get(3));
		}
		
		if(("0".equals(listBlock2.get(4)))&&("0".equals(listBlock2.get(5)))&&("0".equals(listBlock2.get(6)))&&("0".equals(listBlock2.get(7)))){
			request.put("BlockItem2", " ");
			request.put("BlockClose2", " ");
			request.put("BlockPending2", " ");
			request.put("BlockRejected2", " ");
			request.put("BlockResolved2", " ");
		}
		else{	
			request.put("BlockItem2", listBlock1.get(4).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(4)))
				request.put("BlockClose2", " ");
			else
				request.put("BlockClose2", listBlock2.get(4));
			
			
			if("0".equals(listBlock2.get(5)))
				request.put("BlockPending2"," ");
			else
				request.put("BlockPending2", listBlock2.get(5));
			
			if("0".equals(listBlock2.get(6)))
				request.put("BlockRejected2", " ");
			else
				request.put("BlockRejected2", listBlock2.get(6));
				
			if("0".equals(listBlock2.get(7)))
				request.put("BlockResolved2", " ");
			else
				request.put("BlockResolved2", listBlock2.get(7));
		}
		
		if(("0".equals(listBlock2.get(8)))&&("0".equals(listBlock2.get(9)))&&("0".equals(listBlock2.get(10)))&&("0".equals(listBlock2.get(11)))){
			request.put("BlockItem3", " ");
			request.put("BlockClose3", " ");
			request.put("BlockPending3", " ");
			request.put("BlockRejected3", " ");
			request.put("BlockResolved3", " ");
		}
		else{	
			request.put("BlockItem3", listBlock1.get(8).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(8)))
				request.put("BlockClose3", " ");
			else
				request.put("BlockClose3", listBlock2.get(8));
			
			
			if("0".equals(listBlock2.get(9)))
				request.put("BlockPending3"," ");
			else
				request.put("BlockPending3", listBlock2.get(9));
			
			if("0".equals(listBlock2.get(10)))
				request.put("BlockRejected3", " ");
			else
				request.put("BlockRejected3", listBlock2.get(10));
				
			if("0".equals(listBlock2.get(11)))
				request.put("BlockResolved3", " ");
			else
				request.put("BlockResolved3", listBlock2.get(11));
		}
		
		if(("0".equals(listBlock2.get(12)))&&("0".equals(listBlock2.get(13)))&&("0".equals(listBlock2.get(14)))&&("0".equals(listBlock2.get(15)))){
			request.put("BlockItem4", " ");
			request.put("BlockClose4", " ");
			request.put("BlockPending4", " ");
			request.put("BlockRejected4", " ");
			request.put("BlockResolved4", " ");
		}
		else{	
			request.put("BlockItem4", listBlock1.get(12).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(12)))
				request.put("BlockClose4", " ");
			else
				request.put("BlockClose4", listBlock2.get(12));
			
			
			if("0".equals(listBlock2.get(13)))
				request.put("BlockPending4"," ");
			else
				request.put("BlockPending4", listBlock2.get(13));
			
			if("0".equals(listBlock2.get(14)))
				request.put("BlockRejected4", " ");
			else
				request.put("BlockRejected4", listBlock2.get(14));
				
			if("0".equals(listBlock2.get(15)))
				request.put("BlockResolved4", " ");
			else
				request.put("BlockResolved4", listBlock2.get(15));
		}
		if(("0".equals(listBlock2.get(16)))&&("0".equals(listBlock2.get(17)))&&("0".equals(listBlock2.get(18)))&&("0".equals(listBlock2.get(19)))){
			request.put("BlockItem5", " ");
			request.put("BlockClose5", " ");
			request.put("BlockPending5", " ");
			request.put("BlockRejected5", " ");
			request.put("BlockResolved5", " ");
		}
		else{	
			request.put("BlockItem5", listBlock1.get(16).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(16)))
				request.put("BlockClose5", " ");
			else
				request.put("BlockClose5", listBlock2.get(16));
			
			
			if("0".equals(listBlock2.get(17)))
				request.put("BlockPending5"," ");
			else
				request.put("BlockPending5", listBlock2.get(17));
			
			if("0".equals(listBlock2.get(18)))
				request.put("BlockRejected5", " ");
			else
				request.put("BlockRejected5", listBlock2.get(18));
				
			if("0".equals(listBlock2.get(19)))
				request.put("BlockResolved5", " ");
			else
				request.put("BlockResolved5", listBlock2.get(19));
		}
		if(("0".equals(listBlock2.get(20)))&&("0".equals(listBlock2.get(21)))&&("0".equals(listBlock2.get(22)))&&("0".equals(listBlock2.get(23)))){
			request.put("BlockItem6", " ");
			request.put("BlockClose6", " ");
			request.put("BlockPending6", " ");
			request.put("BlockRejected6", " ");
			request.put("BlockResolved6", " ");
		}
		else{	
			request.put("BlockItem6", listBlock1.get(20).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(20)))
				request.put("BlockClose6", " ");
			else
				request.put("BlockClose6", listBlock2.get(20));
			
			
			if("0".equals(listBlock2.get(21)))
				request.put("BlockPending6"," ");
			else
				request.put("BlockPending6", listBlock2.get(21));
			
			if("0".equals(listBlock2.get(22)))
				request.put("BlockRejected6", " ");
			else
				request.put("BlockRejected6", listBlock2.get(22));
				
			if("0".equals(listBlock2.get(23)))
				request.put("BlockResolved6", " ");
			else
				request.put("BlockResolved6", listBlock2.get(23));
		}
		if(("0".equals(listBlock2.get(24)))&&("0".equals(listBlock2.get(25)))&&("0".equals(listBlock2.get(26)))&&("0".equals(listBlock2.get(27)))){
			request.put("BlockItem7", " ");
			request.put("BlockClose7", " ");
			request.put("BlockPending7", " ");
			request.put("BlockRejected7", " ");
			request.put("BlockResolved7", " ");
		}
		else{	
			request.put("BlockItem7", listBlock1.get(24).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(24)))
				request.put("BlockClose7", " ");
			else
				request.put("BlockClose7", listBlock2.get(24));
			
			
			if("0".equals(listBlock2.get(25)))
				request.put("BlockPending7"," ");
			else
				request.put("BlockPending7", listBlock2.get(25));
			System.out.println( listBlock2.get(25));
			
			if("0".equals(listBlock2.get(26)))
				request.put("BlockRejected7", " ");
			else
				request.put("BlockRejected7", listBlock2.get(26));
				
			if("0".equals(listBlock2.get(27)))
				request.put("BlockResolved7", " ");
			else
				request.put("BlockResolved7", listBlock2.get(27));
			System.out.println( listBlock2.get(27));
		}
		
		if(("0".equals(listBlock2.get(28)))&&("0".equals(listBlock2.get(29)))&&("0".equals(listBlock2.get(30)))&&("0".equals(listBlock2.get(31)))){
			request.put("BlockItem8", " ");
			request.put("BlockClose8", " ");
			request.put("BlockPending8", " ");
			request.put("BlockRejected8", " ");
			request.put("BlockResolved8", " ");
		}
		else{	
			request.put("BlockItem8", listBlock1.get(28).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(28)))
				request.put("BlockClose8", " ");
			else
				request.put("BlockClose8", listBlock2.get(28));
			
			
			if("0".equals(listBlock2.get(29)))
				request.put("BlockPending8"," ");
			else
				request.put("BlockPending8", listBlock2.get(29));
			
			if("0".equals(listBlock2.get(30)))
				request.put("BlockRejected8", " ");
			else
				request.put("BlockRejected8", listBlock2.get(30));
				
			if("0".equals(listBlock2.get(31)))
				request.put("BlockResolved8", " ");
			else
				request.put("BlockResolved8", listBlock2.get(31));
		}
		
		if(("0".equals(listBlock2.get(32)))&&("0".equals(listBlock2.get(33)))&&("0".equals(listBlock2.get(34)))&&("0".equals(listBlock2.get(35)))){
			request.put("BlockItem9", " ");
			request.put("BlockClose9", " ");
			request.put("BlockPending9", " ");
			request.put("BlockRejected9", " ");
			request.put("BlockResolved9", " ");
		}
		else{	
			request.put("BlockItem9", listBlock1.get(32).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(32)))
				request.put("BlockClose9", " ");
			else
				request.put("BlockClose9", listBlock2.get(32));
			
			
			if("0".equals(listBlock2.get(33)))
				request.put("BlockPending9"," ");
			else
				request.put("BlockPending9", listBlock2.get(33));
			
			if("0".equals(listBlock2.get(34)))
				request.put("BlockRejected9", " ");
			else
				request.put("BlockRejected9", listBlock2.get(34));
				
			if("0".equals(listBlock2.get(35)))
				request.put("BlockResolved9", " ");
			else
				request.put("BlockResolved9", listBlock2.get(35));
		}
		
		if(("0".equals(listBlock2.get(36)))&&("0".equals(listBlock2.get(37)))&&("0".equals(listBlock2.get(38)))&&("0".equals(listBlock2.get(39)))){
			request.put("BlockItem10", " ");
			request.put("BlockClose10", " ");
			request.put("BlockPending10", " ");
			request.put("BlockRejected10", " ");
			request.put("BlockResolved10", " ");
		}
		else{	
			request.put("BlockItem10", listBlock1.get(36).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(36)))
				request.put("BlockClose10", " ");
			else
				request.put("BlockClose10", listBlock2.get(36));
			
			
			if("0".equals(listBlock2.get(37)))
				request.put("BlockPending10"," ");
			else
				request.put("BlockPending10", listBlock2.get(37));
			
			if("0".equals(listBlock2.get(38)))
				request.put("BlockRejected10", " ");
			else
				request.put("BlockRejected10", listBlock2.get(38));
				
			if("0".equals(listBlock2.get(39)))
				request.put("BlockResolved10", " ");
			else
				request.put("BlockResolved10", listBlock2.get(39));
		}		
		
		return SUCCESS;
		
	}
	public String searchModel() throws Exception {	
/*		ModelcodesDAO mcd=new ModelcodesDAO();
		Map<Integer,String> ma=mcd.getCodes(request1.getParameter("projectname")); 
		session.put("mapcode",ma);*/
		/*session.put("projectname_session", request1.getParameter("projectname"));*/
		HttpServletRequest request=ServletActionContext.getRequest();
		String projectname= (String)request.getParameter("projectname");	
		request.setAttribute("projectname",projectname);
		return SUCCESS;
	}
	
	public String searchDefect() throws Exception {		
				HttpServletRequest request=ServletActionContext.getRequest();
				String projectname= (String)request.getParameter("projectname");
				//2016-11-25 wuliying add modelname part
				String modelname= (String)request.getParameter("modelname");
				String item= (String)request.getParameter("item");	 //Opened?Total?
				request.setAttribute("projectname",projectname);
				request.setAttribute("modelname",modelname);
				request.setAttribute("item",item);
				return SUCCESS;
	}
	
	//�������ʾ
public String multiSearchCode(){
	
		String pn = request1.getParameter("projectname");
		String pjn = request1.getParameter("pn");
		String miles = request1.getParameter("ms");
		String sdate = request1.getParameter("sd");
		String edate = request1.getParameter("ed");
		String state = request1.getParameter("sta");
		String city = request1.getParameter("sel");
		String curp = request1.getParameter("cur");
		System.out.println("pn:"+pn);
		//System.out.println("cur:"+cur);
		pn=pn.substring(0,pn.length()-1); //ȥ��projectname �����','
		String a[] = pn.split(",");
		ModelcodesDAO mcd=new ModelcodesDAO();
		Map<Integer,String> maa=mcd.getCodes(a[0]);
		for(int i=0;i<a.length;i++){
			Map<Integer,String> mb=mcd.getCodes(a[i]); 
			maa.putAll(mb);
			session.put("mapcode",maa);
		}
		
		session.put("pn", pjn);
		session.put("ms", miles);
		session.put("sd", sdate);
		session.put("ed", edate);
		session.put("sta", state);
		session.put("sel", city);
		session.put("cur", curp);
		session.put("projectname_session", request1.getParameter("projectname"));
		session.put("SWEM_session", request1.getParameter("SWEM"));
		session.put("PVRPlan_session", request1.getParameter("PVRPlan"));
		session.put("PVRActual_session", request1.getParameter("PVRActual"));
		session.put("PRAPlan_session", request1.getParameter("PRAPlan"));
		session.put("PRAActual_session", request1.getParameter("PRAActual"));
		//System.out.println("request1.getParameter("PRAActual")"+request1.getParameter("PRAActual"));
		
		DefactAllDAO dad=new DefactAllDAO();
		List<Integer> listTotal= dad.getAll_type_select_project_multi(pn);
		
		
		request.put("Total", listTotal.get(0));
		request.put("TotalA", listTotal.get(1));
		request.put("TotalB", listTotal.get(2));
		request.put("TotalC", listTotal.get(3));
		request.put("TotalN", listTotal.get(4));
		
		request.put("Total", listTotal.get(0));
		request.put("Opened", listTotal.get(5));
		request.put("Resolved", listTotal.get(6));
		request.put("Closed", listTotal.get(7));
		
		request.put("OpenedA", listTotal.get(8));
		request.put("OpenedB", listTotal.get(9));
		request.put("OpenedC", listTotal.get(10));
		request.put("OpenedN", listTotal.get(11));
		
		request.put("ResolvedA", listTotal.get(12));
		request.put("ResolvedB", listTotal.get(13));
		request.put("ResolvedC", listTotal.get(14));
		request.put("ResolvedN", listTotal.get(15));
		
		request.put("ClosedA", listTotal.get(16));
		request.put("ClosedB", listTotal.get(17));
		request.put("ClosedC", listTotal.get(18));
		request.put("ClosedN", listTotal.get(19));
		
		request.put("SQAPLMTotalDelay", listTotal.get(20));
		request.put("SQAPLMTotalDelay30", listTotal.get(21));
		request.put("SQAPLMTotalDelay60", listTotal.get(22));
		
		request.put("SQAPLMTotalA", listTotal.get(23));
		request.put("SQAPLMOpenedA", listTotal.get(24));
		request.put("SQAPLMResolvedA", listTotal.get(25));
		request.put("SQAPLMClosedA", listTotal.get(26));
		
		request.put("SQAPLMTotalBC", listTotal.get(28));
		request.put("SQAPLMOpenedBC", listTotal.get(29));
		request.put("SQAPLMResolvedBC", listTotal.get(30));
		request.put("SQAPLMClosedBC", listTotal.get(31));
		
		if(listTotal.get(27)!=null)
			{
				
				request.put("SelectDate",listTotal.get(27).toString().substring(0, 4)+"/"+listTotal.get(27).toString().substring(4,6)+"/"+listTotal.get(27).toString().substring(6,8));
			//System.out.println("�����");
			}
		
		List<String> listTotal3= dad.getDailyData_multi(pn);
		
		request.put("Day1", listTotal3.get(0));
		session.put("Day1_session", listTotal3.get(0));
		request.put("Day2", listTotal3.get(1));
		request.put("Day3", listTotal3.get(2));
		request.put("Day4", listTotal3.get(3));
		request.put("Day5", listTotal3.get(4));
		request.put("Day6", listTotal3.get(5));
		request.put("Day7", listTotal3.get(6));
		request.put("Day8", listTotal3.get(7));
		request.put("Day9", listTotal3.get(8));
		request.put("Day10", listTotal3.get(9));
		request.put("Day11", listTotal3.get(10));
		request.put("Day12", listTotal3.get(11));
		request.put("Day13", listTotal3.get(12));
		request.put("Day14", listTotal3.get(13));
		request.put("Day15", listTotal3.get(14));
		request.put("Day16", listTotal3.get(31));
		request.put("Day17", listTotal3.get(32));
		request.put("Day18", listTotal3.get(33));
		request.put("Day19", listTotal3.get(34));
		request.put("Day20", listTotal3.get(35));
		session.put("Day15_session", listTotal3.get(14));
		request.put("ResolveDay1", listTotal3.get(15));
		session.put("ResolveDay1_session", listTotal3.get(15));
		request.put("ResolveDay2", listTotal3.get(16));
		request.put("ResolveDay3", listTotal3.get(17));
		request.put("ResolveDay4", listTotal3.get(18));
		request.put("ResolveDay5", listTotal3.get(19));
		request.put("ResolveDay6", listTotal3.get(20));
		request.put("ResolveDay7", listTotal3.get(21));
		request.put("ResolveDay8", listTotal3.get(22));
		request.put("ResolveDay9", listTotal3.get(23));
		request.put("ResolveDay10", listTotal3.get(24));
		request.put("ResolveDay11", listTotal3.get(25));
		request.put("ResolveDay12", listTotal3.get(26));
		request.put("ResolveDay13", listTotal3.get(27));
		request.put("ResolveDay14", listTotal3.get(28));
		request.put("ResolveDay15", listTotal3.get(29));
		request.put("ResolveDay16", listTotal3.get(36));
		request.put("ResolveDay17", listTotal3.get(37));
		request.put("ResolveDay18", listTotal3.get(38));
		request.put("ResolveDay19", listTotal3.get(39));
		request.put("ResolveDay20", listTotal3.get(40));
		session.put("ResolveDay15_session", listTotal3.get(29));
		//System.out.println("ǰǰǰǰǰǰǰǰǰǰǰǰǰ");
		request.put("7daysselectdate", listTotal3.get(30));
		//System.out.println("ǰǰǰǰǰǰǰǰǰǰǰǰǰ");
		for(int i=0;i<40;i++){
			request.put("Day"+(i+21), listTotal3.get(41+i));
		}
		
		for(int i=0;i<40;i++){
			request.put("ResolveDay"+(i+21), listTotal3.get(81+i));
		}
		request.put("msg_codename", "All");
		request.put("msg_codename", "All");
		
				
		
		Map<String,Integer> map=dad.getAllComponent_multi(pn);
		List<String> listTotal1=new ArrayList<String>();
		List<String> listTotal2=new ArrayList<String>();
		Set<String> keys=map.keySet();
		Iterator<String> iter=keys.iterator();		
		while(iter.hasNext()){
			listTotal1.add(iter.next());
		}
	
		Collection<Integer> values=map.values();
		Iterator<Integer> iter1=values.iterator();
		while(iter1.hasNext()){
			listTotal2.add(iter1.next()+"");
		}
		
		
			
		if(("0".equals(listTotal2.get(0)))&&("0".equals(listTotal2.get(1)))&&("0".equals(listTotal2.get(2)))&&("0".equals(listTotal2.get(3)))){
			request.put("CompItem1", " ");
			request.put("CompClose1", " ");
			request.put("CompPending1", " ");
			request.put("CompRejected1", " ");
			request.put("CompResolved1", " ");
		}
		else{			
			if(listTotal1.get(0).contains("NonSmartClosed"))
				request.put("CompItem1", listTotal1.get(0).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem1", listTotal1.get(0).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(0)))
				request.put("CompClose1", " ");
			else
				request.put("CompClose1", listTotal2.get(0));
			if("0".equals(listTotal2.get(1)))
				request.put("CompPending1", " ");
			else
			request.put("CompPending1", listTotal2.get(1));
			if("0".equals(listTotal2.get(2)))
				request.put("CompRejected1", " ");
			else
				request.put("CompRejected1", listTotal2.get(2));
			if("0".equals(listTotal2.get(3)))
				request.put("CompResolved1", " ");
			else
				request.put("CompResolved1", listTotal2.get(3));
			
		}
		
		
		if(("0".equals(listTotal2.get(4)))&&("0".equals(listTotal2.get(5)))&&("0".equals(listTotal2.get(6)))&&("0".equals(listTotal2.get(7)))){
			request.put("CompItem2", " ");
			request.put("CompClose2", " ");
			request.put("CompPending2", " ");
			request.put("CompRejected2", " ");
			request.put("CompResolved2", " ");
		}
		else{	
			if(listTotal1.get(4).contains("NonSmartClosed"))
				request.put("CompItem2", listTotal1.get(4).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem2", listTotal1.get(4).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(4)))
				request.put("CompClose2", " ");
			else
				request.put("CompClose2", listTotal2.get(4));
			
			if("0".equals(listTotal2.get(5)))
				request.put("CompPending2", " ");
			else
				request.put("CompPending2", listTotal2.get(5));
			
			if("0".equals(listTotal2.get(6)))
				request.put("CompRejected2", " ");
			else
				request.put("CompRejected2", listTotal2.get(6));
			 
			if("0".equals(listTotal2.get(7)))
				request.put("CompResolved2", " ");
			else
				request.put("CompResolved2", listTotal2.get(7));	
			
		}
		
		if(("0".equals(listTotal2.get(8)))&&("0".equals(listTotal2.get(9)))&&("0".equals(listTotal2.get(10)))&&("0".equals(listTotal2.get(11)))){
			request.put("CompItem3", " ");
			request.put("CompClose3", " ");
			request.put("CompPending3", " ");
			request.put("CompRejected3", " ");
			request.put("CompResolved3", " ");
		}
		else{	
			if(listTotal1.get(8).contains("NonSmartClosed"))
				request.put("CompItem3", listTotal1.get(8).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem3", listTotal1.get(8).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(8)))
				request.put("CompClose3", " ");
			else
				request.put("CompClose3", listTotal2.get(8));
			
			if("0".equals(listTotal2.get(9)))
				request.put("CompPending3", " ");
			else
				request.put("CompPending3", listTotal2.get(9));
			
			if("0".equals(listTotal2.get(10)))
				request.put("CompRejected3", " ");
			else
				request.put("CompRejected3", listTotal2.get(10));
			 
			if("0".equals(listTotal2.get(11)))
				request.put("CompResolved3", " ");
			else
				request.put("CompResolved3", listTotal2.get(11));
		}
		
		if(("0".equals(listTotal2.get(12)))&&("0".equals(listTotal2.get(13)))&&("0".equals(listTotal2.get(14)))&&("0".equals(listTotal2.get(15)))){
			request.put("CompItem4", " ");
			request.put("CompClose4", " ");
			request.put("CompPending4", " ");
			request.put("CompRejected4", " ");
			request.put("CompResolved4", " ");
		}
		else{	
			if(listTotal1.get(12).contains("NonSmartClosed"))
				request.put("CompItem4", listTotal1.get(12).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem4", listTotal1.get(12).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(12)))
				request.put("CompClose4", " ");
			else
				request.put("CompClose4", listTotal2.get(12));
			
			if("0".equals(listTotal2.get(13)))
				request.put("CompPending4", " ");
			else
				request.put("CompPending4", listTotal2.get(13));
			
			if("0".equals(listTotal2.get(14)))
				request.put("CompRejected4", " ");
			else
				request.put("CompRejected4", listTotal2.get(14));
			 
			if("0".equals(listTotal2.get(15)))
				request.put("CompResolved4", " ");
			else
				request.put("CompResolved4", listTotal2.get(15));
		}
		
		
		if(("0".equals(listTotal2.get(16)))&&("0".equals(listTotal2.get(17)))&&("0".equals(listTotal2.get(18)))&&("0".equals(listTotal2.get(19)))){
			request.put("CompItem5", " ");
			request.put("CompClose5", " ");
			request.put("CompPending5", " ");
			request.put("CompRejected5", " ");
			request.put("CompResolved5", " ");
		}
		else{	
			if(listTotal1.get(16).contains("NonSmartClosed"))
				request.put("CompItem5", listTotal1.get(16).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem5", listTotal1.get(16).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(16)))
				request.put("CompClose5", " ");
			else
				request.put("CompClose5", listTotal2.get(16));
			
			if("0".equals(listTotal2.get(17)))
				request.put("CompPending5", " ");
			else
				request.put("CompPending5", listTotal2.get(17));
			
			if("0".equals(listTotal2.get(18)))
				request.put("CompRejected5", " ");
			else
				request.put("CompRejected5", listTotal2.get(18));
			 
			if("0".equals(listTotal2.get(19)))
				request.put("CompResolved5", " ");
			else
				request.put("CompResolved5", listTotal2.get(19));
		}
		
		if(("0".equals(listTotal2.get(20)))&&("0".equals(listTotal2.get(21)))&&("0".equals(listTotal2.get(22)))&&("0".equals(listTotal2.get(23)))){
			request.put("CompItem6", " ");
			request.put("CompClose6", " ");
			request.put("CompPending6", " ");
			request.put("CompRejected6", " ");
			request.put("CompResolved6", " ");
		}
		else{	
			if(listTotal1.get(20).contains("NonSmartClosed"))
				request.put("CompItem6", listTotal1.get(20).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem6", listTotal1.get(20).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(20)))
				request.put("CompClose6", " ");
			else
				request.put("CompClose6", listTotal2.get(20));
			
			if("0".equals(listTotal2.get(21)))
				request.put("CompPending6", " ");
			else
				request.put("CompPending6", listTotal2.get(21));
			
			if("0".equals(listTotal2.get(22)))
				request.put("CompRejected6", " ");
			else
				request.put("CompRejected6", listTotal2.get(22));
			 
			if("0".equals(listTotal2.get(23)))
				request.put("CompResolved6", " ");
			else
				request.put("CompResolved6", listTotal2.get(23));
		}
		
		if(("0".equals(listTotal2.get(24)))&&("0".equals(listTotal2.get(25)))&&("0".equals(listTotal2.get(26)))&&("0".equals(listTotal2.get(27)))){
			request.put("CompItem7", " ");
			request.put("CompClose7", " ");
			request.put("CompPending7", " ");
			request.put("CompRejected7", " ");
			request.put("CompResolved7", " ");
		}
		else{	
			if(listTotal1.get(24).contains("NonSmartClosed"))
				request.put("CompItem7", listTotal1.get(24).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem7", listTotal1.get(24).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(24)))
				request.put("CompClose7", " ");
			else
				request.put("CompClose7", listTotal2.get(24));
			
			if("0".equals(listTotal2.get(25)))
				request.put("CompPending7", " ");
			else
				request.put("CompPending7", listTotal2.get(25));
			
			if("0".equals(listTotal2.get(26)))
				request.put("CompRejected7", " ");
			else
				request.put("CompRejected7", listTotal2.get(26));
			 
			if("0".equals(listTotal2.get(27)))
				request.put("CompResolved7", " ");
			else
				request.put("CompResolved7", listTotal2.get(27));
		}
	
		
		if(("0".equals(listTotal2.get(28)))&&("0".equals(listTotal2.get(29)))&&("0".equals(listTotal2.get(30)))&&("0".equals(listTotal2.get(31)))){
			request.put("CompItem8", " ");
			request.put("CompClose8", " ");
			request.put("CompPending8", " ");
			request.put("CompRejected8", " ");
			request.put("CompResolved8", " ");
		}
		else{	
			if(listTotal1.get(28).contains("NonSmartClosed"))
				request.put("CompItem8", listTotal1.get(28).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem8", listTotal1.get(28).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(28)))
				request.put("CompClose8", " ");
			else
				request.put("CompClose8", listTotal2.get(28));
			
			if("0".equals(listTotal2.get(29)))
				request.put("CompPending8", " ");
			else
				request.put("CompPending8", listTotal2.get(29));
			
			if("0".equals(listTotal2.get(30)))
				request.put("CompRejected8", " ");
			else
				request.put("CompRejected8", listTotal2.get(30));
			 
			if("0".equals(listTotal2.get(31)))
				request.put("CompResolved8", " ");
			else
				request.put("CompResolved8", listTotal2.get(31));
		}
		
		if(("0".equals(listTotal2.get(32)))&&("0".equals(listTotal2.get(33)))&&("0".equals(listTotal2.get(34)))&&("0".equals(listTotal2.get(35)))){
			request.put("CompItem9", " ");
			request.put("CompClose9", " ");
			request.put("CompPending9", " ");
			request.put("CompRejected9", " ");
			request.put("CompResolved9", " ");
		}
		else{	
			if(listTotal1.get(32).contains("NonSmartClosed"))
				request.put("CompItem9", listTotal1.get(32).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem9", listTotal1.get(32).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(32)))
				request.put("CompClose9", " ");
			else
				request.put("CompClose9", listTotal2.get(32));
			
			if("0".equals(listTotal2.get(33)))
				request.put("CompPending9", " ");
			else
				request.put("CompPending9", listTotal2.get(33));
			
			if("0".equals(listTotal2.get(34)))
				request.put("CompRejected9", " ");
			else
				request.put("CompRejected9", listTotal2.get(34));
			 
			if("0".equals(listTotal2.get(35)))
				request.put("CompResolved9", " ");
			else
				request.put("CompResolved9", listTotal2.get(35));

		}
		
		if(("0".equals(listTotal2.get(36)))&&("0".equals(listTotal2.get(37)))&&("0".equals(listTotal2.get(38)))&&("0".equals(listTotal2.get(39)))){
			request.put("CompItem10", " ");
			request.put("CompClose10", " ");
			request.put("CompPending10", " ");
			request.put("CompRejected10", " ");
			request.put("CompResolved10", " ");
		}
		else{	
			if(listTotal1.get(36).contains("NonSmartClosed"))
				request.put("CompItem10", listTotal1.get(36).replace("NonSmartClosed", ""));
			else 
				request.put("CompItem10", listTotal1.get(36).replace("Closed", ""));
			
			if("0".equals(listTotal2.get(36)))
				request.put("CompClose10", " ");
			else
				request.put("CompClose10", listTotal2.get(36));
			
			
			if("0".equals(listTotal2.get(37)))
				request.put("CompPending10"," ");
			else
				request.put("CompPending10", listTotal2.get(37));
			
			if("0".equals(listTotal2.get(38)))
				request.put("CompRejected10", " ");
			else
				request.put("CompRejected10", listTotal2.get(38));
				
			if("0".equals(listTotal2.get(39)))
				request.put("CompResolved10", " ");
			else
				request.put("CompResolved10", listTotal2.get(39));
		}
		
		
		
		
		Map<String,Integer> map2= dad.getAllBlock_multi(pn);
		List<String> listBlock1=new ArrayList<String>();
		List<String> listBlock2=new ArrayList<String>();
		
		Set<String> keysBlock=map2.keySet();
		Iterator<String> iterBlock1=keysBlock.iterator();		
		while(iterBlock1.hasNext()){
			listBlock1.add(iterBlock1.next());
		}
	
		Collection<Integer> valuesBlock=map2.values();
		Iterator<Integer> iterBlock2=valuesBlock.iterator();
		while(iterBlock2.hasNext()){
			listBlock2.add(iterBlock2.next()+"");
		}
		System.out.println(listBlock1.get(0)+" "+listBlock2.get(0));
		
		if(("0".equals(listBlock2.get(0)))&&("0".equals(listBlock2.get(1)))&&("0".equals(listBlock2.get(2)))&&("0".equals(listBlock2.get(3)))){
			request.put("BlockItem1", " ");
			request.put("BlockClose1", " ");
			request.put("BlockPending1", " ");
			request.put("BlockRejected1", " ");
			request.put("BlockResolved1", " ");
		}
		else{	
			request.put("BlockItem1", listBlock1.get(0).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(0)))
				request.put("BlockClose1", " ");
			else
				request.put("BlockClose1", listBlock2.get(0));
			
			
			if("0".equals(listBlock2.get(1)))
				request.put("BlockPending1"," ");
			else
				request.put("BlockPending1", listBlock2.get(1));
			
			if("0".equals(listBlock2.get(2)))
				request.put("BlockRejected1", " ");
			else
				request.put("BlockRejected1", listBlock2.get(2));
				
			if("0".equals(listBlock2.get(3)))
				request.put("BlockResolved1", " ");
			else
				request.put("BlockResolved1", listBlock2.get(3));
		}
		
		if(("0".equals(listBlock2.get(4)))&&("0".equals(listBlock2.get(5)))&&("0".equals(listBlock2.get(6)))&&("0".equals(listBlock2.get(7)))){
			request.put("BlockItem2", " ");
			request.put("BlockClose2", " ");
			request.put("BlockPending2", " ");
			request.put("BlockRejected2", " ");
			request.put("BlockResolved2", " ");
		}
		else{	
			request.put("BlockItem2", listBlock1.get(4).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(4)))
				request.put("BlockClose2", " ");
			else
				request.put("BlockClose2", listBlock2.get(4));
			
			
			if("0".equals(listBlock2.get(5)))
				request.put("BlockPending2"," ");
			else
				request.put("BlockPending2", listBlock2.get(5));
			
			if("0".equals(listBlock2.get(6)))
				request.put("BlockRejected2", " ");
			else
				request.put("BlockRejected2", listBlock2.get(6));
				
			if("0".equals(listBlock2.get(7)))
				request.put("BlockResolved2", " ");
			else
				request.put("BlockResolved2", listBlock2.get(7));
		}
		
		if(("0".equals(listBlock2.get(8)))&&("0".equals(listBlock2.get(9)))&&("0".equals(listBlock2.get(10)))&&("0".equals(listBlock2.get(11)))){
			request.put("BlockItem3", " ");
			request.put("BlockClose3", " ");
			request.put("BlockPending3", " ");
			request.put("BlockRejected3", " ");
			request.put("BlockResolved3", " ");
		}
		else{	
			request.put("BlockItem3", listBlock1.get(8).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(8)))
				request.put("BlockClose3", " ");
			else
				request.put("BlockClose3", listBlock2.get(8));
			
			
			if("0".equals(listBlock2.get(9)))
				request.put("BlockPending3"," ");
			else
				request.put("BlockPending3", listBlock2.get(9));
			
			if("0".equals(listBlock2.get(10)))
				request.put("BlockRejected3", " ");
			else
				request.put("BlockRejected3", listBlock2.get(10));
				
			if("0".equals(listBlock2.get(11)))
				request.put("BlockResolved3", " ");
			else
				request.put("BlockResolved3", listBlock2.get(11));
		}
		
		if(("0".equals(listBlock2.get(12)))&&("0".equals(listBlock2.get(13)))&&("0".equals(listBlock2.get(14)))&&("0".equals(listBlock2.get(15)))){
			request.put("BlockItem4", " ");
			request.put("BlockClose4", " ");
			request.put("BlockPending4", " ");
			request.put("BlockRejected4", " ");
			request.put("BlockResolved4", " ");
		}
		else{	
			request.put("BlockItem4", listBlock1.get(12).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(12)))
				request.put("BlockClose4", " ");
			else
				request.put("BlockClose4", listBlock2.get(12));
			
			
			if("0".equals(listBlock2.get(13)))
				request.put("BlockPending4"," ");
			else
				request.put("BlockPending4", listBlock2.get(13));
			
			if("0".equals(listBlock2.get(14)))
				request.put("BlockRejected4", " ");
			else
				request.put("BlockRejected4", listBlock2.get(14));
				
			if("0".equals(listBlock2.get(15)))
				request.put("BlockResolved4", " ");
			else
				request.put("BlockResolved4", listBlock2.get(15));
		}
		if(("0".equals(listBlock2.get(16)))&&("0".equals(listBlock2.get(17)))&&("0".equals(listBlock2.get(18)))&&("0".equals(listBlock2.get(19)))){
			request.put("BlockItem5", " ");
			request.put("BlockClose5", " ");
			request.put("BlockPending5", " ");
			request.put("BlockRejected5", " ");
			request.put("BlockResolved5", " ");
		}
		else{	
			request.put("BlockItem5", listBlock1.get(16).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(16)))
				request.put("BlockClose5", " ");
			else
				request.put("BlockClose5", listBlock2.get(16));
			
			
			if("0".equals(listBlock2.get(17)))
				request.put("BlockPending5"," ");
			else
				request.put("BlockPending5", listBlock2.get(17));
			
			if("0".equals(listBlock2.get(18)))
				request.put("BlockRejected5", " ");
			else
				request.put("BlockRejected5", listBlock2.get(18));
				
			if("0".equals(listBlock2.get(19)))
				request.put("BlockResolved5", " ");
			else
				request.put("BlockResolved5", listBlock2.get(19));
		}
		if(("0".equals(listBlock2.get(20)))&&("0".equals(listBlock2.get(21)))&&("0".equals(listBlock2.get(22)))&&("0".equals(listBlock2.get(23)))){
			request.put("BlockItem6", " ");
			request.put("BlockClose6", " ");
			request.put("BlockPending6", " ");
			request.put("BlockRejected6", " ");
			request.put("BlockResolved6", " ");
		}
		else{	
			request.put("BlockItem6", listBlock1.get(20).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(20)))
				request.put("BlockClose6", " ");
			else
				request.put("BlockClose6", listBlock2.get(20));
			
			
			if("0".equals(listBlock2.get(21)))
				request.put("BlockPending6"," ");
			else
				request.put("BlockPending6", listBlock2.get(21));
			
			if("0".equals(listBlock2.get(22)))
				request.put("BlockRejected6", " ");
			else
				request.put("BlockRejected6", listBlock2.get(22));
				
			if("0".equals(listBlock2.get(23)))
				request.put("BlockResolved6", " ");
			else
				request.put("BlockResolved6", listBlock2.get(23));
		}
		if(("0".equals(listBlock2.get(24)))&&("0".equals(listBlock2.get(25)))&&("0".equals(listBlock2.get(26)))&&("0".equals(listBlock2.get(27)))){
			request.put("BlockItem7", " ");
			request.put("BlockClose7", " ");
			request.put("BlockPending7", " ");
			request.put("BlockRejected7", " ");
			request.put("BlockResolved7", " ");
		}
		else{	
			request.put("BlockItem7", listBlock1.get(24).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(24)))
				request.put("BlockClose7", " ");
			else
				request.put("BlockClose7", listBlock2.get(24));
			
			
			if("0".equals(listBlock2.get(25)))
				request.put("BlockPending7"," ");
			else
				request.put("BlockPending7", listBlock2.get(25));
			System.out.println( listBlock2.get(25));
			
			if("0".equals(listBlock2.get(26)))
				request.put("BlockRejected7", " ");
			else
				request.put("BlockRejected7", listBlock2.get(26));
				
			if("0".equals(listBlock2.get(27)))
				request.put("BlockResolved7", " ");
			else
				request.put("BlockResolved7", listBlock2.get(27));
			System.out.println( listBlock2.get(27));
		}
		
		if(("0".equals(listBlock2.get(28)))&&("0".equals(listBlock2.get(29)))&&("0".equals(listBlock2.get(30)))&&("0".equals(listBlock2.get(31)))){
			request.put("BlockItem8", " ");
			request.put("BlockClose8", " ");
			request.put("BlockPending8", " ");
			request.put("BlockRejected8", " ");
			request.put("BlockResolved8", " ");
		}
		else{	
			request.put("BlockItem8", listBlock1.get(28).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(28)))
				request.put("BlockClose8", " ");
			else
				request.put("BlockClose8", listBlock2.get(28));
			
			
			if("0".equals(listBlock2.get(29)))
				request.put("BlockPending8"," ");
			else
				request.put("BlockPending8", listBlock2.get(29));
			
			if("0".equals(listBlock2.get(30)))
				request.put("BlockRejected8", " ");
			else
				request.put("BlockRejected8", listBlock2.get(30));
				
			if("0".equals(listBlock2.get(31)))
				request.put("BlockResolved8", " ");
			else
				request.put("BlockResolved8", listBlock2.get(31));
		}
		
		if(("0".equals(listBlock2.get(32)))&&("0".equals(listBlock2.get(33)))&&("0".equals(listBlock2.get(34)))&&("0".equals(listBlock2.get(35)))){
			request.put("BlockItem9", " ");
			request.put("BlockClose9", " ");
			request.put("BlockPending9", " ");
			request.put("BlockRejected9", " ");
			request.put("BlockResolved9", " ");
		}
		else{	
			request.put("BlockItem9", listBlock1.get(32).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(32)))
				request.put("BlockClose9", " ");
			else
				request.put("BlockClose9", listBlock2.get(32));
			
			
			if("0".equals(listBlock2.get(33)))
				request.put("BlockPending9"," ");
			else
				request.put("BlockPending9", listBlock2.get(33));
			
			if("0".equals(listBlock2.get(34)))
				request.put("BlockRejected9", " ");
			else
				request.put("BlockRejected9", listBlock2.get(34));
				
			if("0".equals(listBlock2.get(35)))
				request.put("BlockResolved9", " ");
			else
				request.put("BlockResolved9", listBlock2.get(35));
		}
		
		if(("0".equals(listBlock2.get(36)))&&("0".equals(listBlock2.get(37)))&&("0".equals(listBlock2.get(38)))&&("0".equals(listBlock2.get(39)))){
			request.put("BlockItem10", " ");
			request.put("BlockClose10", " ");
			request.put("BlockPending10", " ");
			request.put("BlockRejected10", " ");
			request.put("BlockResolved10", " ");
		}
		else{	
			request.put("BlockItem10", listBlock1.get(36).replace("Closed", ""));
			
			if("0".equals(listBlock2.get(36)))
				request.put("BlockClose10", " ");
			else
				request.put("BlockClose10", listBlock2.get(36));
			
			
			if("0".equals(listBlock2.get(37)))
				request.put("BlockPending10"," ");
			else
				request.put("BlockPending10", listBlock2.get(37));
			
			if("0".equals(listBlock2.get(38)))
				request.put("BlockRejected10", " ");
			else
				request.put("BlockRejected10", listBlock2.get(38));
				
			if("0".equals(listBlock2.get(39)))
				request.put("BlockResolved10", " ");
			else
				request.put("BlockResolved10", listBlock2.get(39));
		}
		
		return SUCCESS;
		
	}
	

	
	public String selectCode()
	{
		
		SelectCodeDAO sdao=new SelectCodeDAO();
		Map<Integer,String> map1=sdao.getCodes(mc);
		//map1.
		
		Iterator<Entry<Integer, String>> iter=map1.entrySet().iterator();
		while(iter.hasNext()){
			Map.Entry<Integer, String> entry=iter.next();
			String val=entry.getValue();
			System.out.println("???????????!!!!!!!!!!!!!"+val);
		}
		//System.out.println("???????????!!!!!!!!!!!!!"+map1.get(2));
		//return SUCCESS;
		return SUCCESS;
	}
	
	public String login_select()
	{
		/*if(uld.usersLogin(user))
		{
			
			ModelDAO moddao=new ModelDAO();
			List<String>mainModels=moddao.getmainModels(user.getRoleid());
			session.put("mainModels", mainModels);*/
			
			DefactAllDAO dad=new DefactAllDAO();
			List<Integer> listTotal2= dad.getAll_select(mc);
			//foreach(Integer s in listTotal1)
	          //{
	            // Console.WriteLine(s);
	           //}
			//System.out.println("mc codeid��"+mc.getCodeid());
			//System.out.println("Total ����㣺"+listTotal2.get(0));
			
			
			request.put("Total", listTotal2.get(0));
			request.put("TotalA", listTotal2.get(1));
			request.put("TotalB", listTotal2.get(2));
			request.put("TotalC", listTotal2.get(3));
			request.put("TotalN", listTotal2.get(4));
			
			List<Integer> listTotal21= dad.getAll_type_select(mc);
			
			List<String> listTotal3 =dad.getDateSelect(mc);
			//foreach(Integer s in listTotal1)
	          //{
	            // Console.WriteLine(s);
	           //}
			//System.out.println("mc codeid��"+mc.getCodeid());
			//System.out.println("Total ����㣺"+listTotal21.get(0));
			
			
			request.put("Total", listTotal21.get(0));
			request.put("Opened", listTotal21.get(1));
			request.put("Resolved", listTotal21.get(2));
			request.put("Closed", listTotal21.get(3));
			
			request.put("OpenedA", listTotal21.get(4));
			request.put("OpenedB", listTotal21.get(5));
			request.put("OpenedC", listTotal21.get(6));
			request.put("OpenedN", listTotal21.get(7));
			
			request.put("ResolvedA", listTotal21.get(8));
			request.put("ResolvedB", listTotal21.get(9));
			request.put("ResolvedC", listTotal21.get(10));
			request.put("ResolvedN", listTotal21.get(11));
			
			request.put("ClosedA", listTotal21.get(12));
			request.put("ClosedB", listTotal21.get(13));
			request.put("ClosedC", listTotal21.get(14));
			request.put("ClosedN", listTotal21.get(15));
			
			request.put("SQAPLMTotalDelay", listTotal21.get(16));
			request.put("SQAPLMTotalDelay30", listTotal21.get(17));
			request.put("SQAPLMTotalDelay60", listTotal21.get(18));
			
			request.put("SQAPLMTotalA", listTotal21.get(19));
			request.put("SQAPLMOpenedA", listTotal21.get(20));
			request.put("SQAPLMResolvedA", listTotal21.get(21));
			request.put("SQAPLMClosedA", listTotal21.get(22));
			
			request.put("SQAPLMTotalBC", listTotal21.get(24));
			request.put("SQAPLMOpenedBC", listTotal21.get(25));
			request.put("SQAPLMResolvedBC", listTotal21.get(26));
			request.put("SQAPLMClosedBC", listTotal21.get(27));
			
			if(listTotal21.get(23)!=null)
				{
					request.put("SelectDate",listTotal21.get(23).toString().substring(0, 4)+"/"+listTotal21.get(23).toString().substring(4,6)+"/"+listTotal21.get(23).toString().substring(6,8));
				}
				//System.out.println("8888888888"+listTotal21.get(23).toString().substring(0, 4)+"/"+listTotal21.get(23).toString().substring(5,7)+"/"+listTotal21.get(23).toString().substring(8,10));
			//�����������
			
			int count=0;//��¼����ݵ���Ŀ
			System.out.println("�����������"+dad.isDataNull(1, mc));
			if(dad.isDataNull(6, mc)){
				request.put("Total_Date_0", listTotal3.get(count));
				request.put("Total_unclosed_0", (Integer.parseInt(listTotal3.get(count))-Integer.parseInt(listTotal3.get(count+1)))+"");
				request.put("SelectDate_0", listTotal3.get(count+2));
				count++;
			}
			else
			{
				request.put("Total_Date_1", 0);
				request.put("Total_unclosed_1", 0);
				request.put("SelectDate_1", "*");
			}
			
			if(dad.isDataNull(5, mc)){
				request.put("Total_Date_1", listTotal3.get(count*3));
				request.put("Total_unclosed_1", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_1", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_1", 0);
				request.put("Total_unclosed_1", 0);
				request.put("SelectDate_1", "*");
			}
			
			if(dad.isDataNull(4, mc)){
				request.put("Total_Date_2", listTotal3.get(count*3));
				request.put("Total_unclosed_2", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_2", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_2", 0);
				request.put("Total_unclosed_2", 0);
				request.put("SelectDate_2", "*");
			}
			
			if(dad.isDataNull(3, mc)){
				request.put("Total_Date_3", listTotal3.get(count*3));
				request.put("Total_unclosed_3", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_3", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_3", 0);
				request.put("Total_unclosed_3", 0);
				request.put("SelectDate_3", "*");
			}
			
			if(dad.isDataNull(2, mc)){
				request.put("Total_Date_4", listTotal3.get(count*3));
				request.put("Total_unclosed_4", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_4", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_4", 0);
				request.put("Total_unclosed_4", 0);
				request.put("SelectDate_4", "*");
			}
			
			if(dad.isDataNull(1, mc)){
				request.put("Total_Date_5", listTotal3.get(count*3));
				request.put("Total_unclosed_5", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_5", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_5", 0);
				request.put("Total_unclosed_5", 0);
				request.put("SelectDate_5", "*");
			}
			
			if(dad.isDataNull(0, mc)){
				request.put("Total_Date_6", listTotal3.get(count*3));
				request.put("Total_unclosed_6", (Integer.parseInt(listTotal3.get(count*3))-Integer.parseInt(listTotal3.get(count*3+1)))+"");
				request.put("SelectDate_6", listTotal3.get(count*3+2));
				count++;
			}
			else
			{
				request.put("Total_Date_6", 0);
				request.put("Total_unclosed_6", 0);
				request.put("SelectDate_6", "*");
			}
			
			//System.out.println("@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!"+listTotal3.get(20));
			//.out.println("@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!"+listTotal3.get(2));
			
			
			
			
			request.put("msg_codename", utd.idTOName_model(mc.getProjectid()));
			
			System.out.println("�û���"+user.getUsername());
			System.out.println("���룺"+user.getPassword());
			System.out.print("��¼���ͣ�"+utd.idTOName(user.getRoleid()));
			//if(dao.usersLogin(user))
			{
				//request.put("msg", utd.idTOName(user.getRoleid()));
			}
			return SUCCESS;
		/*}
		else{
			this.addActionMessage("�û�����������");
			return INPUT;
		}*/
	}
	
	public String login_type_select()
	{
		/*if(uld.usersLogin(user))
		{
			
			ModelDAO moddao=new ModelDAO();
			List<String>mainModels=moddao.getmainModels(user.getRoleid());
			session.put("mainModels", mainModels);*/
			
			DefactAllDAO dad=new DefactAllDAO();
			List<Integer> listTotal2= dad.getAll_type_select(mc);
			//foreach(Integer s in listTotal1)
	          //{
	            // Console.WriteLine(s);
	           //}
			//System.out.println("mc codeid��"+mc.getCodeid());
			//System.out.println("Total ����㣺"+listTotal2.get(0));
			
			
			request.put("Total", listTotal2.get(0));
			request.put("Opened", listTotal2.get(1));
			request.put("Resolved", listTotal2.get(2));
			request.put("Closed", listTotal2.get(3));
			
			
			request.put("msg_type_codename", utd.idTOName_model(mc.getCodeid()));
			
			//System.out.println("�û���"+user.getUsername());
			//System.out.println("���룺"+user.getPassword());
			//System.out.print("��¼���ͣ�"+utd.idTOName(user.getRoleid()));
			//if(dao.usersLogin(user))
			{
				//request.put("msg", utd.idTOName(user.getRoleid()));
			}
			return SUCCESS;
		/*}
		else{
			this.addActionMessage("�û�����������");
			return INPUT;
		}*/
	}
	
	public Modelcodes getModel() {
		// TODO Auto-generated method stub
		return mc;
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
	//�Ե�¼������֤
	public void validateLogin()
	{
		if(uld.usersLogin(user)){
			if(!randomCode.equalsIgnoreCase(session.get("randomCode").toString()))
			{
				this.addFieldError("random_error","��֤�벻��ȷ��");
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
