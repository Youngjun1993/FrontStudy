<%@page import="com.bitcamp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); //클라이언트에서 수정된 내용이 서버(DB)로 전송되면서 한글이 깨지기 때문에 선언해준다.
	
	int nowNum = Integer.parseInt(request.getParameter("nowNum"));
	String searchKey = request.getParameter("searchKey");
	String searchWord = request.getParameter("searchWord");
	System.out.println(nowNum+", "+searchKey+", "+searchWord);
%>
<jsp:useBean id="vo" class="com.bitcamp.board.BoardVO" scope="page"/>
<jsp:setProperty property="*" name="vo"/>

<%
	vo.setUserid((String)session.getAttribute("logId"));
	
	BoardDAO dao = new BoardDAO();
	int result = dao.boardEditOk(vo);
	if(result>0){//수정시
		String url = request.getContextPath()+"/board/boardView.jsp?no="+vo.getNo()+"&nowNum="+nowNum;
		if(searchWord!=null && !searchWord.equals("")){
			url += "&searchKey="+searchKey+"&searchWord="+searchWord;
		}
		%>
		<script>
			location.href="<%=url%>";
		</script>
		<%
	}else{//수정 실패시
		%>
			<script>
				alert("글수정 실패하였습니다.");
				history.back();
			</script>
		<%
	}
%>