<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="errorPage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<style>
   #result{ background-color:pink;}
</style>
</head>
<body>
<%
   String n1 = request.getParameter("num1");
   String n2 = request.getParameter("num2");
   
   // 사칙연산
   int nInt1=0; int nInt2=0;
   if(n1!=null && n2!=null && !n1.equals("") && !n2.equals("")){
      nInt1 = Integer.parseInt(n1);
      nInt2 = Integer.parseInt(n2);
   }
%>
   <div class="container">
      <form method="get" action="errorTest.jsp"> <!-- 서브밋하고 전페이지 후페이지가 같은 페이지~ -->
        수 1 : <input type="text" id="num1" name="num1"/> 
     	 수 2 : <input type="text" id="num2" name="num2"/>
        <input type="submit" id="btn" value="계산하기"/>
      </form>
      <div id="result">
      <%if(n1!=null && n2!=null && !n1.equals("") && !n2.equals("")){ %>   
      <ul>
         <li><%=nInt1 %>+<%=nInt2 %>=<%=nInt1+nInt2 %></li>
         <li><%=nInt1 %>-<%=nInt2 %>=<%=nInt1-nInt2 %></li>
         <li><%=nInt1 %>*<%=nInt2 %>=<%=nInt1*nInt2 %></li>
         <li><%=nInt1 %>/<%=nInt2 %>=<%=nInt1/nInt2 %></li>
      </ul>
   <%} %>
   </div>
   </div>
</body>
</html>