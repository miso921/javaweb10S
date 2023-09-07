package com.spring.javaweb10S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String name;
	private String mid;
	private String pwd;
	private String email;
	private String address;
	private String tel;
	private String birthday;
	private String gender;
	private String userDel;
	private int level;
	private int point;
	private int todayCnt;
	private String startDate;
	private String lastDate;
	private String photo;

	private String part;
	// private int startMemberCnt;
	private String date_list;
	private String visitCount;
}
