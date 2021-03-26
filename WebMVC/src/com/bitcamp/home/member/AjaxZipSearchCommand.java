package com.bitcamp.home.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bitcamp.home.CommandService;

public class AjaxZipSearchCommand implements CommandService {

	@Override
	public String processStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String doro = req.getParameter("doro");
		//DB검색
		MemberDAO dao = MemberDAO.getInstance();
		List<ZipCodeVO> list = dao.zipcodeSearchSelect(doro);
		req.setAttribute("list", list);
		return "/member/AjaxZipList.jsp";
	}

}
