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
		.container, h4, h3 {font-family:'SUITE-Regular';font-weight:bold;}
		a:hover {text-decoration:none;}
		a, div {color:black;}
	  .Star{
	   display: flex;
    -webkit-box-align: start;
    align-items: center;
  	}
   .Star .SScor{
   	font-weight: 700;
    font-size: 20px;
    color: rgb(62, 62, 62);
    margin: 6px 0px 3px 8px;
   }
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <span><a href="${ctp}/admin/recipe/recipeList" class="w3-button w3-ripple w3-brown mr-2">전체</a></span>
  <c:forEach var="partVO" items="${partVOS}" varStatus="st">
  	<span><a href="${ctp}/admin/recipe/recipeList?part=${partVO.part}" class="w3-button w3-border w3-border-brown w3-round">${partVO.part}</a></span>
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
          <a href="${ctp}/admin/recipe/recipeContent?idx=${vo.idx}">
            <img src="${ctp}/recipe/${fn:split(vo.file,'/')[0]}" width="200px" height="180px"/>
            <div><b><font color="brown"></font>${vo.foodName}</b></div>
            <%-- <div><b><font color="brown">난이도&nbsp;|</font>&nbsp;&nbsp;${vo.star}</b></div> --%>
              <div class="Star" style="display:flex;flex-wrap:nowrap;justify-content:center;">
	              <!-- 짝수 별 -->
	              <c:if test="${vo.star%2 == 0}">
                	<c:forEach begin="0" end="4" step="1" varStatus="st" >
                  	<c:if test="${st.index+1 <= vo.star/2}">
                    	<span style="display:flex;justify-content:center;width:25px;"><img src="${ctp}/images/fullStar.png" width="100%" /></span>
                    </c:if>
                    <c:if test="${st.index+1 > vo.star/2}">
                    	<span style="display:flex;justify-content:center;width:25px;"><img src="${ctp}/images/emptyStar.png" width="100%" /></span>
                    </c:if>
                  </c:forEach>
                </c:if>
                <!-- 홀수 별 -->
                <c:if test="${vo.star%2 != 0}">
                	<c:set var="str" value="${(vo.star-1)/2}" />
                	<c:forEach begin="0" end="4" step="1" varStatus="st" >
                       <c:if test="${st.index+1 <= str}">
                          <span style="display:flex;justify-content:center;width:25px;"><img src="${ctp}/images/fullStar.png" width="100%"/></span>
                       </c:if>
                       <c:if test="${st.index+1 == str+1}">
                          <span style="display:flex;justify-content:center;width:25px;"><img src="${ctp}/images/halfStar.png" width="100%"/></span>
                       </c:if>
                       <c:if test="${st.index+1 > str && st.index+1 != str+1}">
                          <span style="display:flex;justify-content:center;width:25px;"><img src="${ctp}/images/emptyStar.png" width="100%"/></span>
                       </c:if>
                    </c:forEach>
                 </c:if>
              </div>
            <div><b><font color="brown">조리시간&nbsp;|</font>&nbsp;&nbsp;${vo.cookTime}</b></div>
           	<c:if test="${vo.openSw == 'OK'}">
            	<div><font color="brown"><b>공개여부&nbsp;|</b>&nbsp;</font>공개</div>
          	</c:if>
           	<c:if test="${vo.openSw == 'NO'}">
            	<div><font color="brown"><b>공개여부&nbsp;|</b>&nbsp;</font>비공개</div>
          	</c:if>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
      	</div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container text-center">
      <c:if test="${fn:length(recipeVOS) == 0}"><h3>레시피 준비중입니다.</h3></c:if>
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>