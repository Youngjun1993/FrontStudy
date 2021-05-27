package com.seoul.home;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.seoul.home.board.BoardDAO;
import com.seoul.home.board.PageSearchVO;

public class IndexCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String pageNumStr = req.getParameter("pageNum");
		PageSearchVO pageVO = new PageSearchVO();
		
		if(pageNumStr != null) {
			pageVO.setPageNum(Integer.parseInt(pageNumStr));
		}
		
		BoardDAO dao = new BoardDAO();
		pageVO.setTotalRecord(dao.totalRecord(pageVO));
		
		req.setAttribute("list", dao.onePageRecordSelect(pageVO));
		req.setAttribute("pageVO", pageVO);
		
		return "/index.jsp";
	}

}
