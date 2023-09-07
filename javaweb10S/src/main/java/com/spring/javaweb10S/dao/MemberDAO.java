package com.spring.javaweb10S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.ProductVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public void setTodayCntReset(@Param("mid") String mid);

	public void setMemberVisitUpdate(@Param("vo") MemberVO vo);

	public void setMemberVisitPointUpdate(@Param("vo") MemberVO vo);

	public void setInputMember(@Param("vo") MemberVO vo);

	public void setMemberJoinOk(@Param("vo") MemberVO vo);

	public String getMemberFindMid(@Param("name") String name, @Param("email") String email);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setMemberProfileInput(@Param("photo") String photo, @Param("mid") String mid);

	public int setMemberUpdateOk(@Param("vo") MemberVO vo);

	public void setUserDelCheck(@Param("mid") String mid);

	public ArrayList<ProductVO> getItemSearch(@Param("searchString") String searchString);

	public MemberVO getMemberEmailCheck(@Param("email") String email);

	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("email") String email);

	public void setMemberUserDelCheck(@Param("mid") String mid);




}
