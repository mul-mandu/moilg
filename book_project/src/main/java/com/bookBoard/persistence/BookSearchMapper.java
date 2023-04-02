package com.bookBoard.persistence;

import java.util.List;

import com.bookBoard.domain.BookCriteria;
import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.domain.ReplyLikeVO;
import com.member.domain.BookListVO;

public interface BookSearchMapper {

	//댓글 추가
	public int insertReply(ReplyBoardVO vo);
	
	//댓글 목록 가져오기(페이징)
	public List<ReplyBoardVO> getReplyList(String isbn);
	
	//댓글 수 카운트
	public int selReTotCount(String isbn);
	
	//댓글 삭제
	public int deleteReply(Integer renum);
	
	//댓글 수정
	public int updateReply(ReplyBoardVO vo);
	
	//re_no주고 좋아요한 ID 받아오기
	public List<String> selLikeId(int renum);
	
	//댓글 공감 (추가하기)
	public int likeInsertReply(ReplyLikeVO vo);
	
	//공감한 댓글에 goodCount 수정
	public int updateGoodCount(int renum);
	
	//공감한 댓글 삭제
	public int deleteLikeReply(String id);
	
	//공감한 댓글 삭제 후 goodCount -1
	public int deleteGoodCount(int renum);
	
	//작성한 댓글 리스트 가져오기
	public List<ReplyBoardVO> selMyReply(String id);
	
	//공감한 댓글 리스트 re_no 가져오기
	public List<Integer> selLikeNum(String id);
	
	//공감한 re_no의 댓글 
	public List<ReplyBoardVO> selLikeList(Integer renum);
	
	
	// 선택한 키워드가 포함된 북플리 list 가져오기
	public List<BookListVO> getKeyPLlist(int keyword_no);
	
	// 검색한 북플리 가져오기 list
	public List<BookListVO> getSearchBPLlist(String search);
	
}
