<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    // 닉네임 중복버튼을 클릭했는지의 여부를 확인ㄴ하기위한 변수(버튼 클릭후에는 내용 수정처리 못하도록 처리)
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
    	
    	let name = myform.name.value;
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	// 앞의 정규식으로 정의된 부분에 대한 유효성체크
      if(!regName.test(name)) {
        alert("성명은 한글과 영문 대/소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }
      else if(tel2 != "" && tel3 != "") {
    	  if(!regTel.test(tel)) {
	    		alert("전화번호형식을 확인하세요.(000-0000-0000)");
	    		myform.tel2.focus();
	    		return false;
    	  }
  	  }
    	else {		// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
    		tel2 = " ";
    		tel3 = " ";
    		tel = tel1 + "-" + tel2 + "-" + tel3;
    	}
    	
    	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
  		myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
    	
  		myform.email.value = email;
  		myform.tel.value = tel;
    	myform.submit();
    }
  </script>
  <style>
  	form, input, .input-group-text {font-weight:bolder;}
  	h2 {font-family: 'EF_watermelonSalad';font-weight:bold;}
  	.container {font-family:'SUITE-Regular'; font-weight:bold;font-size:16px;}
  	#id, #forename, #mail, #sex, #birth, #call, #addr {color:#ba55d3;text-weight:bold;font-size:20px;}
  	#sMid {font-size:17px;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
    <h2 class="text-center">회 원 정 보 수 정</h2>
    <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
	  	<table class="table table-borderless">
				<tr>
					<td style="text-align: center;">
						<label for="mid" class="mr-4" style="font-weight:bold;margin-left:-30px;margin-right:-20px;">아이디</label>
						<input type="text" id="mid" value="${sMid}" class="w3-input w3-border w3-round-xlarge" style="width: 220px; margin: 0 auto; display: inline-block;" readonly />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<label for="name" style="font-weight:bold;margin-left:-20px;">성명</label>
						<input type="text" id="name" name="name" value="${vo.name}" class="w3-input w3-border w3-round-xlarge" required style="width: 220px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">
						<label for="email1" style="font-weight:bold;margin-left:-30px;">이메일</label>
		          <c:set var="emails" value="${fn:split(vo.email,'@')}" />
		          <c:set var="email1" value="${emails[0]}" />
		          <c:set var="email2" value="${emails[1]}" />
		          <input type="text" name="mail" id="email1" value="${email1}" class="w3-input w3-border w3-round-xlarge" style="width: 220px; margin: 0 auto; margin-left:20px; display: inline-block;" required />
		      </td>    
          <td class="input-group-append">
            <select name="email2" class="w3-input w3-border w3-round-xlarge" style="width:130px;margin-left:-400px; display: inline-block;">
              <option value="naver.com"   ${email2 == 'naver.com'   ? selected : ''}>naver.com</option>
              <option value="hanmail.net" ${email2 == 'hanmail.net' ? selected : ''}>hanmail.net</option>
              <option value="hotmail.com" ${email2 == 'hotmail.com' ? selected : ''}>hotmail.com</option>
              <option value="gmail.com"   ${email2 == 'gmail.com'   ? selected : ''}>gmail.com</option>
              <option value="nate.com"    ${email2 == 'nate.com'    ? selected : ''}>nate.com</option>
              <option value="yahoo.com"   ${email2 == 'yahoo.com'   ? selected : ''}>yahoo.com</option>
            </select>
          </td>
				</tr>
				<tr>
					<td class="text-center">
						<label for="gender" class="mr-3" style="font-weight:bold;margin-left:-150px;">성별</label>&nbsp;
						<input type="radio" id="gender1" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if>>&nbsp;남자&nbsp;
		     		<input type="radio" id="gender2" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if>>&nbsp;여자
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<label for="birthday" style="font-weight:bold;margin-left:-50px;">생년월일</label>
						<input type="date" id="birthday" name="birthday" value="${fn:substring(vo.birthday,0,10)}" class="w3-input w3-border w3-round-xlarge" required style="width: 220px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					</td>
				</tr>
				<tr style="text-align: center;">
					<td>
						<label for="tel" style="margin-right:60px;margin-left:-13px;">전화번호</label>
							<c:set var="tel" value="${fn:split(vo.tel,'-')}"/>
	            <c:set var="tel1" value="${tel[0]}"/>
	            <c:set var="tel2" value="${fn:trim(tel[1])}"/>
	            <c:set var="tel3" value="${fn:trim(tel[2])}"/>
	            <select name="tel1" id="tel1" class="w3-input w3-border w3-round-xlarge mr-1" style="width:100px;display:inline-block;margin-left:-40px;">
	              <option value="010" ${tel1=="010" ? selected : ""}>010</option>
	              <option value="02"  ${tel1=="02" ? selected : ""}>서울</option>
	              <option value="031" ${tel1=="031" ? selected : ""}>경기</option>
	              <option value="032" ${tel1=="032" ? selected : ""}>인천</option>
	              <option value="041" ${tel1=="041" ? selected : ""}>충남</option>
	              <option value="042" ${tel1=="042" ? selected : ""}>대전</option>
	              <option value="043" ${tel1=="043" ? selected : ""}>충북</option>
	              <option value="051" ${tel1=="051" ? selected : ""}>부산</option>
	              <option value="052" ${tel1=="052" ? selected : ""}>울산</option>
	              <option value="061" ${tel1=="061" ? selected : ""}>전북</option>
	              <option value="062" ${tel1=="062" ? selected : ""}>광주</option>
	            </select>-
	            <input type="text" id="tel2" name="tel2" value="${tel2}" class="w3-input w3-border w3-round-xlarge mr-1" size=4 maxlength=4 style="width:60px;display:inline-block;" />-
	            <input type="text" id="tel3" name="tel3" value="${tel3}" class="w3-input w3-border w3-round-xlarge" size=4 maxlength=4 style="width:60px;display:inline-block;" />
          </td> 
				</tr>
				<tr style="text-align: center;">
					<td>
						<label for="address" style="margin-left:-45px;margin-right:15px;">주소</label>
			      <c:set var="address" value="${fn:split(vo.address,'/')}"/>
			      <c:set var="postcode" value="${address[0]}"/>
			      <c:set var="roadAddress" value="${address[1]}"/>
			      <c:set var="detailAddress" value="${address[2]}"/>
			      <c:set var="extraAddress" value="${address[3]}"/>
			      <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" class="w3-input w3-border w3-round-xlarge" style="width:70px;display:inline-block;" placeholder="우편번호" >
			      <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="w3-button w3-round w3-brown"><br />
			      <input type="text" name="roadAddress" id="sample6_address" value="${roadAddress}" size="50" placeholder="주소" class="w3-input w3-border w3-round-xlarge mt-2" style="width:250px;display:inline-block;margin-left:65px;"><br />   
			      <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" placeholder="상세주소" class="w3-input w3-border w3-round-xlarge mt-2" style="width:270px;display:inline-block;margin-left:85px;"><br /> 
			      <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="w3-input w3-border w3-round-xlarge mt-2" style="width:270px;display:inline-block;margin-left:85px;">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="등록" onclick="fCheck()" class="w3-button w3-border w3-border-brown w3-round" />
						<input type="reset" value="재입력" class="w3-button w3-border w3-border-brown w3-round" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMypage';" class="w3-button w3-round w3-red" />
						<input type="hidden" name="email" />
				    <input type="hidden" name="tel" />
				    <input type="hidden" name="address" />
				    <input type="hidden" name="photo"/>
				    <input type="hidden" name="hobbys"/>
				    <input type="hidden" name="mid" value="${sMid}"/>
					</td>
				</tr>
			</table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>