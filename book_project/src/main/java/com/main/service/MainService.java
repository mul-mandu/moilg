package com.main.service;

import java.util.List;

import com.member.domain.BookListVO;

public interface MainService {

   // 전체 북플레이 리스트 가져오기
   public List<BookListVO> getAllPL();
   
   // 장르 전체 리스트넘버 가져오기 
   public List<Integer> getGenreAll();
   
   // 무드 전체 리스트넘버 가져오기 
   public List<Integer> getMoodAll();
   
   // 상황 전체 리스트넘버 가져오기 
   public List<Integer> getSituAll();
   

   
}