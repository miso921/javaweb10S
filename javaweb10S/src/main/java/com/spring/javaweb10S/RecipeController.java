package com.spring.javaweb10S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb10S.pagination.PageProcess;
import com.spring.javaweb10S.pagination.PageVO;
import com.spring.javaweb10S.service.RecipeService;
import com.spring.javaweb10S.vo.DibsRecipeVO;
import com.spring.javaweb10S.vo.RecipeVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

	@Autowired
	RecipeService recipeService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 레시피 목록으로 이동
	@RequestMapping(value = "/recipeList" , method = RequestMethod.GET)
	public String recipeListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part) {
		ArrayList<RecipeVO> partVOS = recipeService.getRecipePart();

		model.addAttribute("partVOS", partVOS);
		model.addAttribute("part", part);
		
		ArrayList<RecipeVO> recipeVOS = recipeService.getPartRecipeList(part);
		model.addAttribute("recipeVOS",recipeVOS);
		return "recipe/recipeList";
	}
	
	// 레시피 상세정보 창으로 이동
	@RequestMapping(value = "/recipeContent", method = RequestMethod.GET)
	public String recipeContentGet(int idx, Model model, HttpSession session) {
		RecipeVO recipeVO = recipeService.getRecipeContent(idx); // 레시피의 상세정보 불러오기
		String mid = (String) session.getAttribute("sMid");
		DibsRecipeVO vo = recipeService.getDibsRecipeSearch(mid, idx);
		model.addAttribute("recipeVO", recipeVO);
		model.addAttribute("vo", vo);
		
		
		return "recipe/recipeContent";
	}
	
	// 레시피 찜하기 처리
	@ResponseBody
	@RequestMapping(value = "/recipeDibs", method = RequestMethod.POST)
	public int recipeDibsPost(@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			HttpSession session) {
		// 아이디 세션 가져오기
		String mid = (String) session.getAttribute("sMid");
		//System.out.println("idx :" + idx + ", mid : " + mid);
		// 선택한 레시피를 아이디와 함께 저장(레시피 찜하기 처리)
		boolean dibs = recipeService.toggleDibsRecipe(idx, mid);
		
		// 반환할 값 설정
		int res = dibs ? 1 : 0;
		if(dibs) res = 1;
		else res = 0;
		
		return res;
	}
	
	/*
	@RequestMapping(value = "/recipeDibs", method = RequestMethod.GET)
	public String recipeDibsGet(@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			HttpSession session, Model model) {
		// 아이디 세션 가져오기
		String mid = (String) session.getAttribute("sMid");
		//System.out.println("idx :" + idx + ", mid : " + mid);
		// 선택한 레시피를 아이디와 함께 저장(레시피 찜하기 처리)
		boolean dibs = recipeService.toggleDibsRecipe(idx, mid);
		
		model.addAttribute("idx",idx);
		
		return "redirect:/recipe/recipeContent";
	}
	*/
	
	// 찜한레시피 목록 이동
	@RequestMapping(value = "/dibsRecipeList", method = RequestMethod.GET)
	public String dibsRecipeListGet(@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize, 
			Model model, HttpServletRequest request) {
//		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dibsRecipe", "", "");
		//System.out.println("pageVO" + pageVO);
		
		List<DibsRecipeVO> vos = recipeService.getDibsRecipeList();
		model.addAttribute("vos", vos);
//		model.addAttribute("pageVO", pageVO);
		
		return "/recipe/dibsRecipeList";
	}
	
	// 선택한 찜한레시피 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/dibsRecipeSelectedDelete", method = RequestMethod.POST)
	public String dibsRecipeSelectedDeletePost(
			@RequestParam(name = "changeItems", defaultValue = "", required = false) String changeItems) {
		String res = "0";
		
		if (!changeItems.isEmpty()) {
			String[] changeItem = changeItems.split("/");
			for (String idx : changeItem) {
				recipeService.setDibsRecipeDelete(Integer.parseInt(idx));
			}
			return res = "1";
		}	
		else return res;
	}
	
	// 개별 찜한레시피 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/dibsRecipeDelete", method = RequestMethod.POST)
	public String dibsRecipeDeletePost(
			@RequestParam(name = "recipeIdx", defaultValue = "0", required = false) int idx) {
		recipeService.setDibsRecipeDelete(idx);
		return "";
	}
	
	
	
	
}
