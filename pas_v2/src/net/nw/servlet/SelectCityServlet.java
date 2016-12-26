package net.nw.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SelectCityServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public SelectCityServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 response.setContentType("text/xml");
         response.setHeader("Cache-Control", "no-cache");
         String state = request.getParameter("state");
         System.out.println(state+"*********************************************");
         StringBuffer sb=new StringBuffer("<state>");
         if ("spt".equals(state)){
                 sb.append("<city>Basic</city><city>Deriv</city>");
         } else if("pg".equals(state)){
        	 	sb.append("<city>HD</city><city>LM</city><city>MFM</city><city>UT</city><city>QT</city>"); //2016-12-26 wuliying add QT option
         }
         else if("ps".equals(state)){
     	 	sb.append("<city>Normal In Prog.</city><city>Delay in Prog.</city><city>Normal Compl.</city><city>Delay Compl.</city>");
         }
         else if("ms".equals(state)){
      	 	sb.append("<city>PIA</city><city>PVR</city><city>PRA</city><city>SRA</city>");
          }
         /*else if("pl".equals(state)){
      	 	sb.append("<city>jie cao</city><city>Liwei Hou</city><city>Hushan Zhu</city><city>ying hua</city><city>Chen Shi</city><city>liangchen qi</city><city>shuai wang</city><city>YANG GAO</city><city>huanjun wang</city><city>sirui li</city><city>Ting Liu</city><city>Yuhong Zhu</city>");
          }*/
         sb.append("</state>");
         PrintWriter out=response.getWriter();
         out.write(sb.toString());
         out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
