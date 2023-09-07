<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<title>memberPwdUpdateCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/> 
	<style>
	  .container, h2 {font-family: 'EF_watermelonSalad';}
		.w3-button:hover {color: beige;}
		.bnts {font-weight: bold;}
		h2 {font-weight: bolder;}
		td {margin-left:auto;margin-right:auto;}
	</style>
	<script>
		'use strict';
		
		function cancelCheck(mid) {
			if ($("#termCheck").prop("checked")) {
				$.ajax({
					type : "post",
					url  : "${ctp}/member/memberCancel",
					data : {mid : mid},
					success : function(res) {
						if(res == 1) {
							alert("회원탈퇴가 완료되었습니다!");
						}
					},
					error : function() {
						alert("전송오류!");
					}
				});
			}
			else alert("약관에 동의하셔야 탈퇴할 수 있습니다!");
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<P><br /></P>
<div class="container text-center">	
	<h2 class="text-center">회 원 탈 퇴</h2>
	<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
	<form method="post">
		<table class="table table-borderless">
			<tr>
				<td class="td" style="text-align: center;">
					<span class="font-weight-bolder mb-3" style="font-size:20px;">회원탈퇴를 원하시면 아래 약관에 동의를 해주세요.</span><br />
	      	<input type="checkbox" name="termCheck" id="termCheck" class="mt-1 mr-1" /><span style="font-weight:bold;">'밥먹자'의 <a href="${ctp}/member/memberCancelTerm">개인정보 수집 및 이용</a>에 동의합니다</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bnts">
					<input type="button" value="확인" onclick="cancelCheck('${sMid}')" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMypage';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
		<input type="hidden" name="mid" value="${sMid}" />
	</form>
</div>	
<P><br /></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>