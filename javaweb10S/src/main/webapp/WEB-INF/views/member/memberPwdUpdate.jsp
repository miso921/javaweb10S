<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<title>memberPwdUpdate.jsp</title>
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
	  
	  function pwdCheck() {
	  	let newPwd = $("#newPwd").val();
	  	let rePwd = $("#rePwd").val();
	  	
	  	if(newPwd == "" || rePwd == "") {
	  		alert("비밀번호를 입력하세요!");
	  		$("newPwd").focus();
	  	}
	  	else if(newPwd != rePwd) {
	  		alert("비밀번호가 서로 같지 않습니다.\n다시 한번 확인하세요!");
	  		$("rePwd").focus();
	  	}
	  	else {
	  		myform.submit();
	  	}
	  }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<P><br /></P>
<div class="container text-center">	
	<h2 class="text-center">비밀번호 변경</h2>
	<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
	<form name="myform" method="post" action="memberPwdUpdate">
		<table class="table table-borderless">
			<tr>
				<td class="td" style="text-align: center;">
					<label for="newPwd" class="mr-4" style="font-weight:bold">새 비밀번호</label>
					<input type="password" id="newPwd" name="newPwd" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td class="td" style="text-align: center;">
					<label for="rePwd" class="mr-4" style="font-weight:bold">비밀번호 확인</label>
					<input type="password" id="rePwd" name="rePwd" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bnts">
					<input type="button" value="비밀번호변경" onclick="pwdCheck()" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="reset" value="다시입력" class="w3-button w3-border w3-border-brown w3-round" />
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