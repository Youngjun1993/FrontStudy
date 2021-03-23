<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bitcamp.board.BoardVO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</head>
<body>
	<c:set var="dan" value="${6}"/>
	<h1>forEach Tag : 반복문</h1>
	<!-- for(int a=10; a<20; a++) step은 생략시 1씩 증가 -->
	<!-- 				시작값	  최종값		증가값 				-->
	<c:forEach var="i" begin="2" end="9" step="1">
		${dan}*${i} = ${dan*i}<br/>
	</c:forEach>
	
	<!-- 배열 반복문 -->
	<c:set var="arr" value="<%= new int[]{25, 68, 2, 5, 64, 32, 84, 35, 95, 14} %>"/>
	<ol>
		<!-- 알아서 인덱스값만큼 담아준다 -->
		<c:forEach var="n" items="${arr}">
			<li>${n }</li>
		</c:forEach>
	</ol>
	<%
		List<BoardVO> list = new ArrayList<BoardVO>();
		list.add(new BoardVO(1, "jstl테스트"));
		list.add(new BoardVO(2, "연습중"));
		list.add(new BoardVO(3, "forEach로 반복처리"));
		list.add(new BoardVO(4, "컬렉션의 반복처리"));
	%>
	<ul>
		<c:forEach var="ii" items="<%=list%>">
			<!-- VO의 getNO()를 호출 / getSubject()를 호출 -->
			<li>${ii.no} : ${ii.subject}<br/></li>
		</c:forEach>
	</ul>
	<%
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("name", "홍길동");
		hm.put("tel", "010-7896-5858");
		hm.put("addr","서울시 마포구 백범로");
	%>
	<ul>
		<c:forEach var="h" items="<%=hm %>">
			<li>key : ${h.key}, value : ${h.value}</li>
		</c:forEach>
	</ul>
</body>
</html>