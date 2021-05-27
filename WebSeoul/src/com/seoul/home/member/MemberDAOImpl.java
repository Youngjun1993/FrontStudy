package com.seoul.home.member;

public interface MemberDAOImpl {
	//아이디 중복검사
	public boolean idCheck(String userid);
	//로그인
	public void loginCheck(MemberVO vo);
	
}
