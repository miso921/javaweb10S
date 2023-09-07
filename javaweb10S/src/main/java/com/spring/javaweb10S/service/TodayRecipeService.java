package com.spring.javaweb10S.service;

import java.util.List;

import com.spring.javaweb10S.vo.TodayRecipeSubVO;
import com.spring.javaweb10S.vo.TodayRecipeVO;

public interface TodayRecipeService {

	public List<TodayRecipeVO> getTodayRecipeList(int startIndexNo, int pageSize);

	public void setTodayRecipeSubApli(TodayRecipeSubVO vo);

	public TodayRecipeSubVO getTodayRecipeSubApli(String sMail);

	public TodayRecipeVO getTodayRecipeContent(int idx);

	public void setTodayRecipeUpdate(int idx, int readNum);


}
