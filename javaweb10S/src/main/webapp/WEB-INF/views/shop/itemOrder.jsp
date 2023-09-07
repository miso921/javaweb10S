<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>itemOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    let x = $(event.target).text();         // active tab
		    let y = $(event.relatedTarget).text();  // previous tab
		  });
		});
  
	  // 결제하기
    function order() {
		  let paymentCard = document.getElementById("paymentCard").value;
    	let payMethodCard = document.getElementById("payMethodCard").value;
		  let paymentBank = document.getElementById("paymentBank").value;
    	let payMethodBank = document.getElementById("payMethodBank").value;
    	if(paymentCard == "" && paymentBank == "") {
    		alert("결제방식과 결제번호를 입력하세요.");
    		return false;
    	}
    	if(paymentCard != "" && payMethodCard == "") {
    		alert("카드번호를 입력하세요.");
    		document.getElementById("payMethodCard").focus();
    		return false;
    	}
    	else if(paymentBank != "" && payMethodBank == "") {
    		alert("입금자명을 입력하세요.");
    		return false;
    	}
    	let ans = confirm("결제하시겠습니까?");
    	if(ans) {
    		if(paymentCard != "" && payMethodCard != "") {
    			document.getElementById("payment").value = "C"+paymentCard;
    			document.getElementById("payMethod").value = payMethodCard;
    		}
    		else {
    			document.getElementById("payment").value = "B"+paymentBank;
    			document.getElementById("payMethod").value = payMethodBank;
    		}
	    	myform.action = "${ctp}/shop/payment";
	    	myform.submit();
    	}
    }
	  
	  // 적립금 사용
	  $(document).ready(function() {
		  // id="point" 입력값이 변경될 때마다 처리
		  $("#point").change(function(){
			  usedPointCheck();
		  });
	  });
	  
	  function usedPointCheck() {
		  let totalAmount = parseInt($("#amount").val()); // 총 결제금액
		  let usedPoint = parseInt($("#point").val());   // 사용하려는 적립금
		  let originPoint = parseInt($("#originPoint").val()); // 보유한 적립금
		  /* let originTotalPrice = parseInt($("#originTotalPrice").val()); */ // 원래 총 결제금액
		  
		  // 사용할 적립금이 보유한 적립금보다 크다면 알림 
		  if(originPoint < usedPoint) {
			  alert("사용 적립금은 보유 적립금보다 클 수 없습니다.(보유 적립금 : " +originPoint+ "원)");
			  $("#point").val(originPoint);
		  }
		  // 사용할 적립금이 총 결제금액보다 크다면 알림
		  /* if(originTotalPrice <= usedPoint) {
			  alert("사용 적립금은 결제액보다 클 수 없습니다.(" +totalAmount+ "원)");
			  $("input[name='point']").val(originPoint);
		  } */  
		  calculator();
	  }
	  
	  function calculator() {
		  let totalAmount = parseInt($("#amount").val()); // 총 결제금액
		  let usedPoint = parseInt($("#point").val());   // 사용하려는 적립금
		  myform.usedPoint.value = usedPoint;
		  
		  let originPoint = parseInt($("#originPoint").val()); // 보유한 적립금
		  /* let originTotalPrice = parseInt($("#originTotalPrice").val()); */   // 원래 총 결제금액
			  
		  // 계산된 총 결제금액 = 총 결제금액 - 적립금, 0보다 작으면 총 결제금액을 0으로 처리
			let calAmount = Math.max(totalAmount - usedPoint, 0);
			
		  // 계산된 결제금액을 출력할 input 요소에 반영
		  $("input[id='amount']").val(calAmount);
		
		  // calAmount를 포맷팅하여 원하는 요소에 보여줌
		  let formattedAmount = numberWithCommas(calAmount); // 적절한 포맷팅 함수를 사용하여 calAmount 값을 포맷팅
		  $("#usedPointPrice").text(formattedAmount + "원");
		  $("input[id='usedPointPrice']").val(calAmount);
		  
		  // 사용 후 사용한 적립금을 출력
		  let rePoint = originPoint - usedPoint;
		  let formattedRePoint = numberWithCommas(rePoint);
		  $("#afterPoint").text(formattedRePoint + "원");
	  } 
	  
		// 천단위마다 쉼표처리
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  }

	  
  </script>
  <style>
    td, th {padding: 5px}
    h2 {font-family: 'RIDIBatang';}
    h3, .cn {font-family:'SUITE-Regular';font-weight:bold;}
    #payMethodCard, #payMethodBank {
     border-left-width:0;
		 border-right-width:0;
		 border-top-width:0;
		 border-bottom-width:1;
		 width:150px;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<h2 class="text-center mb-4">|&nbsp;주문내역&nbsp;|</h2>
	<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="100%" />
		<table class="table-borderless" style="margin: auto; width:90%">
			<c:forEach var="vo" items="${sOrderVOS}" varStatus="st">
			  <c:set var="imsiProductName" value="${vo.productName}"/>
				<c:if test="${st.index eq 0}">
  				<tr>주문번호 : ${vo.orderNum}</tr>
				</c:if>
				<!-- 주문서 목록출력 -->
  			<c:set var="orderTotalPrice" value="0"/>
				<tr>
					<td>
						<a href="${ctp}/shop/itemContent?idx=${vo.productIdx}"><img src="${ctp}/product/${vo.thumbnail}" width="150px"/></a>
					</td>
					<td>
						<span style="font-weight:bold;"><a href="${ctp}/shop/itemContent?idx=${vo.productIdx}">${vo.productName}</a></span><br/>
						<c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
		        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
						<c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
							<&nbsp;${optionNames[i]}&nbsp;|&nbsp;<fmt:formatNumber value="${optionPrices[i]}"/>원&nbsp;|&nbsp;${optionNums[i]}개&nbsp;><br/>
						</c:forEach>
					</td>
					<td class="font-weight-bold">
						총&nbsp;<fmt:formatNumber value="${vo.totalPrice}"/>원
		        <input type="hidden" id="totalPrice${listVO.idx}" value="${listVO.totalPrice}"/>
					</td>
				</tr>
				<c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
	    </c:forEach>
		</table>
		<div style="padding:8px; background-color:#eee;text-align:center;">
  		총 주문(결제) 금액 : 상품가격(<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>) +
      배송비(<fmt:formatNumber value="${sOrderVOS[0].baesong}" pattern='#,###원'/>) =
      총 <font size="4" color="orange"><b><span id="usedPointPrice"><fmt:formatNumber value="${orderTotalPrice + sOrderVOS[0].baesong}" pattern='#,###원'/></span></b></font>
		</div>
		<hr />
  		
		<p><br/></p>
		<p><br/></p>
		<form name="myform" method="post">
			<h2 class="text-center mb-4">|&nbsp;배송지 및 결제수단&nbsp;|</h2>
			<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="100%" />
			<table class="table table-borderless">
				<tr>
					<td class="td" style="text-align:center;">
						<%-- <span style="margin-left:-125px;" class="mr-3"><b>구매자</b></span><span style="color:#760c0c;font-size:20px;margin-left:5px;">${memberVO.name}</span> --%>
						<label for="buyer_name" class="mr-3" style="font-weight:bold;">구매자</label>
						<input type="text" id="buyer_name" name="buyer_name" value="${memberVO.name}" class="w3-input w3-border w3-round-xlarge" style="width:220px;display:inline-block;margin-right:-40px;" />
					</td>
				</tr>
				<tr>
					<td class="td" style="text-align: center;">
						<label for="buyer_email" class="mr-3" style="font-weight:bold;">이메일</label>
						<input type="email" id="buyer_email" name="buyer_email" value="${memberVO.email}" class="w3-input w3-border w3-round-xlarge" style="width:220px;display:inline-block;margin-right:-40px;" />
					</td>
				</tr>
				<tr>
					<td class="td" style="text-align: center;">
						<label for="buyer_tel" class="mr-3" style="font-weight:bold;margin-right:-60px;">구매자 연락처</label>
						<input type="email" id="buyer_tel" name="buyer_tel" value="${memberVO.tel}" class="w3-input w3-border w3-round-xlarge" style="width:220px;display: inline-block;" />
					</td>
				</tr>
				<tr>
					<td class="td" style="text-align: center;">
						<label for="buyer_postcode" style="font-weight:bold;margin-left:-230px;">구매자 주소</label>
						<c:set var="addr" value="${fn:split(memberVO.address,'/')}"/>
						<input type="text" name="buyer_postcode" value="${addr[0]}" class="w3-input w3-border w3-round-xlarge" style="width:80px;margin-left:490px;margin-top:-35px;" />
			   	 	<input type="text" name="buyer_addr" value="${addr[1]}${addr[2]}${addr[3]}" style="width:400px;margin-left:490px;" class="w3-input w3-border w3-round-xlarge mt-2"/>
			   	 	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="w3-button w3-round w3-brown" style="margin-left:200px;margin-top:-81px;">
					</td>
				</tr>
				<tr>
					<td class="td" style="text-align: center;">
						<label for="buyer_postcode" style="font-weight:bold;margin-left:-230px;">배송 요청사항</label>
						<select name="message" class="w3-input w3-border w3-round-xlarge" style="width:250px;margin-left:490px;margin-top:-35px;">
				      <option>부재중 시 경비실에 맡겨주세요.</option>
				      <option>빠른 배송부탁합니다.</option>
				      <option>부재중 시 현관문 앞에 놓아주세요.</option>
				      <option>배송 전 미리 연락주세요.</option>
				    </select>
					</td>
				</tr>
				<tr>
					<td class="td" style="text-align: center;">
						<label for="point" class="mr-3" style="font-weight:bold;margin-left:-110px;">보유 적립금&nbsp;|&nbsp;<font color="#937062;"><fmt:formatNumber value="${memberVO.point}" pattern='#,###원'/></font></label>
						<input type="text" id="point" name="point" value="0" class="w3-input w3-border w3-round-xlarge" style="width:150px;display:inline-block;" /><br />
						<div style="margin-top:10px;">사용 후 적립금 | <span id="afterPoint"></span></div>
					</td>
				</tr>
				<tr>
					<td>
						<label for="amount" style="font-weight:bold;margin-left:400px;">총 결제금액</label>
					  <%-- <td><input type="text" name="amount" value="${orderTotalPrice}" class="form-control" /> --%>
					  <input type="text" name="amount" id="amount"  value="${orderTotalPrice + sOrderVOS[0].baesong}" class="w3-input w3-border w3-round-xlarge" style="width:150px;margin-left:490px;margin-top:-35px;" readonly />
					  
				  </td>
				</tr>
			</table>
			<br />
		
	  <!-- Nav tabs-->
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결제</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">무통장입금</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
	  </ul>
	
	  <!--  Tab panes-->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <h3>카드결제</h3>
	      <p>
	        <select name="paymentCard" id="paymentCard">
	          <option value="">카드선택</option>
	          <option>국민카드</option>
	          <option>현대카드</option>
	          <option>신한카드</option>
	          <option>농협카드</option>
	          <option>BC카드</option>
	          <option>롯데카드</option>
	          <option>삼성카드</option>
	          <option>LG카드</option>
	        </select>
	      </p>
				<p class="cn font-weight-bold">카드번호&nbsp;&nbsp;|&nbsp;&nbsp;<input type="text" name="payMethodCard" id="payMethodCard" /></p>
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <h3>무통장입금</h3>
	      <p>
	        <select name="paymentBank" id="paymentBank">
	          <option value="">은행선택</option>
	          <option value="국민은행">국민(111-111-111)</option>
	          <option value="신한은행">신한(222-222-222)</option>
	          <option value="우리은행">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p class="cn font-weight-bold">입금자명&nbsp;&nbsp;|&nbsp;&nbsp;<input type="text" name="payMethodBank" id="payMethodBank"/></p>
	    </div>
	    <div id="telCheck" class="container tab-pane fade"><br>
	      <h3>전화상담</h3>
	      <p>콜센터(☎) : 02-1234-1234</p>
	    </div>
	  </div>
		<div align="center">
		  <button type="button" class="w3-button w3-border w3-border-brown w3-round w-25" onClick="order()">결제하기</button> &nbsp;
			<button type="button" class="w3-button w3-ripple w3-brown w-25" onclick="location.href='${ctp}/shop/itemCart';">장바구니보기</button> &nbsp;
		  <button type="button" class="w3-button w3-round w3-red" onClick="location.href='${ctp}/shop/itemList';">계속 쇼핑하기</button>
		  <%-- <a href="${ctp}/dbShop/dbShopList" class="btn btn-secondary">계속쇼핑하기</a> --%>
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
    <%-- <input type="hidden" name="oIdx" value="${oIdx}"/> --%>  						<!-- 주문테이블 고유번호 -->
	  <input type="hidden" name="orderNum" value="${orderNum}"/>  							<!-- 주문번호 -->
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>	<!-- 최종 구매(결제)금액 -->
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>			<!-- 결제종류 : 카드/계좌이체 등. -->
	  <input type="hidden" name="payMethod" id="payMethod"/>	<!-- 결제방법중에서 카드번호/계좌번호 등. -->
	  <input type="hidden" name="name" value="${imsiProductName}"/>	<!-- 결제창으로 넘겨줄 모델명 -->
	  <input type="hidden" id="originPoint" value="${memberVO.point}" />	<!-- 전체 적립금 -->
	  <input type="hidden" id="rePoint" />	<!-- 사용 후 남은 적립금 -->
	  <input type="hidden" name="usedPoint" />	<!-- 사용한 적립금 -->
	  <input type="hidden" value="${orderTotalPrice}"/>	<!-- 결재창으로 넘겨줄 결제금액 name="amount" -->
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>