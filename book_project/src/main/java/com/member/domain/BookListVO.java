package com.member.domain;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
public class BookListVO {
	
	// 북리스트 VO
	
	private int list_no;
	private String bookPLTitle;
	private String id;
	private String mbti;
	private String packCover;
	private int listStatus;
	private int scrapCount;
	
}
