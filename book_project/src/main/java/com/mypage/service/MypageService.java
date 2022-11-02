package com.mypage.service;


import java.util.List;

import com.member.domain.BookListVO;
import com.member.domain.ScrapRDListVO;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;

public interface MypageService {

   //회원 북플리 갯수 가져오기
   public int bookPlistCount(String id);
   
   // 회원의 북플리 전체 가져오기
   public List<BookListVO> getMyBookPLlist(String id);
   
   //읽고 싶은 책 DB 추가하기
   public int addWantBook(WantBookVO want);
   
   // 읽고 싶은 책 해제
   public int cancelWantBook(WantBookVO want);
   
   //읽고 싶은 책 DB 리스트 가져오기 
   public List<WantBookVO> wantBookList(String id);
   
   
   //읽은 책 DB 추가하기
   public int addFinBook(FinBookVO finish);
   
   
   // 읽은 책 해제
   public int cancelFinRead(FinBookVO finish);
   
   
   //읽은 책 DB 리스트 가져오기 
   public List<FinBookVO> finBookList(String id);
   
   //읽은 책 갯수 가져오기
   public int readBookCount(String id);
   
   //찜한 리스트 가져오기
   public List<Integer> getMyscrapRDList(String id);
}