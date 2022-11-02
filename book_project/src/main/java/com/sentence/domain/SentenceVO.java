package com.sentence.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SentenceVO {

	private int great_no;
	private String id;
	private String greatContent;
	private String greatImg; // 파일명 -> DB
	private int greatLikeCount;
	private int greatContentStatus;
	private Date greatReg;
	private String nickName;

}
