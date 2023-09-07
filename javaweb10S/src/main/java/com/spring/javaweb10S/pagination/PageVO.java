package com.spring.javaweb10S.pagination;

import lombok.Data;

@Data
public class PageVO {
	private int pag;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int curBlock;
	private int blockSize;
	private int lastBlock;

	private String section;
	private String search;
	private String searchString;
}
