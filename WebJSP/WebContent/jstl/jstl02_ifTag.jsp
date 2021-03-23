<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ page trimDirectiveWhitespaces="true" %>
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
	<h1>if tag : 조건문</h1>
	<c:set var="n1" value="${12}" />
	<c:set var="n2" value="${5 }"/>
	<!-- test속성에 조건식을 쓴다 / else if는 없다. -->
	<c:if test="${n1>n2}">
		n1은 n2보다 크다.
	</c:if>
	<c:if test="${n2>n1 }">
		n2가 n1보다 크다.
	</c:if>
	<!-- jstl에서 request처리하기 -->
	<%
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"))+10;
		
	%>
	이름 = <%=name %><br/>
	나이 = <%=age %><br/>
	
	<hr/>
	<!-- jstl로 request하기 -->
	이름 = ${param.name}<br/>
	나이 = ${param.age + 10}<br/> <!-- 형변환도 알아서 해준다.(29번째 라인 jsp의 형변환과 비교) -->
</body>
</html>