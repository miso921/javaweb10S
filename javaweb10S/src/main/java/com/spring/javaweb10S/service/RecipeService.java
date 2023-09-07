package com.spring.javaweb10S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb10S.vo.DibsRecipeVO;
import com.spring.javaweb10S.vo.RecipeVO;

public interface RecipeService {

	public ArrayList<RecipeVO> getRecipePart();

	public ArrayList<RecipeVO> getPartRecipeList(String part);

	public RecipeVO getRecipeContent(int idx);

	public RecipeVO getRecipeFile(String file);

	public boolean toggleDibsRecipe(int idx, String mid);

	public List<RecipeVO> getRecipeList();

	public List<DibsRecipeVO> getDibsRecipeList();

	public void setDibsRecipeDelete(int idx);

	public DibsRecipeVO getDibsRecipeSearch(String mid, int idx);


}
