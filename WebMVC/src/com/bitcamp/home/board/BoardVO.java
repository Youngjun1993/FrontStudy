package com.bitcamp.home.board;

public class BoardVO {
	private int no;
	private String subject;
	private String content;
	private String userid;
	private int hit;
	private String writedate;
	private String ip;
	
	
	public BoardVO() {
		
	}
	// 사용자가 글작성/수정할때 제목,내용만 작성/수정 가능하므로 두개의 매개변수 가진 VO 생성자 필요
	public BoardVO(String subject, String content) {
		this.subject = subject;
		this.content = content;
	}
	// 리스트 출력을 위한 VO 생성
	public BoardVO (int no, String subject, String userid, String writedate, int hit) {
		this.no=no;
		this.subject = subject;
		this.userid = userid;
		this.hit = hit;
		this.writedate = writedate;
	}
	// 글 내용 보여줄때는 ip 빼고는 다 보여주기 때문에 ip를 뺀 나머지를 VO생성자로 만듬
	public BoardVO (int no, String subject, String content, String userid, int hit, String writedate) {
		this.no=no;
		this.subject = subject;
		this.content = content;
		this.userid = userid;
		this.hit = hit;
		this.writedate = writedate;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
}
