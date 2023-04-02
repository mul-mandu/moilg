package com.bookBoard.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO { //페이지 번호등 페이징 처리시 필요한 정보 담는 클래스

	private int startPage;
	private int endPage;
	private boolean prev, next; //페이지 번호 앞으로 가기, 뒤로가기 활성화 실킬지 여부를 담고 있을 변수
	private int total; // 전체 글의 개수
	private BookCriteria cri; //페이지번호 pageNum, 페이지당 보여줄 글의 개수 listQty
	
	public PageDTO(BookCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//한페이지에 페이지번호 10개 띄우는 기준으로 계산
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		//나와야하는 제일 마지막 페이지 번호 : realEnd 설정
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getListQty()));
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
	
	
	
	
}
