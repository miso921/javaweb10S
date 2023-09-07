<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryView.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		
		function updateCheck() {
			let ans = confirm("문의글을 수정하시겠습니까?");
			if(!ans) return false;
			else location.href="${ctp}/inquiry/inquiryUpdate?idx=${vo.idx}&pag=${pag}";
		}
		
		function deleteCheck() {
			let ans = confirm("문의글을 삭제하시겠습니까?");
			if(!ans) return false;
			location.href="${ctp}/inquiry/inquiryDelete?idx=${vo.idx}&pag=${pag}";
		}
	</script>
	<style>
	  th {
	    background-color: #937062;
	    text-align:center;
	  }
	  h3 {font-family:'EF_watermelonSalad';}
	  #an {font-family:'SUITE-Regular';font-weight:bold;font-size:20px;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<p><br/></p>
	<div class="container">
		<table class="table table-bordered">
			<tr>
				<th class="text-light th">제목</th>
				<td>
					[${vo.part}] ${vo.title}
					<c:if test="${vo.reply=='답변대기중'}">
						<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
					</c:if>
					<c:if test="${vo.reply=='답변완료'}">
						<span class="badge badge-pill badge-danger">${vo.reply}</span>						
					</c:if>
				</td>
				<th class="text-light th">작성자</th>
				<td>${vo.mid}</td>				
			</tr>
			<tr>
				<th class="text-light th">작성일자</th>
				<td>${fn:substring(vo.quiryDate,0,10)}</td>
				<th class="text-light th">주문번호</th>
				<td>
					<c:if test="${!empty vo.orderNo}">${vo.orderNo}</c:if>
					<c:if test="${empty vo.orderNo}">-</c:if>
			 	</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center"><%-- <img src="${ctp}/inquiry/${fn:substring(vo.content, fn:length('/javaweb10S/resources/data/inquiry/') + 1)}" width="500px" /> --%>
					<br/>
		      <p>${fn:replace(vo.content,newLine,"<br/>")}<br/></p>
		    	<hr/>
				</td>
			</tr>
		</table>
	<!-- 관리자가 답변을 달았을때는 현재글을 수정/삭제 처리 못하도록 하고 있다. -->
	<div class="text-center">
		<c:if test="${empty reVO.reContent}">
			<input type="button" value="수정" onclick="updateCheck()" class="w3-button w3-ripple w3-brown" />&nbsp;
		  <input type="button" value="삭제" onclick="deleteCheck()" class="w3-button w3-border w3-border-brown w3-round" />&nbsp;
		  <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList?pag=${pag}';" class="w3-button w3-border w3-border-black w3-round" />
		</c:if>  
	</div>
	<!-- 관리자가 답변을 달았을때 보여주는 구역 -->
	<c:if test="${!empty reVO.reContent}">
		<form name="replyForm">
			<label for="reContent" id="an">답변</label>
			<textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="form-control">${reVO.reContent}</textarea>
		</form>
	</c:if>
	<br/>
	</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<p><br/></p>
</body>
</html>