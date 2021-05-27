package com.seoul.home.board;

public class PageSearchVO {
	private int pageNum=1; 		// 현재페이지
	private int onePageNum=5; 	// 한 페이지당 페이지 번호 수
	private int startPageNum=1; // 시작페이지
	private int onePageRecord=6;// 마지막페이지(총페이지수)
	private int totalPage;		// 총 페이지 수
	private int totalRecord;	// 총 레코드 수
	private int lastPageRecord; // 마지막 페이지의 남은 레코드 수
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		
		startPageNum = ((pageNum-1)/onePageNum*onePageNum)+1;
	}
	public int getOnePageNum() {
		return onePageNum;
	}
	public void setOnePageNum(int onePageNum) {
		this.onePageNum = onePageNum;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		totalPage = (int)Math.ceil(totalRecord/(double)onePageRecord);
		lastPageRecord = totalRecord%onePageRecord;
		if(lastPageRecord==0) {
			lastPageRecord = onePageRecord;
		}
	}
	public int getLastPageRecord() {
		return lastPageRecord;
	}
	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}
	
}
