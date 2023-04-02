package com.sentence.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GreatCriteria {
	
	private int pageNum; 	// 페이지 번호
	private int listQty;	// 한 페이지에 보여줄 게시물 개수
	
	public GreatCriteria() {
		this(1, 9);	// 아무것도 넘어오지 않을때 페이지 번호 1이고 10개씩 보여주겠다.
	}

	public GreatCriteria(int pageNum, int listQty) {
		this.pageNum = pageNum;
		this.listQty = listQty;
	}
	

	// URL 링크에 붙히는 쿼리 스트링 자동 생성해주는 메서드 
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("listQty", this.listQty);
		
		return builder.toUriString(); // ?pageNum=1&listQty=10
	}
	
	
}
