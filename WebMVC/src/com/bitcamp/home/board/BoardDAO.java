package com.bitcamp.home.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bitcamp.home.CommandService;
import com.bitcamp.home.DBCPconn;

public class BoardDAO extends DBCPconn implements CommandService, BoardDAOService {

	@Override
	public int oneRecordInsert(BoardVO vo) {
		int result = 0;
		try {
			getConn();
			sql ="insert into board(no, subject, content, userid, hit, writedate, ip) values(boardsq.nextval, ?, ?, ?, 0, sysdate, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getSubject());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getUserid());
			pstmt.setString(4, vo.getIp());
			
			result = pstmt.executeUpdate();
			System.out.println("insert dao 실행됨");
		}catch(Exception e) {
			System.out.println("글쓰기 에러!!!!");
			e.printStackTrace();
		}finally{
			getClose();
		}
		
		return result;
	}

	@Override
	public void oneRecordSelect(BoardVO vo) {
		try {
			getConn();
			
			sql = "select no, subject, content, userid, writedate, hit from board where no=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getNo());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setUserid(rs.getString(4));
				vo.setWritedate(rs.getString(5));
				vo.setHit(rs.getInt(6));
			}
			
		}catch(Exception e) {
			System.out.println("레코드 선택에러...(1record)");
			e.printStackTrace();
		}finally {
			getClose();
		}

	}

	@Override
	public int deleteRecord(int no, String userid) {
		int result = 0;
		try {
			getConn();
			
			sql = "delete from board where no=? and userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setString(2, userid);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시글 삭제 오류!!!");
			e.printStackTrace();
		}finally {
			getClose();
		}
		return result;
	}

	@Override
	public void hitCount(int no) {
		try {
			getConn();
			
			sql = "update board set hit=hit+1 where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("조회수증가 에러...");
			e.printStackTrace();
		}finally {
			getClose();
		}

	}

	@Override
	public int totalRecord(PageSearchVO vo) {
		int totalRecord = 0;
		try {
			getConn();
			
			sql = "select count(no) from board";
			if(vo.getSearchWord() != null) {
				sql += " where "+vo.getSearchKey()+" like ?";
			}
			
			pstmt = con.prepareStatement(sql);
			if(vo.getSearchWord() != null) {
				pstmt.setString(1, "%"+vo.getSearchWord()+"%");
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalRecord = rs.getInt(1);
			}
			
		} catch(Exception e) {
			System.out.println("총 레코드수 구하는 중 에러!");
			e.printStackTrace();
		} finally {
			getClose();
		}
		return totalRecord;
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		int result = 0;
		try {
			getConn();
			
			sql = "update board set subject=?, content=? where no=? and userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getSubject());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getNo());
			pstmt.setString(4, vo.getUserid());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시판 글수정 에러...");
			e.printStackTrace();
		}finally {
			getClose();
		}
		return result;
	}

	@Override
	public List<BoardVO> onePageRecordSelect(PageSearchVO vo) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		try {
			getConn();
			
			sql = "select * from (select * from (select no, subject, userid, hit, to_char(writedate, 'yy-mm-dd hh:mi') as writedate from board ";
			// 검색어가 있을경우 조건절 추가	
			if (vo.getSearchWord() != null) { 
				sql += " where "+vo.getSearchKey()+" like ?";
			}
			
			sql += " order by no desc) where rownum<=? order by no asc) where rownum<=? order by no desc";
			pstmt = con.prepareStatement(sql);
			
			if(vo.getSearchWord()==null) { // 검색어가 없을 때
				pstmt.setInt(1, vo.getPageNum()*vo.getOnePageRecord());
				if(vo.getPageNum()==vo.getTotalPage()) { // 현재 페이지가 마지막 페이지 일 때
					pstmt.setInt(2, vo.getLastPageRecord());
				} else {
					pstmt.setInt(2, vo.getOnePageRecord());
				}
			} else { // 검색어가 있을 때
				pstmt.setString(1, "%"+vo.getSearchWord()+"%");
				pstmt.setInt(2, vo.getPageNum()*vo.getOnePageRecord());
				if(vo.getPageNum()==vo.getTotalPage()) {
					pstmt.setInt(3, vo.getLastPageRecord());
				} else {
					pstmt.setInt(3, vo.getOnePageRecord());
				}
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) { //			글번호, 			글제목,         userid            writedate			hit
				list.add(new BoardVO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(5), rs.getInt(4)));
			}
			
		} catch(Exception e) {
			System.out.println("레코드 1페이지 선택 중 에러발생!!");
			e.printStackTrace();
		} finally {
			getClose();
		}
		return list;
	}

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getUserid(int no) {
		String userid = "";
		try {
			getConn();
			sql = "select userid from board where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userid=rs.getString(1);
			}
		}catch(Exception e) {
			System.out.println("아이디 선택에러");
			e.printStackTrace();
		}finally {
			getClose();
		}
		return userid;
	}

}
