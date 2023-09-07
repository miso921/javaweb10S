package com.spring.javaweb10S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb10S.dao.RecipeDAO;
import com.spring.javaweb10S.vo.DibsRecipeVO;
import com.spring.javaweb10S.vo.RecipeVO;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeDAO recipeDAO;

	@Override
	public ArrayList<RecipeVO> getRecipePart() {
		return recipeDAO.getRecipePart();
	}

	@Override
	public ArrayList<RecipeVO> getPartRecipeList(String part) {
		return recipeDAO.getPartRecipeList(part);
	}

	@Override
	public RecipeVO getRecipeContent(int idx) {
		return recipeDAO.getRecipeContent(idx);
	}

	@Override
	public RecipeVO getRecipeFile(String file) {
		return recipeDAO.getRecipeFile(file);
	}

	@Override
	public boolean toggleDibsRecipe(int idx, String mid) {
		boolean isDibs = recipeDAO.dibsRecipeCheck(idx, mid);
		
    if (isDibs) {
    	recipeDAO.deleteDibsRecipe(idx, mid);
    } else {
    	recipeDAO.insertDibsRecipe(idx, mid);
    }
    return !isDibs;
	}

	@Override
	public List<RecipeVO> getRecipeList() {
		return recipeDAO.getRecipeList();
	}

	@Override
	public List<DibsRecipeVO> getDibsRecipeList() {
		return recipeDAO.getDibsRecipeList();
	}

	@Override
	public void setDibsRecipeDelete(int idx) {
		recipeDAO.setDibsRecipeDelete(idx);
	}

	@Override
	public DibsRecipeVO getDibsRecipeSearch(String mid, int idx) {
		return recipeDAO.getDibsRecipeSearch(mid,idx);
	}

	
}	
