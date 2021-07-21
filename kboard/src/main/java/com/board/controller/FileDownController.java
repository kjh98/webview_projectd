package com.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.domain.BoardVO;
import com.board.service.BoardService;

@Controller
public class FileDownController {
	
	@Inject
	private BoardService BoardService;
     
    @RequestMapping(value = "/board/fileDownload.do")
    public void fileDownload4(@RequestParam("bno") int bno, HttpServletRequest request,HttpServletResponse response) throws Exception {
        //String path =  request.getSession().getServletContext().getRealPath("저장경로");
    	BoardVO vo = BoardService.view(bno);
    	String userfileName = request.getParameter("userfileName");
    	System.out.println("userfileName"+userfileName);
        String filename = request.getParameter("fileName");
        String realFilename="";
        System.out.println("filename"+filename);
         
        try {
            String browser = request.getHeader("User-Agent"); 
            //파일 인코딩 
            if (browser.contains("MSIE") || browser.contains("Trident")
                    || browser.contains("Chrome")) {
                filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+","%20");
                userfileName = URLEncoder.encode(userfileName, "UTF-8").replaceAll("\\+","%20");
            } else {
                filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
                userfileName = new String(userfileName.getBytes("UTF-8"), "ISO-8859-1");
            }
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        realFilename = "D:\\upload" + filename;
        System.out.println("realFilename" + realFilename);
        File file1 = new File(realFilename);
        if (!file1.exists()) {
            return ;
        }
         
        // 파일명 지정        
        response.setContentType("application/octer-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + userfileName + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realFilename);
 
            int ncount = 0;
            byte[] bytes = new byte[512];
 
            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (Exception e) {
            System.out.println("FileNotFoundException : " + e);
        }
    }
}