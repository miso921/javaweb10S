<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>newHome.jsp</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<table class="table table-bordered">
	  <tr>
	  	<th>레시피명</th>
	  	<td>${vo.foodName}</td>
	  </tr>
	  <tr>
	  	<th>레시피 이미지</th>
	  	<td>${vo.file}</td>
	  </tr>
	  <tr>
	  	<th>재료명</th>
	  	<td>${vo.item}</td>
	  </tr>
	</table>
	<div class="item"><img src="${ctp}/resources/images/paris.jpg" /></div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>