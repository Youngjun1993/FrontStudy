<%@page import="com.bitcamp.board.BoardVO"%>
<%@page import="com.bitcamp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	li{border-bottom: 1px solid gray; line-height: 50px;}
</style>
</head>
<body>
	<div class="container">
		<%@ include file="/jsp04_include/jspf_header.jspf" %>
		<%
			//레코드번호
			int no = Integer.parseInt(request.getParameter("no"));
			//페이지번호
			int nowNum = Integer.parseInt(request.getParameter("nowNum"));
			//검색키
			String searchKey = request.getParameter("searchKey");
			//검색어
			String searchWord = request.getParameter("searchWord");
			
			BoardDAO dao = new BoardDAO();
			BoardVO vo = dao.getOneSelect(no);
		%>
		<div>
			<h1>글 내용보기</h1>
			<ul>
				<li>번호 : <%=vo.getNo() %></li>
				<li>작성자 : <%=vo.getUserid() %> </li>
				<li>등록일 : <%=vo.getWritedate() %></li>
				<li>조회수 : <%=vo.getHit() %></li>
				<li>글제목 : <%=vo.getSubject() %></li>
				<li>
					글내용<br/>
					<%=vo.getContent() %>
				</li>
			</ul>
			<div>
				<a href="boardList.jsp?nowNum=<%=nowNum%><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);}%>">리스트</a>
				<!-- 글쓴이와 세션에 저장된 로그인 아이디가 같으면 수정, 삭제가능 -->
				<%if(vo.getUserid().equals((String)session.getAttribute("logId"))){ %>
					<a href="">수정</a>
					<a href="">삭제</a>
				<%} %>
			</div>
		</div>		
	</div>
</body>
</html>