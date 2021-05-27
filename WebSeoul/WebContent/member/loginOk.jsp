<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${userid != null}">
	<script>
		location.href="<%=request.getContextPath() %>/index.do";
	</script>
</c:if>
<c:if test="${userid==null}">
	<script>
		alert("아이디 및 비밀번호를 입력하세요.")
		history.back();
	</script>
</c:if>