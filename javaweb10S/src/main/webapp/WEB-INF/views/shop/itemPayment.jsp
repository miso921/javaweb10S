<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemPayment.jsp</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	// IMP.init('imp21064327');
	var IMP = window.IMP; 
  IMP.init("imp65823341");
	
	IMP.request_pay({
		  //alert("paymentVO:"+paymentVO);
	    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
	    pg : 'html5_inicis.INIpayTest',
	    pay_method : 'card',
   		merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '${paymentVO.name}',
	   	amount : ${paymentVO.amount}, //판매 가격 */
	   	//amount : 1, //판매 가격
	    buyer_email : '${paymentVO.buyer_email}',
	    buyer_name : '${paymentVO.buyer_name}',
	    buyer_tel : '${paymentVO.buyer_tel}',
	    buyer_addr : '${paymentVO.buyer_addr}',
	    buyer_postcode : '${paymentVO.buyer_postcode}'
	}, function(rsp) {
			let paySw = 'no';
			let msg = '';
	    if (rsp.success) {
	    		msg = '결제가 완료되었습니다.';
	        msg += '\n고유ID : ' + rsp.imp_uid;
	        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	        msg += '\n결제 금액 : ' + rsp.paid_amount;
	        msg += '\n카드 승인번호 : ' + rsp.apply_num;
	        paySw = 'ok';
	    } else {
	        msg = '결제에 실패했습니다.';
	        msg += + rsp.error_msg;
	        /* msg += '내용 : ' + rsp.error_msg; */
	    }
	    alert(msg);
	    if(paySw == 'no') {
		    alert("다시 주문해주세요.");
	    	location.href='${ctp}/shop/itemCart';
	    }
	    else {
				var temp = "";
				temp += '?name=${paymentVO.name}';
				temp += '&amount=${paymentVO.amount}';
				temp += '&buyer_email=${paymentVO.buyer_email}';
				temp += '&buyer_name=${paymentVO.buyer_name}';
				temp += '&buyer_tel=${paymentVO.buyer_tel}';
				temp += '&buyer_addr=${paymentVO.buyer_addr}';
				temp += '&buyer_postcode=${paymentVO.buyer_postcode}';
				temp += '&imp_uid=' + rsp.imp_uid;
				temp += '&merchant_uid=' + rsp.merchant_uid;
				temp += '&paid_amount=' + rsp.paid_amount;
				temp += '&apply_num=' + rsp.apply_num;
				
				//temp += '&orderIdx=${orderVO.orderIdx}';
				
				location.href='${ctp}/shop/paymentResult'+temp;
	    }
	});
</script>
<style>
	h2 {font-family: 'EF_watermelonSalad';}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container">
  <p class="text-center"><img src="${ctp}/resources/images/payment.gif" width="400px"/></p>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>