<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemList.jsp</title>
<link rel="stylesheet" href="${ctp}/font/font.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
  .container, h2, h4 {font-family:'EF_watermelonSalad';font-weight:bold;}
  span a, div a {color: black;}
  span a:hover, div a:hover {color: black;text-decoration:none;}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container">
	<span><a href="${ctp}/shop/itemList" class="w3-button w3-ripple w3-brown mr-2">전체</a></span>
	<c:forEach var="partVO" items="${partVOS}" varStatus="st">
		<span><a href="${ctp}/shop/itemList?part=${partVO.part}" class="w3-button w3-border w3-border-brown w3-round mr-2">${parts[st.index]}</a></span>
	</c:forEach>
	<hr />
	<div class="row">
		<div class="col text-center">
			<c:if test="${part == '전체'}">
				<h2><b><font color="brown">전체</font>&nbsp;상품</b></h2>
				<h4>즐거운 하루 보내세요 :&nbsp;)</h4>
			</c:if>
			<c:if test="${part == '신선식품'}">
				<h2><b><font color="brown">신선식품</font></b></h2>
				<h4>신선식품을 둘러보세요 :&nbsp;)</h4>
			</c:if>
			<c:if test="${part == '가공식품'}">
				<h2><b><font color="brown">가공식품</font></b></h2>
				<h4>가공식품을 둘러보세요 :&nbsp;)</h4>
			</c:if>
			<c:if test="${part == '주방용품'}">
				<h2><b><font color="brown">주방용품</font></b></h2>
				<h4>주방용품을 둘러보세요 :&nbsp;)</h4>
			</c:if>
		</div>
	</div>
	<hr />
	<c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${itemVOS}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/shop/itemContent?idx=${vo.idx}">
            <img src="${ctp}/product/${vo.thumbnail}" width="200px" height="180px"/>
	            <div><font size="2">${vo.productName}</font></div>
	            <c:if test="${vo.discountRate != 0}">
	            	<div>
	            		<del><font size="2" class="mr-1"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font></del>
		            	<font size="2" color="red">${vo.discountRate}%</font>
	            	</div>
		            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.discount}" pattern="#,###"/>원</font></div>
	            </c:if>
	            <c:if test="${vo.discountRate == 0}">
	            	<div>
		            	<font size="2" color="orange"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font>
	            	</div>
	            </c:if>
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
      <c:if test="${fn:length(itemVOS) == 0}">
      	<h3>상품 준비 중입니다.</h3>
			  <hr/>
    	</c:if>
    </div>
  </div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>