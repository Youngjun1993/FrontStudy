<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	/*목록*/
	.lst>li {
		float:left; width: 10%; height: 40px; line-height: 40px; border-bottom: 1px solid #ddd;
	}
	.lst>li:nth-child(5n+2) {width: 55%;}
	.lst>li:nth-child(5n+4) {width: 15%;}
	.wordCut {
		white-space:nowrap; overflow:hidden; text-align: ellipsis;
	}
	
	/*페이지*/
	#page{overflow: auto;}
	#page>li{
		float: left; width: 50px; height: 50px; line-height: 50px; text-align: center; border: 1px solid #ddd;
		margin: 5px 15px;
	}
</style>
<div class="container">
	<h1>글목록</h1>
	<ul class="lst">
		<li>번호</li>
		<li>제목</li>
		<li>작성자</li>
		<li>작성일</li>
		<li>조회수</li>
		<c:forEach var="vo" items="${list }">
			<li>${vo.no }</li>
			<!--																		글번호,현재페이지,검색어,검색키		  -->
			<li class="wordCut"><a href="<%=request.getContextPath()%>/board/boardView.do?no=${vo.no}&pageNum=${pageVO.pageNum}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${vo.subject }</a></li>
			<li>${vo.userid }</li>
			<li>${vo.writedate }</li>
			<li>${vo.hit }</li>
		</c:forEach>
	</ul>
	<c:if test="${userid!=null && userid!=''}">
		<div><a href="<%=request.getContextPath()%>/board/boardWrite.do">글쓰기</a></div>
	</c:if>
		<div>
			<ul id="page">
				<c:if test="${pageVO.pageNum>1}"><!-- 이전페이지가 있을때 -->
					<li><a href="<%=request.getContextPath()%>/board/list.do?pageNum=${pageVO.pageNum-1}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">이전</a></li>
				</c:if>
				<!-- 페이지 번호 						1												5							-->
				<c:forEach var="p" begin="${pageVO.startPageNum}" step="1" end="${pageVO.startPageNum + pageVO.onePageNum-1}">
					<c:if test="${p<=pageVO.totalPage}">
						<c:if test="${p==pageVO.pageNum }"> <!-- 현재페이지일때 실행 -->
							<li style="color:red"><a href="<%=request.getContextPath()%>/board/list.do?pageNum=${p}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">${p}</a></li>
						</c:if>	
						<c:if test="${p!=pageVO.pageNum}"> <!-- 현재페이지가 아닐때 실행 -->
							<li><a href="<%=request.getContextPath()%>/board/list.do?pageNum=${p}">${p}</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${pageVO.pageNum < pageVO.totalPage} }">
					<li><a href="<%=request.getContextPath()%>/board/list.do?pageNum=${pageVO.pageNum+1}<c:if test="${pageVO.searchWord != null && pageVO.searchWord != ''}">&searchKey=${pageVO.searchKey}&searchWord=${pageVO.searchWord}</c:if>">다음</a></li>
				</c:if>
			</ul>
		</div>
		<div>
			<form method="get" action="<%=request.getContextPath()%>/">
				<select name="searchKey">
					<option value="subject">제목</option>
					<option value="userid">글쓴이</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchWord" id="searchWord" />
				<input type="submit" value="Search"/>
			</form>
		</div>
</div>