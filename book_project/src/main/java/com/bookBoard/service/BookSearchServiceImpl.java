package com.bookBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookBoard.domain.BookCriteria;
import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.domain.ReplyLikeVO;
import com.bookBoard.persistence.BookSearchMapper;
import com.member.domain.BookListVO;

@Service
public class BookSearchServiceImpl implements BookSearchService{
	
	@Autowired BookSearchMapper mapper;

	//댓글 추가
	@Override
	public int addReply(ReplyBoardVO vo) {
		return mapper.insertReply(vo);
	}
	
	//댓글 전체 목록 가져오기
	@Override
	public List<ReplyBoardVO> getReply(String isbn) {
		return mapper.getReplyList(isbn); 
	}

	//댓글 수 카운트
	@Override
	public int getReTot(String isbn) {
		return mapper.selReTotCount(isbn);
	}
	
	//댓글 삭제
	@Override
	public int delReply(Integer renum) {
		return mapper.deleteReply(renum);
	}

	//댓글 수정
	@Override
	public int modiReply(ReplyBoardVO vo) {
		return mapper.updateReply(vo);
	}

	//re_no주고 좋아요한 ID 받아오기
	@Override
	public List<String> getLikeId(int renum) {
		return mapper.selLikeId(renum);
	}
	
	//댓글 공감하기(추가)
	@Override
	public int likeAddReply(ReplyLikeVO vo) {
		return mapper.likeInsertReply(vo);
	}

	//공감한 댓글에 goodCount +1
	@Override
	public int modifyGoodCount(int renum) {
		return mapper.updateGoodCount(renum);
	}
	
	//공감한 댓글 삭제하기
	@Override
	public int delLikeReply(String id) {
		return mapper.deleteLikeReply(id);
	}
	
	//공감한 댓글 삭제후 goodCount -1
	@Override
	public int delGoodCount(int renum) {
		return mapper.deleteGoodCount(renum);
	}

	//내가 작성한 댓글 가져오기
	@Override
	public List<ReplyBoardVO> getMyReply(String id) {
		return mapper.selMyReply(id);
	}

	//내가 공감한 댓글의 re_no 가져오기
	@Override
	public List<Integer> getLikeNum(String id) {
		return mapper.selLikeNum(id);
	}
	
	//공감한 re_no의 댓글 
	@Override
	public List<ReplyBoardVO> getLikeList(Integer renum) {
		return mapper.selLikeList(renum);
	}

	
	// 선택한 키워드가 포함된 북플리 list 가져오기
	@Override
	public List<BookListVO> getKeyPLlist(int keyword_no) {
		return mapper.getKeyPLlist(keyword_no);
	}

	// 검색한 북플리 가져오기 list
	@Override
	public List<BookListVO> getSearchBPLlist(String search) {
		return mapper.getSearchBPLlist(search);
	}

	
	







	
	
	
	
}
