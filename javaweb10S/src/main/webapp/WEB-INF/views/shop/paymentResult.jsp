<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentResult.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
	  function nWin(orderNum) {
	  	let url = "${ctp}/shop/itemOrderDelivery?orderNum="+orderNum;
	  	window.open(url,"itemOrderDelivery","width=600px,height=600px");
	  }
  </script>
  <style>
		.payResult {font-family: 'RIDIBatang';}
		#hr1 {border:2px solid #937062;margin-left:auto;margin-right:auto;width:100%;}
		.oi {color:#937062;font-size:20px;}
		.odi {font-size:17px;font-weight:bold;}
		a:hover {text-decoration:none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
<div class="container text-center">
	<i class="xi-receipt xi-5x mb-4"></i><br />
	<h2 class="text-center payResult">|&nbsp;결제내역&nbsp;|</h2>
	<br /><hr id="hr1" /><br />
	<table class="table-borderless" style="margin:auto;">
		<tr>
			<th class="oi">상품명&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.name}</td>
		</tr>
		<tr>
			<th class="oi">주문금액&nbsp;|&nbsp;</th>
			<td class="odi"><fmt:formatNumber value="${itemDeliveryVO.orderTotalPrice}" pattern='#,###원'/>&nbsp;(사용한 적립금:${usedPoint}원)</td>
		</tr>
		<tr>
			<th class="oi">주문자&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.buyer_name}</td>
		</tr>
		<tr>
			<th class="oi">주문자 이메일&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.buyer_email}</td>
		</tr>
		<tr>
			<th class="oi">주문자 연락처&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.buyer_tel}</td>
		</tr>
		<tr>
			<th class="oi">주문자 주소&nbsp;|&nbsp;</th>
			<td class="odi">(${sPayMentVO.buyer_postcode})&nbsp;${sPayMentVO.buyer_addr}</td>
		</tr>
		<tr>
			<th class="oi">결제 고유ID&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.imp_uid}</td>
		</tr>
		<tr>
			<th class="oi">결제 상점 거래 ID&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.merchant_uid}</td>
		</tr>
		<tr>
			<th class="oi">결제 금액&nbsp;|&nbsp;</th>
			<td class="odi"><fmt:formatNumber value="${sPayMentVO.paid_amount}" pattern='#,###원'/></td>
		</tr>
		<tr>
			<th class="oi">카드 승인번호&nbsp;|&nbsp;</th>
			<td class="odi">${sPayMentVO.apply_num}</td>
		</tr>
	</table>
	<br /><br /><br />
	
	<h2 class="text-center payResult">|&nbsp;주문완료&nbsp;|</h2>
	<br /><hr id="hr1" />
	<table class="table-borderless" style="margin: auto; width:90%">
		<tr>
		<c:forEach var="vo" items="${orderVOS}">
			<td>
				<img src="${ctp}/product/${vo.thumbnail}" width="100px"/>
			</td>
			<td>
				<p>주문번호&nbsp;|&nbsp;${vo.orderNum}</p>
      	<p>총 주문액&nbsp;|&nbsp;<fmt:formatNumber value="${itemDeliveryVO.orderTotalPrice}" pattern='#,###원'/></p>
        <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderNum}')" class="btn btn-success"></p>
        
			</td>
			<td>
				<p><br/>상품명&nbsp;|&nbsp;${vo.productName}<br/>&nbsp;&nbsp;<fmt:formatNumber value="${vo.totalPrice}"/>원</p><br/>
        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
        <p>
        <p>
          - 주문 내역
          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
            &nbsp; &nbsp;ㆍ${optionNames[i-1]}/<fmt:formatNumber value="${optionPrices[i-1]}"/>원/${optionNums[i-1]}개<br/>
          </c:forEach>
        </p>
			</td>
			<td><br/><font color="#9b111e">결제완료</font><br/>(배송준비중)</td>
		</c:forEach>	
		</tr>
	</table>
  <hr/>
  <p class="text-center"><a href="${ctp}/shop/itemList" class="w3-button w3-ripple w3-brown w-10">계속쇼핑하기</a> &nbsp;
    <a href="${ctp}/shop/myOrder" class="w3-button w3-border w3-border-brown w3-round w-10">구매내역보기</a>
  </p>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>