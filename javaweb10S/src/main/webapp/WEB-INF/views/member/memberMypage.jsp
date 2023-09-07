<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberMypage.jsp</title>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function photoCheck(mid) {
  		let url = "${ctp}/member/memberProfileUpload";
  		window.open(url,"nWin","width=500, height=150");
  	}
  	
  	function profileUpload() {
  		let maxSize = 1024 * 1024 * 2; // 업로드할 회원사진의 용량은 2MByte까지로 제한
  		let fName = $("#fName")[0];
  		let file = fName.files[0];
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase(); // 확장자 발췌 후 대문자 변환
  		
  		if(!file) {
  			$("#profileImage").html('<img src="${ctp}/resources/data/member/noimage.jpg" width="200px" />');
  			return;
  		}

  		else if(file.size > maxSize) {
  			alert("파일 용량은 2MB를 초과할 수 없습니다!");
  			return;
  		}
  		
  		else if(ext != "JPG" && ext != "JPEG" && ext != "GIF" && ext != "PNG") {
  			alert("업로드 가능한 파일은 'JPG/JPEG/GIF/PNG'파일 입니다.");
  			return;
  		}
  		
  		/* let reader = new FileReader(); FileReader로 파일 읽기
  		reader.onload = function (e) {
  			let photo = e.target.result; 읽은 파일의 데이터 나타내기 */
  			
  			$.ajax({
  				type : "post",
  				url  : "${ctp}/member/memberProfileUpload",
  				data : {photo : photo, mid : mid},
  				success : function() {
  					$("#profileImage").html('<img src="${vo.photo}" width=200px; />')
  				},
  				error : function() {
  					alert("전송오류!");
  				}
  			});
  		
  	}
  </script>
  <style>
  	#f {
  		display:flex;
  		flex-wrap:wrap;
  		gap:10px;
  		width:900px;
  		margin:0 auto;
  	}
		#imsi {
			font-family:'SUITE-Regular';
		  font-size:38px;
		  border:5px solid black;
		  border-color:#ff3333;
		  width:810px;
		  height:400px;	
		  justify-content:center;
		  padding:130px 10px 10px 10px;
		  /* display: flex;
		 /*  align-items: center; */
		}
		.box1 {
		  border:3px solid black;
		  border-color:#d3d3d3;
		  width:400px;
		  height:350px;
		  align-items:center;
		}
		.content {
			color:black;
			font-family:'SUITE-Regular';
		  font-size:1.5em;
		  display:flex;
		  flex-direction:column;
		  justify-content:center;
		  height:100%;
		  align-items:center;
		  font-weight:bolder;
		}
		a {color: black;}
		a:hover {
			color: #ba55d3;
			text-decoration: none;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <form id="f" name="myform">
			<c:if test="${!empty sImsiPwd}">
				<div id="imsi" class="text-center">
				    현재 임시비밀번호를 발급받아 사용중입니다.<br/>
				    비밀번호를 변경해 주세요.<br/>
				    <a href="${ctp}/member/memberPwdUpdate" class="w3-button w3-border w3-border-red w3-round w3-large">비밀번호변경</a>
				</div>
		  </c:if>
	  <div class="box1">
	    <div class="content">
	      <button type="button" onclick="photoCheck('${sMid}')" class="badge badge-pill badge-dark mb-1"><font size="2em;">사진등록</font></button>
	      <c:if test="${!empty vo.photo}">
	      	<span id="profileImage"><img src="${ctp}/member/${vo.photo}" class="w3-circle" width="120px"></span>
	      </c:if>
	      <c:if test="${empty vo.photo}">
	      	<span id="profileImage"><img src="${ctp}/member/noimage.jpg" class="w3-circle" width="200px"></span>
	      </c:if>
	      <span class="mb-5"><font color="#327358" size="5em">${sMid}</font>님 로그인 중입니다</span>
	      <span><a href="${ctp}/member/memberUpdate">회원정보수정</a></span>
	      <span><a href="${ctp}/member/memberPwdUpdateCheck">비밀번호변경</a></span>
	      <span><a href="${ctp}/member/memberCancel">회원탈퇴</a></span>
	    </div>
	  </div>
	  <div class="box1">
	    <div class="content">
	      <span>적립금 |&nbsp;&nbsp;<font color="#327358" size="5em"><fmt:formatNumber value="${vo.point}" pattern="#,###" />원</font></span>
	    </div>
	  </div>
	  <div class="box1">
	    <div class="content">
	      <span><a href="${ctp}/shop/myOrder">주문내역</a></span>
	      <span><a href="${ctp}/shop/itemCart">장바구니</a></span>
	      <span><a href="${ctp}/recipe/dibsRecipeList">찜한레시피</a></span>
	    </div>
	  </div>
	  <div class="box1">
	    <div class="content">
	      <span><a href="${ctp}/inquiry/inquiryList">나의문의</a></span>
	    </div>
	  </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>