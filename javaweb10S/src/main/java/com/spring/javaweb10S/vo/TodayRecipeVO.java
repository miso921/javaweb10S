package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class TodayRecipeVO {
	private int idx;
	private int recipeIdx;
	private String title;
	private String article;
	private String issueDate;
	private String openSw;
	private int readNum;
	
	//private int day_diff;	// 날짜 차이 계산 필드(1일차이 계산)
	private int hour_diff;	// 날짜 차이 계산 필드(24시간차이 계산)
}
