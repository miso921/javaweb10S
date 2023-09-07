package com.spring.javaweb10S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb10S.vo.InquiryReplyVO;
import com.spring.javaweb10S.vo.InquiryVO;
import com.spring.javaweb10S.vo.ItemDeliveryVO;
import com.spring.javaweb10S.vo.MainVO;
import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.OptionVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.RecipeVO;
import com.spring.javaweb10S.vo.ReviewVO;
import com.spring.javaweb10S.vo.TodayRecipeSubVO;
import com.spring.javaweb10S.vo.TodayRecipeVO;

public interface AdminDAO {

	public int totRecCnt(@Param("part") String part);

	public List<MemberVO> getAdminMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setMemberDelete(@Param("idx") int idx);

	public void setMemberLevelChange(@Param("level") int level, @Param("idx") int idx);

	public List<MemberVO> getAdminMemberListSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int setProductInput(@Param("vo") ProductVO vo);

	public ArrayList<ProductVO> getPart();

	public List<ProductVO> getProductList(@Param("part") String part);

	public List<ProductVO> getProductName(@Param("part") String part, @Param("productName") String productName);

	public ProductVO getProductInfor(@Param("productName") String productName);

	public List<OptionVO> getOptionList(@Param("productIdx") int productIdx);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public void setOptionInput(@Param("vo") OptionVO vo);

	public ProductVO getProduct(@Param("idx") int idx);

	public ArrayList<OptionVO> getOption(@Param("productIdx") int productIdx);

	public void setOptionDelete(@Param("idx") int idx);

	public void setNewsLetter(@Param("vo") TodayRecipeVO vo);

	public void setRecipeSave(@Param("vo") RecipeVO vo);

	public void setProductDelete(@Param("idx") int idx);

	public ArrayList<RecipeVO> getRecipePart();

	public ArrayList<RecipeVO> getPartRecipeList(@Param("part") String part);

	public RecipeVO getRecipeContent(@Param("idx") int idx);

	public void setRecipeDelete(@Param("idx") int idx);

	public int setTodayRecipeSave(@Param("vo") TodayRecipeVO vo);

	public int totRecCnt2();

	public ArrayList<TodayRecipeVO> getTodayRecipeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<TodayRecipeVO> getTodayRecipeSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search,
			@Param("searchString") String searchString);

	public TodayRecipeVO getTodayRecipeContent(@Param("idx") int idx);

	public void setTodayRecipeDelete(@Param("idx") int idx);

	public void setTodayRecipeUpdate(@Param("idx") int idx, @Param("readNum") int readNum);

	public int mainSettingSave(@Param("vo") MainVO vo);

	public MainVO getMainList(@Param("slideName") String slideName);

	public int setMainUpdate(@Param("vo") MainVO vo, @Param("idx") int idx);

	public List<MainVO> getMainSetting();

	public List<TodayRecipeSubVO> getTodayRecipeSub(@Param("startIndexNo") int startIndexNo,  @Param("pageSize") int pageSize);

	public List<TodayRecipeVO> getTodayRecipe();

	public TodayRecipeSubVO getTodayRecipeSubList(@Param("mail") String mail);

	public ArrayList<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public int totRecCntAdmin(@Param("part") String part);

	public InquiryVO getInquiryContent(@Param("idx") int idx);

	public InquiryReplyVO getInquiryReplyContent(@Param("idx") int idx);

	public void setInquiryInputAdmin(@Param("vo") InquiryReplyVO vo);

	public void setInquiryUpdateAdmin(@Param("inquiryIdx") int inquiryIdx);

	public void setInquiryReplyUpdate(@Param("reVO") InquiryReplyVO reVO);

	public void setInquiryReplyDelete(@Param("reIdx") int reIdx);

	public void setInquiryUpdateAdmin2(@Param("inquiryIdx") int inquiryIdx);

	public int totRecCntAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public List<ItemDeliveryVO> getAdminOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun,	@Param("orderStatus") String orderStatus);

	public void setOrderStatusUpdate(@Param("orderNum") String orderNum, @Param("orderStatus") String orderStatus);

	public List<MemberVO> getMemberGenderCnt();

	public void getInquiryReplyOk();

	public void setInquiryReplyUpdateOk(@Param("inquiryIdx") int inquiryIdx);

	public List<ReviewVO> getReviewList();

	public TodayRecipeVO getSlideName(@Param("slideName") String slideName);













}
