package com.spring.javaweb10S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb10S.vo.TodayRecipeSubVO;
import com.spring.javaweb10S.vo.TodayRecipeVO;

public interface TodayRecipeDAO {

	public List<TodayRecipeVO> getTodayRecipeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt1();

	public void setTodayRecipeSubApli(@Param("vo") TodayRecipeSubVO vo);

	public TodayRecipeSubVO getTodayRecipeSubApli(@Param("sMail") String sMail);

	public int totRecCnt2();

	public TodayRecipeVO getTodayRecipeContent(@Param("idx") int idx);

	public void setTodayRecipeUpdate(@Param("idx") int idx, @Param("readNum") int readNum);
	
}
