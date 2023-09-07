package com.spring.javaweb10S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb10S.vo.DibsRecipeVO;
import com.spring.javaweb10S.vo.RecipeVO;

public interface RecipeDAO {

	public ArrayList<RecipeVO> getRecipePart();

	public ArrayList<RecipeVO> getPartRecipeList(@Param("part") String part);

	public RecipeVO getRecipeContent(@Param("idx") int idx);

	public RecipeVO getRecipeFile(@Param("file") String file);

	public boolean dibsRecipeCheck(@Param("idx") int idx, @Param("mid") String mid);

	public void insertDibsRecipe(@Param("idx") int idx, @Param("mid") String mid);

	public void deleteDibsRecipe(@Param("idx") int idx, @Param("mid") String mid);

	public List<RecipeVO> getRecipeList();

	public List<DibsRecipeVO> getDibsRecipeList();

	public int totRecCnt();

	public void setDibsRecipeDelete(@Param("idx") int idx);

	public DibsRecipeVO getDibsRecipeSearch(@Param("mid") String mid, @Param("idx") int idx);


}
