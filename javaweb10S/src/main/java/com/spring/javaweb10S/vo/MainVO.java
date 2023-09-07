package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class MainVO {
	private int idx;
	private String slideName;
	private int todayRecipeIdx;
	private String slideImg;

	// 저장용
	private String todayRecipe;
}
