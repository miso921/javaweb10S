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
  <title>recipeList.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		.container, h4, h3 {font-family: 'EF_watermelonSalad';font-weight:bold;}
		#ed {font-family: 'Pretendard-Regular';}
		a:hover {text-decoration:none;}
		a {color:black;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <span><a href="${ctp}/recipe/recipeList" class="w3-button w3-ripple w3-brown mr-2">전체</a></span>
  <c:forEach var="partVO" items="${partVOS}" varStatus="st">
  	<span><a href="${ctp}/recipe/recipeList?part=${partVO.part}" class="w3-button w3-border w3-border-brown w3-round mr-2">${partVO.part}</a></span>
	  <%-- <c:if test="${!st.last}"></c:if> --%>
  </c:forEach>
  <hr/>
  <div class="row">
    <div class="col">
	    <h4 class="text-center"><font color="brown" class="font-weight-bold"><b>${part}</b></font></h4>
    </div>
  </div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${recipeVOS}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/recipe/recipeContent?idx=${vo.idx}">
            <img src="${ctp}/recipe/${fn:split(vo.file,'/')[0]}" width="200px" height="180px"/>
            <div><font color="brown"><b>요리명&nbsp;|&nbsp;&nbsp;</font>${vo.foodName}</b></div>
		        <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-signal-3 xi-x"></i>${vo.star}</font></span>&nbsp;&nbsp;
		        <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-time-o xi-x"></i>${vo.cookTime}</font></span>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
      	</div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(recipeVOS) == 0}"><h3>레시피 준비중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>