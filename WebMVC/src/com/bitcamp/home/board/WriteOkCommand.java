package com.bitcamp.home.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bitcamp.home.CommandService;
import com.bitcamp.home.member.MemberDAO;

public class WriteOkCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession ses = req.getSession();
		String sesUserid = (String)ses.getAttribute("userid");
		String viewFilename = "";
		
		//로그인 일때
		if(sesUserid!=null && !sesUserid.equals("")) {
			req.setCharacterEncoding("UTF-8");
			
			BoardVO vo = new BoardVO();
			vo.setSubject(req.getParameter("subject"));
			vo.setContent(req.getParameter("content"));
			
			vo.setUserid(sesUserid);
			vo.setIp(req.getRemoteAddr());
			
			//DB
			
			BoardDAO dao = new BoardDAO();
			int rec = dao.oneRecordInsert(vo);
			
			req.setAttribute("result", rec);
			
			viewFilename = "/board/writeOk.jsp";
		//로그인 아닐때
		}else {
			viewFilename = "/member/login.jsp";
		}
		
		return viewFilename;
	}

}
