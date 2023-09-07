package com.spring.javaweb10S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb10S.dao.AdminDAO;
import com.spring.javaweb10S.dao.RecipeDAO;
import com.spring.javaweb10S.dao.ShopDAO;
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

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	ShopDAO shopDAO;

	@Autowired
	RecipeDAO recipeDAO;
	
	@Override
	public List<MemberVO> getAdminMemberList(int startIndexNo, int pageSize) {
		return adminDAO.getAdminMemberList(startIndexNo, pageSize);
	}

	@Override
	public void setMemberDelete(int idx) {
		adminDAO.setMemberDelete(idx);
	}

	@Override
	public void setMemberLevelChange(int level, int idx) {
		adminDAO.setMemberLevelChange(level,idx);
	}

	@Override
	public List<MemberVO> getAdminMemberListSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return adminDAO.getAdminMemberListSearch(startIndexNo, pageSize, search, searchString);
	}
	
	@Override
	public int setProductInput(ProductVO vo, MultipartFile fName1, MultipartFile fName2) {
		int res = 0;
		UUID uid = UUID.randomUUID();
		String oFileName = fName1.getOriginalFilename();
		String saveFileName = uid + "_" + oFileName;
		String oFileName2= fName2.getOriginalFilename();
		String saveFileName2 = uid + "_" + oFileName2;
		
		// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		try {
			writeFile(fName1, saveFileName, "product");
			writeFile(fName2, saveFileName2, "product");
			vo.setThumbnail(saveFileName);
			vo.setContent(saveFileName2);
			
			adminDAO.setProductInput(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public void writeFile(MultipartFile fName, String saveFileName, String flag) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = "";
		if(flag.equals("product")) realPath = request.getSession().getServletContext().getRealPath("/resources/data/product/");
		else if(flag.equals("recipe")) realPath = request.getSession().getServletContext().getRealPath("/resources/data/recipe/");
		else if(flag.equals("todayRecipe")) realPath = request.getSession().getServletContext().getRealPath("/resources/data/todayRecipe/");
		else if(flag.equals("main")) realPath = request.getSession().getServletContext().getRealPath("/resources/data/main/");
		
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		fos.write(data);
		fos.close();
	}
	
	@Override
	public void imgCheck(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/product/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/product/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "product/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 product폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	// 파일을 복사처리...
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream  fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<ProductVO> getPart() {
		return adminDAO.getPart();
	}

	@Override
	public List<ProductVO> getProductList(String part) {
		return adminDAO.getProductList(part);
	}

	@Override
	public List<ProductVO> getProductName(String part, String productName) {
		return adminDAO.getProductName(part,productName);
	}

	@Override
	public ProductVO getProductInfor(String productName) {
		return adminDAO.getProductInfor(productName);
	}

	@Override
	public List<OptionVO> getOptionList(int productIdx) {
		return adminDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return adminDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public void setOptionInput(OptionVO vo) {
		adminDAO.setOptionInput(vo);
	}

	@Override
	public ProductVO getProduct(int idx) {
		return adminDAO.getProduct(idx);
	}

	@Override
	public ArrayList<OptionVO> getOption(int productIdx) {
		return adminDAO.getOption(productIdx);
	}

	@Override
	public void setOptionDelete(int idx) {
		adminDAO.setOptionDelete(idx);
	}

	@Override
	public void setNewsLetter(TodayRecipeVO vo) {
		adminDAO.setNewsLetter(vo);
	}

	@Override
	public void setRecipeSave(RecipeVO vo, MultipartHttpServletRequest mFile) {
		try {
			List<MultipartFile> fileList = mFile.getFiles("fName");
			//String oFileNames = "";
			String sFileNames = "";
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				System.out.println("oFileName : " + oFileName);
				// 파일을 서버에 저장처리...
				writeFile(file, sFileName, "recipe");
				
				// 여러개의 파일명을 관리...
//				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
//			vo.setFile1(oFileNames);
			vo.setFile(sFileNames);
		} catch (IOException e) {
			e.printStackTrace();
		}
		adminDAO.setRecipeSave(vo);
	}

	// 파일명 중복방지를 위한 저장파일명 만들기
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
	public void setProductDelete(int idx) {
		ProductVO vo = shopDAO.getItemContent(idx);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/product/");
		String thumbnail = vo.getThumbnail();
		String content = vo.getContent();
		
		// 서버에서 파일들을 삭제한다.
		new File(realPath + thumbnail).delete();
		new File(realPath + content).delete();
		
		adminDAO.setProductDelete(idx);
	}

	@Override
	public ArrayList<RecipeVO> getRecipePart() {
		return adminDAO.getRecipePart();
	}

	@Override
	public ArrayList<RecipeVO> getPartRecipeList(String part) {
		return adminDAO.getPartRecipeList(part);
	}

	@Override
	public RecipeVO getRecipeContent(int idx) {
		return adminDAO.getRecipeContent(idx);
	}

	// 레시피 삭제
	@Override
	public void setRecipeDelete(int idx) {
		RecipeVO vo = adminDAO.getRecipeContent(idx);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/recipe/");
		String file = vo.getFile();
		
		// 서버에서 파일들을 삭제한다.
		new File(realPath + file).delete();
		
		adminDAO.setRecipeDelete(idx);
	}

	@Override
	public int setTodayRecipeSave(TodayRecipeVO vo, MultipartFile fName) {
		int res = 0;
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
//		String saveFileName = uid + "_" + oFileName;
		String saveFileName = uid + "";

		// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		try {
			writeFile(fName, saveFileName, "todayRecipe");
			vo.setArticle(saveFileName);
			
			adminDAO.setTodayRecipeSave(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public ArrayList<TodayRecipeVO> getTodayRecipeList(int startIndexNo, int pageSize) {
		return adminDAO.getTodayRecipeList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<TodayRecipeVO> getTodayRecipeSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return adminDAO.getTodayRecipeSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public TodayRecipeVO getTodayRecipeContent(int idx) {
		return adminDAO.getTodayRecipeContent(idx);
	}

	// 오늘의레시피 삭제
	@Override
	public void setTodayRecipeDelete(int idx) {
		TodayRecipeVO vo = adminDAO.getTodayRecipeContent(idx);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/todayRecipe/");
		String file = vo.getArticle();
		
		// 서버에서 파일들을 삭제한다.
		new File(realPath + file).delete();
		
		adminDAO.setTodayRecipeDelete(idx);
	}

	@Override
	public void setTodayRecipeUpdate(int idx, int readNum) {
		adminDAO.setTodayRecipeUpdate(idx, readNum);
	}

	@Override
	public int mainSettingSave(MultipartFile file, MainVO vo) {
		String oFileName = file.getOriginalFilename();
		
		try {
			writeFile(file, oFileName, "main");
			vo.setSlideImg(oFileName);

		} catch (IOException e) {
			e.printStackTrace();
		}
   return adminDAO.mainSettingSave(vo);
 }

	@Override
	public MainVO getMainList(String slideName) {
		return adminDAO.getMainList(slideName);
	}

	@Override
	public int mainSettingUpdate(MultipartFile file, MainVO vo, MainVO vo2) {

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/main/");
		String file2 = vo2.getSlideImg();
		
		// 서버에서 파일들을 삭제한다.
		new File(realPath + file2).delete();
		
		
		// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		String oFileName = file.getOriginalFilename();
		
		try {
			writeFile(file, oFileName, "main");
			vo.setSlideImg(oFileName);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return adminDAO.setMainUpdate(vo,vo2.getIdx());
	}

	@Override
	public List<MainVO> getMainSetting() {
		return adminDAO.getMainSetting();
	}

	@Override
	public List<TodayRecipeSubVO> getTodayRecipeSub(int startIndexNo, int pageSize) {
		return adminDAO.getTodayRecipeSub(startIndexNo, pageSize);
	}

	@Override
	public List<TodayRecipeVO> getTodayRecipe() {
		return adminDAO.getTodayRecipe();
	}

	@Override
	public TodayRecipeSubVO getTodayRecipeSubList(String mail) {
		return adminDAO.getTodayRecipeSubList(mail);
	}

	@Override
	public ArrayList<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part) {
		return adminDAO.getInquiryList(startIndexNo, pageSize, part);
	}

	@Override
	public InquiryVO getInquiryContent(int idx) {
		return adminDAO.getInquiryContent(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReplyContent(int idx) {
		return adminDAO.getInquiryReplyContent(idx);
	}

	@Override
	public void setInquiryInputAdmin(InquiryReplyVO vo) {
		adminDAO.setInquiryInputAdmin(vo);
	}

	@Override
	public void setInquiryUpdateAdmin(int inquiryIdx) {
		adminDAO.setInquiryUpdateAdmin(inquiryIdx);
	}

	@Override
	public void setInquiryReplyUpdate(InquiryReplyVO reVO) {
		adminDAO.setInquiryReplyUpdate(reVO);
	}

	@Override
	public void setInquiryReplyDelete(int reIdx) {
		adminDAO.setInquiryReplyDelete(reIdx);
	}

	@Override
	public void setInquiryUpdateAdmin2(int inquiryIdx) {
		adminDAO.setInquiryUpdateAdmin2(inquiryIdx);
	}

	@Override
	public List<ItemDeliveryVO> getAdminOrderList(int startIndexNo, int pageSize, String startJumun, String endJumun, String orderStatus) {
		return adminDAO.getAdminOrderList(startIndexNo, pageSize, startJumun, endJumun, orderStatus);
	}

	@Override
	public void setOrderStatusUpdate(String orderNum, String orderStatus) {
		adminDAO.setOrderStatusUpdate(orderNum, orderStatus);
	}

	@Override
	public List<MemberVO> getMemberGenderCnt() {
		return adminDAO.getMemberGenderCnt();
	}

	@Override
	public void setInquiryReplyUpdateOk(int inquiryIdx) {
		adminDAO.setInquiryReplyUpdateOk(inquiryIdx);
	}

	@Override
	public List<ReviewVO> getReviewList() {
		return adminDAO.getReviewList();
	}

	@Override
	public TodayRecipeVO getSlideName(String slideName) {
		return adminDAO.getSlideName(slideName);
	}






	
	
}
