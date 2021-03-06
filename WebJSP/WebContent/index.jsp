<!-- 지시부(이페이지는 아래 속성과 같이 실행하라는 코드) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 임폴트하는 방법 -->
<%@ page import="java.util.Calendar, java.util.Scanner" %>
<%@ page import="java.util.Random" %>
<%@ page trimDirectiveWhitespaces="true" %><!-- jsp 코드 빈자리 제거  -->
<%!
	//선언부
	//메소드 또는 변수 선언
	//*메소드는 반드시 선언부에서 선언해야 한다.
	public int sum(int a, int b){
		int hap = a + b;
		return hap;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	h1{background:pink;}
</style>
<script type="text/javascript">
	//document.write("javascript....")
</script>
</head>
<body>
	<%@ include file="jsp04_include/jspf_header.jspf" %>
	<h2>session.ID : <%=session.getId() %></h2> <!-- session id값 구하기(이메일 인증에 가끔 사용된다) -->
	
	<h1>JSP Start......</h1>
	<%
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);	//년
		int month = now.get(Calendar.MONTH)+1;	//월
		int day = now.get(Calendar.DAY_OF_MONTH);	//일
	%>
	<h1>오늘은<%=year %>년 <%=month %>월 <%=day %>일입니다.</h1>
	<hr/>
	<h1>jstl태그</h1>
	<!--
		http://archive.apache.org/dist/jakarta/taglibs/standard/에서 jakarta-taglibs-standard-1.1.2.zip를 다운로드 후
		
		현재 프로젝트의 WEB-INF/lib에 jstl.jar, standard.jar를 복사한다.
	 -->
	<ol>
		<li><a href="jstl/jstl01_setTag.jsp">set Tag : 변수의 선언 및 삭제</a></li>
		<li><a href="jstl/jstl02_ifTag.jsp?name=이순신&age=28">if Tag : 조건문</a></li>
		<li><a href="jstl/jstl03_forEachTag.jsp">forEach Tag : 반복문</a></li>
		<li><a href="jstl/jstl04_forTokensTag.jsp">forTokens Tag : 문자열 조각내기</a></li>
		<li><a href="jstl/jstl05_urlTag.jsp">url Tag : 문자열 조각내기</a></li>
		<li><a href="jstl/jstl06_chooseTag.jsp?username=홍길동&age=25">choose Tag : if~else, switch</a></li>
		<li><a href="jstl/jstl07_redirectTag.jsp">redirect Tag</a></li>
	</ol>
	<!-- JSP코드는 %로 묶어서 실행하고 해당 영역은 자바영역이 된다. -->
	<%	
		// 이와같이 html에 java를 추가해서 사용하는 공간을 스크립트릿 이라고 한다.
		int a = 1234;
		int b = 5678;
		String name = "홍길동";
		//out내장객체 : client에게 정보를 보냄(response)
		out.write(name);
		int result = sum(a, b);
		out.write("<br/>result="+result);
		out.write("<br/>"+a+"+"+b+"="+sum(a,b));
		
	%>
	<br />
	<!-- %옆에 =이 out.write의 역할을 해준다.(단순 변수만 호출할때 자주 사용한다) -->
	<%=a+4 %>-
	<%=b %>=
	<%=sum(a,b) %> 
	
	
	<hr />
	<%
		out.write("<h1>AAAAAAAAAAA</h1>");
		out.write("<img src='img/img1.jpg'/>");
	
	%>
</body>
</html>