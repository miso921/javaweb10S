package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class ItemDeliveryVO {
	private int idx;
	private int orderIdx;
	private String orderNum;
	private int orderTotalPrice;
	private String mid;
	private String name;
	private String address;
	private String tel;
	private String thumbImg;
	private String message;
	private String payment;
	private String payMethod;
	private String orderStatus;
	
	//아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String orderDate;
	private String productName;
	private String thumbnail;
	private int price;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	
	private int reviewCnt;
}
