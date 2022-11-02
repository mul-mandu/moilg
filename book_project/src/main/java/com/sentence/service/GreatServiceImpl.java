package com.sentence.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sentence.domain.SentenceVO;
import com.sentence.persistence.GreatMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GreatServiceImpl implements GreatService{

	@Autowired
	private GreatMapper mapper;
	
	//인생 문장 등록하기
	@Override
	public int addSentence(SentenceVO sentence) {
		log.info("******************************** addSentence 처리중~~~");
		
		return mapper.addSenten(sentence);
	}

	//모든 문장 가져오기 
	@Override
	public List<SentenceVO> getAllSentence(SentenceVO sentence) {
		log.info("******************************** getAllSentence 처리중~~~");
		
		return mapper.getAllSenten(sentence);
	}
	
   //id에 맞는 문장 가져오기
   @Override
   public List<SentenceVO> getMemAllSentence(String id) {
      return mapper.getAllMemSen(id);
   }

	
	
}
