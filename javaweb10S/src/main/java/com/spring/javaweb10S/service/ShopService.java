package com.spring.javaweb10S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb10S.vo.ItemCartVO;
import com.spring.javaweb10S.vo.ItemDeliveryVO;
import com.spring.javaweb10S.vo.ItemOrderVO;
import com.spring.javaweb10S.vo.OptionVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.ReviewVO;

public interface ShopService {

	public ArrayList<ProductVO> getItemPart();

	public ArrayList<ProductVO> getPartItemList(String part);

	public ProductVO getItemContent(int idx);

	public ArrayList<OptionVO> getItemOption(int productIdx);

	public ItemCartVO getItemCartProductOptionSearch(String productName, String optionName, String mid);

	public void setItemCartUpdate(ItemCartVO vo);

	public void setItemCartInput(ItemCartVO vo);

	public ArrayList<ItemCartVO> getItemCartList(String mid);

	public void setCartItemDelete(int idx);

	public ItemOrderVO getOrderMaxIdx();

	public ItemCartVO getCartIdx(int parseInt);

	public void setItemOrder(ItemOrderVO vo);

	public void setItemDelivery(ItemDeliveryVO itemDeliveryVO);

	public void setMemberPointPlus(int point, String mid);

	public List<ProductVO> getItemList();

	public List<ItemDeliveryVO> getOrderDelivery(String orderNum);

	public List<ReviewVO> getReviewList(int idx);

	public List<ItemDeliveryVO> getMyOrderList(int startIndexNo, int pageSize, String mid);

	public List<ItemDeliveryVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun,	String endJumun, String conditionOrderStatus);

	public void setMemberPointMinus(String mid, String point);

	public void setPayCancle(int orderNum);

	public List<ItemDeliveryVO> getOrderCondition(String mid, int conditionDate, int startIndexNo, int pageSize);

	public ProductVO getProductContent(String productName);

	public int setReviewInput(ReviewVO vo, MultipartHttpServletRequest file);

	public ReviewVO getReviewYesOrNo(String productName);

	public void setBuyOkUpdate(String orderNum);










}
