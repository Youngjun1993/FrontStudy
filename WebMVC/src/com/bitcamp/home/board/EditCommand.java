package com.bitcamp.home.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bitcamp.home.CommandService;

public class EditCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		BoardVO vo = new BoardVO();
		PageSearchVO pVO = new PageSearchVO();
		
		vo.setNo(Integer.parseInt(req.getParameter("no"))); //레코드번호
		
		pVO.setPageNum(Integer.parseInt(req.getParameter("pageNum"))); //페이지번호
		pVO.setSearchKey(req.getParameter("searchKey"));//검색키
		pVO.setSearchWord(req.getParameter("searchWord"));//검색어
		
		BoardDAO dao = new BoardDAO();
		dao.oneRecordSelect(vo);
		
		req.setAttribute("vo", vo);
		req.setAttribute("pVO", pVO);
		
		return "/board/boardEdit.jsp";
	}

}
