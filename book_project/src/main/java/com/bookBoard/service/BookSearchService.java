package com.bookBoard.service;

import java.util.List;

import com.bookBoard.domain.ReplyBoardVO;

public interface BookSearchService {

	//댓글 추가하기
	public int addReply(ReplyBoardVO vo);
	
	//댓글 목록 조회 (페이징 처리 X)
	public List<ReplyBoardVO> getReply(String isbn);
	
	
}
