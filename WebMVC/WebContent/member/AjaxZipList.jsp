<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
/* item의 list는 AjaxZipSearchCommand 에서 req.setattribute 한 list얌 (바로갖다쓸수있음)
 	 jsp는 get set 안하고 변수쓰면 알아서 된다?! 호오
 */
</script>
<hr id="z"/>
<c:forEach var="vo" items="${list }">
	<li><span class="zCode">${vo.zipcode }</span> <span class="addr">${vo.sido } ${vo.sigungu }<c:if test="${vo.um!=null}"> ${vo.um}</c:if> ${vo.doro } ${vo.build1 }<c:if test="${vo.build2!=null }">-${vo.build2 }</c:if> (${vo.dong }<c:if test="${vo.sibuild!=null }">, ${vo.sibuild}</c:if>)</span>
	  <br/>${vo.sido } ${vo.sigungu } ${vo.dong } ${vo.leename} ${vo.gibun1 }<c:if test="${vo.gibun2 != 0 }">-${vo.gibun2 }</c:if><c:if test="${vo.sibuild!=null }">, ${vo.sibuild}</c:if></li>
</c:forEach>
<hr id="z"/>