<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.bitcamp.board.BoardDAO"%>

<!-- 게시판 입력폼에 입력한 데이터를 DB에 저장 -->
<!-- 
	액션태그 중 useBean사용하여 폼데이터 가져오기 
	ㄴ request + vo에 담는다. 단, 폼의 name속성의 값과 vo에 있는 멤버변수명이 같은 데이터끼리 담는다.
-->
<!-- 
	BoardVo vo = new BoardVO();
	즉 class에 적은것(패키지명.클래스명)을 객체로 만들어서 id에 담아준다.
											scope="생명주기" : request, page, session, application : 페이지가 stop될때까지 생성되어있는 기능
											scope="page"는 현재 페이지에 담긴 id(vo)객체가 지워지지 않게 해준다.
 -->
 <% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="vo" class="com.bitcamp.board.BoardVO" scope="page" />
<jsp:setProperty property="*" name="vo"/>

<%
	//session의 글쓴이 아이디를 vo에 대입한다.
	vo.setUserid((String)session.getAttribute("logId"));
	//글쓴이 컴 아이피
	vo.setIp(request.getRemoteAddr());
	
	BoardDAO dao = new BoardDAO();
	int result = dao.insertBoard(vo);
	
	if(result>0){//글등록
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	}else{//글등록 실패
		%>
			<script>
				alert("글등록이 실패하였습니다.");
				history.back();//history.go(-1) 둘중 하나 사용
			</script>
		<%
	}

%>