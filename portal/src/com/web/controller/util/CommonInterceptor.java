package com.web.controller.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class CommonInterceptor implements HandlerInterceptor {
	private Log log = LogFactory.getLog(this.getClass());
	@Override
	public void afterCompletion(HttpServletRequest arg0,HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,Object handler, ModelAndView modelAndView) throws Exception {
		log.info("==============执行顺序: 2、postHandle================");   
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.info("==============执行顺序: 1、preHandle================");   
        String requestUri = request.getRequestURI();  
        String contextPath = request.getContextPath();  
        String url = requestUri.substring(contextPath.length());  
        
        log.info("requestUri:"+requestUri);    
        log.info("contextPath:"+contextPath);    
        log.info("url:"+url);    
        //System.out.println(">>>: " + url);
        // 判断路径是登出还是登录验证，是这两者之一的话执行Controller中定义的方法
        if(url.startsWith("/user/logUI") || url.endsWith("/user/logout")) {
            return true;
        }
        
        // 进入登录页面，判断session中是否有key，有的话重定向到首页，否则进入登录界面
        if(url.startsWith("/user/login/")) {        	
            if(request.getSession() != null && request.getSession().getAttribute("usersession") != null) {
            	return true;  
            } 
            else {   
            	response.sendRedirect("/portal/user/logUI");
            	return false;
            }
        }   
        return true;
	}
}
