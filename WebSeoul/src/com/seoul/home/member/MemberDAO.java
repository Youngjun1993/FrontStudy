package com.seoul.home.member;

import com.seoul.home.DBCPconn;

public class MemberDAO extends DBCPconn implements MemberDAOImpl {
	public static MemberDAO getInstance() {
		return new MemberDAO();
	}
	@Override
	public boolean idCheck(String userid) {
		boolean result = false;
		try {
			DBConn();
			sql = "select userid from registor where userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			System.out.println("아이디중복체크 에러!!");
			e.printStackTrace();
		}finally {
			DBClose();
		}
		return result;
	}

	@Override
	public void loginCheck(MemberVO vo) {
		try {
			DBConn();
			sql ="select username from registor where userid=? and userpwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getUserid());
			pstmt.setString(2, vo.getUserpwd());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setUsername(rs.getString(1));
			}
			
		}catch(Exception e) {
			System.out.println("로그인 에러 발생~~~");
			e.printStackTrace();
		}finally {
			DBClose();
		}
		
	}

}
