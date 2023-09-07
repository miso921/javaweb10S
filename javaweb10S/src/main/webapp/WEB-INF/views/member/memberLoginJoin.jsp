<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberLoginJoin.jsp</title>
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
	<link rel="stylesheet" href="${ctp}/css/login.css"/>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		document.addEventListener("DOMContentLoaded", function() {
		  const signup = document.getElementById("sign-up");
		  const signin = document.getElementById("sign-in");
		  const loginin = document.getElementById("login-in");
		  const loginup = document.getElementById("login-up");
	
		  signup.addEventListener("click", function() {
		    loginin.classList.remove("block");
		    loginup.classList.remove("none");
	
		    loginin.classList.add("none");
		    loginup.classList.add("block");
		  });
	
		  signin.addEventListener("click", function() {
		    loginin.classList.remove("none");
		    loginup.classList.remove("block");
	
		    loginin.classList.add("block");
		    loginup.classList.add("none");
		  });
		});
	
	// 로그인 확인
	function loginCheck() {
		let mid = $("#mid").val();
		let pwd = $("#pwd").val();
		
		if(mid == "") {
			alert("아이디를 입력하세요!");
			$("#mid").focus();
		}
		else if(pwd == "") {
			alert("비밀번호를 입력하세요!");
			$("#pwd").focus();
		}
		$('form[name="loginForm"]').submit();	
	}
	
  let idCheckSw = 0;
	function fCheck() {
		// 아이디와 닉네임 중복버튼을 클릭했는지의 여부를 확인하기위한 변수(버튼 클릭후에는 내용 수정처리 못하도록 처리)
	    
		let regMid = /^[a-zA-Z0-9_]{4,20}$/;
		let regPwd = /^(?=.*[0-9a-zA-Z]).{6,20}$/;
		let regName = /^[가-힣a-zA-Z]+$/;
    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
    let mid = joinForm.jMid.value.trim();
    let name = joinForm.name.value.trim();
    let pwd = joinForm.jPwd.value.trim();
    let email = joinForm.mail.value.trim();
    
    let submitFlag = 0;		// 모든 체크가 정상으로 종료되게되면 submitFlag는 1로 변경처리될수 있게 한다.
    
    if(!regMid.test(mid)) {
    	alert("아이디는 4~20자리의 영문 대/소문자, 숫자, 밑줄(_)만 사용가능합니다.");
    	joinForm.jMid.focus();
    	return false;
    }
    else if(!regName.test(name)) {
    	alert("성명은 한글과 영문 대/소문자만 사용가능합니다.");
    	joinForm.name.focus();
    	return false;
    }
	  else if(!regPwd.test(pwd)) {
    	alert("비밀번호는 6~20자리의 1개이상의 문자와 특수문자를 조합하여 사용가능합니다.");
    	joinForm.pwd.focus();
    	return false;
    } 
    else if(!regEmail.test(email)) {
    	alert("이메일 형식에 맞지 않습니다.");
    	joinForm.email.focus();
    	return false;
    }
    else {
    	submitFlag = 1;
    }
    
    // 전송전에 모든 체크가 끝나면 submitFlag가 1로 변한다. 이때 값들을 서버로 전송처리한다.
    if(submitFlag == 1) {
    	if(idCheckSw == 0) {
    		alert("아이디 중복확인을 해주세요!");
    		document.getElementById("midBtn").focus();
    	}
    }
  	// 회원가입 ajax처리
    $.ajax({
    	type    : "post",
    	url     : "${ctp}/member/memberJoin",
    	data    : {mid : mid, name : name, pwd : pwd, email : email},
    	success : function(res) {
    		if(res == "1") {
    			alert("회원가입이 완료되었습니다!");
    			location.href="${ctp}/member/memberLoginJoin";
    		}
    	} 
    });
	}
	
	// 아이디 중복확인
	function idCheck() {
		let mid = joinForm.jMid.value;
		if(mid.trim() == "" || mid.length < 4 || mid.length > 20) {
			alert("아이디를 확인하세요!(아이디는 4~20자 이내)");
			joinForm.jMid.focus();
			return false;
		}
		$.ajax({
			type : "post",
			url  : "${ctp}/member/memberIdCheck",
			data : {mid: mid},
			success : function(res) {
				if(res == "1"){
					alert("이미 사용중인 아이디입니다.\n다시 입력해주세요!");
					$("#jMid").focus();
				}
				else {
					alert("사용 가능한 아이디입니다.");
					idCheckSw = 1;
					$("#name").focus();
				}
			}
		});
	}
	
	
	<!-- 카카오로그인 js파일 -->
	// 카카로그인을 위한 자바스크립트 키
	window.Kakao.init("8f1ee709ef5ab9a76af9ebef2707ae73");

  // 카카오 로그인
	function kakaoLogin() {
		window.Kakao.Auth.login({
			scope: 'account_email',  // profile_nickname 필드에 nickName이 없어서 이메일만 받아옴
			success:function(autoObj) {
				console.log(Kakao.Auth.getAccessToken(),"로그인 OK");
				console.log(autoObj);
				window.Kakao.API.request({
					url : '/v2/user/me',
					success:function(res) {
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						//alert(kakao_account.email + " / " + kakao_account.profile.nickname);
						location.href="${ctp}/member/memberKakaoLogin?email="+kakao_account.email;  // nickName="+kakao_account.profile.nickname"
					}
				});
			}
		});
	}
	</script>
	<style>
		.container, h1 {font-family: 'EF_watermelonSalad';}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<p><br /></p>
<div class="container">
  <div class="login">
    <div class="login__content">
      <div class="login__img">
        <img src="${ctp}/resources/images/cook.png">
      </div>
			<!-- login form -->
      <div class="login__forms">
        <form name="loginForm" action="${ctp}/member/memberLogin" method="post" id="login-in" class="login__register">
          <h1 class="login__title">로그인</h1>
          <div style="display: flex; align-items: center;">
					  <input type="checkbox" id="idSave" name="idSave" checked class="login__forgot" style="margin-right: 5px;">
					  <label for="idSave" style="margin-top:10px;">아이디 저장</label>
					</div>
          <div class="login__box">
            <i class='bx bx-user login__icon'></i>
            <input type="text" id="mid" name="mid" value="${mid}" placeholder="아이디" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="password" id="pwd" name="pwd" placeholder="비밀번호" class="login__input">
          </div>
          <!-- 카카오로그인 API -->
			    <div style="display: flex; justify-content: center; margin-top: 1rem;">
			      <div><a href="javascript:kakaoLogin();"><img src="${ctp}/images/kakao_login_medium_narrow.png" width="200px" /></a></div>			      
				  </div>	
          <a href="${ctp}/member/memberFindMid" class="login__forgot">아이디찾기</a>
          <a href="${ctp}/member/memberFindPwd" class="login__forgot">비밀번호찾기</a>
          <a href="javascript:loginCheck()" class="login__button">로그인</a>
          
          <div>
            <span class="login__account login__account--account">계정이 없으신가요?</span>
            <span class="login__signin login__signin--signup" id="sign-up">회원가입</span>
          </div>
        </form>
				<!-- create account form -->
        <form name="joinForm" id="login-up" class="login__create none">
          <h1 class="login__title">회원가입</h1>
          <div class="login__box d-flex">
            <i class='bx bx-user login__icon'></i>
            <input type="text" name="jMid" id="jMid" placeholder="아이디" class="login__input">
	          <input type="button" id="midBtn" name="midBtn" value="중복확인" onclick="idCheck()" class="btn btn-success btn-sm justify-content-right" />
          </div>
          <div class="login__box">
            <i class='bx bx-user login__icon'></i>
            <input type="text" name="name" id="name" placeholder="이름" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="password" name="jPwd" id="jPwd" placeholder="비밀번호" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-at login__icon'></i>
            <input type="email" name="mail" id="mail" placeholder="이메일" class="login__input">
          </div>
          <div>
          	<input type="checkbox" name="term" id="term" value="agree" class="mt-1 mr-1" /><span style="font-weight:bold;">'밥먹자'의 <a href="${ctp}/member/memberJoinTerm">개인정보 수집 및 이용</a>에 동의합니다</span>
          </div>
          <a href="javascript:fCheck()" class="login__button">회원가입</a>
          <div>
            <span class="login__account login__account--account">이미 회원가입을 하셨나요?</span>
            <span class="login__signup login__signup--signup" id="sign-in">로그인</span>
          </div>
        </form>
      </div>
    </div>
   </div>
</div>	
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>