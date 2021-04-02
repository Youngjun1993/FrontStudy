package com.bitcamp.home.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bitcamp.home.CommandService;

public class WriteCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 글쓰기폼
		String viewFilename = "";
		
		HttpSession ses = req.getSession();
		String sesUserid = (String)ses.getAttribute("userid");
		
		// 로그인인 경우에는 글쓰기폼으로 이동
		if(sesUserid!=null && !sesUserid.equals("")) {
			viewFilename = "/board/boardForm.jsp";
		// 로그인 안된 경우에는 로그인 폼으로 이동
		}else{
			viewFilename = "/member/login.jsp";
		}
		return viewFilename;
	}

}
