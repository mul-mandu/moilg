package com.mypage.domain;

import lombok.Data;

@Data
public class WantBookVO {
	private int wantBook_no;
	private String id;
	private String isbn;
	private String bookTitle;
	private String author;
	private String bookCover;

}
