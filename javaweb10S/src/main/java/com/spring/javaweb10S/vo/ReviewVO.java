package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private int productIdx;
	private String orderNum;
	private String productName;
	private String mid;
	private String content;
	private String photo;
	private String star;
	private String reviewDate;

	private String oName;
	private String pName;
	
}
