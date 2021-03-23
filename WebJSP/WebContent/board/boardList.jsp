<%@page import="com.bitcamp.board.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.bitcamp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<style type="text/css">
	ul, li{margin:0; padding:0; list-style: none;}
	#boardList>li{
		float: left;
		width: 10%;
		height: 40px;
		line-height: 40px;
		border-bottom: 1px solid gray;
	}
	/* 제목 : 55% */
	#boardList>li:nth-child(5n+2) {
		width:55%; 
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	/* 작성일 : 15% */
	#boardList>li:nth-child(5n+4) {
		width:15%;
	}
</style>
<script>
	$(function(){
		$("#searchFrm").submit(function(){
			if($("#searchWord").val()==""){
				alert("검색어를 입력후 검색하세요~");
				return false;
			}
			return true;
		});
	});
</script>
</head>
<body>
	<%@ include file ="/jsp04_include/jspf_header.jspf" %>
	<%
		//총레코드수 (BoardDAO.java)
		BoardDAO dao = new BoardDAO();
	
		//검색어
		String searchKey = request.getParameter("searchKey");
		String searchWord = request.getParameter("searchWord");
		
		System.out.println("searchKey="+searchKey + ", searchWord="+ searchWord);
		
		int totalRecord = dao.totalRecord(searchKey, searchWord); // 총레코드수
		int onePageRecord = 5; //한페이지당 출력할 레코드수
		int onePageSize = 5; //한번에 표시할 페이지수
		//현재페이지 번호
		String nowNumStr = request.getParameter("nowNum"); // null, "4"
		int nowNum = 1;
		if(nowNumStr != null && !nowNumStr.equals("")){
			//전송받은 페이지 번호가 있다.
			nowNum = Integer.parseInt(nowNumStr);
		}else{ // 생략해도 되는 부분 (전송받은 페이지 번호가 없을경우 어차피 nowNum의 초기값은 1이기 때문)
			//전송받은 페이지 번호가 없다.
			nowNum = 1;
		}
		
		//총페이지수
		int totalpage = (int)Math.ceil(totalRecord / (double)onePageRecord); //7.9 -> 8.0  
		
		//레코드 선택							현재페이지, 한페이지당 출력할 레코드수, 총 레코드수, 총 페이지수
		List<BoardVO> list = dao.selectRecord(nowNum, onePageRecord , totalRecord, totalpage, searchKey, searchWord);
	%>
	<div class="container">
		<h1>게시판목록</h1>
		<div>총레코드 수 : <%=totalRecord %>, page : <%=nowNum %>/<%=totalpage %>page</div>
		<ul id="boardList">
			<li>번호</li>
			<li>제목</li>
			<li>작성자</li>
			<li>작성일</li>
			<li>조회수</li>
			<% 
				for(int i=0; i<list.size(); i++){ 
					BoardVO vo = list.get(i);
			%>
				<li><%=vo.getNo() %></li>
				<li><a href="<%=request.getContextPath() %>/board/boardView.jsp?no=<%=vo.getNo()%>&nowNum=<%=nowNum%><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>"><%=vo.getSubject() %></a></li>
				<li><%=vo.getUserid() %></li>
				<li><%=vo.getWritedate() %></li>
				<li><%=vo.getHit() %></li>
			<% }%>
		</ul>
		<div>
			<%
				String logStatus = (String)session.getAttribute("logStatus"); //Y or null,""
				if(logStatus != null && logStatus.equals("Y")){
			%>
			<a href="<%=request.getContextPath()%>/board/boardWriteForm.jsp">글쓰기</a>
			<%
				}
			%>
		</div>
		<div>
			<%//((현재페이지-1)/출력페이지수 * 출력페이지수)+1
			int startPage = ((nowNum-1)/onePageSize*onePageSize)+1;%>
			
			<ul class="breadcrumb pagination-md">
			<%if(nowNum>1){%>
				<!-- 버튼 누르면 전페이지 이동하기 -->
				<li class="page-item"><a href="boardList.jsp?nowNum=<%=nowNum-1 %><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>" class="page-link">Prev</a></li>	
			<%}else{%>
				<!-- 1페이지라면 해당버튼 비활성화 -->
				<li class="page-item disabled"><a href="#" class="page-link">Prev</a></li>
            <%} %>
            
            <% //페이지 번호							
            for(int p=startPage; p<startPage+onePageSize; p++){
            	if(p<=totalpage){//페이지 넘버 출력 컨트롤
	            	if(nowNum==p){ //현재 보고있는 페이지
	            %>
	           		<li class="page-item active"><a href="boardList.jsp?nowNum=<%=p %><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>" class="page-link"><%=p %></a></li>
	           		
	            <%
	            	}else{
	            %>
	            	<li class="page-item"><a href="boardList.jsp?nowNum=<%=p %><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>" class="page-link"><%=p %></a></li>
	            <%
	            	}
            	}//totalPage
            }
            
            if(nowNum==totalpage){ //마지막페이지 
            %>
            	<!-- 마지막페이지에서 next버튼 비활성화 -->
            	<li class="page-item disabled"><a href="#" class="page-link">Next</a></li>
            <%}else{ %>
            	<!-- 마지막페이지가 아니라면 next버튼 활성화 및 클릭시 다음페이지 이동 -->
            	<li class="page-item"><a href="boardList.jsp?nowNum=<%=nowNum+1 %><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);} %>" class="page-link">Next</a></li>
            <%} %>
        </ul>
		</div>
		<div>
			<form method="post" id="searchFrm" action="<%=request.getContextPath() %>/board/boardList.jsp">
				<select name="searchKey">
					<option value="subject">제목</option>
					<option value="userid">작성자</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchWord" id="searchWord"/>
				<input type="submit" value="Search..."/>
			</form>
		</div>
	</div>
</body>
</html>