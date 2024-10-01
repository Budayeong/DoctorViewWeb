package com.edu.springboot.member;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String password;
	private String name;
	private String nickname;
	private String tel;
	private String address;
	private String rrn;
	private int point;
	private String emoji;
	private String taxid;
	private String department;
	private int visitcount;
	private int enable;
	private String auth;
	private String email;
//	private String approve;
	private String attend;
	
}