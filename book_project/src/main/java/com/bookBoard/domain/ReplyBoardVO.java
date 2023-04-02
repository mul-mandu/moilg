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
	private int reStatus;
	private int goodCount;
	private Date reReg;
	private String nickName;  // 멤버 정보 가져올때 사용할것
	private String photo;  // 멤버 정보 가져올때 사용할것
	private String bookTitle;//마이페이지 댓글 정보 가져올 때 사용할것
	private String bookCover; // 마이페이지에 댓글 정보 가져올 때 사용할 것
}
