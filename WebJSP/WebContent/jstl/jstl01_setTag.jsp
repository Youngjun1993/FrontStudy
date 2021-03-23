<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl을 사용하기 위해서는 지시부를 설정해야 한다. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<h1>set Tag : 변수선언 및 삭제</h1>
	<%
		int a = 200;
		int b = 300;
		
	%>
	<c:set var="num" value="${300}"/>
	<c:set var="num2" value="${a+300}"/>
	<c:set var="username">세종대왕</c:set> <!-- 위와같다 -->
	<c:set var="today" value="<%=new Date() %>"></c:set>
	
	<h1>변수 사용하기</h1>
	a = ${a}<br/>
	b = ${b}<br/>
	num = ${num}<br/>
	num2 = ${num2}<br/>
	username = ${username}<br/>
	today = ${today}<br/>
	
	<h1>변수 삭제</h1>
	<c:remove var="num2" scope="page"/>
	num2 = ${num2}
</body>
</html>