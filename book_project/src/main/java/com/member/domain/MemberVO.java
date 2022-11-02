package com.member.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import lombok.Data;

@Data
public class MemberVO {
	
	private String id;
	private String pw;
	private String name;
	private String nickName;
	private String email;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	//@Nullable
	private Date birth;
	private String gender;
	private String photo;
	private String bgImg;
	private String mbti;
	private int memStatus;
	private List<AuthVO> authList;  // 권한 (여러개) 저장가능한 변수
}
