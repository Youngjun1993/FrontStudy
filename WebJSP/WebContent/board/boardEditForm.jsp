<%@page import="com.bitcamp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp04_include/logCheck.jspf" %>
<jsp:useBean id="vo" class="com.bitcamp.board.BoardVO" scope="page"/>
<jsp:setProperty name="vo" property="no" />

<%
	int nowNum = Integer.parseInt(request.getParameter("nowNum"));
	String searchKey = request.getParameter("searchKey");
	String searchWord = request.getParameter("searchWord");
	System.out.println(nowNum+", "+searchKey+", "+searchWord);
	BoardDAO dao = new BoardDAO();
	vo = dao.getOneSelect(vo.getNo(), 2);

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
<script src="//cdn.ckeditor.com/4.16.0/full/ckeditor.js"></script>
<style type="text/css">
	ul,li{margin:0; padding: 0; list-style: none;}
	#subject{width:100%;}
	
</style>
<script type="text/javascript">
	$(function (){
		CKEDITOR.replace("content");
		
		$("#frm").submit(function () {
			if($("#subject").val()==""){
				alert("제목을 입력하세요.");
				return false;
			}
			if(CKEDITOR.instances.content.getData()==""){
				alert("글내용을 입력하세요.");
				return false;
			}
			return true;
		});
	});
</script>
</head>
<body>
	<%@ include file="/jsp04_include/jspf_header.jspf" %>
	<div class="container">
		<h1>글쓰기폼</h1>
		<form method="post" id="frm" action="boardEditOk.jsp?nowNum=<%=nowNum %><%if(searchWord!=null && !searchWord.equals("")){out.write("&searchKey="+searchKey+"&searchWord="+searchWord);}%>">
			<input type="hidden" name="no" value="<%=vo.getNo()%>"/>
			<ul>
				<li>제목</li>
				<li><input type="text" name="subject" id="subject" value="<%=vo.getSubject()%>"/></li>
				<li>글내용</li>
				<li><textarea name="content" id="content"><%=vo.getContent() %></textarea></li>
				<li><input type="submit" value="글수정"/></li>
			</ul>
		</form>
	</div>
</body>
</html>