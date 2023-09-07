<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>밥먹자</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<link rel="stylesheet" href="${ctp}/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/resources/css/owl.theme.default.min.css">
	<script src="${ctp}/resources/js/owl.carousel.js"></script> 
	<script src="${ctp}/resources/js/owl.carousel.min.js"></script>
	<style>
		@font-face {
	    font-family: 'RIDIBatang';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
		
		#item {
			width: 220px;
			heigth: 240px;
		}
		
		#work2, #work1 {
			float: right;	
			margin-right: 50px;		
			margin-top: 5px;	
			margin-bottom: 0px;	
			color: #676a59;	
			font-size: 1em;
		}
		
		#work2 a:hover, #work1 a:hover {
			text-decoration: none;
			color: #cfdd8e;
		}
		
		a:hover {text-decoration:none;}
		
		.border {
			border-style:solid;
			border-width:10px;
			border-color:#de34n6;
		}
		
		.card-text {
			font-size:22px;
			font-family:'SUITE-Regular';
		}
		
		#ps {font-family:'RIDIBatang'; font-size:30px;}
		
		 #loading {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: block;
    opacity: 0.6;
    background: #e4e4e4;
    z-index: 99;
    text-align: center;
  }

  #loading>img {
    position: absolute;
    top: 40%;
    left: 45%;
    z-index: 100;
  }

  #loading>p {
    position: absolute;
    top: 57%;
    left: 43%;
    z-index: 101;
  }

  /* chatbot message */
  .chatbot-message-two {
    border: 1px solid #ccc;
    background-color: #f2f2f2;
    padding: 10px;
    margin: 10px 0;
    border-radius: 8px;
    max-width: 100%;
  }
  /* user message */
  .user-message-two {
    border: 1px solid #ccc;
    background-color: #f2f2f2;
    padding: 10px;
    margin: 10px 0;
    border-radius: 8px;
    max-width: 70%;
    clear: both; /* Ensure that the message does not wrap around other elements */
  }

  /* chatbot message container */
 .chat-container-two {
    position: fixed;
    bottom: 90px; /* Adjust this value to lift the chat container higher */
    right: 20px;
    display: flex; /* Use flexbox to keep chatbot and user input together */
    flex-direction: column; /* Stack the messages and input vertically */
    align-items: flex-end; /* Align items to the right side */
    max-width: 400px; /* Limit the container width */
  }

  /* user input container */
  .user-input-container-two {
    position: fixed;
    bottom: 30px; /* Adjust this value to lift the user input higher */
    right: 20px;
    display: flex; /* Use flexbox to align items horizontally */
    align-items: center; /* Center items vertically */
    background-color: #f2f2f2;
    border: 1px solid #ccc;
    border-radius: 20px;
    padding: 10px;
    max-width: 300px; /* Limit the container width */
  }

  .user-input-container-two input[type="text"] {
    flex: 1; /* Let the input take the remaining space */
    border: none;
    outline: none;
    background-color: transparent;
    margin-left: 10px;
    font-family: Arial, sans-serif;
    font-size: 16px;
  }

  .user-input-container-two button {
    border: none;
    background-color: transparent;
    cursor: pointer;
    font-family: Arial, sans-serif;
    font-size: 16px;
  }
  .resultTextArea {
	   width: 220px;
	   height: 200px;
	   border: 2px solid #ccc;
	   border-radius: 10px;
	   padding: 10px;
	   background-color: #fff;
	   color: #333;
	   font-family: Arial, sans-serif;
	   font-size: 16px;
	   line-height: 1.5;
	   white-space: pre-wrap;
	 }
	
	 
	 .resultTextArea::placeholder {
	   color: #999;
	 }
	 
	 .resultTextArea:focus {
	   border-color: #66afe9;
	 }
 
	</style>
	
</head>
<body>
<!-- logo -->
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- silde show -->
<jsp:include page="/WEB-INF/views/include/slide.jsp" />

  <!-- 특정 아이콘을 눌렀을 때 채팅창을 나타나도록 하기 위한 HTML 코드 -->
	<div id="chatIcon" style="position: fixed; bottom: 30px; right: 20px; cursor: pointer;">
	  <i class="xi-forum xi-3x"></i>
	</div>
  
  <div class="chat">
    <div class="chat-container-two" >
      <div class="chatbot-message-two">무엇을 도와드릴까요?</div>
      	<div id="result" class="resultTextArea"></div>
  	</div>
	  <div class="user-input-container-two">
		  <input type="text" id="keywords" name="keywords" required style="width:150px;" />
		  <button onclick="chatGPT()">확인</button>
	  </div>
  </div>

  <div id="loading">
    <img src="https://studentrights.sen.go.kr/images/common/loading.gif">
  </div>
  
  <script>
  	'use strict';
  	
  	 // 아이콘을 클릭했을 때 채팅창을 보이게 하는 함수
    function showChatContainer() {
      let chatContainer = document.querySelectorAll('.chat-container-two, .user-input-container-two');
      chatContainer.forEach((element) => {
        element.style.display = 'block';
      });
    }
 		
 		// 아이콘을 클릭 이벤트 처리
  	document.getElementById('chatIcon').addEventListener('click', showChatContainer);
  
    $(document).ready(function () {
      $('#loading').hide();
    });

    function chatGPT() {
    	let api_key = "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"  // <- API KEY 영신이꺼 입력
  	  let keywords = document.getElementById('keywords').value
      $('#loading').show();

      let messages = [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: 'user', content: keywords + '에 대하여 최대한 도움이 되는 답변을 해주세요.' },
      ]

      let data = {
        model: 'gpt-3.5-turbo',
        temperature: 0.5,
        n: 1,
        messages: messages,
      }

      $.ajax({
        url: "https://api.openai.com/v1/chat/completions",
        method: 'POST',
        headers: {
          Authorization: "Bearer " + api_key,
          'Content-Type': 'application/json',
        },
        data: JSON.stringify(data),
      }).then(function (response) {
        $('#loading').hide();
        console.log(response)
        let result = document.getElementById('result')
        let pre = document.createElement('pre')

        pre.innerHTML = "\n\n" + response.choices[0].message.content
        result.appendChild(pre)

        document.getElementById('keywords').value = ''
      });
    }
  </script>
<div class="container">
	<div class="text-center mt-5 mb-0" id="ps" style="padding-top:20px;">&nbsp;|&nbsp;다양한 상품을 둘러보세요&nbsp;|&nbsp;</div>
	<br /><span id="work1"><a href="${ctp}/recipe/recipeList"><b>상품 전체보기 ></b></a></span><br /><br />
	<div class="owl-carousel owl-theme">
		<c:forEach var="vo" items="${productVOS}">
		<div class="card shadow-none" style="width:79%; height:300px; border: 3px solid #f5f5f5;">
    	<div id="item"><a href="${ctp}/shop/itemContent?idx=${vo.idx}"><img src="${ctp}/product/${vo.thumbnail}" style="width:206px;height:193px;" /></a></div>
    		<div class="w3-container w3-center">
      		<div class="mt-2"><b>${vo.productName}</b></div>
      		<c:if test="${vo.discountRate != 0}">
			    	<div><font size="2em"><del><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</del></font></div>
			    	<div>
			    		<font size="3em" color="#f66f58">${vo.discountRate}%</font>&nbsp;
			    		<font size="3em" color="black"><fmt:formatNumber value="${vo.discount}" pattern="#,###"/>원</font>
		    		</div>
			    </c:if>
			    <c:if test="${vo.discountRate == 0}">
			    	<div><font size="3em"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font></div>
			    </c:if>
    		</div>
  	</div>
  	</c:forEach>
	</div>
	<div class="text-center mb-0" id="ps" style="padding-top:50px;">&nbsp;|&nbsp;맛있는 하루를 위한 레시피를 둘러보세요&nbsp;|&nbsp;</div>
	<br /><span id="work2" class="mb-0"><a href="${ctp}/recipe/recipeList"><b>레시피 전체보기 ></b></a></span><br /><br />
  <c:set var="cnt" value="0" />
  <c:forEach var="i"  begin="1" end="3">
	  <div class="row">
	    <c:forEach begin="1" end="3">
	      <div class="col mt-3 mb-5">
				    <a href="${ctp}/recipe/recipeContent?idx=${recipeVOS[cnt].idx}">
					    <div class="border" style="width:281px; height: 310px; background-color:#dedede">
					      <c:set var="file" value="${fn:split(recipeVOS[cnt].file,'/')}"/>
					      	<img src ="${ctp}/recipe/${file[0]}" width="280px" height="220px">
					      	<div class="card-body text-center">
					        <span id="en" class="card-text"><font color="black"><b>${recipeVOS[cnt].foodName}</b></font></span>
					        <br /><span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-signal-3 xi-x"></i>${recipeVOS[cnt].star}</font></span>&nbsp;&nbsp;
					        <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-time-o xi-x"></i>${recipeVOS[cnt].cookTime}</font></span>
					      </div>
					    </div>
				    </a>
				  </div>
				  <c:set var="cnt" value="${cnt + 1}"/>
		  </c:forEach>
	  </div>
  </c:forEach>
</div>
<p><br /><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	var owl = $('.owl-carousel');
	owl.owlCarousel({
	    loop:true,
	    nav:true,
	    margin:10,
	    responsive:{
	        0:{
	            items:1
	        },
	        600:{
	            items:3
	        },            
	        960:{
	            items:5
	        },
	        1200:{
	            items:4
	        }
	    }
	});
	owl.on('mousewheel', '.owl-stage', function (e) {
	    if (e.deltaY>0) {
	        owl.trigger('next.owl');
	    } else {
	        owl.trigger('prev.owl');
	    }
	    e.preventDefault();
	});

	// 천단위마다 콤마를 표시해 주는 함수
  function numberWithCommas(x) {
  	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
  }
</script>
</body>
</html>
