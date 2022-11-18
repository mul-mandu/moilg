package com.bookBoard.persistence;

import java.util.List;

import com.bookBoard.domain.ReplyBoardVO;

public interface BookSearchMapper {

	//댓글 추가
	public int insertReply(ReplyBoardVO vo);
	
	//댓글 목록 가져오기(페이징 x)
	public List<ReplyBoardVO> getReplyList(String isbn);
	
	
}
