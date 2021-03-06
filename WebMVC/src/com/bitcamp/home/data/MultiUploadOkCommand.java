package com.bitcamp.home.data;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.bitcamp.home.CommandService;

public class MultiUploadOkCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		//저장할 위치
		String path = req.getServletContext().getRealPath("/upload");
		
		try {
			
			//1. 팩토리 객체 생성
			DiskFileItemFactory dfif = new DiskFileItemFactory();
			
			//2. 팩토리 업로드 위치 셋팅
			File f = new File(path);
			dfif.setRepository(f);
			
			//3. ServletFileUpload객체생성
			ServletFileUpload fileUpload = new ServletFileUpload(dfif);
			
			//4. 폼의 필드 수만큼 FileItem을 얻어온다.
			List<FileItem> items = fileUpload.parseRequest(req);
			
			DataVO vo = new DataVO();
			for(FileItem item : items) {
				//텍스트필드인지 첨부파일인지
				if(item.isFormField()) {//제목, 글내용
					String fieldName = item.getFieldName();	//필드명
					String value = item.getString("UTF-8");	//값
					
					if(fieldName.equals("title")) {vo.setTitle(value);}
					if(fieldName.equals("content")) {vo.setContent(value);}
				}else {//파일
					//파일의 크기를 구하여 0보다 크면 업로드 구현
					if(item.getSize() > 0) {//getSize() : 파일크기
						String oriFilename = item.getName();//원래 파일명 aaaa.gif -> aaaa_1.gif -> aaaa_2.gif -> aaaa_3.gif 처럼 _넣고 파일명이 존재할경우 숫자 증가시키기
						
						//파일명과 확장자를 분리
						int dot = oriFilename.lastIndexOf(".");//.의 위치
						String filename = oriFilename.substring(0, dot);
						String ext = oriFilename.substring(dot+1);
						
						File file = new File(path, oriFilename);
						int idx=1;
						while(file.exists()) { // 있으면 true, 없으면 false
							file = new File(path, filename + "_" + idx++ + "." + ext);
						}//while
						
						//업로드 실행
						item.write(file);
					}//if
				}//else
			}//for
			System.out.println("제목->"+vo.getTitle());
			System.out.println("글내용->"+vo.getContent());
			
			
		}catch(Exception e) {
			System.out.println("파일 다중저장 커맨드 에러 ~~~~");
			e.printStackTrace();
		}
		
		return "/index.jsp";
	}

}
