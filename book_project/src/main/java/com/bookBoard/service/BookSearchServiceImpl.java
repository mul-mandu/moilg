package com.bookBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.persistence.BookSearchMapper;

@Service
public class BookSearchServiceImpl implements BookSearchService{
	
	@Autowired BookSearchMapper mapper;

	//댓글 추가
	@Override
	public int addReply(ReplyBoardVO vo) {
		return mapper.insertReply(vo);
	}

	@Override
	public List<ReplyBoardVO> getReply(String isbn) {
		return mapper.getReplyList(isbn); 
	}
	
	
	
	
}
