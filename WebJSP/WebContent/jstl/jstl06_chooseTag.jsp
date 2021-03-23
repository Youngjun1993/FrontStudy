<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<h1>choose태그 : </h1>
	
	<c:choose>
		<%-- test속성에 조건이 들어가며 참일경우 해당 영역 실행 --%>	
		<c:when test="${param.username=='홍길동'}">
			당신의 이름은 ${param.uesrname}입니다.<br/>
		</c:when>
		<c:when test="${param.age>=20}">
			당신의 나이는 20세이상입니다.<br/>
		</c:when>
		<%-- otherwise : 그 외인경우(즉 아무런 조건에 해당하지 않는경우) --%>
		<c:otherwise>
			당신의 이름은 홍길동이 아니고, 20세 이상도 아닙니다.
		</c:otherwise>
	</c:choose>
</body>
</html>