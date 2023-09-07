<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <style>
      .layer  {
      border:0px;
      width:100%;
      padding:10px;
      margin-left:1px;
      background-color:#eee;
    }
    .numBox {width:40px}
    .price  {
      width:160px;
      background-color:#eee;
      text-align:right;
      font-size:1.2em;
      border:0px;
      outline: none;
    }
    .totalPrice {
      text-align:right;
      margin-right:10px;
      color:#f63;
      font-size:1.5em;
      font-weight: bold;
      border:0px;
      outline: none;
    }
    .container {font-family:'SUITE-Regular';}
    h3, del {font-family:'EF_watermelonSalad';font-weight:bold;}
    .ss {font-size: 18px;}
    .pp {font-size: 15px;}
    #selectOption {border:1px solid orange;}
    #selectOption:focus {border:1px solid orange;}
	</style>
</head>
  <script>
  	'use strict';
  	
  	let idxArray = new Array();		/* 배열의 개수 지정없이 동적배열로 설정하고있다. */
    
  	// 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수
    $(function(){
    	$("#selectOption").change(function(){
    		let selectOption = $(this).val();
    		let idx = selectOption.substring(0,selectOption.indexOf(":"));					// 현재 옵션의 고유번호
    		let optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));	// 옵션명
    		let optionPrice = selectOption.substring(selectOption.indexOf("_")+1);	// 옵션가격
    		let commaPrice = numberWithCommas(optionPrice);			// 콤마붙인 가격
    		
    		// 선택박스의 내용을 한개라도 선택하게된다면 선택된 옵션의 '고유번호/옵션명/콤마붙인가격'을 화면에 출력처리해준다.
    		if($("#layer"+idx).length == 0 && selectOption != "") {		// 옵션이 하나라도 있으면 처리하게 된다.
    		  idxArray[idx] = idx;
    		  
	    		let str = '';
	    		str += '<div class="layer row optName" id="layer'+idx+'"><div class="col">'+optionName+'</div>';
	    		str += '<input type="hidden" name="itemName" value="'+optionName+'"/>';
	    		str += '<input type="number" class="text-center numBox" id="numBox'+idx+'" name="optionNum" onchange="numChange('+idx+')" value="1" min="1"/> &nbsp;';
	    		str += '<input type="text" id="imsiPrice'+idx+'" class="price" value="'+commaPrice+'" readonly />';
	    		str += '<input type="hidden" id="price'+idx+'" value="'+optionPrice+'"/> &nbsp;';			/* 변동되는 가격을 재계산하기위해 price+idx 아이디를 사용하고 있다. */
	    		str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove('+idx+')" value="삭제"/>';
	    		str += '<input type="hidden" name="statePrice" id="statePrice'+idx+'" value="'+optionPrice+'"/>';		/* 현재상태에서의 변경된 상품(옵션)의 가격이다. */
	    		str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
	    		str += '<input type="hidden" name="optionName" value="'+optionName+'"/>';
	    		str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
	    		str += '</div>';
	    		$("#product1").append(str);
	    		onTotal();
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  $("div").remove("#layer"+idx);
  	  
  	  // 옵션내역이 1개라도 있으면 가격을 재계산하고, 없으면 reload한다.
  	  // if(document.getElementsByTagName('optionNum')[0].hasAttribute('type')) onTotal();
  	  // if(document.getElementsByTagName('optionNum')) onTotal();
  	  // if(document.getElementsByName('optionNum')) onTotal();
  	  if($(".price").length) onTotal();
  	  else location.reload();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  let total = 0;
  	  for(let i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;
  		  }	
  	  }
	    let discountRate = document.getElementById("discountRate").value;
  	  let discountPrice = total - (total * (discountRate / 100));
  	  document.getElementById("totalPrice").value = numberWithCommas(discountPrice);
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;
    	onTotal();
    }
    
    // 장바구니 호출시 수행함수
    /* function cart() {
    	//let basic = $("#basic option:selected").text();
    	
    	if('${sMid}' == "") {
    		alert("로그인 후 구매가능합니다!");
    		location.href="${ctp}/member/memberLoginJoin";
	    }
	    else if(document.getElementById("totalPrice").value==0) {
				alert("옵션을 선택해주세요");
	    	return false;
    	}
    } */
    
    // 장바구니 호출 시 실행 함수
    function cart() {
    	let totalPrice = document.getElementById("totalPrice").value;
    	
    	if('${sMid}' == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memberLoginJoin";
    	}
    	else if(totalPrice=="" || totalPrice==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		document.getElementById("flag").value = "order";
    		document.myform.submit();
    	}
    }
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
    
    // 상품 삭제 처리
    function productDelete(idx) {
    	let ans = confirm("선택한 상품을 삭제하시겠습니까?");
    	
    	if(!ans) location.reload();
    	else {
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/admin/product/productDelete",
	    		data : {idx : idx},
	    		success : function() {
	    			alert("상품이 삭제되었습니다!");
	    			location.href = "${ctp}/admin/product/productList";
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <div class="row">
    <div class="col p-3 text-center" style="border:none;">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/product/${productVO.thumbnail}" width="90%"/>
		  </div>
		</div>
		<div class="col p-3 text-left">
		  <!-- 상품 기본정보 -->
		  <div><h3 class="ml-4">${productVO.productName}</h3></div>
		  <c:if test="${productVO.discountRate == 0}">
			  <div>
			    <h4 class="ml-4 mt-4"><fmt:formatNumber value="${productVO.price}"/>원</h4>
			  </div>
		  </c:if>
		  <c:if test="${productVO.discountRate != 0}">
			  <div>
			  	<del class="text-right pp" style="margin-left:360px;"><fmt:formatNumber value="${productVO.price}"/>원</del>
			  </div>
			  <div>
			    <span><h2 class="text-right ml-4"><font color="orange" class="text-left">${productVO.discountRate}%</font>&nbsp;<fmt:formatNumber value="${productVO.discount}" />원</h2></span>
			  </div>
		  </c:if>
		  <hr />
		  <div class="ss ml-4"><b>배송</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50,000원 이상 구매 시 무료배송</div>
		  <div class="ss ml-4"><b>원산지</b>&nbsp;&nbsp;각 상품별 상세설명 참조</div>
		  <hr /><br />	
		  <!-- 상품주문을 위한 옵션정보 출력 -->
		  <div class="form-group">
		    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
		      <select size="1" id="selectOption" class="text-center" style="width:200px;height:50px;">
		        <option value="" disabled selected>상품옵션선택</option>
		        <c:forEach var="vo" items="${optionVOS}">
		          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
		        </c:forEach>
		      </select>
		       	<!-- 상품삭제/옵션등록 처리 -->
			    <input type="button" value="상품삭제" onclick="productDelete('${productVO.idx}');" class="w3-button w3-border w3-border-brown w3-round mr-2 ml-2" style="width:100px;height:50px;" />
			    <input type="button" value="옵션등록" onclick="location.href='${ctp}/admin/product/productOptionInput?productName=${productVO.productName}';" class="w3-button w3-ripple w3-brown mr-2" style="width:110	px;height:50px;" />
			    <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/product/productList';" class="w3-button w3-border w3-border-red w3-round ml-2" style="width:100px;height:50px;" />
		    </form>
		  </div>
		  <br />
		  <div>
			  <form name="myform" method="post" action="${ctp}/shop/itemContent">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
			    <input type="hidden" name="mid" value="${sMid}"/>
			    <input type="hidden" name="productIdx" value="${productVO.idx}"/>
			    <input type="hidden" name="productName" value="${productVO.productName}"/>
			    <input type="hidden" name="price" value="${productVO.price}"/>
			    <input type="hidden" name="thumbnail" value="${productVO.thumbnail}"/>
			    <input type="hidden" name="discountRate" id="discountRate" value="${productVO.discountRate}" />
			    <input type="hidden" name="discount" id="discount" value="${productVO.discount}" />
			    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
			    <input type="hidden" name="flag" id="flag"/>

			    <div id="product1"></div>
			  </form>
		  </div>
		  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
		  <div>
		    <hr/>
		    <div>
			    <span><font size="4" color="black"><b>총 상품금액</b></font></span>
		    	<!-- 아래의 id와 class이름인 totalPrice는 출력용으로 보여주기위해서만 사용한것으로 값의 전송시와는 관계가 없다. -->
	        <b><input type="text" class="totalPrice" id="totalPrice" name="totalPrice" value="<fmt:formatNumber value='0' />" readonly />&nbsp;원</b>
		    </div>
		  </div>
		  <br/>
		</div>
  </div>
  <br/><br/>
  <!-- 상품 상세설명 보여주기 -->
  <div id="content" class="text-center"><br/>
    <img src="${ctp}/product/${productVO.content}">
  </div>
</div>
<p><br/></p>
</body>
</html>