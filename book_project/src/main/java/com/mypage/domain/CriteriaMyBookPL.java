package com.mypage.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CriteriaMyBookPL {   // 마이페이지 플레이 리스트 뿌려줄것들
	
	private int pageNum; 	// 페이지 번호
	private int listQty;	// 한페이지에 보여줄 게시물 개수 
	
	private String sel;		// 검색 조건 T, W, C, TW, TC, TWC
	private String keyword;	// 검색 키워드
	
	public CriteriaMyBookPL() {
		this(1, 8); // 페이지번호 1이고 10개씩 보여주겠다
	}
	
	public CriteriaMyBookPL(int pageNum, int listQty) {
		this.pageNum = pageNum; 
		this.listQty = listQty;
	}
	
	public String[] getSelArr() {
		return sel == null ? new String[] {} : sel.split("");
	}
	
	
	// URL 링크에 붙히는 쿼리 스트링 자동 생성해주는 메서드 
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("listQty", this.listQty)
				.queryParam("sel", this.sel)
				.queryParam("keyword", this.keyword);
		
		return builder.toUriString(); // ?pageNum=1&listQty=10
	}
	

}
