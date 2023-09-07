package com.spring.javaweb10S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb10S.dao.ShopDAO;
import com.spring.javaweb10S.vo.ItemCartVO;
import com.spring.javaweb10S.vo.ItemDeliveryVO;
import com.spring.javaweb10S.vo.ItemOrderVO;
import com.spring.javaweb10S.vo.OptionVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.ReviewVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	ShopDAO shopDAO;

	@Override
	public ArrayList<ProductVO> getItemPart() {
		return shopDAO.getItemPart();
	}

	@Override
	public ArrayList<ProductVO> getPartItemList(String part) {
		return shopDAO.getPartItemList(part);
	}

	@Override
	public ProductVO getItemContent(int idx) {
		return shopDAO.getItemContent(idx);
	}

	@Override
	public ArrayList<OptionVO> getItemOption(int productIdx) {
		return shopDAO.getItemOption(productIdx);
	}

	@Override
	public ItemCartVO getItemCartProductOptionSearch(String productName, String optionName, String mid) {
		return shopDAO.getItemCartProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public void setItemCartUpdate(ItemCartVO vo) {
		shopDAO.setItemCartUpdate(vo);
	}

	@Override
	public void setItemCartInput(ItemCartVO vo) {
		shopDAO.setItemCartInput(vo);
	}

	@Override
	public ArrayList<ItemCartVO> getItemCartList(String mid) {
		return shopDAO.getItemCartList(mid);
	}

	@Override
	public void setCartItemDelete(int idx) {
		shopDAO.setCartItemDelete(idx);
	}

	@Override
	public ItemOrderVO getOrderMaxIdx() {
		return shopDAO.getOrderMaxIdx();
	}

	@Override
	public ItemCartVO getCartIdx(int idx) {
		return shopDAO.getCartIdx(idx);
	}

	@Override
	public void setItemOrder(ItemOrderVO vo) {
		shopDAO.setItemOrder(vo);
	}

	@Override
	public void setItemDelivery(ItemDeliveryVO itemDeliveryVO) {
		
		
		shopDAO.setItemDelivery(itemDeliveryVO);
	}

	@Override
	public void setMemberPointPlus(int point, String mid) {
		shopDAO.setMemberPointPlus(point,mid);
	}

	@Override
	public List<ProductVO> getItemList() {
		return shopDAO.getItemList();
	}

	@Override
	public List<ItemDeliveryVO> getOrderDelivery(String orderNum) {
		return shopDAO.getOrderDelivery(orderNum);
	}

	@Override
	public List<ReviewVO> getReviewList(int idx) {
		return shopDAO.getReviewList(idx);
	}

	@Override
	public List<ItemDeliveryVO> getMyOrderList(int startIndexNo, int pageSize, String mid) {
		return shopDAO.getMyOrderList(startIndexNo, pageSize, mid);
	}

	@Override
	public List<ItemDeliveryVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun,	String endJumun, String conditionOrderStatus) {
		return shopDAO.getMyOrderStatus(startIndexNo, pageSize, mid, startJumun, endJumun, conditionOrderStatus);
	}

	@Override
	public void setMemberPointMinus(String mid, String point) {
		shopDAO.setMemberPointMinus(mid,point);
	}

	@Override
	public void setPayCancle(int orderNum) {
		shopDAO.setPayCancle(orderNum);
	}

	@Override
	public List<ItemDeliveryVO> getOrderCondition(String mid, int conditionDate, int startIndexNo, int pageSize) {
		return shopDAO.getOrderCondition(mid, conditionDate, startIndexNo, pageSize);
	}

	@Override
	public ProductVO getProductContent(String productName) {
		return shopDAO.getProductContent(productName);
	}
	
  @Override
  public int setReviewInput(ReviewVO vo, MultipartHttpServletRequest mfile) {
     int res = 0;
     try {
        List<MultipartFile> fileList = mfile.getFiles("file");
        String sFileNames = "";
        for(MultipartFile file : fileList) {
           String oFileName = file.getOriginalFilename();
           if(!oFileName.equals("")) {  // 들어온값이 null이면 ㄴㄴ
              String sFileName = saveFileName(oFileName);
              // 파일을 서버에 저장처리...
              writeFile(file, sFileName);
              
              // 여러개의 파일명을 관리...
              sFileNames += sFileName + "/";
           }
        }
        vo.setPhoto(sFileNames);
        
        res = shopDAO.setReviewInput(vo);
     } catch (IOException e) {
        e.printStackTrace();
     }
     return res;
  }

  private void writeFile(MultipartFile file, String sFileName) throws IOException {
    byte[] data = file.getBytes();
    
    HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
    
    FileOutputStream fos = new FileOutputStream(realPath + sFileName);
    fos.write(data);
    fos.close();
 }
  
  	//화일명 중복방지를 위한 저장파일명 만들기
  private String saveFileName(String oFileName) {
     String fileName = "";
     
     Calendar cal = Calendar.getInstance();
     fileName += cal.get(Calendar.YEAR);
     fileName += cal.get(Calendar.MONTH);
     fileName += cal.get(Calendar.DATE);
     fileName += cal.get(Calendar.HOUR);
     fileName += cal.get(Calendar.MINUTE);
     fileName += cal.get(Calendar.SECOND);
     fileName += cal.get(Calendar.MILLISECOND);
     fileName += "_" + oFileName;
     
     return fileName;
  }

	@Override
	public ReviewVO getReviewYesOrNo(String productName) {
		return shopDAO.getReviewYesOrNo(productName);
	}

	@Override
	public void setBuyOkUpdate(String orderNum) {
		shopDAO.setBuyOkUpdate(orderNum);
	}


}
