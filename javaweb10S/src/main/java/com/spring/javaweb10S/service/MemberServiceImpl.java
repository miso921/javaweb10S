package com.spring.javaweb10S.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb10S.common.JavawebProvide;
import com.spring.javaweb10S.dao.MemberDAO;
import com.spring.javaweb10S.vo.MemberVO;
import com.spring.javaweb10S.vo.ProductVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public void setTodayCntReset(String mid) {
		memberDAO.setTodayCntReset(mid);
	}

	@Override
	public void setMemberVisitUpdate(MemberVO vo) {
		memberDAO.setMemberVisitUpdate(vo);
	}

	@Override
	public void setMemberVisitPointUpdate(MemberVO vo) {
		memberDAO.setMemberVisitPointUpdate(vo);
	}

	@Override
	public void setMemberJoinOk(MemberVO vo) {
		memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public String getMemberFindMid(String name, String email) {
		return memberDAO.getMemberFindMid(name, email);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	
  @Override 
  public int setMemberProfileInput(MultipartFile fName, String mid) {
  	int res = 0;
		String photo="";
		try {
			String oFileName = fName.getOriginalFilename(); //파일의 이름 가져오기
			
			if(oFileName.equals("")) {
				photo = "noimage.jpg";
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "member");
				
				photo = saveFileName;
			}
			memberDAO.setMemberProfileInput(photo,mid);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int setMemberUpdateOk(MemberVO vo) {
		return memberDAO.setMemberUpdateOk(vo);
	}

	@Override
	public void setUserDelCheck(String mid) {
		memberDAO.setUserDelCheck(mid);
	}

	@Override
	public ArrayList<ProductVO> getItemSearch(String searchString) {
		return memberDAO.getItemSearch(searchString);
	}

	@Override
	public MemberVO getMemberEmailCheck(String email) {
		return memberDAO.getMemberEmailCheck(email);
	}

	@Override
	public void setKakaoMemberInputOk(String mid, String pwd, String email) {
		memberDAO.setKakaoMemberInputOk(mid, pwd, email);
	}

	@Override
	public void setMemberUserDelCheck(String mid) {
		memberDAO.setMemberUserDelCheck(mid);
	}

}	
