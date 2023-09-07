<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productOptionInput.jsp(상품의 옵션 등록)</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
		.container {font-family:'SUITE-Regular';}
		h2 {font-family:'EF_watermelonSalad';}
	</style>
  <script>
  	'use strict';
    let cnt = 1;
    
    // 옵션항목 추가
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'"><hr size="5px"/>';
    	strOption += '<font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<input type="button" value="삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/><br/>'
    	strOption += '상품옵션명';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="w3-input w3-border w3-round-xlarge" style="width:200px;margin-left:450px;" />';
    	strOption += '<div class="form-group">';
    	strOption += '상품옵션가';
    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="w3-input w3-border w3-round-xlarge" style="width:200px;margin-left:450px;" />';
    	strOption += '<div class="form-group">';
    	strOption += '상품옵션수량';
    	strOption += '<input type="text" name="stock" id="stock'+cnt+'" class="w3-input w3-border w3-round-xlarge" style="width:200px;margin-left:450px;" />';
    	strOption += '</div>';
    	strOption += '</div>';
    	strOption += '</div>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	/* $("#"+test).remove(); */
    	$("#"+test.id).remove();
    }
    
    // 옵션 입력후 등록전송
    function fCheck() {
    	for(let i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value=="") {
    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
    			return false;
    		}
    	}
    	if(document.getElementById("optionName").value=="") {
    		alert("상품 옵션이름을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("optionPrice").value=="") {
    		alert("상품 옵션가격을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("productName").value=="") {
    		alert("상품명을 선택하세요");
    		return false;
    	}
    	else if(document.getElementById("stock").value=="") {
    		alert("수량을 등록하세요");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
    
   /*  // 상품 입력창에서 분류를 선택박스에 뿌리기
    function partChange() {
    	var part = myform.part.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/product/part",
				data : {part : part},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품명</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	} */
    
    
    // 상품 입력창에서 분류 선택(Change)시 해당 상품들을 가져와서 품목 선택박스에 뿌리기
    function productNameChange() {
    	var part = myform.part.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/product/productName",
				data : {
					part : part
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 상품명을 선택하면 상품의 설명을 띄워준다.
    function productNameCheck() {
    	var productName = document.getElementById("productName").value;
    	$.ajax({
    		type:"post",
    		url : "${ctp}/admin/product/getProductInfor",
    		data: {productName : productName},
    		success:function(vo) {
    			let part = '';
    			if(vo.part == '신선식품') part = '신선식품';
    			else if(vo.part == '가공식품') part = '가공식품';
    			else if(vo.part == '주방용품') part = '주방용품';
    			
    			let str = '<hr /><div class="row">';
    			str += '<div class="col">';
    			str += '분   류 : '+part+'<br/>';
    			str += '상 품 명 : '+vo.productName+'<br/>';
    			str += '상 품 가  : '+numberWithCommas(vo.price)+'원<br/>';
    			str += '할 인 율 : '+vo.discountRate+'%<br/>';
    			str += '할 인 가 : '+numberWithCommas(vo.discount)+'원<br/>';
    			str += '수   량 : '+vo.stock+'개<br/>';
    			str += '<input type="button" value="등록된옵션(삭제)" onclick="optionShow('+vo.idx+')" class="btn btn-info btn-sm"/><br/>';
    			str += '</div>';
    			str += '<div class="col">';
    			str += '<img src="${ctp}/product/'+vo.thumbnail+'" width="160px" style="margin-left:-70px;"/><br/>';
    			str += '</div>';
    			str += '</div><hr />';
    			str += '<div id="optionDemo"></div>';
    			if($("#productName").val == "") $("#demo").hide();
    			else {
	    			$("#demo").html(str);
	    			$("#demo").show();
    			}
    			document.myform.productIdx.value = vo.idx;
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션상세내역보기
    function optionShow(productIdx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/product/getOptionList",
    		data : {productIdx : productIdx},
    		success:function(vos) {
    			let str = '';
    			if(vos.length != 0) {
						str = "옵션 : / ";
	    			for(let i=0; i<vos.length; i++) {
	    				str += '<a href="javascript:optionDelete('+vos[i].idx+')">';
							str += vos[i].optionName + "</a> / ";
	    			}
    			}
    			else {
    				str = "상품에 등록된 옵션이 없습니다.";
    			}
					$("#optionDemo").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션항목 삭제하기
    function optionDelete(idx) {
    	let ans = confirm("현재 선택한 옵션을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/product/optionDelete",
    		data : {idx : idx},
    		success : function() {
    			alert("삭제되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 콤마찍기
    function numberWithCommas(x) {
		  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
  </script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center"><b>상품 옵션 등록</b></h2>
  <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="45%" />
  <form name="myform" method="post">
  	<table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="part" class="mr-4" style="font-weight:bold;margin-left:-260px;">분류</label>
						<select id="part" name="part" onchange="productNameChange()" class="w3-input w3-border w3-round-xlarge text-center" style="width:150px;margin-left:453px;margin-top:-35px;" autofocus required>
				    	<option value="" disabled selected>분류를 선택하세요</option>
				    	<c:forEach var="partVO" items="${partVOS}">
				    	<c:if test="${partVO.part == '신선식품'}">
        				<option value="${partVO.part}">신선식품</option>
        			</c:if>
        			<c:if test="${partVO.part == '가공식품'}">
		        	<option value="${partVO.part}">가공식품</option>
			        </c:if>
			        <c:if test="${partVO.part == '주방용품'}">
			        	<option value="${partVO.part}">주방용품</option>
			        </c:if>
			        </c:forEach>
		    		</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="productName" style="font-weight:bold;margin-left:-100px;margin-right:30px;">상품명</label>
					<select name="productName" id="productName" onchange="productNameCheck()" class="w3-input w3-border w3-round-xlarge" required style="width:150px;display: inline-block;">
        		<option value="">상품선택</option>
      		</select>
      		<div id="demo"></div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;margin-right:8px;margin-left:-200px;">상품 옵션 등록</label>
					<input type="button" value="옵션박스추가" onclick="addOption()" class="btn btn-outline-success btn-sm mb-2" style="margin-right:-20px;" /><br/>
					<div class="form-group">
			      <label for="optionName" style="font-weight:bold;margin-left:-300px;margin-top:20px;">상품옵션명</label>
			      <input type="text" name="optionName" id="optionName" value="${productVO.productName}" class="w3-input w3-border w3-round-xlarge" style="width:180px;margin-left:450px;margin-top:-40px;" />
			    </div>
			    <div class="form-group">
			      <label for="optionPrice" style="font-weight:bold;margin-left:-300px;margin-top:20px;">상품옵션가</label>
			      <input type="text" name="optionPrice" id="optionPrice" class="w3-input w3-border w3-round-xlarge" style="width:180px;margin-left:450px;margin-top:-40px;" />
			    </div>
			    <div class="form-group">
			      <label for="stock" style="font-weight:bold;margin-left:-300px;margin-top:20px;">수량</label>
			      <input type="text" name="stock" id="stock" class="w3-input w3-border w3-round-xlarge" style="width:180px;margin-left:450px;margin-top:-40px;" />
			    </div><br />
			    <div id="optionType"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="등록" onclick="fCheck()" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminContent';" class="w3-button w3-round w3-red" />
					<input type="hidden" name="productIdx">
				</td>
			</tr>
		</table>
  </form>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
</body>
</html>