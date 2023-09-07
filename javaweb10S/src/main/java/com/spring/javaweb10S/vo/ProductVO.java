package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String part;
	private String productName;
	private String price;
	private String discount;
	private String discountRate;
	private String thumbnail;
	private String content;
	private String ingredient;
	private String openSw;
}
