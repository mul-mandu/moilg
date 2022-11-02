package com.main.persistence;

import java.util.List;

import com.member.domain.BookListVO;

public interface MainMapper {
   
   //전체 플레이 리스트 가져오기
   public List<BookListVO> getAllPL();

   //장르 플레이 리스트 넘버 가져오기 (전체)
   public List<Integer> getAllGenreListNo();
   
   //무드 플레이 리스트 넘버 가져오기 (전체)
   public List<Integer> getAllMoodListNo();
   
   //상황 플레이 리스트 넘버 가져오기 (전체)
   public List<Integer> getAllSituListNo();
   

}