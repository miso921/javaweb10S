package com.spring.javaweb10S;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb10S.pagination.PageProcess;
import com.spring.javaweb10S.pagination.PageVO;
import com.spring.javaweb10S.service.InquiryService;
import com.spring.javaweb10S.vo.InquiryReplyVO;
import com.spring.javaweb10S.vo.InquiryVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 문의 목록 이동
	@RequestMapping(value = "/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(HttpSession session,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			Model model) {
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "inquiry", part, mid);
		System.out.println("pageVO : " + pageVO);
		List<InquiryVO> vos = inquiryService.getInquiryList(pageVO.getStartIndexNo(), pageSize, part, mid);
		System.out.println("pageVO.getStartIndexNo():1:"+pageVO.getStartIndexNo());
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		model.addAttribute("mid", mid);
		
		return "inquiry/inquiryList";
	}
	
	// 문의글 등록 창 이동
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.GET)
	public String inquiryInputGet() {
		return "inquiry/inquiryInput";
	}

	// 문의글 등록 처리
	@RequestMapping(value = "/inquiryInput", method = RequestMethod.POST)
	public String inquiryInputPost(InquiryVO vo) {
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/inquiry/폴더에 저장시켜준다.
		inquiryService.imgCheck(vo.getContent());
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 inquiry폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/inquiry/)
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/inquiry/"));
		
		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = inquiryService.setInquiryInput(vo);
		
		if(res == 1) return "redirect:/message/inquiryInputOk";
		return "redirect:/message/inquiryInputNo";
	}
	
	// 문의글 상세보기
	@RequestMapping(value = "/inquiryView", method = RequestMethod.GET)
	public String inquiryViewGet(
			@RequestParam(name="idx", defaultValue="0", required=false) int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		System.out.println("reVO:"+reVO);
		return "/inquiry/inquiryView";
	}
	
	// 문의글 수정 폼 이동
	@RequestMapping(value = "/inquiryUpdate", method = RequestMethod.GET)
	public String inquiryUpdateGet(
			@RequestParam(name="idx", defaultValue="0", required=false) int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		model.addAttribute("idx", idx);
		
		return "/inquiry/inquiryUpdate";
	}

	// 문의글 수정 처리(사진 파일 포함)
	@RequestMapping(value = "/inquiryUpdate", method = RequestMethod.POST)
	public String inquiryUpdatePost(InquiryVO vo,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			Model model) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
		InquiryVO origVO = inquiryService.getInquiryView(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 내용을 수정처리한다.
		if(!origVO.getContent().equals(vo.getContent())) {
			
		// 실제로 수정하기 버튼을 클릭하게되면, 기존의 inquiry폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
		if(origVO.getContent().indexOf("src=\"/") != -1) inquiryService.imgDelete(origVO.getContent());
				
		// inquiry폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getContent()에 있는 그림파일경로 'inquiry'를 'ckeditor'경로로 변경해줘야한다.
		vo.setContent(vo.getContent().replace("/data/inquiry/", "/data/ckeditor/"));
		
		// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/inquiry/폴더에 저장시켜준다.
		inquiryService.imgCheck(vo.getContent());
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 inquiry폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/inquiry/)
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/inquiry/"));
		}
			
		// content의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update시켜준다.
		int res = inquiryService.setInquiryUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		
		if(res == 1) {
			return "redirect:/message/inquiryUpdateOk";
		}
		else {
			return "redirect:/message/inquiryUpdateNo";
		}		
	}
//
//	// 문의글 삭제 처리
//	@RequestMapping(value = "/inquiryDelete", method = RequestMethod.GET)
//	public String inquiryDeleteGet(HttpSession session, HttpServletRequest request,
//			@RequestParam(name="idx", defaultValue="", required=false) int idx,
//			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
//			Model model) {
//		
//		// 게시글에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
//		InquiryVO vo = inquiryService.getInquiryView(idx);
//		if(vo.getContent().indexOf("src=\"/") != -1) inquiryService.imgDelete(vo.getContent());
//		
//		// DB에서 실제로 존재하는 게시글을 삭제처리한다.
//		int res = inquiryService.setInquiryDelete(idx);
//		
//		if(res == 1) return "redirect:/message/inquiryDeleteOk";
//		else return "redirect:/message/inquiryDeleteNo?idx="+idx+"&pag="+pag;
//		}
	
}
