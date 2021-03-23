<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--  --%>
<c:redirect url="../board/boardList.jsp">
	<c:param name="nowNum" value="2"/>
	<c:param name="searchKey" value="content"/>
	<c:param name="searchWord" value="프"/>
</c:redirect>