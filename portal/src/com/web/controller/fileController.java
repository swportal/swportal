package com.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/file")
public class fileController {
	/*@RequestMapping("/upload")
	public String upload(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		if(multipartResolver.isMultipart(request)){
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			Iterator<String> iter = multiRequest.getFileNames();
			if(iter.hasNext()){				
				MultipartFile file = multiRequest.getFile((String)iter.next());
				if(file!=null){
					 	//String fileName="demoUpload"+file.getOriginalFilename();
						String fileName=file.getOriginalFilename()+Math.random();
					    String path = "D:/upload/" + fileName;					    
					    File localFile = new File(path);					    
					    file.transferTo(localFile);
					    file.getInputStream();
				}
			}
		}
		return "/fileController/success"; 
	}*/
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)  
	public String upload(@RequestParam("file") MultipartFile image, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		// 转型为MultipartHttpRequest  
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
        // 根据前台的name名称得到上传的文件  
        MultipartFile file = multipartRequest.getFile("file");  
        // 获得文件名：  
        String realFileName = file.getOriginalFilename();  
        // 获取路径  
        String ctxPath = request.getSession().getServletContext().getRealPath(  
                "/")  
                + "\\" + "download\\";  
        System.out.println("路径" + ctxPath);  
        // 创建文件  
        File dirPath = new File(ctxPath);  
        if (!dirPath.exists()) {  
            dirPath.mkdir();  
        }  
        File uploadFile = new File(ctxPath + realFileName);  
        FileCopyUtils.copy(file.getBytes(), uploadFile);  
        request.setAttribute("files", loadFiles(request));  
        //List<String> a = loadFiles(request);
		return "/fileController/success"; 
	}
	
	@RequestMapping("/download/{fileName:.*}")  
    public void download(@PathVariable("fileName") String fileName,  
            HttpServletRequest request, HttpServletResponse response)  
            throws Exception {  
        response.setContentType("text/html;charset=utf-8");  
        java.io.BufferedInputStream bis = null;  
        java.io.BufferedOutputStream bos = null;  
        String ctxPath = request.getSession().getServletContext()  
                .getRealPath("/")  
                + "\\" + "download\\";  
        String downLoadPath = ctxPath + fileName;  
        System.out.println(downLoadPath);  
        try {  
            long fileLength = new File(downLoadPath).length();  
            response.setContentType("application/x-msdownload;");  
            response.setHeader("Content-disposition", "attachment; filename="
            		+java.net.URLEncoder.encode(fileName, "UTF-8"));
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
	
	public List<String> loadFiles(HttpServletRequest request) {  
        List<String> files = new ArrayList<String>();  
        String ctxPath = request.getSession().getServletContext()  
                .getRealPath("/")  
                + "\\" + "download\\";  
        File file = new File(ctxPath);  
        if (file.exists()) {  
            File[] fs = file.listFiles();  
            String fname = null;  
            for (File f : fs) {  
                if (f.isFile()) {  
                    fname=f.getName();  
                    files.add(fname);  
                }  
            }  
        }  
        return files;  
    }  
	
	@RequestMapping("/toUpload")
	public String toUpload(){
		return "/fileController/upload"; 
	}
	
	
}
