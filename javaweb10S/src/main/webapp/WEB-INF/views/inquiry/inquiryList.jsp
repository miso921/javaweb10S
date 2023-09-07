<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
	  th, td {text-align:center;}
	  .tr {background-color:#937062;}
	</style>
	<script>
	  'use strict';
	  
	  //if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/inquiry/inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
	  
	  function pageCheck() {
	  	let pageSize = document.getElementById("pageSize").value;
	  	location.href = "${ctp}/inquiry/inquiryList?pag=${pageVO.pag}&pageSize="+pageSize;
	  }
  </script> 
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<h3 style="text-align:center;font-family: 'EF_watermelonSalad';font-weight:bold;">문의</h3>
	<br/>
	<table class="table table-borderless">
    <tr>
      <td class="text-right">
        <!-- 한페이지 분량처리 -->
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
        </select> 건
      </td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="tr text-light">
      <th>번호</th>
      <th>작성자</th>
      <th>제목</th>
      <th>작성일자</th>
      <th>답변상태</th>
    </tr>
    <c:if test="${empty mid}">
			<tr>
				<td colspan="5" style="text-align:center">
					문의글이 존재하지 않습니다.
				</td>
			</tr>
		</c:if>
    <c:if test="${!empty mid}">
    <div style="text-align:right;" class="p-1">
			<input type="button" onclick="location.href='${ctp}/inquiry/inquiryInput'" value="문의" class="w3-button w3-ripple w3-brown w-15 mb-2"/>
		</div>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
    <c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${mid == vo.mid}">
      <tr>
        <td>${curScrStartNo}</td>
        <td>${vo.mid}</td>
        <td class="text-center">
          <a href="${ctp}/inquiry/inquiryView?idx=${vo.idx}&pag=${pageVO.pag}">[${vo.part}]&nbsp;${vo.title}</a>
          <%-- <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if> --%>
        </td>
        <td>
          <!-- 1일(24시간) 이내는 시간만 표시, 이후는 날짜와 시간을 표시 : 2023-05-04 10:35:25 -->
          <!-- 단(24시간안에 만족하는 자료), 날짜가 오늘날짜만 시간으로표시하고, 어제날짜는 날짜로 표시하시오. -->
          ${fn:substring(vo.quiryDate,0,10)}
        </td>
        <td>
      		<c:if test="${vo.reply=='답변대기중'}">
						<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
					</c:if>
					<c:if test="${vo.reply=='답변완료'}">
						<span class="badge badge-pill badge-danger">${vo.reply}</span>						
					</c:if>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:if>  
    </c:forEach>
		</c:if>
    <tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
  
  <c:if test="${!empty vos}">
	<!-- 블록 페이징 처리 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}">
		    <li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		      <li class="page-item active"><a href="${ctp}/inquiry/inquiryList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href='${ctp}/inquiry/inquiryList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		    <li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
	  </ul>
	</div>
	<!-- 블록 페이징 처리 끝 -->
	</c:if>
	<br/>
</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>