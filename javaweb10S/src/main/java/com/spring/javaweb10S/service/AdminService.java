package com.spring.javaweb10S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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

public interface AdminService {

	public List<MemberVO> getAdminMemberList(int startIndexNo, int pageSize);

	public void setMemberDelete(int idx);

	public void setMemberLevelChange(int level, int idx);

	public List<MemberVO> getAdminMemberListSearch(int startIndexNo, int pageSize, String search, String searchString);

	public void imgCheck(String content);

	public ArrayList<ProductVO> getPart();

	public List<ProductVO> getProductList(String part);

	public int setProductInput(ProductVO vo, MultipartFile file, MultipartFile fName2);

	public List<ProductVO> getProductName(String part, String productName);

	public ProductVO getProductInfor(String productName);

	public List<OptionVO> getOptionList(int productIdx);

	public int getOptionSame(int productIdx, String optionName);

	public void setOptionInput(OptionVO vo);

	public ProductVO getProduct(int idx);

	public ArrayList<OptionVO> getOption(int idx);

	public void setOptionDelete(int idx);

	public void setNewsLetter(TodayRecipeVO vo);

	public void setRecipeSave(RecipeVO vo, MultipartHttpServletRequest fName);

	public void setProductDelete(int idx);

	public ArrayList<RecipeVO> getRecipePart();

	public ArrayList<RecipeVO> getPartRecipeList(String part);

	public RecipeVO getRecipeContent(int idx);

	public void setRecipeDelete(int idx);

	public int setTodayRecipeSave(TodayRecipeVO vo, MultipartFile fName);

	public ArrayList<TodayRecipeVO> getTodayRecipeList(int startIndexNo, int pageSize);

	public ArrayList<TodayRecipeVO> getTodayRecipeSearch(int startIndexNo, int pageSize, String search, String searchString);

	public TodayRecipeVO getTodayRecipeContent(int idx);

	public void setTodayRecipeDelete(int idx);

	public void setTodayRecipeUpdate(int idx, int readNum);

	public MainVO getMainList(String slideName);

	public int mainSettingSave(MultipartFile file, MainVO vo);

	public int mainSettingUpdate(MultipartFile file, MainVO vo, MainVO vo2);

	public List<MainVO> getMainSetting();

	public List<TodayRecipeSubVO> getTodayRecipeSub(int startIndexNo, int pageSize);

	public List<TodayRecipeVO> getTodayRecipe();

	public TodayRecipeSubVO getTodayRecipeSubList(String mail);

	public ArrayList<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part);

	public InquiryVO getInquiryContent(int idx);

	public InquiryReplyVO getInquiryReplyContent(int idx);

	public void setInquiryInputAdmin(InquiryReplyVO vo);

	public void setInquiryUpdateAdmin(int inquiryIdx);

	public void setInquiryReplyUpdate(InquiryReplyVO reVO);

	public void setInquiryReplyDelete(int reIdx);

	public void setInquiryUpdateAdmin2(int inquiryIdx);

	public List<ItemDeliveryVO> getAdminOrderList(int startIndexNo, int pageSize, String startJumun, String endJumun,	String orderStatus);

	public void setOrderStatusUpdate(String orderNum, String orderStatus);

	public List<MemberVO> getMemberGenderCnt();

	public void setInquiryReplyUpdateOk(int inquiryIdx);

	public List<ReviewVO> getReviewList();

	public TodayRecipeVO getSlideName(String slideName);






	}









