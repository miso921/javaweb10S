package com.spring.javaweb10S.service;

import java.util.List;

import com.spring.javaweb10S.vo.InquiryReplyVO;
import com.spring.javaweb10S.vo.InquiryVO;

public interface InquiryService {

	public List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid);

	public void imgCheck(String content);

	public int setInquiryInput(InquiryVO vo);

	public InquiryVO getInquiryView(int idx);

	public InquiryReplyVO getInquiryReply(int idx);

	public void imgDelete(String content);

	public int setInquiryUpdate(InquiryVO vo);

	public int setInquiryDelete(int idx);




}
