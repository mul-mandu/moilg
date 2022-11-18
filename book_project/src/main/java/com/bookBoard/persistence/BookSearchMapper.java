package com.bookBoard.persistence;

import com.bookBoard.domain.ReplyBoardVO;

public interface BookSearchMapper {

	//댓글 추가
	public int insertReply(ReplyBoardVO vo);
	
	
}
