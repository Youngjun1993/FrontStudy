package com.bitcamp.home.board;

import java.util.List;

public interface BoardDAOService {
	// 레코드 추가 (글쓰기)
	public int oneRecordInsert (BoardVO vo);
	
	// 레코드 선택 (1개선택, 글 내용 보여주기 / 수정폼에서도 이걸로 쓰자~)
	public void oneRecordSelect(BoardVO vo);
		/* 반환형 BoardVO로 써도 됨! 매개변수 vo에 setting 하려고
		 * void 반환형으로 해서 VO 매개변수 쓴거얌~~*/
	
	// 레크도 삭제 (글 지우기)
	public int deleteRecord(int no, String userid);
	
	// 조회수 증가
	public void hitCount(int no);
	
	// 총 레코드 수
	public int totalRecord(PageSearchVO vo);
	
	// 레코드 수정 - update
	public int boardUpdate(BoardVO vo);
	
	// 레코드선택(1page)
	public List<BoardVO> onePageRecordSelect(PageSearchVO vo);
	
	// 글쓴이 선택
	public String getUserid(int no);
}
