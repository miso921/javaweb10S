<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>책(의)세계</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
 		.pill-nav a {
		  display: inline-block;
		  color: black;
		  text-align: center;
		  padding: 8px 20px;
		  text-decoration: none;
		  font-size: 17px;
		  border-radius: 5px;
		}
		.pill-nav a:hover {
		  background-color: #ddd;
		  color: black;
		}
		.pill-nav a.active {
		  background-color: #F5EBE0;
		  color: #282828;
		}
		a:link {text-decoration: none;}
		a:visited {text-decoration: none;}
		a:hover {text-decoration: none;}
		a:active {text-decoration: none;}
		
		.magazineHover:hover { 
	    text-decoration: none;
	  	color: #ffa0c5;
		}
		
		#back-to-top {
		  display: inline-block;
		  background-color: #282828;
		  width: 50px;
		  height: 50px;
		  text-align: center;
		  border-radius: 4px;
		  position: fixed;
		  bottom: 30px;
		  right: 30px;
		  transition: background-color .3s, opacity .5s, visibility .5s;
		  opacity: 0;
		  visibility: hidden;
		  z-index: 1000;
		}
		#back-to-top::after {
		  content: "\f077";
		  font-family: FontAwesome;
		  font-weight: normal;
		  font-style: normal;
		  font-size: 2em;
		  line-height: 50px;
		  color: #fff;
		}
		#back-to-top:hover {
		  cursor: pointer;
		  text-decoration: none;
		  background-color: #333;
		}
		#back-to-top:active {
		  background-color: #555;
		}
		#back-to-top.show {
		  opacity: 1;
		  visibility: visible;
		}
		.infoBox {
    	border: 4px solid #e8e8e8;
    	width: 100%;
    	height: 100%;
    	max-height: 200px;
    	box-sizing: border-box;
    	background-color: white;
    	overflow: auto;
    	padding: 20px
    }
	</style>
	<script>
		'use strict';
		
		// 맨 위로 스크롤
		$(function(){
		  $('#back-to-top').on('click',function(e){
		      e.preventDefault();
		      $('html,body').animate({scrollTop:0},600);
		  });
		  
		  $(window).scroll(function() {
		    if ($(document).scrollTop() > 100) {
		      $('#back-to-top').addClass('show');
		    } else {
		      $('#back-to-top').removeClass('show');
		    }
		  });
		});
		
		// 처음 총 (장바구니에 저장된)상품 금액 보여주기
		$(function() {
				let res = 0;
				$("input[name=tempTotalPrice]").each(function(index, item){
					res = res + parseInt($(item).val());
			  });
				
				document.getElementById("cartPrice").value = numberWithCommas(res)+ "  원";
		});
		
		function numChange(opPrice, idx, flag) {
			let num = document.getElementById("num"+idx).value;
			
			if(flag == 'minus') {
				if(num <= 1) {
					alert('최소 주문수량은 1개 입니다.');
					num = 1;
				}
				else num--;
			}
			
			if(flag == 'plus') {
				if(num >= 99) {
					alert('최대 주문수량은 99개 입니다.');
					num = 99;
				}
				else num++;
			}
			
			document.getElementById("num"+idx).value = num;
    	let price = opPrice * num;
    	document.getElementById("price"+idx).value = price;
    	document.getElementById("totalPrice"+idx).value = numberWithCommas(price) + " 원";
    }
		
		// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
		
		// 수량 변경
		function numUpdate(idx) {
			let num = document.getElementById("num"+idx).value;
			let price = document.getElementById("price"+idx).value;
			
			$.ajax({
    		type  : "post",
    		url   : "${ctp}/order/cartProdNumUpdate",
    		data  : {
				  memNickname  : '${sNickname}',
    			idx : idx,
    			num : num,
    			totalPrice : price
				},
    		success:function() {
    			alert("수량이 변경되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	}); 
		}
		
		/* 체크박스 전체선택, 전체해제 */
		function checkAll(){
	    if( $("#th_checkAll").is(':checked') ){
	      $("input[name=checkRow]").prop("checked", true);
	      
	    }else{
	      $("input[name=checkRow]").prop("checked", false);
	    }
	    
	    // 체크된 값 계산해서 결제예정금액에 넣어주기
	    let res = 0;
		  $( "input[name='checkRow']:checked" ).each (function() {
		    
			  $("#tempTotalPrice"+$(this).val()).each(function(index, item){
					res = res + parseInt($(item).val());
			  });
		    
		  });
			document.getElementById("totalPrice").value = numberWithCommas(res)+ "  원";
		}
		
		/* 개별 박스 선택할 때도 똑같이 처리 */
		function tempTotalPriceChange() {
			
	    // 체크된 값 계산해서 결제예정금액에 넣어주기
	    let res = 0;
		  $( "input[name='checkRow']:checked" ).each (function() {
		    
			  $("#tempTotalPrice"+$(this).val()).each(function(index, item){
					res = res + parseInt($(item).val());
			  });
		    
		  });
			document.getElementById("totalPrice").value = numberWithCommas(res)+ "  원";
			
			// 전체 해제한 경우 '전체 선택' 체크박스도 해제시켜주기
			if($( "input[name='checkRow']:checked" ).length == 0) {
				$("input[name=checkAll]").prop("checked", false);
			}
		}
		
		/* 삭제(체크박스된 것 전부) */
		function deleteAction(){
		  let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function() {
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("삭제할 상품을 선택해주세요.");
		    return false;
		  }
		 
		  if(confirm("선택한 상품을 삭제하시겠습니까?")) {
		      
 	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/order/cartIdxesDelete",
	    	  data : {checkRow : checkRow},
	    	  success : function(res) {
    				alert("선택한 상품이 삭제되었습니다.");
    				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 개별 삭제
		function deleteOne(idx) {
			if(confirm("선택한 상품을 삭제하시겠습니까?")) {
	      
	      $.ajax({
	    	  type : "post",
	    	  url : "${ctp}/order/cartIdxDelete",
	    	  data : {idx : idx},
	    	  success : function(res) {
	  				alert("선택한 상품이 삭제되었습니다.");
	  				location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류! 재시도 부탁드립니다.");
	    		}
	    	}); 
		  }
		}
		
		// 관심 등록
		function saveInsert(type,prodIdx,prodName,prodPrice,prodThumbnail) {
			
			$.ajax({
    		type  : "post",
    		url   : "${ctp}/order/saveInsert",
    		data  : {
				  memNickname  : '${sNickname}',
				  type : type,
				  prodIdx : prodIdx,
    			prodName : prodName,
    			prodPrice : prodPrice,
    			prodThumbnail : prodThumbnail	
				},
    		success:function() {
    			alert("관심상품에 추가되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	}); 	
		}
		
		// 관심 등록 취소
		function saveDelete(idx) {
			$.ajax({
    		type  : "post",
    		url   : "${ctp}/order/saveDelete",
    		data  : {
				  memNickname  : '${sNickname}',
				  idx : idx
				},
    		success:function() {
    			alert("관심상품이 취소되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류! 재시도 부탁드립니다.");
    		}
    	}); 
		}
		
		// 선택 주문
		function orderAction() {
			let checkRow = "";
		  $( "input[name='checkRow']:checked" ).each (function() {
		    checkRow = checkRow + $(this).val()+"," ;
		  });
		  checkRow = checkRow.substring(0,checkRow.lastIndexOf(",")); //맨 끝 콤마 지우기
		 
		  if(checkRow == '') {
		    alert("주문할 상품을 선택해주세요.");
		    return false;
		  }
		  location.href = "${ctp}/order/orderMutiItems?checkRow="+checkRow;
		}
	</script>
</head>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<div id="container" style="margin:100px 0px 200px 0px">
		<div class="container-xl">
			<h2 class="text-center" style="margin:0px auto; font-size:35px; font-weight:bold; padding-bottom:20px">장바구니</h2>
		
			<div class="row" style="margin:10px 0px 50px 0px">
				<div class="col">
					<div class="infoBox">
						책의 세계는 모두 무료배송<hr/>
						구매 완료 시, 포인트 5%가 적립됩니다. &nbsp;&nbsp;&nbsp;&nbsp;(<span style="font-weight:bold">보유 포인트</span>&nbsp;&nbsp;<span>${memberVO.point}</span>)
					</div>
				</div>
			</div>
			
			<c:if test="${(empty cartProdVOS) && (empty cartMagazineVOS) && (empty cartSubscribeVOS)}">
				<div class="row" style="margin:10px 0px 50px 0px">
					<div class="col">
						<div class="infoBox">
							<div class="row text-center">
								<div class="col-8 text-left">
									장바구니를 채워주세요
								</div>
								<div class="col-4">
									<div class="mb-2"><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/magazine/magazineList';">매거진 계속 쇼핑</button></div>
									<div><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/collection/collectionList';">컬렉션 계속 쇼핑</button></div>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</c:if>
			
			<c:if test="${(!empty cartProdVOS) || (!empty cartMagazineVOS) || (!empty cartSubscribeVOS)}">
				<div class="row" style="margin:10px 0px 50px 0px">
					<div class="col">
						<div class="infoBox">
							<div class="row text-center">
								<div class="col-2 text-left">
									<br/><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll()"/><label for="th_checkAll">&nbsp;&nbsp;&nbsp;&nbsp;<b>전체 선택</b></label>
									<div class="mb-2"><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/magazine/magazineList';">매거진 계속 쇼핑</button></div>
									<div><button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/collection/collectionList';">컬렉션 계속 쇼핑</button></div>
								</div>
								<div class="col-4">
									<div style="font-size:17px; font-weight:bold; color:#3C486B;"><br/>총 상품금액 <i class="fa-regular fa-credit-card"></i></div><br/>
									<input type=text id="cartPrice" class="text-center" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/><br/><br/>
								</div>
								<div class="col-4">
									<div style="font-size:17px; font-weight:bold; color:#3C486B;"><br/>결제 예정금액 <i class="fa-regular fa-credit-card"></i></div><br/>
									<input type=text id="totalPrice" class="text-center" value="0  원" style="font-size:20px; font-weight:bold; width:150px; border:0px; outline: none;" readonly/><br/><br/>
								</div>
								<div class="col-2">
									<div class="mb-2"><br/><button class="btn btn-outline-danger" onclick="deleteAction()">선택 삭제</button></div>
									<div><button class="btn btn-danger" onclick="orderAction()">선택 주문</button></div>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</c:if>
			
			<!-- 상품 장바구니 -->
			<c:if test="${(!empty cartProdVOS)}">
				<div class="table-responsive" style="margin-top:80px">
					<div style="padding: 0px 0px 20px 10px" class="text-center">
					  <div class="w3-tag" style="font-size:22px; font-style:italic;">컬렉션 상품</div>
					</div>
					<table class="table text-center" style="margin-top:10px">
				    <thead>
				      <tr>
				        <th>번호</th>
				        <th>이미지</th>
				        <th>상품정보</th>
				        <th>판매가</th>
				        <th>수량</th>
				        <th>합계</th>
				        <th>선택</th>
				      </tr>
				    </thead>
				    <tbody>
		 		    	<c:forEach var="cartProdVO" items="${cartProdVOS}" varStatus="st">
					      <tr>
					        <td><label for="chk${cartProdVO.idx}"><input type="checkbox" name="checkRow" id="chk${cartProdVO.idx}" onclick="tempTotalPriceChange()" class="form-check-input" value="${cartProdVO.idx}" />&nbsp;&nbsp;${st.count}</label></td>
					        <td>
					        	<a href="${ctp}/collection/colProduct?idx=${cartProdVO.prodIdx}">
					        	<img src="${ctp}/collection/${cartProdVO.prodThumbnail}" style="width:100%; max-width:100px"/>
					        	</a>
					        </td>
					        <td>
					        	<a href="${ctp}/collection/colProduct?idx=${cartProdVO.prodIdx}">
					        	<span style="font-size:16px; font-weight:bold;">${cartProdVO.prodName}</span><br/><hr style="margin:10px;"/>
					        	<span>[옵션]  ${cartProdVO.opName}</span>
					        	</a>
					        </td>
					        <td><fmt:formatNumber value="${cartProdVO.opPrice}" pattern="#,###"/>원</td>
					        <td>
					        	<!-- 수량 변경 내용 -->
					        	<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartProdVO.opPrice}','${cartProdVO.idx}', 'minus')"><i class="fa-solid fa-minus"></i></button>
										<input type="text" class="text-center opNum num" name="num" id="num${cartProdVO.idx}" value="${cartProdVO.num}" readonly style="width:50px;"/>
										<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartProdVO.opPrice}','${cartProdVO.idx}', 'plus')"><i class="fa-solid fa-plus"></i></button>
										<br/><hr style="margin:10px;"/>
					        	<button class="btn btn-outline-primary btn-sm" onclick="numUpdate('${cartProdVO.idx}')">변경</button>
					        	<input type="hidden" id="price${cartProdVO.idx}" name="totalPrice" value="${cartProdVO.opPrice}"/>
					        </td>
					        <td>
					        	<input type=text id="totalPrice${cartProdVO.idx}" class="text-center" value='<fmt:formatNumber value="${cartProdVO.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
					        	<input type=hidden id="tempTotalPrice${cartProdVO.idx}" name="tempTotalPrice" value="${cartProdVO.totalPrice}"/>
					        <td>
					        	<div class="mb-1"><button class="btn btn-sm btn-dark">주문하기 <i class="fa-solid fa-chevron-right"></i></button></div>
					        	<c:if test="${cartProdVO.saveIdx == 0}"><div class="mb-1"><button class="btn btn-sm btn-secondary" onclick="saveInsert('${cartProdVO.type}','${cartProdVO.prodIdx}','${cartProdVO.prodName}','${cartProdVO.prodPrice}','${cartProdVO.prodThumbnail}')">관심상품 추가</button></div></c:if>
					        	<c:if test="${cartProdVO.saveIdx != 0}"><div class="mb-1"><button class="btn btn-sm btn-outline-secondary" onclick="saveDelete(${cartProdVO.saveIdx})">관심상품 취소</button></div></c:if>
										<div><button class="btn btn-sm btn-outline-dark" onclick="deleteOne(${cartProdVO.idx})">삭제하기</button></div>
					        </td>
					      </tr>
				    	</c:forEach>
				    	<tr><td colspan="7"></td></tr> 
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
			<!-- 매거진 장바구니 -->
			<c:if test="${(!empty cartMagazineVOS)}">
				<div class="table-responsive" style="margin-top:80px">
					<div style="padding: 0px 0px 20px 10px" class="text-center">
					  <div class="w3-tag" style="font-size:22px; font-style:italic;">매거진</div>
					</div>
					<table class="table text-center" style="margin-top:10px">
				    <thead>
				      <tr>
				        <th>번호</th>
				        <th>이미지</th>
				        <th>상품정보</th>
				        <th>판매가</th>
				        <th>수량</th>
				        <th>합계</th>
				        <th>선택</th>
				      </tr>
				    </thead>
				    <tbody>
		 		    	<c:forEach var="cartMagazineVO" items="${cartMagazineVOS}" varStatus="st">
					      <tr>
					        <td><label for="chk${cartMagazineVO.idx}"><input type="checkbox" name="checkRow" id="chk${cartMagazineVO.idx}" onclick="tempTotalPriceChange()" class="form-check-input" value="${cartMagazineVO.idx}" />&nbsp;&nbsp;${st.count}</label></td>
					        <td>
					        	<a href="${ctp}/magazine/maProduct?idx=${cartMagazineVO.maIdx}">
					        	<img src="${ctp}/magazine/${cartMagazineVO.prodThumbnail}" style="width:100%; max-width:100px"/>
					        	</a>
					        </td>
					        <td>
					        	<a href="${ctp}/magazine/maProduct?idx=${cartMagazineVO.maIdx}">
					        	<span style="font-size:16px; font-weight:bold;">${cartMagazineVO.prodName}</span>
					        	</a>
					        </td>
					        <td><fmt:formatNumber value="${cartMagazineVO.prodPrice}" pattern="#,###"/>원</td>
					        <td>
					        	<!-- 수량 변경 내용 -->
					        	<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartMagazineVO.prodPrice}','${cartMagazineVO.idx}', 'minus')"><i class="fa-solid fa-minus"></i></button>
										<input type="text" class="text-center opNum num" name="num" id="num${cartMagazineVO.idx}" value="${cartMagazineVO.num}" readonly style="width:50px;"/>
										<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartMagazineVO.prodPrice}','${cartMagazineVO.idx}', 'plus')"><i class="fa-solid fa-plus"></i></button>
										<br/><hr style="margin:10px;"/>
					        	<button class="btn btn-outline-primary btn-sm" onclick="numUpdate('${cartMagazineVO.idx}')">변경</button>
					        	<input type="hidden" id="price${cartMagazineVO.idx}" name="totalPrice" value="${cartMagazineVO.prodPrice}"/>
					        </td>
					        <td>
					        	<input type=text id="totalPrice${cartMagazineVO.idx}" class="text-center" value='<fmt:formatNumber value="${cartMagazineVO.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
					        	<input type=hidden id="tempTotalPrice${cartMagazineVO.idx}" name="tempTotalPrice" value="${cartMagazineVO.totalPrice}"/>
					        <td>
					        	<div class="mb-1"><button class="btn btn-sm btn-dark">주문하기 <i class="fa-solid fa-chevron-right"></i></button></div>
										<c:if test="${cartMagazineVO.saveIdx == 0}"><div class="mb-1"><button class="btn btn-sm btn-secondary" onclick="saveInsert('${cartMagazineVO.type}','${cartMagazineVO.maIdx}','${cartMagazineVO.prodName}','${cartMagazineVO.prodPrice}','${cartMagazineVO.prodThumbnail}')">관심상품 추가</button></div></c:if>
					        	<c:if test="${cartMagazineVO.saveIdx != 0}"><div class="mb-1"><button class="btn btn-sm btn-outline-secondary" onclick="saveDelete(${cartMagazineVO.saveIdx})">관심상품 취소</button></div></c:if>
										<div><button class="btn btn-sm btn-outline-dark" onclick="deleteOne(${cartMagazineVO.idx})">삭제하기</button></div>
					        </td>
					      </tr>
				    	</c:forEach>
				    	<tr><td colspan="7"></td></tr> 
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
			<!-- 매거진 정기구독 장바구니 -->
			<c:if test="${(!empty cartSubscribeVOS)}">
				<div class="table-responsive" style="margin-top:80px">
					<div style="padding: 0px 0px 20px 10px" class="text-center">
					  <div class="w3-tag" style="font-size:22px; font-style:italic;">매거진 정기구독</div>
					  <div style="font-size:17px;" class="mt-3">&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle-exclamation" style="color:#491f51;"></i>
					  	&nbsp;&nbsp;복수 개 구매 시, "info@chaeg.co.kr" 이메일로 "<u>주문번호</u>"와 매거진을 받으실 "<u>주소</u>"를 보내주세요:)<br/>
					  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;그렇지 않으면 주문 배송지로 일괄 배송됩니다.
				  	</div>
					</div>
					<table class="table text-center" style="margin-top:10px">
				    <thead>
				      <tr>
				        <th>번호</th>
				        <th>이미지</th>
				        <th>상품정보</th>
				        <th>판매가</th>
				        <th>수량</th>
				        <th>합계</th>
				        <th>선택</th>
				      </tr>
				    </thead>
				    <tbody>
		 		    	<c:forEach var="cartSubscribeVO" items="${cartSubscribeVOS}" varStatus="st">
					      <tr>
					        <td><label for="chk${cartSubscribeVO.idx}"><input type="checkbox" name="checkRow" id="chk${cartSubscribeVO.idx}" onclick="tempTotalPriceChange()" class="form-check-input" value="${cartSubscribeVO.idx}" />&nbsp;&nbsp;${st.count}</label></td>
					        <td>
					        	<a href="${ctp}/magazine/maProduct?idx=${cartSubscribeVO.maIdx}">
					        	<img src="${ctp}/magazine/${cartSubscribeVO.prodThumbnail}" style="width:100%; max-width:100px"/>
					        	</a>
					        </td>
					        <td>
					        	<a href="${ctp}/magazine/maProduct?idx=${cartSubscribeVO.maIdx}">
					        	<span style="font-size:16px; font-weight:bold;">${cartSubscribeVO.prodName}</span>
					        	</a>
					        </td>
					        <td><fmt:formatNumber value="${cartSubscribeVO.prodPrice}" pattern="#,###"/>원</td>
					        <td>
					        	<!-- 수량 변경 내용 -->
					        	<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartSubscribeVO.prodPrice}','${cartSubscribeVO.idx}', 'minus')"><i class="fa-solid fa-minus"></i></button>
										<input type="text" class="text-center opNum num" name="num" id="num${cartSubscribeVO.idx}" value="${cartSubscribeVO.num}" readonly style="width:50px;"/>
										<button type="button" class="btn btn-sm btn-outline-secondary" onclick="numChange('${cartSubscribeVO.prodPrice}','${cartSubscribeVO.idx}', 'plus')"><i class="fa-solid fa-plus"></i></button>
										<br/><hr style="margin:10px;"/>
					        	<button class="btn btn-outline-primary btn-sm" onclick="numUpdate('${cartSubscribeVO.idx}')">변경</button>
					        	<input type="hidden" id="price${cartSubscribeVO.idx}" name="totalPrice" value="${cartSubscribeVO.prodPrice}"/>
					        </td>
					        <td>
					        	<input type=text id="totalPrice${cartSubscribeVO.idx}" class="text-center" value='<fmt:formatNumber value="${cartSubscribeVO.totalPrice}" pattern="#,###"/> 원' style="font-weight:bold; width:150px; border:0px; outline: none;" readonly/>
					        	<input type=hidden id="tempTotalPrice${cartSubscribeVO.idx}" name="tempTotalPrice" value="${cartSubscribeVO.totalPrice}"/>
					        <td>
					        	<div class="mb-1"><button class="btn btn-sm btn-dark">주문하기 <i class="fa-solid fa-chevron-right"></i></button></div>
										<c:if test="${cartSubscribeVO.saveIdx == 0}"><div class="mb-1"><button class="btn btn-sm btn-secondary" onclick="saveInsert('${cartSubscribeVO.type}','${cartSubscribeVO.maIdx}','${cartSubscribeVO.prodName}','${cartSubscribeVO.prodPrice}','${cartSubscribeVO.prodThumbnail}')">관심상품 추가</button></div></c:if>
					        	<c:if test="${cartSubscribeVO.saveIdx != 0}"><div class="mb-1"><button class="btn btn-sm btn-outline-secondary" onclick="saveDelete(${cartSubscribeVO.saveIdx})">관심상품 취소</button></div></c:if>
										<div><button class="btn btn-sm btn-outline-dark" onclick="deleteOne(${cartSubscribeVO.idx})">삭제하기</button></div>
					        </td>
					      </tr>
				    	</c:forEach>
				    	<tr><td colspan="7"></td></tr> 
				    </tbody>
				  </table>
			  </div>
			</c:if>
			
			
		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</footer>
</body>
</html> --%>