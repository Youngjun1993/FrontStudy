package com.bitcamp.home.board;

public class PageSearchVO {
	// 현재페이지
	private int pageNum=1;
	// 한 페이지당 페이지 번호 수
	private int onePageNum=5;
	// 시작페이지
	private int startPageNum=1;
	//  한 페이지당 레코드 수
	private int onePageRecord=6;
	// 마지막페이지 (총페이지수)
	private int totalPage;
	// 총 레코드 수
	private int totalRecord;
	// 마지막 페이지의 남은 레코드 수
	private int lastPageRecord;
	// 검색키
	private String searchKey;
	// 검색어
	private String searchWord;

	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		// 현재 페이지 번호에 따라서 시작페이지 번호를 계산, 세팅!
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
		/* 총 레코드수가 구해질 때 총 페이지 수를 구함 (총레코드/한페이지에 보여줄record)
		totalRecord 와 onePageRecord 중 하나를 실수로 잡아서 올림처리 (int 형변환) => 하나라도 넘치면 다음페이지 생성하기 위함*/
		totalPage = (int) Math.ceil (totalRecord / (double)onePageRecord);
		/* 마지막페이지 레코드 수도 구함 */
		lastPageRecord = totalRecord%onePageRecord;
		if(lastPageRecord==0) {
			// 나머지가0이면 마지막페이지 레코드 = 한페이지 출력레코드 수 (뒷페이지로 넘어갈 수 없이 딱맞으니까!)
			lastPageRecord = onePageRecord;
		} 
	}
	public int getLastPageRecord() {
		return lastPageRecord;
	}
	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
