package com.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.persistence.MainMapper;
import com.member.domain.BookListVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MainServiceImpl implements MainService{
   
   @Autowired
   private MainMapper mapper;
   
   @Override
   // 전체 북리스트 가져오기
   public List<BookListVO> getAllPL() {
      return mapper.getAllPL();
   }

   // 장르 전체 리스트 가져오기 
   @Override
   public List<Integer> getGenreAll() {
      return mapper.getAllGenreListNo();
   }
   
   // 분위기 전체 리스트 가져오기 
   @Override
   public List<Integer> getMoodAll() {
      return mapper.getAllMoodListNo();
   }
   
   // 상황 전체 리스트 가져오기 
   @Override
   public List<Integer> getSituAll() {
      return mapper.getAllSituListNo();
   }

   // 카운트 순으로 인기 북플리 가져오기
	@Override
	public List<BookListVO> getBestPL() {
		return mapper.getBestPL();
	}



}