<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	/* 로그인 성공시 session의 userid, username 존재여부 확인
	jstl은 session값은 별도 지정없이 그냥 변수명 사용하면 알아서 읽어오지롱!*/
%>
<c:if test="${userid != null && username != null }">
	<script>
		location.href="<%=request.getContextPath() %>/index.do";
	</script>
</c:if>
<c:if test="${userid==null || username==null }">
	<script>
		history.back();
	</script>
</c:if>