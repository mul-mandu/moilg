package com.bookBoard.service;

import java.util.List;

import com.bookBoard.domain.BookCriteria;
import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.domain.ReplyLikeVO;
import com.member.domain.BookListVO;

public interface BookSearchService {

	//댓글 추가하기
	public int addReply(ReplyBoardVO vo);
	
	//댓글 목록 조회 (페이징 처리 X)
	public List<ReplyBoardVO> getReply(String isbn);
	
	//댓글 수 카운트
	public int getReTot(String isbn);
	
	//댓글 삭제하기
	public int delReply(Integer renum);
	
	//댓글 수정하기
	public int modiReply(ReplyBoardVO vo);
	
	//re_no주고 좋아요한 id 리스트 가져오기
	public List<String> getLikeId(int renum);
	
	//댓글 공감하기(추가)
	public int likeAddReply(ReplyLikeVO vo);
	
	//공감한 댓글에 goodCount +1
	public int modifyGoodCount(int renum);
	
	//공감 댓글 삭제하기 
	public int delLikeReply(String id);
	
	//공감 댓글 삭제 후 goodCount -1 
	public int delGoodCount(int renum);
	
	
	//작성한 댓글 리스트 가져오기
	public List<ReplyBoardVO> getMyReply(String id);
	   
	//공감한 댓글 리스트의 re_no 가져오기
	public List<Integer> getLikeNum(String id);
	
	//공감한 re_no의 댓글 
	public List<ReplyBoardVO> getLikeList(Integer renum);
	
	// 선택한 키워드가 포함된 북플리 list 가져오기
	public List<BookListVO> getKeyPLlist(int keyword_no);
	
	// 검색한 북플리 가져오기 list
	public List<BookListVO> getSearchBPLlist(String search);
	
}
