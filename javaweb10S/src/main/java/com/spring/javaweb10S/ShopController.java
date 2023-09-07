package com.spring.javaweb10S;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb10S.pagination.PageProcess;
import com.spring.javaweb10S.pagination.PageVO;
import com.spring.javaweb10S.service.MemberService;
import com.spring.javaweb10S.service.ShopService;
import com.spring.javaweb10S.vo.ItemCartVO;
import com.spring.javaweb10S.vo.ItemDeliveryVO;
import com.spring.javaweb10S.vo.ItemOrderVO;
import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.OptionVO;
import com.spring.javaweb10S.vo.PaymentVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.ReviewVO;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopService shopService;
	
	@Autowired
	MemberService memberService;

	@Autowired
	PageProcess pageProcess;
	
	// 가게 메뉴를 누른 후 화면으로 이동
	@RequestMapping(value = "/itemList", method = RequestMethod.GET)
	public String itemListGet(Model model,
			@RequestParam(name="part", defaultValue="전체", required=false) String part) {
		ArrayList<ProductVO> partVOS = shopService.getItemPart();
		ArrayList<String> parts = new ArrayList<>();
		
//		for(ProductVO partVO : partVOS) {
//			if(partVO.getPart().equals("freshFood")) parts.add("신선식품");
//			else if(partVO.getPart().equals("processedFood")) parts.add("가공식품");
//			else if(partVO.getPart().equals("kitchenWare")) parts.add("주방용품");
//		}
		for(ProductVO partVO : partVOS) {
			if(partVO.getPart().equals("신선식품")) parts.add("신선식품");
			else if(partVO.getPart().equals("가공식품")) parts.add("가공식품");
			else if(partVO.getPart().equals("주방용품")) parts.add("주방용품");
		}
		model.addAttribute("partVOS",partVOS);
		model.addAttribute("parts",parts);
		model.addAttribute("part",part);
		
		ArrayList<ProductVO> itemVOS = shopService.getPartItemList(part);
		model.addAttribute("itemVOS",itemVOS);
		
		return "shop/itemList";
	}
	
	// 상품 상세정보 창으로 이동
	@RequestMapping(value = "/itemContent", method = RequestMethod.GET)
	public String itemContentGet(int idx, Model model) {
		ProductVO productVO = shopService.getItemContent(idx); // 상품의 상세정보 불러오기
		ArrayList<OptionVO> optionVOS = shopService.getItemOption(idx); // 상품의 옵션 정보 불러오기
		List<ReviewVO> reviewVOS = shopService.getReviewList(idx); // 상품의 리뷰 불러오기
		
		model.addAttribute("productVO",productVO);
		model.addAttribute("optionVOS",optionVOS);
		model.addAttribute("reviewVOS",reviewVOS);
		
		return "shop/itemContent";
	}
	
	// 상품상세정보보기창에서 '장바구니'버튼, '주문하기'버튼을 클릭하면 모두 이곳을 거쳐서 이동처리했다.
	// '장바구니'버튼에서는 '다시쇼핑하기'처리했고, '주문하기'버튼에서는 '주문창(장바구니창)'으로 보내도록 처리했다.
	@RequestMapping(value="/itemContent", method=RequestMethod.POST)
	public String itemContentPost(ItemCartVO vo, HttpSession session) {
		// itemCartVO(vo) : 사용자가 선택한 품목(기본품목+옵션)의 정보를 담고 있는 VO
		// itemCartVO(resVo) : 사용자가 기존에 장바구니에 담아놓은적이 있는 품목(기본품목+옵션)의 정보를 담고 있는 VO
		String mid = (String) session.getAttribute("sMid");
		vo.setMid(mid);
		
		ItemCartVO resVo = shopService.getItemCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
		int res = 0;
		
		if(resVo != null) {		// 기존에 저장한적이 있었다면 '현재 구매한 내역'과 '기존 장바구니의 수량'을 합쳐서 'Update'시켜줘야한다.
			shopService.setItemCartUpdate(vo);
			res = 1;
		}		
//		if(resVo != null) {		// 기존에 저장한적이 있었다면 '현재 구매한 내역'과 '기존 장바구니의 수량'을 합쳐서 'Update'시켜줘야한다.
//			String[] voOptionNums = vo.getOptionNum().split(",");
//			String[] resOptionNums = resVo.getOptionNum().split(",");
//			int[] nums = new int[99];
//			String strNums = "";
//			for(int i=0; i<voOptionNums.length; i++) {
//				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
//				strNums += nums[i];
//				if(i < nums.length - 1) strNums += ",";
//			}
//			vo.setOptionNum(strNums);
//			shopService.setItemCartUpdate(vo);
//			res = 1;
//		}		// 처음 구매하는 제품이라면 장바구니에 insert시켜준다.
		else {
			shopService.setItemCartInput(vo);
			res = 1;
		}
		if(res == 1) {
			return "redirect:/message/cartInputOk";
		}
		else {
			return "redirect:/message/cartInputNo";
		}
	}
	
	//장바구니에 담겨있는 모든 상품들의 내역을 보여주기-주문 전단계(장바구니는 DB에 들어있는 자료를 바로 불러와서 처리하면 된다.)
	@RequestMapping(value="/itemCart", method=RequestMethod.GET)
	public String itemCartGet(HttpSession session, ItemCartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		ArrayList<ItemCartVO> vos = shopService.getItemCartList(mid);
	
		if(mid != null) {
			if(vos.size() == 0) return "redirect:/message/cartEmpty";
		}
		else if(mid == null) return "redirect:/message/cartMidEmpty";
		model.addAttribute("cartListVOS", vos);
		return "shop/itemCart";
	}
	
	// 장바구니 상품 한개씩 삭제처리
	@ResponseBody
	@RequestMapping(value="/itemCartDelete", method=RequestMethod.POST)
	public String itemCartDeletePost(int idx) {
		shopService.setCartItemDelete(idx);
		return "";
	}	
	
	// 장바구니 선택한 상품 삭제처리
	@ResponseBody
	@RequestMapping(value="/selCartDelete", method=RequestMethod.POST)
	public String selCartDeletePost(
			@RequestParam(name="delItems", defaultValue="", required=false) String delItems) {
		String[] delItem = delItems.split("/");
		for (String idx : delItem) {
			shopService.setCartItemDelete((Integer.parseInt(idx)));
		}
		return "";
	}	
	
	// 장바구니에서 '주문하기'버튼 클릭시에 처리하는 부분
	// 카트에 담겨있는 품목들중에서, 주문한 품목들을 읽어와서 세션에 담아준다. 이때 고객의 정보도 함께 처리하며, 주문번호를 만들어서 다음단계인 '결재'로 넘겨준다.
	@RequestMapping(value="/itemCart", method=RequestMethod.POST)
	public String itemCartPost(HttpServletRequest request, Model model, HttpSession session, 
			@RequestParam(name="total",  defaultValue = "0", required = false) String totalStr,
			@RequestParam(name="baesong", defaultValue = "0", required = false) int baesong) {
		String mid = session.getAttribute("sMid").toString();
		session.setAttribute("sMid", mid);
		
	// total 파라미터를 숫자로 변환 (,가 있다는 오류 해결을 위한 코드)
    int total = 0;
    try {
        total = Integer.parseInt(totalStr.replaceAll(",", ""));
    } catch (NumberFormatException e) {
        // 숫자로 변환할 수 없는 경우 기본값을 설정하거나 오류 처리를 수행할 수 있습니다.
        // 여기서는 기본값 0을 사용하도록 설정합니다.
        total = 0;
    }
		
		
		// 주문한 상품에 대하여 '고유번호'를 만들어준다.
		// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
		ItemOrderVO maxIdx = shopService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderNum = sdf.format(today) + idx;
				
		// 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.
		String[] idxChecked = request.getParameterValues("idxChecked");
		ItemCartVO cartVo = new ItemCartVO();
		ArrayList<ItemOrderVO> orderVOS = new ArrayList<ItemOrderVO>();
		
		for(String strIdx : idxChecked) {
			cartVo = shopService.getCartIdx(Integer.parseInt(strIdx));
			ItemOrderVO orderVo = new ItemOrderVO();
			orderVo.setProductIdx(cartVo.getProductIdx());
			orderVo.setProductName(cartVo.getProductName());
			orderVo.setPrice(cartVo.getPrice());
			orderVo.setThumbnail(cartVo.getThumbnail());
			orderVo.setOptionName(cartVo.getOptionName());
			orderVo.setOptionPrice(cartVo.getOptionPrice());
			orderVo.setOptionNum(cartVo.getOptionNum());
			orderVo.setTotalPrice(total);
			orderVo.setCartIdx(cartVo.getIdx());
			orderVo.setBaesong(baesong);
			
			orderVo.setOrderNum(orderNum);	// 관리자가 만들어준 '주문고유번호'를 저장
			orderVo.setMid(mid);						// 로그인한 아이디를 저장한다.
			
			
			orderVOS.add(orderVo);
		}
		session.setAttribute("sOrderVOS", orderVOS);
		
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member2테이블에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		
		return "shop/itemOrder";
	}
	
	//결제시스템(결제창 호출하기) - API이용
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(PaymentVO paymentVO, ItemDeliveryVO deliveryVO, HttpSession session, Model model,
			@RequestParam(name="usedPoint", defaultValue="", required=false) String usedPoint) {
		
		 // 기본값 처리
    int pointValue = 0;
    if (!usedPoint.isEmpty()) {
        pointValue = Integer.parseInt(usedPoint);
    }
    
		model.addAttribute("paymentVO", paymentVO);
		session.setAttribute("sPaymentVO", paymentVO);
		session.setAttribute("sDeliveryVO", deliveryVO);
		session.setAttribute("sUsedPoint", usedPoint); // 포인트 세션 생성
		
		return "shop/itemPayment";
	}
	
  // 결제시스템 연습하기(결제창 호출 후 결제 완료후에 처리하는 부분)
	// 주문 완료후 주문내역을 '주문테이블(itemOrder)에 저장
	// 주문이 완료되었기에 주문된 물품은 장바구니(itemCart)에서 내역을 삭제처리한다.
	// 사용한 세션은 제거시킨다.
	// 작업처리후 오늘 구매한 상품들의 정보(구매품목,결제내역,배송지)들을 model에 담아서 확인창으로 넘겨준다.
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, PaymentVO receivePaymentVO, Model model) {
		// 주문내역 itemOrder/itemDelivery 테이블에 저장하기(앞에서 저장했던 세션에서 가져왔다.)
		ArrayList<ItemOrderVO> orderVOS = (ArrayList<ItemOrderVO>) session.getAttribute("sOrderVOS");
		String usedPoint = (String) session.getAttribute("sUsedPoint");
		PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");
		ItemDeliveryVO itemDeliveryVO = (ItemDeliveryVO) session.getAttribute("sDeliveryVO");
		
		// 사용된 세션은 반환한다.
		// session.removeAttribute("sOrderVOS");  // 마지막 결제처리후에 결제결과창에서 확인하고 있기에 지우면 안됨
		session.removeAttribute("sItemDeliveryVO"); // 배송물품을 삭제
		for(ItemOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderNum().substring(8))); // 주문테이블에 고유번호를 셋팅한다.	
			vo.setOrderNum(vo.getOrderNum());        				            // 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());							
			
			shopService.setItemOrder(vo);                 	   // 주문내용을 주문테이블(itemOrder)에 저장.
			shopService.setCartItemDelete(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(itemCart)테이블에서 주문한 내역을 삭체처리한다.
		}
		// 주문된 정보를 배송테이블에 담기위한 처리(기존 itemDeliveryVO에 담기지 않은 내역들을 담아주고 있다.)
		itemDeliveryVO.setOrderIdx(orderVOS.get(0).getIdx());
		itemDeliveryVO.setOrderNum(orderVOS.get(0).getOrderNum());
		itemDeliveryVO.setOrderTotalPrice(paymentVO.getAmount());
		itemDeliveryVO.setThumbImg(orderVOS.get(0).getThumbnail());
		itemDeliveryVO.setAddress(paymentVO.getBuyer_addr());
		itemDeliveryVO.setTel(paymentVO.getBuyer_tel());
		
		// 배송비 계산처리(주문금액이 5만원 이하면 총 주문액에 배송비 2500원 추가처리한다.)
//		if(itemDeliveryVO.getOrderTotalPrice() <= 50000) {
//			itemDeliveryVO.setOrderTotalPrice(itemDeliveryVO.getOrderTotalPrice()+2500);
//		}
		MemberVO vo = new MemberVO();
		shopService.setItemDelivery(itemDeliveryVO);  // 배송내용을 배송테이블(ItemDelivery)에 저장
		if(!usedPoint.equals(null)) shopService.setMemberPointMinus(orderVOS.get(0).getMid(), usedPoint);  // 회원테이블에 사용 포인트 차감하기
		shopService.setMemberPointPlus((int)(itemDeliveryVO.getOrderTotalPrice() * 0.01), orderVOS.get(0).getMid());	// 회원테이블에 포인트 적립하기(1%)
		
		paymentVO.setImp_uid(receivePaymentVO.getImp_uid());
		paymentVO.setMerchant_uid(receivePaymentVO.getMerchant_uid());
		paymentVO.setPaid_amount(receivePaymentVO.getPaid_amount());
		paymentVO.setApply_num(receivePaymentVO.getApply_num());
		
		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
		session.setAttribute("sOrderVOS", orderVOS);
		session.setAttribute("sPayMentVO", paymentVO);
		session.setAttribute("sItemDeliveryVO", itemDeliveryVO);
		
		return "redirect:/message/paymentResultOk";
	}
	
	//결제완료된 정보 보여주기
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<ItemOrderVO> orderVOS = (List<ItemOrderVO>) session.getAttribute("sOrderVOS");
    ItemDeliveryVO itemDeliveryVO = (ItemDeliveryVO) session.getAttribute("sItemDeliveryVO");
    String usedPoint = (String) session.getAttribute("sUsedPoint");
		
		model.addAttribute("orderVOS", orderVOS);
		model.addAttribute("itemDeliveryVO", itemDeliveryVO);
		model.addAttribute("usedPoint", usedPoint);
		
		session.removeAttribute("sOrderVOS");
		
		return "shop/paymentResult";
	}
	
	// 결제완료 화면 - 배송지 정보 보여주기
	@RequestMapping(value="/itemOrderDelivery", method=RequestMethod.GET)
	public String itemOrderDeliverygGet(String orderNum, Model model) {
		List<ItemDeliveryVO> vos = shopService.getOrderDelivery(orderNum);  // 같은 주문번호가 2개 이상 있을수 있기에 List객체로 받아온다.
		
		ItemDeliveryVO vo = vos.get(0);  // 같은 배송지면 0번째것 하나만 vo에 담아서 넘겨주면 된다.
		String payMethod = "";
		if(vo.getPayment().substring(0,1).equals("C")) payMethod = "카드결제";
		else payMethod = "무통장결제";
		
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("vo", vo);
		
		return "shop/itemOrderDelivery";
	}
	
	
	//현재 로그인 사용자가 주문내역 조회하기 폼 보여주기
	@RequestMapping(value="/myOrder", method=RequestMethod.GET)
	public String myOrderGet(HttpServletRequest request, HttpSession session, Model model,
			String startJumun, 
			String endJumun, 
			String productName,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
		
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "전체";
		System.out.println("mid : " + mid);
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrder", mid, "");
		
		// 오늘 구매한 내역을 초기화면에 보여준다.
		List<ItemDeliveryVO> vos = shopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid);
		
		//ProductVO productVo = shopService.getProductContent(vos.get(0).getProductName());
		
		/*
		System.out.println("vos.size() : " + vos.size());
		// 구매한 물건이 있다면, 후기 목록을 가져와서 후기를 넘긴 후 jstl로 후기가 null이면 후기작성 버튼을 사라지게 한다.
		if(vos.size() != 0) {
			ReviewVO reviewVo = shopService.getReviewYesOrNo(vos.get(0).getProductName());
			model.addAttribute("reviewVo",reviewVo);
		}
		*/
		
		//model.addAttribute("productVo", productVo);				
		model.addAttribute("vos", vos);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVO", pageVO);
		
		return "shop/myOrder";
	}
	
 //주문 조건 조회하기(날짜별(오늘/일주일/보름/한달/3개월/전체)
 @RequestMapping(value="/orderCondition", method=RequestMethod.GET)
 public String orderConditionGet(HttpSession session, int conditionDate, Model model,
     @RequestParam(name="pag", defaultValue="1", required=false) int pag,
     @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
   String mid = (String) session.getAttribute("sMid");
   String strConditionDate = conditionDate + "";
   PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "shopMyOrderCondition", mid, strConditionDate);

   List<ItemDeliveryVO> vos = shopService.getOrderCondition(mid, conditionDate, pageVO.getStartIndexNo(), pageSize);
   
	 model.addAttribute("vos", vos);
	 model.addAttribute("pageVO", pageVO);
   model.addAttribute("conditionDate", conditionDate);

   // 아래는 1일/일주일/보름/한달/3달/전체 조회시에 startJumun과 endJumun을 넘겨주는 부분(view에서 시작날짜와 끝날짜를 지정해서 출력시켜주기위해 startJumun과 endJumun값을 구해서 넘겨준다.)
   Calendar startDateJumun = Calendar.getInstance();
   Calendar endDateJumun = Calendar.getInstance();
   startDateJumun.setTime(new Date());  // 오늘날짜로 셋팅
   endDateJumun.setTime(new Date());    // 오늘날짜로 셋팅
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String startJumun = "";
   String endJumun = "";
   switch (conditionDate) {
     case 1:
       startJumun = sdf.format(startDateJumun.getTime());
       endJumun = sdf.format(endDateJumun.getTime());
       break;
     case 7:
       startDateJumun.add(Calendar.DATE, -7);
       break;
     case 15:
       startDateJumun.add(Calendar.DATE, -15);
       break;
     case 30:
       startDateJumun.add(Calendar.MONTH, -1);
       break;
     case 90:
       startDateJumun.add(Calendar.MONTH, -3);
       break;
     case 99999:
       startDateJumun.set(2022, 00, 01);
       break;
     default:
       startJumun = null;
       endJumun = null;
   }
   if(conditionDate != 1 && endJumun != null) {
     startJumun = sdf.format(startDateJumun.getTime());
     endJumun = sdf.format(endDateJumun.getTime());
   }

   model.addAttribute("startJumun", startJumun);
   model.addAttribute("endJumun", endJumun);

   return "shop/myOrder";
 }
	
	// 날짜별 상태별 기존제품 구매한 주문내역 확인하기
	@RequestMapping(value="/myOrderStatus", method=RequestMethod.GET)
	public String myOrderStatusGet(
			HttpServletRequest request, 
			HttpSession session, 
			String startJumun, 
			String endJumun, 
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus,
			Model model) {
		
		//PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");
		String usedPoint = (String) session.getAttribute("sUsedPoint");
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		
		if(level == 0) mid = "전체";
		String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString);  // 4번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
		
		List<ItemDeliveryVO> vos = shopService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
		model.addAttribute("vos", vos);				
		model.addAttribute("usedPoint", usedPoint);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVO", pageVO);
		
		return "shop/myOrder";
	}
	 
	// 배송중/배송완료일 때 구매확정 처리
	@ResponseBody
	@RequestMapping(value = "/buyOk", method = RequestMethod.POST)
	public String buyOkPost(String orderNum) {
		shopService.setBuyOkUpdate(orderNum);
		return "";
	}
	
	
	
	
	
	
	
	// 후기에 상품명 가져가기
	@RequestMapping(value = "/itemContentProductName", method=RequestMethod.GET)
	public String itemContentProductNameGet(String productName) {
		ProductVO vo = shopService.getProductContent(productName);
		return "redirect:/shop/itemContent?idx="+vo.getIdx();
	}
	
	
	
	// 결제완료일 때만 결제취소 처리
	@ResponseBody
	@RequestMapping(value="/payCancle", method=RequestMethod.POST)
	public String payCanclePost(int orderNum) {
		shopService.setPayCancle(orderNum);
		
		return "";
	}
	
	// 후기 작성 폼 이동
	@RequestMapping(value="/reviewInput", method=RequestMethod.GET)
	public String reviewInputGet(String productName, Model model) {
		ProductVO vo = shopService.getProductContent(productName);
		model.addAttribute("vo",vo);
		return "review/reviewInput";
	}
	
	// 후기 작성 등록 처리
	@RequestMapping(value="/reviewInput", method=RequestMethod.POST)
	public String reviewInputPost(ReviewVO vo, MultipartHttpServletRequest file) {
		//int res = 0;
		shopService.setReviewInput(vo,file);
		return "redirect:/message/reviewInputOk";
	}
	
	
}
