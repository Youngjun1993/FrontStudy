package com.bitcamp.home.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bitcamp.home.CommandService;

public class ListCommand implements CommandService {

	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String pageNumStr = req.getParameter("pageNum");
		PageSearchVO pageVO = new PageSearchVO();
		
		if(pageNumStr != null) {
			// 페이지 번호가 있을 때 숫자화 시키기 (없으면 1이 초기값임!)
			pageVO.setPageNum(Integer.parseInt(pageNumStr));
			// setPageNum 이 되면서 startPageNum이 구해짐~
		}
		
		/* 검색했을때도 리스트 호출이 필요하니까 검색어/검색키 기준 request도 해야행 
		 * 어차피 검색키, 검색어 없으면 null값 출력되니까 걍 request 해부러~ */
		
		pageVO.setSerachKey(req.getParameter("searchKey"));
		pageVO.setSearchWord(req.getParameter("searchWord"));
		
		// 총 레코드 수 구하기
		BoardDAO dao = new BoardDAO();
		pageVO.setTotalRecord(dao.totalRecord(pageVO));
		// setTotalRecord 하면서 총 페이지수랑 마지막 레코드수도 구해졌음!
		
		// 현재 페이지 검색어에 해당하는 레코드를 선택해서 list를 다음페이지로 반환!
		req.setAttribute("list", dao.onePageRecordSelect(pageVO));
		req.setAttribute("pageVO", pageVO);
		
		return "/board/list.jsp";
	}

}
