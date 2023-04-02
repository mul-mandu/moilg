package com.mypage.persistence;



import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bookBoard.domain.ReplyBoardVO;
import com.member.domain.BookListVO;
import com.member.domain.ScrapRDListVO;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;
import com.sentence.domain.SentenceVO;


public interface MypageMapper {

   //북플리 개수
   public int bookPlistCount(String id);
   
   // 회원이 찜한 북플리 갯수 가져오기
   public int scrapPLCount(String id);
   
   // 회원의 전체 북플리 가져오기
   public List<BookListVO> getMyBookPLlist(String id);
   
   //읽고 싶은 책 DB에 넣기 
   public int addWantBookData(WantBookVO want);
   
   // 읽고 싶은 책 해제하기
   public int cancelWantBook(WantBookVO want);
   
   //읽고 싶은 책 DB 리스트 가져오기
   public List<WantBookVO> wantBookListSelect(String id);
   
   // 읽고 싶은 책 개수 가져오기
   public int wantBookCount (String id);
   
   //읽은 책 DB에 넣기 
   public int finishBookData(FinBookVO finish);
   
   // 읽은 책 등록 취소
   public int cancelFinRead(FinBookVO finish);
   
   //읽은 책 DB 리스트 가져오기
   public List<FinBookVO> finBookListSelect(String id);
   
   //읽은 책 갯수 가져오기
   public int getCountReadBook(String id);
   
   //찜한 리스트 뿌리기
   public List<Integer> getMyscrapRDList(String id);
   
   //공감한 댓글 마이페이지에서 삭제 처리
   public int deleteLikeReplyInMypage(@Param("id")String id, @Param("re_no") int renum);
   
   // 회원이 생성한 북플리 페이징처리해서 가져오기
   public List<BookListVO> getMyBookPLlistPaging(@Param("id")String id, @Param("num") int num);
   
   
   // 회원의 찜한 북플리 페이징처리해서 가져오기
   public List<BookListVO> getMemScrapPLPaging(@Param("id")String id,@Param("num") int num);
   
   // 회원의 읽고 싶은 책 목록 페이징처리해서 가져오기
   public List<WantBookVO> getWantBooksPaging(@Param("id")String id, @Param("num")int num);
   
   //회원이 읽은 책 페이징처리해서 가져오기
   public List<FinBookVO> readBooksPaging(@Param("id")String id, @Param("num")int num);
   
   // 회원의 인생문장 개수 가져오기
   public int mySentenceCount(String id);
   
   // 회원의 인생문장 페이징해서 가져오기
   public List<SentenceVO> mySentencesPaging(@Param("id")String id, @Param("num")int num);
   
   // 회원의 좋아요한 인생문장 개수 가져오기
   public int myLikeSentenceCount(String id);
   
   // 회원의 좋아요한 인생문장 페이징해서 가져오기
   public List<SentenceVO> myLikeSentencePaging(@Param("id")String id, @Param("num")int num);
   
   // 회원의 댓글 수 가져오기
   public int myReplyCount(String id);
   
   // 회원이 작성한 댓글 페이징해서 가져오기
   public List<ReplyBoardVO> getMyReplyPaging(@Param("id")String id, @Param("num")int num);
   
   // 회원이 좋아요한 댓글 수 가져오기
   public int myLikeReplyCount(String id);
   
   // 회원이 좋아요한 댓글 페이징해서 가져오기
   public List<ReplyBoardVO> getLikeReplyPaging(@Param("id")String id, @Param("num")int num);
   
}