package com.mypage.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.domain.BookListVO;
import com.member.domain.ScrapRDListVO;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;
import com.mypage.persistence.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService{
   
   @Autowired
   private MypageMapper mapper;

   @Override
   public int bookPlistCount(String id) {

      return mapper.bookPlistCount(id); 
   }

   @Override
   public List<BookListVO> getMyBookPLlist(String id) {
      return mapper.getMyBookPLlist(id);
   }

   //읽고 싶은 책 DB 추가
   @Override
   public int addWantBook(WantBookVO want) {
      return mapper.addWantBookData(want);
   }
   
   
   // 읽고 싶은 책 해제
   @Override
   public int cancelWantBook(WantBookVO want) {
      return mapper.cancelWantBook(want);
   }

   
   //읽고 싶은 책 DB 리스트 가져오기 
   @Override
   public List<WantBookVO> wantBookList(String id) {
      return mapper.wantBookListSelect(id);
   }

   //읽은 책 DB 추가
   @Override
   public int addFinBook(FinBookVO finish) {
      return mapper.finishBookData(finish);
   }
   
   
   // 읽은 책 해제
   @Override
   public int cancelFinRead(FinBookVO finish) {
      return mapper.cancelFinRead(finish);
   }

   

   //읽은 책 DB리스트 가져오기 
   @Override
   public List<FinBookVO> finBookList(String id) {
      return mapper.finBookListSelect(id);
   }

   //읽은 책 갯수 가져오기
   @Override
   public int readBookCount(String id) {
      return mapper.getCountReadBook(id);
   }

   
   // 찜한 북플리 리스트 가져오기
   @Override
   public List<Integer> getMyscrapRDList(String id) {
      return mapper.getMyscrapRDList(id);
   }





   

}