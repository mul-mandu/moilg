package com.bookBoard.domain;

import java.util.Date;
import java.util.List;

import com.member.domain.MemberVO;

import lombok.Data;

@Data
public class ReplyBoardVO {

	private int re_no;
	private String id;
	private String isbn;
	private String reTitle;
	private String reContent;
	private int goodCount;
	private Date reReg;
	private List<MemberVO> memberInfo;  // 멤버 정보 가져올때 사용할것
	
}
