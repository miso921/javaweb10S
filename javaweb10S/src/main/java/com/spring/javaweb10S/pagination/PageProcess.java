package com.spring.javaweb10S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb10S.dao.AdminDAO;
import com.spring.javaweb10S.dao.InquiryDAO;
import com.spring.javaweb10S.dao.RecipeDAO;
import com.spring.javaweb10S.dao.ShopDAO;
import com.spring.javaweb10S.dao.TodayRecipeDAO;

@Service
public class PageProcess {
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	TodayRecipeDAO todayRecipeDAO;
	
	@Autowired
	RecipeDAO recipeDAO;
	
	@Autowired
	InquiryDAO inquiryDAO;
	
	@Autowired
	ShopDAO shopDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("admin")) totRecCnt = adminDAO.totRecCnt(part);
		else if(section.equals("todayRecipe")) totRecCnt = todayRecipeDAO.totRecCnt1();
		else if(section.equals("todayRecipeSub")) totRecCnt = todayRecipeDAO.totRecCnt2();
		else if(section.equals("dibsRecipe")) totRecCnt = recipeDAO.totRecCnt();
		
		else if(section.equals("inquiry")) {
			totRecCnt = inquiryDAO.totRecCnt(part, searchString);
		}
		else if(section.equals("adminInquiry")) {
			totRecCnt = adminDAO.totRecCntAdmin(part);
		}
		else if(section.equals("myOrder")) {
			totRecCnt = shopDAO.totRecCnt(part);
		}
		else if(section.equals("myOrderStatus")) {
			String mid = part;
			// searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
			String[] searchStringArr = searchString.split("@");
			totRecCnt = shopDAO.totRecCntMyOrderStatus(mid,searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("shopMyOrderCondition")) {
			String mid = part;
			int conditionDate = Integer.parseInt(searchString);
			totRecCnt = shopDAO.totRecCntMyOrderCondition(mid,conditionDate);
		}
		else if(section.equals("adminOrderList")) {
			String[] searchStringArr = searchString.split("@");
			totRecCnt = adminDAO.totRecCntAdminStatus(searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		
		
		
		
		
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSection(section);
		pageVO.setSearch(part);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}
	
}
