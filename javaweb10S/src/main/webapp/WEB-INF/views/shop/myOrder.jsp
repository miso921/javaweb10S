<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>myOrder.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
    // 배송지 정보보기
    function nWin(orderNum) {
    	var url = "${ctp}/shop/itemOrderDelivery?orderNum="+orderNum;
    	window.open(url,"itemOrderDelivery","width=600px,height=600px");
    }
    
   /*  $(document).ready(function() {
    	// 주문 상태별 조회 : 전체/결제완료/배송중~~
    	$("#orderStatus").change(function() {
	    	let orderStatus = $(this).val();
	    	location.href="${ctp}/shop/orderStatus?orderStatus="+orderStatus+"&pag=${pageVO.pag}";
    	});
    }); */
    
    // 날짜별 주문 조건 조회(오늘/일주일이내/보름이내~~)
    function orderCondition(conditionDate) {
    	location.href="${ctp}/shop/orderCondition?conditionDate="+conditionDate+"&pag=${pageVO.pag}";
    }
    
    // 날찌기간에 따른 조건검색
    function myOrderStatus() {
    	let startDateJumun = new Date(document.getElementById("startJumun").value);
    	let endDateJumun = new Date(document.getElementById("endJumun").value);
    	let conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="${ctp}/shop/myOrderStatus?pag=${pageVO.pag}&startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus;
    }
    
    // 결제완료일때만 결제취소
    function payCancle(orderNum) {
		  let ans = confirm("결제를 취소하시겠습니까?");
		  
		  if(!ans) location.reload();
		  else {
			 $.ajax({
				 type : "post",
				 url  : "${ctp}/shop/payCancle",
				 data : {orderNum : orderNum},
				 success : function() {
				 	alert("결제가 취소되었습니다!");
				 	location.href = "${ctp}/shop/myOrder";
				 },
				 error : function() {
					 alert("전송오류!");
				 }
			 }); 
		  }
	  }
    
   	function buyOkCheck(orderNum) {
		  let ans = confirm("구매확정을 하시겠습니까?");
		  
		  if(!ans) location.reload();
		  else {
			 $.ajax({
				 type : "post",
				 url  : "${ctp}/shop/buyOk",
				 data : {orderNum : orderNum},
				 success : function() {
				 	alert("구매확정이 완료되었습니다!");
				 	location.href = "${ctp}/shop/myOrder";
				 },
				 error : function() {
					 alert("전송오류!");
				 }
			 }); 
		  }
	  }
  </script>
  <style>
  	.orderCheck {font-family: 'RIDIBatang';}
		#hr1 {border:2px solid #937062;margin-left:auto;margin-right:auto;}
		a:hover {text-decoration:none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
<p><br/></p>
<div class="container">
	<c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="보름 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="한달 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="석달 이내 조회"/></c:if>
	<h2 class="text-center orderCheck">|&nbsp;주문/배송확인&nbsp;|</h2>
	<br /><hr id="hr1" /><br />
	<c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="보름 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="한달 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="석달 이내 조회"/></c:if>
  <table class="table table-borderless">
  	<tr>
  		<td class="text-center">
  			<c:choose>
			    <c:when test="${conditionDate == '1'}"><c:set var="conditionDate" value="오늘"/></c:when>
			    <c:when test="${conditionDate == '7'}"><c:set var="conditionDate" value="일주일이내"/></c:when>
			    <c:when test="${conditionDate == '15'}"><c:set var="conditionDate" value="보름이내"/></c:when>
			    <c:when test="${conditionDate == '30'}"><c:set var="conditionDate" value="한달이내"/></c:when>
			    <c:when test="${conditionDate == '90'}"><c:set var="conditionDate" value="석달이내"/></c:when>
			    <c:otherwise><c:set var="conditionDate" value="전체"/></c:otherwise>
			  </c:choose>
			  <input type="button" value="오늘" onclick="orderCondition(1)" class="w3-button w3-border w3-border-brown w3-round mr-1" />
        <input type="button" value="일주일이내" onclick="orderCondition(7)" class="w3-button w3-border w3-border-brown w3-round mr-1"/>
        <input type="button" value="보름이내" onclick="orderCondition(15)" class="w3-button w3-border w3-border-brown w3-round mr-1"/>
        <input type="button" value="한달이내" onclick="orderCondition(30)" class="w3-button w3-border w3-border-brown w3-round mr-1"/>
        <input type="button" value="3달이내" onclick="orderCondition(90)" class="w3-button w3-border w3-border-brown w3-round mr-1"/>
        <input type="button" value="전체조회" onclick="orderCondition(99999)" class="w3-button w3-border w3-border-brown w3-round mr-1"/>
  		</td>
  		<td></td>
  	</tr>
  	<c:if test="${sLevel == 0}">	<!-- 관리자일때 기간처리... -->
	    <tr>
	      <td class="text-center">
	        <c:if test="${startJumun == null}">
	          <c:set var="startJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="startJumun"><fmt:formatDate value="${startJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if>
	        <c:if test="${endJumun == null}">
	          <c:set var="endJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="endJumun"><fmt:formatDate value="${endJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if>
	        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
	        <select name="conditionOrderStatus" id="conditionOrderStatus">
	          <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
	          <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
	          <option value="배송완료"  ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매완료"  ${conditionOrderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	          <%-- <option value="반품처리"  ${conditionOrderStatus == '반품처리' ? 'selected' : ''}>반품처리</option> --%>
	        </select>
	        <input type="button" value="조회하기" class="w3-button w3-ripple w3-brown" onclick="myOrderStatus()"/>
	      </td>
	    </tr>
	    <tr>
	      <td class="text-right">
		      <a href="${ctp}/shop/itemCart" class="w3-button w3-border w3-border-brown w3-round">장바구니</a>
		      <a href="${ctp}/shop/itemList" class="w3-button w3-round w3-black">계속쇼핑하기</a>
	      </td>
	    </tr>  
    </c:if>
  </table>

	<table class="table table-hover">
    <tr style="text-align:center;background-color:#ccc;">
      <th>주문정보</th>
      <th>상품</th>
      <th>주문내역</th>
      <th>주문일자</th>
    </tr>
    <tr>
    	<td colspan="4" class="text-center"><c:if test="${productVos.length == 0}">오늘 구매하신 상품이 없습니다.</c:if></td>
    </tr>
    <c:set var="sw" value="0"/>
    <c:set var="temporderNum" value="0"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<!-- 같은 주문상품은 한번에 총 금액을 출력처리한다. -->
      <c:if test="${temporderNum != vo.orderNum}">
        <c:if test="${sw != 0}">
		      <tr class="bg-light">
		        <td colspan="4" class="p-0">
		          <div class="text-center m-3">주문번호 | ${temporderNum} / 총액 | <fmt:formatNumber value="${tempOrderTotalPrice}" />원</div>
		        </td>
		      </tr>
	      </c:if>
        <c:set var="temporderNum" value="${vo.orderNum}" />
        <c:set var="tempOrderTotalPrice" value="${vo.orderTotalPrice}" />
	      <c:set var="sw" value="1"/>
      </c:if>
      
      <tr>
        <td style="text-align:center;">
          <p>주문번호 | ${vo.orderNum}</p>
          <%-- <p>총 주문액 : <fmt:formatNumber value="vo.totalPrice"/>원</p> --%>
          <p><b>총 주문액 | <font color="#937062"><fmt:formatNumber value="${vo.orderTotalPrice}"/>원</font></b></p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderNum}')" class="w3-button w3-ripple w3-brown"></p>
          <c:if test="${vo.orderStatus eq '결제완료'}">
          	<p><input type="button" value="결제취소" onclick="payCancle(${vo.orderNum})" class="w3-button w3-ripple w3-red"></p>
          </c:if>
          <c:if test="${vo.orderStatus eq '구매완료' && vo.reviewCnt==0}">
          	<p><input type="button" value="후기작성" onclick="location.href='${ctp}/shop/reviewInput?productName=${vo.productName}&orderNum=${vo.orderNum}';" class="w3-button w3-ripple w3-green" ></p>
          </c:if>
          <c:if test="${vo.orderStatus eq '배송중' || vo.orderStatus eq '배송완료'}">
          	<p><input type="button" value="구매확정" onclick="buyOkCheck(${vo.orderNum})" class="w3-button w3-ripple w3-green" ></p>
          </c:if>
        </td>
        <td style="text-align:center;"><br/><a href="${ctp}/shop/itemContentProductName?productName=${vo.productName}"><img src="${ctp}/product/${vo.thumbnail}" class="thumb" width="100px"/></a></td>
        <td align="left">
	        <p><br/>상품명 | <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.totalPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align:center;"><br/>
          주문일자 | ${fn:substring(vo.orderDate,0,10)}<br/><br/>
          <font color="brown">${vo.orderStatus}</font><br/>
          <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
        </td>
      </tr>
      
      <c:if test="${st.last}">
        <c:set var="lastOrderTotalPrice" value="${vo.orderTotalPrice}"/>
        <c:set var="lastOrderNum" value="${vo.orderNum}"/>
      </c:if>
    </c:forEach>
    
    <tr class="bg-light">
      <td colspan="4" class="p-0">
        <div class="text-center m-3">주문번호 | ${lastOrderNum}&nbsp;&nbsp;&nbsp;&nbsp;총 구입금액 | <fmt:formatNumber value="${vo.totalPrice}" pattern="#,###원" /></div>
      </td>
    </tr>
    <tr><td colspan="4" class="p-0"></td></tr>
  </table>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${pageVO.totPage != 0}">
			  <c:if test="${pageVO.pag != 1}">
			    <li class="page-item"><a href="${ctp}/shop/myOrder?pag=1&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/shop/myOrder?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i == pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item active"><a href='${ctp}/shop/myOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item"><a href='${ctp}/shop/myOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="${ctp}/shop/myOrder?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="${ctp}/shop/myOrder?pag=${pageVO.totPage}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
  <hr/>
  <p class="text-center"><a href="${ctp}/shop/itemList" class="w3-button w3-round w3-black">계속쇼핑하기</a></p>
  <hr/>
<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>