package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class ItemCartVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int productIdx;
	private String productName;
	private int price;
	private String thumbnail;
	private String optionIdx;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;

	private int discountRate; // 장바구니에서 계산하는 할인율
	private int discount; // 장바구니에서 보여줄 할인가
	private int stock; // 장바구니에서 사용할 수량
}
