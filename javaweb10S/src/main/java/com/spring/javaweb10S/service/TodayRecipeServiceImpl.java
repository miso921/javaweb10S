package com.spring.javaweb10S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb10S.dao.TodayRecipeDAO;
import com.spring.javaweb10S.vo.TodayRecipeSubVO;
import com.spring.javaweb10S.vo.TodayRecipeVO;

@Service
public class TodayRecipeServiceImpl implements TodayRecipeService {
	
	@Autowired
	TodayRecipeDAO todayRecipeDAO;

	@Override
	public List<TodayRecipeVO> getTodayRecipeList(int startIndexNo, int pageSize) {
		return todayRecipeDAO.getTodayRecipeList(startIndexNo, pageSize);
	}

	@Override
	public void setTodayRecipeSubApli(TodayRecipeSubVO vo) {
		todayRecipeDAO.setTodayRecipeSubApli(vo);
	}

	@Override
	public TodayRecipeSubVO getTodayRecipeSubApli(String sMail) {
		return todayRecipeDAO.getTodayRecipeSubApli(sMail);
	}

	@Override
	public TodayRecipeVO getTodayRecipeContent(int idx) {
		return todayRecipeDAO.getTodayRecipeContent(idx);
	}

	@Override
	public void setTodayRecipeUpdate(int idx, int readNum) {
		todayRecipeDAO.setTodayRecipeUpdate(idx, readNum);
	}


}
