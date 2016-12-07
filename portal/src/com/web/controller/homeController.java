package com.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class homeController {
	
	@RequestMapping("/index")
	public String index(){
		return "/homeController/index";
	}
	@RequestMapping("/top")
	public String top(){
		return "/homeController/top";
	}
	
	@RequestMapping("/bottom")
	public String bottom(){
		return "/homeController/bottom";
	}
	
	@RequestMapping("/left")
	public String left(){
		return "/homeController/left";
	}
	
	@RequestMapping("/right")
	public String right(){
		return "/homeController/right";
	}
	
	@RequestMapping("/download/{fileName:.*}")  
    public void download(@PathVariable("fileName") String fileName,  
            HttpServletRequest request, HttpServletResponse response)  
            throws Exception {  
        response.setContentType("text/html;charset=utf-8");  
        java.io.BufferedInputStream bis = null;  
        java.io.BufferedOutputStream bos = null;  
       /* String ctxPath = request.getSession().getServletContext()  
        		 .getRealPath("/download/training/")  
                 + "/" ; 
        String downLoadPath = ctxPath + fileName;  */
        String ctxPath = request.getSession().getServletContext().getRealPath("/").substring(0, request.getSession().getServletContext().getRealPath("/").lastIndexOf(request.getContextPath().replace("/", "")))+File.separator+"upload"+File.separator+"manual"+File.separator;
        String downLoadPath = ctxPath + fileName;  
        System.out.println(downLoadPath);  
        try {  
            long fileLength = new File(downLoadPath).length();  
            response.setContentType("application/x-msdownload;");  
            response.setHeader("Content-disposition", "attachment; filename="
            		+java.net.URLEncoder.encode(fileName, "UTF-8").replace("+","%20"));
                   // + new String(fileName.getBytes("ISO8859-1"), "utf-8"));  
            response.setHeader("Content-Length", String.valueOf(fileLength));  
            bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
            bos = new BufferedOutputStream(response.getOutputStream());  
            byte[] buff = new byte[2048];  
            int bytesRead;  
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
                bos.write(buff, 0, bytesRead);  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (bis != null)  
                bis.close();  
            if (bos != null)  
                bos.close();  
        }  
    } 
}
