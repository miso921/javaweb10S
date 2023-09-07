package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class ItemOrderVO {
	private int idx;
	private String orderNum;
	private String mid;
	private int productIdx;
	private String orderDate;
	private String productName;
	private int price;
	private String thumbnail;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	
	private int cartIdx;  // 장바구니 고유번호
	private int maxIdx;   // 주문번호를 구하기 위한 기존 최대 비밀번호 필드
	private int baesong;  // 배송비 저장 필드
}


