package com.bookBoard.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookCriteria {//게시판 사용시 부수적으로 필요한 데이터들 묶음


		private int pageNum; //	페이지 번호
		private int listQty; // 한페이지에 보여줄 게시물 개수 
		

		public BookCriteria() {
			this(1, 5); //아무것도 넘어오지 않을때 페이지 번호 1이고 10개씩 보여주겠다 
		};
		
		
		public BookCriteria(int pageNum, int listQty) {
			this.pageNum = pageNum;
			this.listQty = listQty;
			
		};
		
		
		

	
	
	
}
