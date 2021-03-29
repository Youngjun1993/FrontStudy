package com.bitcamp.home.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bitcamp.home.CommandService;

public class LoginOkCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		MemberVO vo = new MemberVO();
		vo.setUserid(req.getParameter("userid"));
		vo.setUserpwd(req.getParameter("userpwd"));
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.loginCheck(vo);
		
		//로그인 성공시 session에 필요한 데이터 저장
		if(vo.getUsername()!=null && !vo.getUsername().equals("")) {
			HttpSession ses = req.getSession(); //세션생성
			ses.setAttribute("userid", vo.getUserid()); //세션에 userid라는 변수를 만들어 접속한 id 저장
			ses.setAttribute("username", vo.getUsername());
		}else {
			
		}
		
		req.setAttribute("vo", vo);
		return "/member/loginOk.jsp";
	}

}
