package com.seoul.home.board;

import java.util.ArrayList;
import java.util.List;

import com.seoul.home.DBCPconn;

public class BoardDAO extends DBCPconn{
	public int totalRecord(PageSearchVO vo) {
		int totalRecord = 0;
		
		try {
			DBConn();
			sql="select count(no) from board";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalRecord = rs.getInt(1);
			}
			
		}catch(Exception e) {
			System.out.println("총레코드수DAO 에러!!!");
			e.printStackTrace();
		}finally {
			DBClose();
		}
		
		return totalRecord;
	}
	public List<BoardVO> onePageRecordSelect(PageSearchVO vo){
		List<BoardVO> list = new ArrayList<BoardVO>();
		try {
			DBConn();
			sql="select * from (select * from (select no, subject, userid, hit, to_char(writedate, 'yy-mm-dd hh:mi') as writedate from board "
					+ "order by no desc) where rownum<=? order by no asc) where rownum<=? order by no desc";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getPageNum()*vo.getOnePageRecord());
			if(vo.getPageNum()==vo.getTotalPage()) {
				pstmt.setInt(2, vo.getLastPageRecord());
			}else {
				pstmt.setInt(2, vo.getOnePageRecord());
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(new BoardVO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(5), rs.getInt(4)));
			}
		}catch(Exception e) {
			System.out.println("레코드 1페이지 선택 중 에러~~");
			e.printStackTrace();
		}finally {
			DBClose();
		}
		return list;
	}
}
