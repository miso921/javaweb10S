package com.spring.javaweb10S;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb10S.pagination.PageProcess;
import com.spring.javaweb10S.pagination.PageVO;
import com.spring.javaweb10S.service.TodayRecipeService;
import com.spring.javaweb10S.vo.TodayRecipeSubVO;
import com.spring.javaweb10S.vo.TodayRecipeVO;

@Controller
@RequestMapping("/todayRecipe")
public class TodayRecipeController {

	@Autowired
	TodayRecipeService todayRecipeService;
	
	@Autowired
	PageProcess pageProcess;
	
	//오늘의레시피 목록 이동
	@RequestMapping(value = "/todayRecipeList", method = RequestMethod.GET)
	public String todayRecipeListGet(@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize, 
			Model model, HttpServletRequest request) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "todayRecipe", "", "");
		System.out.println("pageVO:"+pageVO);

		List<TodayRecipeVO> vos = todayRecipeService.getTodayRecipeList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "/todayRecipe/todayRecipeList";
	}
	
	// 오늘의레시피 구독 신청 폼 이동
	@RequestMapping(value = "/todayRecipeSubApli", method = RequestMethod.GET)
	public String todayRecipeSubApliGet() {
		return "/todayRecipe/todayRecipeSubApli";
	}
	
	// 구독 신청 처리
	@RequestMapping(value = "/todayRecipeSubApli", method = RequestMethod.POST)
	public String todayRecipeSubApliPost(TodayRecipeSubVO vo, Model model) {
		TodayRecipeSubVO vo2 = todayRecipeService.getTodayRecipeSubApli(vo.getMail());
		
		// 중복된 이메일 있는지 확인 처리
		if(vo2 != null) {
				return "redirect:/message/todayRecipeSubApliNo";
		}
		else {
				todayRecipeService.setTodayRecipeSubApli(vo);
				model.addAttribute("flag", vo.getMail());
				return "redirect:/message/todayRecipeSubApliOk";
		}	
	}
	
	// 구독 신청 완료 창 이동
	@RequestMapping(value = "/todayRecipeSubResult", method = RequestMethod.GET)
	public String todayRecipeSubResultGet(HttpSession session, Model model, String mail) {
		model.addAttribute("mail",mail);
		return "/todayRecipe/todayRecipeSubResult";
	}
	
	// 오늘의레시피 상세정보 창 이동
	@RequestMapping(value = "/todayRecipeContent", method = RequestMethod.GET)
	public String todayRecipeContentGet(@RequestParam(name="idx", defaultValue="", required=false) int idx,
			Model model) {
		TodayRecipeVO vo = todayRecipeService.getTodayRecipeContent(idx);
		todayRecipeService.setTodayRecipeUpdate(idx, vo.getReadNum());
		model.addAttribute("vo",vo);
		
		return "todayRecipe/todayRecipeContent";
	}
	
}
