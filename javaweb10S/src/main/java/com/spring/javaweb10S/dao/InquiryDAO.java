package com.spring.javaweb10S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb10S.vo.InquiryReplyVO;
import com.spring.javaweb10S.vo.InquiryVO;

public interface InquiryDAO {

	public List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("mid") String mid);

	public int totRecCnt(@Param("part") String part, @Param("searchString") String searchString);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public int setInquiryInput(@Param("vo") InquiryVO vo);

	public InquiryVO getInquiryView(@Param("idx") int idx);

	public InquiryReplyVO getInquiryReply(@Param("idx") int idx);

	public int setInquiryUpdate(@Param("vo") InquiryVO vo);

	public int setInquiryDelete(@Param("idx") int idx);


}
