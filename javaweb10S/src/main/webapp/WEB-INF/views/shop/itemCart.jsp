<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
  <title>itemCart.jsp(장바구니)</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';
    
    function onTotal(){
      let total = 0;
      let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx; i<=maxIdx; i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked) {  	// 장바구니에 들어있는 체크된 항목만을 총계를 구한다.
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value = total.toString();
      document.getElementById("showTotal").value = numberWithCommas(total);
      
      if(total >= 50000 || total == 0){
        document.getElementById("baesong").value = 0;
      } else {
        document.getElementById("baesong").value = 2500;
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);
    }

		// 상품 체크박스에 체크했을때 처리하는 함수
    function onCheck(){
      let minIdx = parseInt(document.getElementById("minIdx").value);				// 출력되어있는 상품중에서 가장 작은 idx값이 minIdx변수에 저장된다.
      let maxIdx = parseInt(document.getElementById("maxIdx").value);				// 출력되어있는 상품중에서 가장 큰  idx값이 maxIdx변수에 저장된다.
      
      // 상품 주문을 위한 체크박스에 체크가 되어있는것에 대한 처리루틴이다.
      // 상품주문 체크박스가 체크되어 있지 않은것에 대한 개수를 emptyCnt에 누적처리하고 있다. 즉, emptyCnt가 0이면 모든 상품이 체크되어 있다는 것으로 '전체체크버튼'을 true로 처리해준다.
      let emptyCnt=0;
      for(let i = minIdx; i <= maxIdx; i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          emptyCnt++;
          break;
        }
      }
      if(emptyCnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// allCheck 체크박스를 체크/해제할때 수행하는 함수
    function allCheck(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      if(document.getElementById("allcheck").checked){
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=minIdx; i<=maxIdx; i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// 장바구니에서 구매한 상품에 대한 '삭제'처리...
    function cartDelete(idx){
      let ans = confirm("선택하신 현재 상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/shop/itemCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    
		// 장바구니에서 선택한 상품만 '주문'처리하기
    function order(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){	// 해당 상품이 존재하면서, 구배한다고 체크가 되어있다면...
          document.getElementById("checkItem"+i).value="1";		// 주문을 선택한상품은 'checkItem고유번호'의 값을 1로 셋팅한다.
        }
      }
      document.myform.baesong.value=document.getElementById("baesong").value;		// 배송비
      
      // 장바구니에서 주문품목을 선택하지 않았을때는 메세지 띄우고, 선택시는 배송지 입력창으로 보내준다.
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
    
		// 천단위마다 쉼표처리
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
		
		// 체크한 상품 삭제
		function selCartDelete() {
		  let delItems = "";
		  let chkBoxes = document.querySelectorAll('.chk');
		  let isChecked = false;
		
		  for (let i = 0; i < chkBoxes.length; i++) {
		    if (chkBoxes[i].checked == true) {
		      isChecked = true;
		      delItems += chkBoxes[i].value + "/";
		    }
		  }
		
		  if (!isChecked) {
		    alert("삭제할 상품을 선택하세요!");
		    return;
		  }
		
		  let ans = confirm("선택한 상품을 모두 삭제하시겠습니까?");
		  if (!ans) return false;
		
		  delItems = delItems.substring(0, delItems.length - 1);
		
		  $.ajax({
		    type: "post",
		    url: "${ctp}/shop/selCartDelete",
		    data: {delItems: delItems},
		    success: function () {
		      alert("상품이 삭제되었습니다!");
		      location.reload();
		    },
		    error: function () {
		      alert("전송오류!");
		    }
		  });
		}
  </script>
  <style>
	  @font-face {
	    font-family: 'RIDIBatang';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
		}
    .totSubBox {
      background-color:#ddd;
      border : none;
      width : 95px;
      text-align : center;
      font-weight: bold;
      padding : 5 0px;
      color : brown;
    }
    td {padding:5px;}
    .container, h2 {font-family: 'SUITE-Regular';}
    .cart {font-family: 'RIDIBatang';}
    #pn	{font-family: 'EF_watermelonSalad';}
    #hr1 {border:2px solid #937062}
    #selDel:hover {cursor:pointer;color:}
    a:hover {text-decoration:none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center cart">|&nbsp;장바구니&nbsp;|</h2>
	<br/>
	<div>
		<input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/>&nbsp;전체선택
		<span onclick="selCartDelete()" id="selDel" style="margin-left:970px;">선택삭제</span>
	</div><hr id="hr1" />
		<form name="myform" method="post">
			<table class="table-borderless" style="margin: auto; width:90%">
				<c:forEach var="listVO" items="${cartListVOS}">
					<tr>
						<td><input type="checkbox" class="chk" name="idxChecked" id="idx${listVO.idx}" value="${listVO.idx}" onClick="onCheck()" /></td>			
						<td>
							<a href="${ctp}/shop/itemContent?idx=${listVO.productIdx}"><img src="${ctp}/product/${listVO.thumbnail}" width="150px"/></a>
						</td>
						<td>
							<span style="font-weight:bold;"><a href="${ctp}/shop/itemContent?idx=${listVO.productIdx}">${listVO.productName}</a></span><br/>
							<%-- <c:set var="optionNames" value="${fn:split(listVO.optionName,',')}"/>
			        <c:set var="optionPrices" value="${fn:split(listVO.optionPrice,',')}"/>
			        <c:set var="optionNums" value="${fn:split(listVO.optionNum,',')}"/> 
							<c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}"> --%>
								-&nbsp;${listVO.optionName}&nbsp;|&nbsp;<fmt:formatNumber value="${listVO.optionPrice}"/>원&nbsp;|&nbsp;${listVO.optionNum}개<br/>
							<%-- </c:forEach> --%>
						</td>
						<td class="font-weight-bold">
							총 금액&nbsp;<fmt:formatNumber value="${listVO.optionPrice*listVO.optionNum}"/>원
							<div style="color:#964b00;font-size:12px" class="buyFont">주문일자&nbsp;|&nbsp;${fn:substring(listVO.cartDate,0,10)}</div>
			        <input type="hidden" name="totalPrice" id="totalPrice${listVO.idx}" value="${listVO.optionPrice*listVO.optionNum}"/>
						</td>
						<td>
							<button type="button" onClick="cartDelete(${listVO.idx})" class="w3-button w3-ripple w3-brown w-5" style="border:0px;">&times;</button>
							<input type="hidden" name="checkItem" value="0" id="checkItem${listVO.idx}"/>	<!-- 구매체크가 되지 않은 품목은 '0'으로, 체크된것은 '1'로 처리하고자 한다. -->
			        <input type="hidden" name="idx" value="${listVO.idx }"/>
			        <input type="hidden" name="thumbnail" value="${listVO.thumbnail}"/>
			        <input type="hidden" name="productName" value="${listVO.productName}"/>
			        <input type="hidden" name="price" value="${listVO.price}"/>
			        <input type="hidden" name="optionName" value="${optionNames}"/>
			        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
			        <input type="hidden" name="optionNum" value="${optionNums}"/>
			        <!-- <input type="hidden" name="totalPrice" value="${listVO.totalPrice}"/> --> <!-- 배송비 포함한 상품 총 금액 -->
						  <input type="hidden" name="total" id="total" /> <!-- 배송비 미포함한 상품 총 금액 -->
			        <input type="hidden" name="mid" value="${sMid}"/>
		        </td>
					</tr>
		    </c:forEach>
			</table>
			<c:set var="minIdx" value="${cartListVOS[0].idx}"/>						<!-- 구매한 첫번째 상품의 idx -->
		  <c:set var="maxSize" value="${fn:length(cartListVOS)-1}"/>		
		  <c:set var="maxIdx" value="${cartListVOS[maxSize].idx}"/>			<!-- 구매한 마지막 상품의 idx -->
		  <input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
		  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
		  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
	    <input type="hidden" name="baesong"/>
		</form>
	<hr id="hr1" />
	<p class="text-center">
    <b style="font-size:18px;">총 주문액</b>&nbsp;&nbsp;5만원 이상 구매 시 배송비 무료
  </p>
  <table class="table-borderless text-center" style="margin:auto">
	  <tr>
	    <th>구매상품금액</th>
	    <th></th>
	    <th>배송비</th>
	    <th></th>
	    <th>총주문금액</th>
	  </tr>
	  <tr>
	    <td><input type="text" id="showTotal" value="0" class="totSubBox" readonly/></td>
	    <td>+</td>
	    <td><input type="text" id="baesong" value="0" class="totSubBox" readonly/></td>
	    <td>=</td>
	    <td><input type="text" id="lastPrice" value="0" class="totSubBox" readonly/></td>
	  </tr>
	</table>
	<br/>
	<div class="text-center">
	  <button class="w3-button w3-ripple w3-brown w-10" onClick="order()">주문</button> &nbsp;
	  <button class="w3-button w3-border w3-border-brown w3-round w-10" onClick="location.href='${ctp}/shop/itemList';">둘러보기</button>
	</div>
	<br/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>