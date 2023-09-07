package com.spring.javaweb10S.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.ProductVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public void setTodayCntReset(String mid);

	public void setMemberVisitUpdate(MemberVO vo);

	public void setMemberVisitPointUpdate(MemberVO vo);

	public void setMemberJoinOk(MemberVO vo);

	public String getMemberFindMid(String name, String email);

	public void setMemberPwdUpdate(String mid, String pwd);

	public int setMemberProfileInput(MultipartFile fName, String mid);

	public int setMemberUpdateOk(MemberVO vo);

	public void setUserDelCheck(String mid);

	public ArrayList<ProductVO> getItemSearch(String searchString);

	public MemberVO getMemberEmailCheck(String email);

	public void setKakaoMemberInputOk(String mid, String pwd, String email);

	public void setMemberUserDelCheck(String mid);

}
