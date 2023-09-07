package com.spring.javaweb10S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb10S.vo.ItemCartVO;
import com.spring.javaweb10S.vo.ItemDeliveryVO;
import com.spring.javaweb10S.vo.ItemOrderVO;
import com.spring.javaweb10S.vo.OptionVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.ReviewVO;

public interface ShopDAO {

	public ArrayList<ProductVO> getItemPart();

	public ArrayList<ProductVO> getPartItemList(@Param("part") String part);

	public ProductVO getItemContent(@Param("idx") int idx);

	public ArrayList<OptionVO> getItemOption(@Param("productIdx") int productIdx);

	public ItemCartVO getItemCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public void setItemCartUpdate(@Param("vo") ItemCartVO vo);

	public void setItemCartInput(@Param("vo") ItemCartVO vo);

	public ArrayList<ItemCartVO> getItemCartList(@Param("mid") String mid);

	public void setCartItemDelete(@Param("idx") int idx);

	public ItemOrderVO getOrderMaxIdx();

	public ItemCartVO getCartIdx(@Param("idx") int idx);

	public void setItemOrder(@Param("vo") ItemOrderVO vo);

	public void setItemDelivery(@Param("itemDeliveryVO") ItemDeliveryVO itemDeliveryVO);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	public List<ProductVO> getItemList();

	public List<ItemDeliveryVO> getOrderDelivery(@Param("orderNum") String orderNum);

	public List<ReviewVO> getReviewList(@Param("idx") int idx);

	public List<ItemDeliveryVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totRecCnt(@Param("mid") String part);

	public int totRecCntMyOrderStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public List<ItemDeliveryVO> getMyOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public void setMemberPointMinus(@Param("mid") String mid, @Param("point") String point);

	public void setPayCancle(@Param("orderNum") int orderNum);

	public int totRecCntMyOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<ItemDeliveryVO> getOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ProductVO getProductContent(@Param("productName") String productName);

	public int setReviewInput(@Param("vo") ReviewVO vo);

	public ReviewVO getReviewYesOrNo(@Param("productName") String productName);

	public void setBuyOkUpdate(@Param("orderNum") String orderNum);




}
