package com.spring.javaweb10S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/message/{msgFlag}", method=RequestMethod.GET)
	public String messageGet(@PathVariable String msgFlag, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
		  @RequestParam(name="flag", defaultValue = "", required = false) String flag,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag ) {
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인되었습니다!");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인이 불가합니다.\\n다시 확인하세요!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃되었습니다!");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("midSameSearch")) {
			model.addAttribute("msg", "같은 아이디가 존재합니다!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시비밀번호가 발급되었습니다.\\n이메일을 확인해주세요!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "임시비밀번호 전송에 실패했습니다.\\n재시도 부탁드립니다.");
			model.addAttribute("url", "/member/memberFindPwd");
		}
		else if(msgFlag.equals("memberEmailCheckNo")) {
			model.addAttribute("msg", "입력하신 이메일을 확인해주세요!");
			model.addAttribute("url", "/member/memberFindPwd");
		}
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "입력하신 아이디는 존재하지 않는 정보입니다!");
			model.addAttribute("url", "/member/memberFindPwd");
		}
		else if(msgFlag.equals("memberProfileUploadOk")) {
			model.addAttribute("msg", "프로필 사진이 업로드되었습니다.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("memberProfileUploadNo")) {
			model.addAttribute("msg", "프로필 사진 업로드에 실패했습니다!");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("memberProfileMidNo")) {
			model.addAttribute("msg", "회원 정보가 올바르지 않습니다.\\n재시도 부탁드립니다!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberMidCheckNo")) {
			model.addAttribute("msg", "아이디를 확인하세요.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberMidNO")) {
			model.addAttribute("msg", "로그인 후 사용하세요!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원정보가 모두 수정되었습니다!");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정이 실패했습니다!\\n정보를 다시 확인하세요!");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 다시 확인하세요!");
			model.addAttribute("url", "/member/memberPwdUpdateCheck");
		}
		else if(msgFlag.equals("memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호 변경이 완료되었습니다!\\n비밀번호 변경 후 사용하세요!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("memberCancleOk")) {
			model.addAttribute("msg", "회원탈퇴가 완료되었습니다!\\n30일 이내 같은 아이디로 가입할 수 없습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품등록이 완료되었습니다!");
			model.addAttribute("url", "/admin/product/productList");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "상품등록에 실패했습니다!\\n다시 한번 확인하세요.");
			model.addAttribute("url", "/admin/product/productInput");
		}
		else if(msgFlag.equals("productOptionInputOk")) {
			model.addAttribute("msg", "옵션 항목이 등록되었습니다.");
			model.addAttribute("url", "/admin/product/productOptionInput");
		}
		else if(msgFlag.equals("productOptionInputNo")) {
			model.addAttribute("msg", "옵션 항목 등록에 실패했습니다.");
			model.addAttribute("url", "/admin/product/productOptionInput");
		}
		else if(msgFlag.equals("starSaveOk")) {
			model.addAttribute("msg", "난이도 등록이 완료되었습니다.");
			model.addAttribute("url", "/admin/recipe/recipeInput");
		}
		else if(msgFlag.equals("starSaveNo")) {
			model.addAttribute("msg", "난이도 등록에 실패했습니다.");
			model.addAttribute("url", "/admin/recipe/recipeInput");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "상품을 장바구니에 담았습니다.\\n즐거운 쇼핑 되세요!");
			model.addAttribute("url", "/shop/itemCart");
		}
		else if(msgFlag.equals("cartInputNo")) {
			model.addAttribute("msg", "장바구니에 담을 수 없습니다.\\n상품을 다시 확인해주세요!");
			model.addAttribute("url", "/shop/itemContent");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/shop/itemList");
		}
		else if(msgFlag.equals("cartMidEmpty")) {
			model.addAttribute("msg", "로그인 후 상품을 담아주세요.");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 완료되었습니다!");
			model.addAttribute("url", "/shop/paymentResultOk");
		}
		else if(msgFlag.equals("recipeInputOk")) {
			model.addAttribute("msg", "레시피가 저장되었습니다!");
			model.addAttribute("url", "/admin/recipe/recipeList");
		}
		else if(msgFlag.equals("recipeInputNo")) {
			model.addAttribute("msg", "레시피 저장에 실패했습니다!");
			model.addAttribute("url", "/admin/recipe/recipeInput");
		}
		else if(msgFlag.equals("todayRecipeInputOk")) {
			model.addAttribute("msg", "오늘의레시피가 저장되었습니다!");
			model.addAttribute("url", "/admin/todayRecipe/todayRecipeList");
		}
		else if(msgFlag.equals("todayRecipeInputNo")) {
			model.addAttribute("msg", "오늘의레시피 저장에 실패했습니다!");
			model.addAttribute("url", "/admin/todayRecipe/todayRecipeInput");
		}
		else if(msgFlag.equals("mainSettingSaveOk")) {
			model.addAttribute("msg", "오늘의레시피 슬라이드 이미지 저장에 성공했습니다!");
			model.addAttribute("url", "/admin/main/mainSetting");
		}
		else if(msgFlag.equals("mainSettingSaveNo")) {
			model.addAttribute("msg", "오늘의레시피 슬라이드 이미지 저장에 실패했습니다!");
			model.addAttribute("url", "/admin/main/mainSetting");
		}
		else if(msgFlag.equals("todayRecipeSubApliOk")) {
			model.addAttribute("msg", "오늘의레시피 구독 신청이 완료되었습니다!");
			model.addAttribute("url", "/todayRecipe/todayRecipeSubResult?mail="+flag);
		}
		else if(msgFlag.equals("todayRecipeSubApliNo")) {
			model.addAttribute("msg", "이미 구독 신청이 완료되었습니다!");
			model.addAttribute("url", "/todayRecipe/todayRecipeSubApli");
		}
		else if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("msg", "문의글 등록이 완료되었습니다!");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryInputNo")) {
			model.addAttribute("msg", "문의글 등록에 실패했습니다!");
			model.addAttribute("url", "/inquiry/inquiryInput");
		}
		else if(msgFlag.equals("inquiryUpdateOk")) {
			model.addAttribute("msg", "문의글 수정이 완료되었습니다!");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryUpdateNo")) {
			model.addAttribute("msg", "문의글 수정에 실패했습니다!");
			model.addAttribute("url", "/inquiry/inquiryView?idx="+idx+"&pag="+pag);
		}
		else if(msgFlag.equals("inquiryDeleteOk")) {
			model.addAttribute("msg", "문의글 삭제가 완료되었습니다!");
			model.addAttribute("url", "/admin/inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryDeleteNo")) {
			model.addAttribute("msg", "문의글 삭제에 실패했습니다!");
			model.addAttribute("url", "/admin/inquiry/inquiryView?idx="+idx+"&pag="+pag);
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("msg", "후기 작성이 완료되었습니다!");
			model.addAttribute("url", "/shop/myOrder");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "로그인 후 사용하세요!");
			model.addAttribute("url", "/member/memberLoginJoin");
		}
		return "include/message";
	}
}
