package com.spring.javaweb10S;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.spring.javaweb10S.service.MemberService;
import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.ProductVO;

@Controller
@RequestMapping("/member")
public class MemberController {	
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 화면으로 이동
	@RequestMapping(value="/memberLoginJoin", method=RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "/member/memberLoginJoin";
	}
	
	// 카카오 로그인 완료후 수행할 내용들을 기술한다.
	@RequestMapping(value="/memberKakaoLogin", method=RequestMethod.GET)
	public String memberKakaoLoginGet(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			String email) throws MessagingException {
		
		session.setAttribute("sLogin", "kakao"); // 어떤 로그인으로 들어왔는지 확인하기 위함으로 필수 코드는 아닙니다.
		
		// 카카오로그인한 회원이 현재 우리 회원인지를 조회한다.(메일주소 @앞의 값을 아이디로 간주하고 처리한다.)
		// 이미 가입된 회원이라면 바로 서비스를 사용하게 하고, 그렇지 않으면 강제로 회원 가입시킨다.
		MemberVO vo = memberService.getMemberEmailCheck(email);
		
		// 현재 우리회원이 아니면 자동회원가입처리..(가입필수사항: 아이디,이메일) - 아이디는 이메일주소의 '@'앞쪽 이름을 사용하기로 한다.
		if(vo == null) {
			// 아이디 결정하기  
			String mid = email.substring(0, email.indexOf("@"));
			
			// 같은 아이디가 존재하면 가입할 수 없도록 처리했다.
			MemberVO vo2 = memberService.getMemberIdCheck(mid);
			if(vo2 != null) return "redirect:/message/midSameSearch";
			
			// 임시 비밀번호 발급하기(UUID 8자리로 발급하기로 한다. -> 발급후 암호화시켜 DB에 저장)
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);	// 임시비밀번호를 발급하여 로그인 후 변경 처리하도록 한다.
			pwd = passwordEncoder.encode(pwd);
			
			// 새로 발급된 임시비밀번호를 메일로 전송처리한다.
			//  메일 처리부분... 생략함.
			mailSend(email, pwd);
			
			// 자동 회원 가입처리한다.
			memberService.setKakaoMemberInputOk(mid, pwd, email);
			
			// 가입 처리된 회원의 정보를 다시 읽어와서 vo에 담아준다.
			vo = memberService.getMemberIdCheck(mid);
		}
		// 만약에 탈퇴신청한 회원이 카카오로그인처리하였다라면 'userDel'필드를 'NO'로 업데이트한다.
		if(!vo.getUserDel().equals("NO")) {
			memberService.setMemberUserDelCheck(vo.getMid());
		}
		
		// 회원 인증처리된 경우 수행할 내용? strLevel처리, session에 필요한 자료를 저장, 쿠키값처리, 그날 방문자수 1 증가(방문포인트도 증가), ..
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 1) strLevel = "회원";
		
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sStrLevel", strLevel);
		session.setAttribute("sMid", vo.getMid());
		// session.setAttribute("sNickName", vo.getNickName());
		
		// 로그인한 사용자의 오늘 방문횟수(포인트) 누적...
		memberService.setMemberVisitPointUpdate(vo);
		
		return "redirect:/message/memberLoginOk?mid="+vo.getMid();
	}
	
	
	// 일반 로그인 OK 때 처리하기
	@RequestMapping(value="/memberLogin", method=RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session,
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			@RequestParam(name="pwd", defaultValue="", required=false) String pwd,
			@RequestParam(name="idSave", defaultValue="", required=false) String idSave) {
		
		// 입력한 id와 vo의 id를 비교
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// vo에 있는 level을 strLevel에 담아 session에 저장, 포인트 증가...
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else strLevel = "회원";
			
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sName", vo.getName());
		
			if(idSave.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*7); // 7일동안 유지되는 쿠키
				response.addCookie(cookie);
			}
			else {
				// idSave가 체크되지 않은 경우, 쿠키 삭제
				Cookie cookie = new Cookie("cMid", "");
				cookie.setPath("/");
				cookie.setMaxAge(0); // 쿠키 삭제
				response.addCookie(cookie);
			}
			
			// 오늘 날짜 formatter
			LocalDate now = LocalDate.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formatNow = now.format(dtf);
			
			// 오늘 첫 방문 시 TodayCnt를 0으로 세팅, 포인트 100점 증가(하루에 1번 방문 포인트 100 증가)
			if(!vo.getLastDate().substring(0,10).equals(formatNow)) {
				memberService.setTodayCntReset(mid);
				memberService.setMemberVisitPointUpdate(vo);
				return "redirect:/message/memberLoginOk?mid="+mid;
			}
			// 오늘 첫 방문이 아니면 TodayCnt만 1증가!
			else {
				memberService.setMemberVisitUpdate(vo);
				return "redirect:/message/memberLoginOk?mid="+mid;
			}
		}	
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	// 아이디 중복확인 처리
	@ResponseBody
	@RequestMapping(value="/memberIdCheck", method=RequestMethod.POST)
	public String memberIdCheckPost(@RequestParam(name="mid", defaultValue="", required=false) String mid,
			MemberVO vo) {
		// 아이디 중복확인
		if(memberService.getMemberIdCheck(mid) != null) return "1";
		else return "0";
	}
	
	// 회원가입 처리
	@ResponseBody
	@RequestMapping(value="/memberJoin", method=RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 비밀번호 암호화(BCryptPasswordEncoder)
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		memberService.setMemberJoinOk(vo);
		
		return "1";
	}
	
	// 이용약관으로 이동
	@RequestMapping(value="/memberJoinTerm", method=RequestMethod.GET)
	public String memberJoinTermGet() {
		return "/member/memberJoinTerm";
	}
	
	// 로그아웃 처리
	@RequestMapping(value="/memberLogout", method=RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();

		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	// 아이디 찾기 폼 이동
	@RequestMapping(value="/memberFindMid", method=RequestMethod.GET)
	public String memberFindMidGet() {
		return "/member/memberFindMid";
	}
	
  // 아이디 찾기 처리
	@ResponseBody
  @RequestMapping(value="/memberFindMid", method=RequestMethod.POST)
  public String memberFindMidPost(String name, String email, Model model) {
  	String mid = memberService.getMemberFindMid(name, email) == null ? "" : memberService.getMemberFindMid(name, email);
  	
  	model.addAttribute("name",name);
  	model.addAttribute("email",email);
  	
  	if(mid.equals("")) {
  		mid = "0";
  	}
  	else {
  		int maskLength = mid.length() -2; // 마스킹할 문자 길이
  		String maskedMid = mid.substring(0, maskLength) + maskStar(maskLength);
  		return maskedMid;
  	}
  	return mid;
  }

	// 마스킹 문자 만들기
	private String maskStar(int maskLength) {
		StringBuilder maskBulider = new StringBuilder();
		for(int i=0; i<maskLength; i++) {
			maskBulider.append('*');
		}
		return maskBulider.toString();
	}
	
	// 비밀번호 찾기 폼 이동
	@RequestMapping(value="/memberFindPwd", method=RequestMethod.GET)
	public String memberFindPwdGet() {
		return "/member/memberFindPwd";
	}
	
	// 비밀번호 찾기 처리
	@RequestMapping(value="/memberFindPwd", method=RequestMethod.POST)
	public String memberFindPwdPost(
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			@RequestParam(name="mail", defaultValue="", required=false) String mail,
			HttpServletRequest request) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO")) {
			if(vo.getEmail().equals(mail)) {
				// 회원정보가 맞다면 임시비밀번호를 발급 (8자리)
				UUID uid = UUID.randomUUID();
				String pwd = uid.toString().substring(0,8);
				
				// 회원이 임시비밀번호를 변경할 수 있도록 유도하기 위한 임시 세션 1개
				HttpSession session = request.getSession();
				session.setAttribute("sImsiPwd", pwd);
				
				// 발급받은 임시비밀번호를 암호화하여 DB에 저장
				memberService.setMemberPwdUpdate(mid, passwordEncoder.encode(pwd));
				
				// 저장된 임시비밀번호를 메일로 전송처리한다.
				String content = pwd;
				int res = mailSend(mail, content); // throws MessagingException 예외 처리
				
				if(res == 1) return "redirect:/message/memberImsiPwdOk";
				else return "redirect:/message/memberImsiPwdNo";
			}
			else {
				return "redirect:/message/memberEmailCheckNo";
			}
		}
		else {
			return "redirect:/message/memberIdCheckNo";
		}
	}

	// 임시비밀번호 메일로 전송하는 메소드
	private int mailSend(String mail, String content) throws MessagingException {
		String title = "<밥먹자> 임시 비밀번호입니다.";
		String str = "";
		// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); // throws MessagingException 예외처리
		
		// 메일 보관함에 회원이 보내온 메세지들의 정보를 모두 저장 후 작업 처리
		messageHelper.setTo(mail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);  
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송할 수 있도록한다.
		str += "<p><a href='http://localhost:9090/javaweb10S//'><img src=\"cid:eatLogo.png\" width='300px'></a></p>";
		str += "<br><hr><h2>임시 비밀번호는<font color='red'>"+content+"</font>입니다.<br>비밀번호 변경 후 로그인해주세요!</h2>";
		str += "<hr>";
		messageHelper.setText(str, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시해준다. 그 후 다시 보관함에 담아준다.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
	
		FileSystemResource file = new FileSystemResource(realPath + "eatLogo.png");
	
		messageHelper.addInline("eatLogo.png", file);
		
		// 메일 전송하기
		mailSender.send(message);
		
		return 1;
	}
	
	// 마이페이지 이동
	@RequestMapping(value="/memberMypage", method=RequestMethod.GET)
	public String memberMypageGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo",vo);
		
		if(!mid.equals(vo.getMid())) return "redirect:/message/memberMidNO";
		else return "/member/memberMypage";
	}
	
	// 프로필 사진 업로드 새창 이동
	@RequestMapping(value="/memberProfileUpload", method = RequestMethod.GET)
	public String memberProfileUploadGet() {
		return "/member/memberProfileUpload";
	}
	
	// 프로필 사진 업로드 처리
	@RequestMapping(value="/memberProfileUpload", method = RequestMethod.POST)
	public String memberProfileUploadPost(MultipartFile fName, Model model, HttpSession session) {
		System.out.println("fName: "+fName);
		String mid = (String) session.getAttribute("sMid");
		int res = 0;
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo",vo);
		
		if(fName != null) {
			if(mid.equals(vo.getMid())) {
				res = memberService.setMemberProfileInput(fName, mid);
				res = 1;
			}
			else {
				return "redirect:/message/memberProfileMidNo";
			}
		}
		else {
			res=1;
		}
		if(res == 1) return "redirect:/message/memberProfileUploadOk"; 
		else return "redirect:/message/memberProfileUploadNo";
	}
	
	// 회원정보 수정 폼 이동
	@RequestMapping(value="/memberUpdate", method=RequestMethod.GET)
	public String memberUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo",vo);
		
		return "/member/memberUpdate";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value="/memberUpdate", method=RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo, HttpSession session, Model model) {
		// vo의 아이디가 비었거나(로그인x) 입력한 아이디와 vo의 아이디가 맞지 않으면 memberMidCheckNo 메세지 출력!
		String mid = (String) session.getAttribute("sMid");
		if(memberService.getMemberIdCheck(vo.getMid()) != null && !mid.equals(vo.getMid())) return "redirect:/message/memberMidCheckNo";
		
		// 수정한 정보를 vo에 저장 후 잘되었으면 res=1을 주고 업데이트 성공 메세지 출력! 아니면 실패 메세지 출력!
		int res = memberService.setMemberUpdateOk(vo);
		model.addAttribute("vo",vo);
		
		if(res == 1) return "redirect:/message/memberUpdateOk";
		else return "redirect:/message/memberUpdateNo";
	}
	
	// 비밀번호 변경 전 현재 비밀번호 확인 폼 이동
	@RequestMapping(value = "/memberPwdUpdateCheck", method = RequestMethod.GET)
	public String memberPwdUpdateCheckGet() {
		return "member/memberPwdUpdateCheck";
	}
	
	// 현재 비밀번호 맞는지 확인 처리
	@RequestMapping(value = "/memberPwdUpdateCheck", method = RequestMethod.POST)
	public String memberPwdUpdateCheckPost(String pwd, String mid, Model model) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			model.addAttribute("vo",vo);
			return "member/memberPwdUpdate";
		}
		else return "redirect:/message/memberPwdCheckNo";
	}
	
	// 비밀번호 변경 처리
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdatePost(
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			@RequestParam(name="newPwd", defaultValue="", required=false) String pwd,
			HttpSession session) {
		
		pwd = passwordEncoder.encode(pwd);
		memberService.setMemberPwdUpdate(mid, pwd);
		
		if(session.getAttribute("sImsiPwd") != null) session.removeAttribute("sImsiPwd");
		
		return "redirect:/message/memberPwdUpdateOk";
	}
	
	// 회원탈퇴 페이지 이동
	@RequestMapping(value="/memberCancel", method=RequestMethod.GET)
	public String memberCancelGet() {
		return "/member/memberCancel";
	}
	
	// 회원탈퇴 이용약관 페이지 이동
	@RequestMapping(value="/memberCancelTerm", method=RequestMethod.GET)
	public String memberCancelTermGet() {
		return "/member/memberCancelTerm";
	}
	
	// 회원탈퇴 처리
	@ResponseBody
	@RequestMapping(value="/memberCancel", method=RequestMethod.POST)
	public String memberCancelPost(
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			HttpSession session, Model model) {
		String res = "";
		System.out.println("mid ! "+ mid);
		//MemberVO vo = memberService.getMemberIdCheck(mid);
		
			if(mid != null) {
				memberService.setUserDelCheck(mid);
				session.invalidate();
				return res = "1";
			}
			else return res = "0";
		}
	
	// 상품명 검색 처리
	@RequestMapping(value = "/itemSearch", method = RequestMethod.POST)
	public String searchPost(String searchString, Model model) {
		ArrayList<ProductVO> searchVOS = memberService.getItemSearch(searchString);
		model.addAttribute("searchVOS",searchVOS);
		model.addAttribute("searchString",searchString);
		
		return "member/searchResult";
	}
}	