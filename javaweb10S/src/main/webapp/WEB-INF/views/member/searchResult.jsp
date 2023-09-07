<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchResult.jsp</title>
<link rel="stylesheet" href="${ctp}/font/font.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
  .container, h2, h3, h4 {font-family: 'EF_watermelonSalad';font-weight:bolder;}
  span a, div a {color: black;}
  span a:hover, div a:hover {color: black;text-decoration:none;}
  span {font-size:1.3em;}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<div class="row">
		<div class="col text-center">
			<h2><b><font color="brown">${searchString}</font>&nbsp;으로 검색한 상품입니다</b></h2>
		</div>
	</div>
	<hr />
	<c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${searchVOS}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/shop/itemContent?idx=${vo.idx}">
            <img src="${ctp}/product/${vo.thumbnail}" width="200px" height="180px"/>
            <div><font size="2">${vo.productName}</font></div>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}" />
      <c:if test="${cnt%3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(searchVOS) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>