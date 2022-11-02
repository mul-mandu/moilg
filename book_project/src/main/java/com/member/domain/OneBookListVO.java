package com.member.domain;

import lombok.Data;

@Data
public class OneBookListVO {
	// 북리스트 하나의 테이블
	
	private int list_no;
	private String isbn;
	private String bookTitle;
	private String author;
	private String bookCover;
	private int scrapCount;

}
