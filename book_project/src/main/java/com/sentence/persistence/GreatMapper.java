package com.sentence.persistence;

import java.util.List;

import com.sentence.domain.SentenceVO;

public interface GreatMapper {
	
	//인생문장 추가
	public int addSenten(SentenceVO senvo);
	
	//모든인생문장 가져오기 
	public List<SentenceVO> getAllSenten(SentenceVO senvo);
	
   //아이디에 맞는 인생문장가져오기 
   public List<SentenceVO> getAllMemSen(String id);

}
