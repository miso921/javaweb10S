<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>todayRecipeContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <style>
		.container, h4, h3 {font-family: 'EF_watermelonSalad';font-weight:bold;}
	</style>
</head>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<p><br/></p>
<div class="container">
	<table class="table table-bordered">
		<tr>
			<th colspan="1" class="table-dark text-light th">제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th class="table-dark text-light th">작성일</th>
			<td>${fn:substring(vo.issueDate,0,10)}</td>
			<th class="table-dark text-light th">조회수</th>
			<td style="padding-right:50px;">${vo.readNum + 1}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center"><img src="${ctp}/todayRecipe/${vo.article}" /></td>
		</tr>
	</table>
</div>
<p><br/></p>
</body>
</html>