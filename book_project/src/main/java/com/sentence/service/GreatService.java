package com.sentence.service;

import java.util.List;

import com.sentence.domain.SentenceVO;

public interface GreatService {

	//인생문장 저장
	public int addSentence(SentenceVO sentence);
	
	//모든 인생문장 가져오기
	public List<SentenceVO> getAllSentence(SentenceVO sentence);
	
	
   //아이디에 맞는 인생문장 가져오기
   public List<SentenceVO> getMemAllSentence(String id);
}
