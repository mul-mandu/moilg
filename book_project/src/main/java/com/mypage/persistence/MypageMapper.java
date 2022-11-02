package com.mypage.persistence;



import java.util.List;

import com.member.domain.BookListVO;
import com.member.domain.ScrapRDListVO;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;


public interface MypageMapper {

   //북플리 개수
   public int bookPlistCount(String id);
   
   // 회원의 전체 북플리 가져오기
   public List<BookListVO> getMyBookPLlist(String id);
   
   //읽고 싶은 책 DB에 넣기 
   public int addWantBookData(WantBookVO want);
   
   // 읽고 싶은 책 해제하기
   public int cancelWantBook(WantBookVO want);
   
   //읽고 싶은 책 DB 리스트 가져오기
   public List<WantBookVO> wantBookListSelect(String id);
   
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
}