package com.spring.javaweb10S;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb10S.pagination.PageProcess;
import com.spring.javaweb10S.pagination.PageVO;
import com.spring.javaweb10S.service.AdminService;
import com.spring.javaweb10S.service.InquiryService;
import com.spring.javaweb10S.service.ShopService;
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

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@Autowired
	InquiryService inquiryService;

	@Autowired
	ShopService shopService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	PageProcess pageProcess;

	@Autowired
	JavaMailSender mailSender;

	// 관리자 페이지 이동 (adminLeft, adminContent 프레임), 회원통계
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	// 관리자 페이지 메뉴
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}

	// 관리자 페이지 화면 이동
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContentGet(String search, Model model) {
		List<MemberVO> vos = adminService.getMemberGenderCnt();
		
		model.addAttribute("vos",vos);
		
		return "admin/adminContent";
	}

	// 회원목록 이동
	@RequestMapping(value = "/member/adminMemberList", method = RequestMethod.GET)
	public String adminMemberListGet(@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize, Model model,
			HttpServletRequest request) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "");

		List<MemberVO> vos = adminService.getAdminMemberList(pageVO.getStartIndexNo(), pageSize);

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);

		return "admin/member/adminMemberList";
	}

	// 회원탈퇴 처리
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberDelete", method = RequestMethod.POST)
	public String adminMemberDeletePost(int idx) {
		adminService.setMemberDelete(idx);
		return "";
	}

	// 선택항목 회원등급 변경처리
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberLevelTotalChange", method = RequestMethod.POST)
	public String adminMemberLevelTotalChangePost(
			@RequestParam(name = "level", defaultValue = "0", required = false) int level,
			@RequestParam(name = "changeItems", defaultValue = "", required = false) String changeItems) {
		String[] changeItem = changeItems.split("/");

		for (String idx : changeItem) {
			adminService.setMemberLevelChange(level, (Integer.parseInt(idx)));
		}
		return "";
	}

	// 개별항목 회원등급 변경처리
	@ResponseBody
	@RequestMapping(value = "/member/adminMemeberLevelChange", method = RequestMethod.POST)
	public String adminMemeberLevelChangePost(
			@RequestParam(name = "level", defaultValue = "0", required = false) int level,
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx) {
		adminService.setMemberLevelChange(level, idx);
		return "";
	}

	// 회원 검색 처리
	@RequestMapping(value = "/member/adminMemberSearch", method = RequestMethod.GET)
	public String adminMemberSearchGet(String search, String searchString,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize, Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", search, searchString);
		List<MemberVO> vos = adminService.getAdminMemberListSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);

		String searchTitle = "";

		if (pageVO.getSearch().equals("name"))
			searchTitle = "성명";
		else if (pageVO.getSearch().equals("mid"))
			searchTitle = "아이디";
		else if (pageVO.getSearch().equals("email"))
			searchTitle = "이메일";
		else if (pageVO.getSearch().equals("address"))
			searchTitle = "주소";
		else if (pageVO.getSearch().equals("tel"))
			searchTitle = "전화번호";
		else if (pageVO.getSearch().equals("birthday"))
			searchTitle = "생년월일";
		else if (pageVO.getSearch().equals("gender"))
			searchTitle = "성별";
		else searchTitle = "탈퇴유무";

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);

		return "admin/member/adminMemberSearch";
	}

	// 상품 등록 창 이동
	@RequestMapping(value = "/product/productInput", method = RequestMethod.GET)
	public String productInputGet() {
		return "admin/product/productInput";
	}

	// 상품 등록 처리
	@RequestMapping(value = "/product/productInput", method = RequestMethod.POST)
	public String productInputPost(ProductVO vo, MultipartFile fName1, MultipartFile fName2) {
		int res = adminService.setProductInput(vo, fName1, fName2);
		if (res == 1)
			return "redirect:/message/productInputOk";
		else
			return "redirect:/message/productInputNo";
	}

	// 상품 목록 모두 보여주기
	@RequestMapping(value = "/product/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part) {

		String[] parts = {"신선식품", "가공식품", "주방용품"};
		
		model.addAttribute("parts", parts);
		model.addAttribute("part", part);

		// 전체 상품 목록 가져오기
		List<ProductVO> productVOS = adminService.getProductList(part);
		model.addAttribute("productVOS", productVOS);

		return "admin/product/productList";
	}

	// 상품 상세정보 보여주기
	@RequestMapping(value = "/product/productContent", method = RequestMethod.GET)
	public String productContentGet(int idx, Model model) {
		ProductVO productVO = adminService.getProduct(idx); // 상품의 상세정보 불러오기
		ArrayList<OptionVO> optionVOS = adminService.getOption(idx); // 옵션의 모든 정보 불러오기

		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);

		return "admin/product/productContent";
	}

	//상품 삭제 처리
	@ResponseBody
	@RequestMapping(value = "product/productDelete", method = RequestMethod.POST)
	public String productDeletePost(int idx) {
		adminService.setProductDelete(idx);
		
		return "";
	}
	
	// 상품 옵션 등록창 이동하기
	@RequestMapping(value = "/product/productOptionInput", method = RequestMethod.GET)
	public String productOptionInputGet(Model model) {
		ArrayList<ProductVO> partVOS = adminService.getPart();
		model.addAttribute("partVOS", partVOS);
		return "admin/product/productOptionInput";
	}

	// 상품 분류 골랐을 때 상품명 가져오기
	@ResponseBody
	@RequestMapping(value = "/product/productName", method = RequestMethod.POST)
	public List<ProductVO> productNamePost(String part, String productName) {
		return adminService.getProductName(part, productName);
	}

	// 옵션 박스에서 상품을 선택하면 선택된 상품의 상세설명 가져가기
	@ResponseBody
	@RequestMapping(value = "/product/getProductInfor", method = RequestMethod.POST)
	public ProductVO getProductInforPost(String productName) {
		return adminService.getProductInfor(productName);
	}

	// 상품의 '옵션보기' 버튼을 누르면 해당 제품의 모든 옵션 보여주기
	@ResponseBody
	@RequestMapping(value = "/product/getOptionList", method = RequestMethod.POST)
	public List<OptionVO> getOptionListPost(int productIdx) {
		return adminService.getOptionList(productIdx);
	}

	// 옵션 등록창에서 옵션 목록 확인 후 필요없는 옵션 항목 삭제처리
	@ResponseBody
	@RequestMapping(value = "/product/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		adminService.setOptionDelete(idx);
		return "";
	}

	// 옵션 등록하기
	@RequestMapping(value = "/product/productOptionInput", method = RequestMethod.POST)
	public String productOptionInputPost(OptionVO vo, String[] optionName, int[] optionPrice, int[] stock) {
		int res = 0;

		for (int i = 0; i < optionName.length; i++) {

			// 상품의 옵션 개수 가져오기(중복된 옵션값 확인하기)
			int optionCnt = adminService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if (optionCnt != 0)
				continue;

			// 동일한 옵션이 없으면 vo에 저장 후 옵션 테이블에 등록
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			vo.setStock(stock[i]);
			for (int k = 0; k < stock.length; k++) {
		    System.out.println("stock[" + k + "]: " + stock[k]);
			}

			adminService.setOptionInput(vo);
			res = 1;
		}
		if (res == 1)
			return "redirect:/message/productOptionInputOk";
		else
			return "redirect:/message/productOptionInputNo";
	}
	
	// 레시피 등록창으로 이동
	@RequestMapping(value = "/recipe/recipeInput", method = RequestMethod.GET)
	public String recipeInputGet() {
		return "admin/recipe/recipeInput";
	}
	
	// 레시피 등록 처리
	@RequestMapping(value = "/recipe/recipeInput", method = RequestMethod.POST)
	public String recipeInputPost(RecipeVO vo, MultipartHttpServletRequest fName) {
		adminService.setRecipeSave(vo, fName);
		int res = 1;
		
		if(res == 1) return "redirect:/message/recipeInputOk ";
		else return "redirect:/message/recipeInputNo";
	}
	
	// 레시피 목록으로 이동
	@RequestMapping(value = "/recipe/recipeList", method = RequestMethod.GET)
	public String recipeListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part) {
		
		// 레시피 분류 가져오기
		ArrayList<RecipeVO> partVOS = adminService.getRecipePart();
		model.addAttribute("partVOS", partVOS);
		model.addAttribute("part", part);
		
		// 전체 레시피 목록 가져오기
		ArrayList<RecipeVO> recipeVOS = adminService.getPartRecipeList(part);
		model.addAttribute("recipeVOS",recipeVOS);
		
		return "admin/recipe/recipeList";
	}
	
	// 레시피 상세정보 이동
	@RequestMapping(value = "/recipe/recipeContent", method = RequestMethod.GET)
	public String recipeContentGet(int idx, Model model) {
		RecipeVO recipeVO = adminService.getRecipeContent(idx);
		model.addAttribute("recipeVO",recipeVO);
		
		return "admin/recipe/recipeContent";
	}
	
	// 레시피 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/recipe/recipeDelete", method = RequestMethod.POST)
	public String recipeDeletePost(int idx) {
		adminService.setRecipeDelete(idx);
		return "";
	}
	
	// 오늘의레시피 등록 창 이동
	@RequestMapping(value = "/todayRecipe/todayRecipeInput", method = RequestMethod.GET)
	public String todayRecipeInputGet() {
		return "admin/todayRecipe/todayRecipeInput";
	}
	
	// 오늘의레시피 등록 처리
	@RequestMapping(value = "/todayRecipe/todayRecipeInput", method = RequestMethod.POST)
	public String todayRecipeInputPost(TodayRecipeVO vo , MultipartFile fName) {
		adminService.setTodayRecipeSave(vo,fName);
		int res = 1;
		
		if(res == 1) return "redirect:/message/todayRecipeInputOk";
		else return "redirect:/message/todayRecipeInputNo";
	}
	
	// 오늘의레시피 목록 이동
	@RequestMapping(value = "/todayRecipe/todayRecipeList", method = RequestMethod.GET)
	public String todayRecipeListGet(@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize, 
			Model model, HttpServletRequest request) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "todayRecipe", "", "");
		ArrayList<TodayRecipeVO> vos = adminService.getTodayRecipeList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);

		return "admin/todayRecipe/todayRecipeList";
	}
	
	// 오늘의레시피 검색 처리
	@RequestMapping(value = "/todayRecipe/today,RecipeSearch", method = RequestMethod.GET)
	public String todayRecipeSearchGet(String search, String searchString, Model model,
			@RequestParam(name= "pag", defaultValue= "1", required = false) int pag,
			@RequestParam(name= "pageSize", defaultValue = "3", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "todayRecipe", search, searchString);
		ArrayList<TodayRecipeVO> searchVOS = adminService.getTodayRecipeSearch(pageVO.getStartIndexNo(), pageVO.getPageSize(), search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "제목";
		else if(pageVO.getSearch().equals("issueDate")) searchTitle = "날짜";
		
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute(searchString, searchString);
		model.addAttribute("searchVOS", searchVOS);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/todayRecipe/todayRecipeSearch";
	}

	// 오늘의레시피 상세보기 이동
	@RequestMapping(value = "/todayRecipe/todayRecipeContent", method = RequestMethod.GET)
	public String todayRecipeContentGet(int idx, Model model) {
		TodayRecipeVO vo = adminService.getTodayRecipeContent(idx);
		adminService.setTodayRecipeUpdate(idx, vo.getReadNum());
		model.addAttribute("vo",vo);
		
		return "admin/todayRecipe/todayRecipeContent";
	}
	
	// 오늘의레시피 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/todayRecipe/todayRecipeDelete", method = RequestMethod.POST)
	public String todayRecipeDeletePost(int idx) {
		adminService.setTodayRecipeDelete(idx);
		return "";
	}
	
	// 초기화면 설정 창 이동
	@RequestMapping(value = "/main/mainSetting", method = RequestMethod.GET)
	public String mainSettingGet() {
		return "admin/main/mainSetting";
	}
	
	// 초기화면 사진 등록처리(ajax)
//	@ResponseBody
//	@RequestMapping(value = "/main/mainSettingAjax", method = RequestMethod.POST, produces="application/text; charset=utf-8")
//	public String mainSettingGet(Model model, String slideName) {
//		MainVO vo = adminService.getMainList(slideName);
//			String slideImg = (vo != null && vo.getSlideImg() != null) ? vo.getSlideImg() : ""; 
//			return slideImg;
//	}
	
	// 초기화면 사진 등록처리(일반)
	@RequestMapping(value = "/main/mainSetting", method = RequestMethod.POST)
	public String mainSettingPost(@RequestParam(name="file") MultipartFile file, 
			MainVO vo) {
		TodayRecipeVO todayRecipeVO = adminService.getSlideName(vo.getSlideName());
		MainVO vo2 = adminService.getMainList(vo.getSlideName());
		int res = 0;
		if(vo2 == null) {
			res = adminService.mainSettingSave(file, vo);
		}
		else {
			if(vo2.getTodayRecipeIdx() != vo.getTodayRecipeIdx() || todayRecipeVO.equals(vo.getSlideName())) {
				res = adminService.mainSettingUpdate(file,vo,vo2);
			}
		}
		
    if(res != 0) {
    	return "redirect:/message/mainSettingSaveOk"; 
     } 
    else { 
    	return "redirect:/message/mainSettingSaveNo"; 
    } 
	}
	
	// 오늘의레시피 소식지 발송 창 이동
	@RequestMapping(value = "/todayRecipe/todayRecipeMailing", method = RequestMethod.GET)
	public String todayRecipeMailingGet(@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			Model model, HttpServletRequest request) {
		// 구독한 주소록 페이징 처리
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "todayRecipeSub", "", "");
		
		// 구독자 가져오기
		List<TodayRecipeSubVO> subVOS = adminService.getTodayRecipeSub(pageVO.getStartIndexNo(), pageSize);
		
		// 소식지 가져오기
		List<TodayRecipeVO> vos = adminService.getTodayRecipe();
		
		model.addAttribute("subVOS", subVOS);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);

		return "admin/todayRecipe/todayRecipeMailing";
	}
	
	// 오늘의레시피 소식지 발송 처리
	@ResponseBody
	@RequestMapping(value="/todayRecipe/todayRecipeSend", method=RequestMethod.GET)
	public String todayRecipeSendPost(
			@RequestParam(name="mail", defaultValue="", required=false) String mail,
			@RequestParam(name="selectedLetter", defaultValue="", required=false) String selectedLetter,
			HttpServletRequest request) throws MessagingException {
		String res = "";
		
		// 여러개 가져온 이메일 분리
		String[] email = mail.split(","); 
		
		// 분리한 이메일을 반복해서 구독 정보에 이메일이 있는지 확인
		for (String sendMail : email) {
      TodayRecipeSubVO vo = adminService.getTodayRecipeSubList(sendMail);
		
			// 구독정보가 있다면 소식지를 메일로 발송하기
			if(vo != null) {
				mailSend(sendMail, selectedLetter); // throws MessagingException 예외 처리
				res = "1";
			}
			else res = "0";
		}
		return res;
	}	

	// 오늘의레시피 메일로 전송하는 메소드
	private int mailSend(String mail, String content) throws MessagingException {
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy년MM월dd일");
		String formatedNow = now.format(dtf);
		
		// ${vo.title}_${vo.article}로 가져온 발송할 소식지 분리
		String[] newsLetter = content.split("/"); 
		String title = newsLetter[0]; // 제목 추출
    String article = newsLetter[1]; // 내용 추출
		
		String str = "";
		// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); // throws MessagingException 예외처리
		
		// 메일 보관함에 회원이 보내온 메세지들의 정보를 모두 저장 후 작업 처리
		messageHelper.setTo(mail);
		messageHelper.setSubject(title);
		messageHelper.setText(article);  
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송할 수 있도록한다.
		str = str.replace("\n", "<br>");
		str += "<p style='text-align:center;'><a href='http://localhost:9090/javaweb10S//'><img src=\"cid:eatLogo.png\" width='300px'></a></p>";
		str += "<br><hr><h2 style='text-align:center;'>"+formatedNow+ "의 소식지입니다.<br>오늘도 행복한 하루 보내세요!</h2>";
		str += "<hr>";
		str += "<p style='text-align:center;'><img src=\"cid:"+article+"\"><p>";
		messageHelper.setText(str, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시해준다. 그 후 다시 보관함에 담아준다.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath1 = request.getSession().getServletContext().getRealPath("/resources/images/");
		String realPath2 = request.getSession().getServletContext().getRealPath("/resources/data/todayRecipe/");
//		FileSystemResource file1 = new FileSystemResource("D:\\javaweb\\springframework\\project\\javaweb10S\\src\\main\\webapp\\resources\\images\\eatLogo.png");
//		FileSystemResource file2 = new FileSystemResource("D:\\javaweb\\springframework\\project\\javaweb10S\\src\\main\\webapp\\resources\\data\\todayRecipe\\"+article+"");
		FileSystemResource file1 = new FileSystemResource(realPath1 + "eatLogo.png");
		FileSystemResource file2 = new FileSystemResource(realPath2 + article);
		
		messageHelper.addInline("eatLogo.png", file1);
		messageHelper.addInline(article, file2);
		
		// 메일 전송하기
		mailSender.send(message);
		
		return 1;
	}
	
	// 관리자 문의 목록 창 이동
	@RequestMapping(value="/inquiry/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminInquiry", part, "");
		
		ArrayList<InquiryVO> vos = adminService.getInquiryList(pageVO.getStartIndexNo(), pageSize, part);
		
   
   	model.addAttribute("vos", vos);
	  model.addAttribute("pageVO", pageVO);
	  model.addAttribute("part", part);
		
		return "admin/inquiry/inquiryList";
	}
	
	//관리자 답변달기 폼 보여주기(관리자가 답변글 수정/삭제처리하였을때도 함께 처리하고 있다.)
	@RequestMapping(value="/inquiry/inquiryReply", method = RequestMethod.GET)
	public String inquiryReplyGet(
			@RequestParam(name="idx", defaultValue="0", required=false) int idx,
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model) {
		InquiryVO vo = adminService.getInquiryContent(idx);
		InquiryReplyVO reVO = adminService.getInquiryReplyContent(idx);
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		return "admin/inquiry/inquiryReply";
	}
	
	// 관리자 답변달기 저장하기
	@ResponseBody
	@RequestMapping(value="/inquiry/inquiryReplyInput", method = RequestMethod.POST)
	public String inquiryReplyInputPost(InquiryReplyVO vo, Model model) {
		
		adminService.setInquiryInputAdmin(vo);
		System.out.println(vo.getInquiryIdx() + " dasdsadsa");
		adminService.setInquiryUpdateAdmin(vo.getInquiryIdx());
		adminService.setInquiryReplyUpdateOk(vo.getInquiryIdx());
		
		return "1";
	}

	// 관리자 답변글 수정처리
	@ResponseBody
	@RequestMapping(value="/inquiry/inquiryReplyUpdate", method = RequestMethod.POST)
	public String inquiryReplyUpdatePost(InquiryReplyVO reVO) {
		adminService.setInquiryReplyUpdate(reVO);	// 관리자가 답변글을 수정했을때 처리 루틴
		return "";
	}
	
	// 관리자 답변글 삭제처리
	@ResponseBody
	@RequestMapping(value="/inquiry/inquiryReplyDelete", method = RequestMethod.POST)
	public String adInquiryReplyDeletePost(int reIdx, int inquiryIdx) {
		adminService.setInquiryReplyDelete(reIdx);	// 관리자가 답변글을 삭제했을때 처리루틴
		adminService.setInquiryUpdateAdmin2(inquiryIdx);
		return "";
	}
	
	// 관리자 원본글과 답변글 삭제처리
	@RequestMapping(value="/inquiry/inquiryDelete", method = RequestMethod.GET)
	public String inquiryDeleteGet(Model model, 
			@RequestParam(name="idx", defaultValue="0", required=false) int idx,
			@RequestParam(name="reIdx", defaultValue="0", required=false) int reIdx,
			@RequestParam(name="pag", defaultValue="0", required=false) int pag) {
		adminService.setInquiryReplyDelete(reIdx);	// 관리자가 답변글을 삭제했을때 처리루틴
		inquiryService.setInquiryDelete(idx);
		model.addAttribute("pag", pag);
		return "redirect:/message/inquiryDeleteOk";
	}
	
	//주문관리.......
	// 관리자에서 관리자가 주문 확인하기
	@RequestMapping(value="/member/adminOrderList", method = RequestMethod.GET)
	public String adminOrderListGet(Model model,
   @RequestParam(name="startJumun", defaultValue="", required=false) String startJumun,
   @RequestParam(name="endJumun", defaultValue="", required=false) String endJumun,
   @RequestParam(name="orderStatus", defaultValue="전체", required=false) String orderStatus,
   @RequestParam(name="pag", defaultValue="1", required=false) int pag,
   @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {

		List<ItemDeliveryVO> vos = null;
		PageVO pageVO = null;
		String strNow = "";
		if(startJumun.equals("")) {
			Date now = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    strNow = sdf.format(now);
	    
	    startJumun = strNow;
	    endJumun = strNow;
		}
   
   String strOrderStatus = startJumun + "@" + endJumun + "@" + orderStatus;
   pageVO = pageProcess.totRecCnt(pag, pageSize, "adminOrderList", "", strOrderStatus);

		vos = adminService.getAdminOrderList(pageVO.getStartIndexNo(), pageSize, startJumun, endJumun, orderStatus);
	
	  model.addAttribute("startJumun", startJumun);
	  model.addAttribute("endJumun", endJumun);
	  model.addAttribute("orderStatus", orderStatus);
	  model.addAttribute("vos", vos);
	  model.addAttribute("pageVO", pageVO);
	
	  return "admin/member/adminOrderList";
	}
	
	// 주문관리에서, 관리자가 주문상태를 변경처리하는것
	@ResponseBody
	@RequestMapping(value="/member/goodsStatus", method=RequestMethod.POST)
	public String goodsStatusGet(String orderNum, String orderStatus) {
		adminService.setOrderStatusUpdate(orderNum, orderStatus);
		return "";
	}
	
	// 전체 후기 가져오기
	@RequestMapping(value="/review/reviewList", method = RequestMethod.GET)
	public String reviewListGet(Model model) {
		List<ReviewVO> vos = adminService.getReviewList();
		model.addAttribute("vos",vos);
		return "admin/review/reviewList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
//	// 오늘의레시피 크롤링으로 가져온 후 저장하기
//	public void crawling() {
//		
//		WebElement webElement;
//		String title, article, issueDate;
//		
//		final File driverFile = new File("C:\\javaweb\\springframework\\javaweb10S\\javaweb10S\\src\\main\\resources\\chromedriver.exe");
//		final String driverFilePath = driverFile.getAbsolutePath();
//		if(!driverFile.exists() && driverFile.isFile()) {
//			throw new RuntimeException("not found file. or this is not file" + driverFilePath);
//		}
//		
//		final ChromeDriverService service;
//		service = new ChromeDriverService.Builder().usingDriverExecutable(driverFile).usingAnyFreePort().build();
////		ChromeOptions options = new ChromeOptions();
//		// 브라우저가 눈에 보이지 않고 내부적으로 돈다.
//		// 설정하지 않을 시 실제 크롬 창이 생성되고, 어떤 순서로 진행되는지 확인할 수 있다.
////		options.addArguments("headless");
//		
//		// 위에서 설정한 옵션은 담은 드라이버 객체 생성
//		// 옵션을 설정하지 않았을 때에는 생략 가능하다.
//		// WebDriver객체가 곧 하나의 브라우저 창이라 생각한다.
//		
////		try {
////			service.start();
////		} catch(IOException e1) {
////			e1.printStackTrace();
////		}
//		
//		//final WebDriver driver = new ChromeDriver(options);
//		final WebDriver driver =  new ChromeDriver(service);
////		final WebDriverWait wait = new WebDriverWait(driver, 10);
//		
//		try {
//			driver.get("https://www.joongang.co.kr/newsletter/cooking");
//			Thread.sleep(3000);
//			
////			JavascriptExecutor js = (JavascriptExecutor) driver;
//			
//            for (int i = 1; i <= 100; i++) {
//            	driver.findElement(By.xpath("/html/body/div[1]/main/section/section[1]/ul/li["+i+"]/div/h2/a")).click();
//            	Thread.sleep(2000);
//							/*
//							 * webElement = driver.findElement(By.xpath("//*[@id=\"d_song_org\"]/a/img"));
//							 * // image 요소 식별 photo = webElement.getAttribute("src"); // 이미지 URL 가져오기
//							 */
//            	webElement = driver.findElement(By.xpath("//*[@id=\"container\"]/section/article/header/div[2]"));
//            	title = webElement.getText();
//            	
//            	String temp = "#container > section > article > div > p:nth-child(\"+j+\") > span";
//            	for(int j=1; j<temp.length(); j++) {
//            	webElement = driver.findElement(By.cssSelector(temp));
//            	article = webElement.getText();
//            	
//            	webElement = driver.findElement(By.xpath("/html/body/div[1]/main/section/article/header/div[2]/div/input"));
//            	issueDate = webElement.getText();
//            	
//            	TodayRecipeVO vo = new TodayRecipeVO();
//            	vo.setTitle(title);
//            	vo.setArticle(article);
//            	vo.setIssueDate(issueDate);
//            	
//            	adminService.setNewsLetter(vo);
//            	
////            	System.out.println(
////            			i + " / Title: " + title + " / Article: " + article + " / date: " + date
////							 + " / photo: " + photo );
//            	
////            	driver.findElement(By.className("menu_bg")).click();
//            	
//            	driver.navigate().back();
//            	Thread.sleep(2000);
//            	
//							/*
//							 * // 다음 페이지로 이동하는 조건문 if(i % 24 == 0) { WebElement nextPageButton =
//							 * driver.findElement(By.xpath(
//							 * "//*[@id=\"container\"]/section/section[1]/nav/ul/li["+i+"]/a")); if
//							 * (!nextPageButton.getAttribute("disabled").equals("true")) {
//							 * nextPageButton.click(); Thread.sleep(2000); } else { break; } }
//							 */
//            }
//			
//	    } catch (Exception e2) {
//	        e2.printStackTrace();
//	    } finally {
//	        // 프로그램이 종료되면 resource 해제
//	        driver.quit();
//	        service.stop();
//	    }
//}
}