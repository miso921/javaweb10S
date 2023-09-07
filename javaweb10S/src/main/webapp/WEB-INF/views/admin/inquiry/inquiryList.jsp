<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminInquiryList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<!-- 날짜를 시간으로 계산해서 돌려주기위한 monent.js 외부라이브러리를 사용하고 있다.  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
	<style>
		.container {font-family:'SUITE-Regular';font-weight:bold;font-size:16px;}
		h2 {font-family:'EF_watermelonSalad';font-weight:bold;}
		th, td {text-align:center;}
		.tr {background-color:#937062;}
		#title {color:black;}
		#title:hover {text-decoration:none;}
	</style>
	<script>
		/* $(document).ready(function() {
			var quiryDate = document.getElementsByClassName('quiryDate');
			for(var i=0; i<quiryDate.length; i++) {		// 여러개의 날짜를 숫자로 변환하는부분이 있다면 그 클래스 갯수만큼 돌린다.
				var fromNow = moment(quiryDate[i].value).fromNow();		// 해당클래스의 value값을 넘겨주면 시간으로 계산해도 돌려준다.
			    document.getElementsByClassName('inputDate')[i].innerText = fromNow;	// 담아온 시간을 inputDate클래스에 뿌려준다.
			}
		}); */
	
		function categoryCheck() {
			var part = categoryForm.part.value;
			location.href="${ctp}/admin/inquiry/inquiryList?part="+part+"&pag=${pageVO.pag}";
		}
	</script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container text-center">
	<h2><font color="#937062";>${part}</font>&nbsp;목록</h2>
	<form name="categoryForm" style="width:200px;" onchange="categoryCheck()">
		<select class="form-control-sm text-left" id="part" name="part" style="margin-left: 50px;">
	    <option value="전체" <c:if test="${part=='전체'}">selected</c:if>>전체문의글</option>
	    <option value="답변대기중" <c:if test="${part=='답변대기중'}">selected</c:if>>답변대기중</option>
	    <option value="답변완료" <c:if test="${part=='답변완료'}">selected</c:if>>답변완료</option>
		</select>
	</form>
  <br/>
	<table class="table table-hover">
		<tr class="tr text-dark"> 
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>답변상태</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${curScrStartNo}</td>
				<td class="text-center"><a href="${ctp}/admin/inquiry/inquiryReply?idx=${vo.idx}&pag=${pageVO.pag}&part=${part}" id="title">[${vo.part}] ${vo.title}</a></td>
				<td>${vo.mid}</td>
				<td>
					<span class="inputDate"></span>
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
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		</c:forEach>
		<tr><td colspan="5" class="p-0 m-0"></td></tr>
	</table>
</div>
	
<!-- 페이징 처리 시작 -->
<c:if test="${pageVO.totRecCnt == 0}">
  <div class="text-center">검색된 자료가 없습니다.</div>
</c:if>
<c:if test="${pageVO.totRecCnt != 0}">
	<div class="text-center">
		<ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}">
		    <li class="page-item"><a href="admin/inquiry/inquiryList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${pageVO.curBlock > 0}">
		    <li class="page-item"><a href="admin/inquiry/inquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
		      <li class="page-item active"><a href="admin/inquiry/inquiryList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
		      <li class="page-item"><a href='admin/inquiry/inquiryList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
		    <li class="page-item"><a href="admin/inquiry/inquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
		  </c:if>
		  <c:if test="${pageVO.pag != pageVO.totPage}">
		    <li class="page-item"><a href="admin/inquiry/inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		  </c:if>
	  </ul>
	</div>
</c:if>
<!-- 페이징 처리 끝 -->
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
</body>
</html>