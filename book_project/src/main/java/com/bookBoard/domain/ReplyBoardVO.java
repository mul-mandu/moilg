package com.bookBoard.domain;

import java.util.Date;

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
	

	
}
