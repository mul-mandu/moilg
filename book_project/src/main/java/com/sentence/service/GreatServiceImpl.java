package com.sentence.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sentence.domain.GreatCriteria;
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

	//모든 문장 가져오기 (페이징)
	@Override
	public List<SentenceVO> getAllSentence(GreatCriteria cri) {
		log.info("******************************** getAllSentence 처리중~~~");
		return mapper.getAllSenten(cri.getPageNum(), cri.getListQty());
	}
	
	// 모든 문장 가져오기(페이징 없음)
	@Override
	public List<SentenceVO> getAllSentenceMain() {
		return mapper.getAllSentenceMain();
	}
	
	
	// 총 문장 갯수 가져오기
	@Override
	public int getTotal(GreatCriteria cri) {
		return mapper.getTotal(cri);
	}
	
	
   //id에 맞는 문장 가져오기
   @Override
   public List<SentenceVO> getMemAllSentence(String id) {
      return mapper.getAllMemSen(id);
   }

   
   // 회원이 찜한 인생문장 가져오기
	@Override
	public List<SentenceVO> getMemLikeSentence(String id) {
		return mapper.getMemLikeSentence(id);
	}

	
   
   // 인생문장 번호주고 인생문장 가져오기
	@Override
	public SentenceVO getOneGreat(int great_no) {
		return mapper.getOneGreat(great_no);
	}

	// 인생문장 수정처리
	@Override
	public int modifyGreat(SentenceVO sen) {
		return mapper.modifyGreat(sen);
	}

	// 인생문장 삭제처리 (상태값 -1로 변경)
	@Override
	public int deleteGreat(int great_no) {
		return mapper.deleteGreat(great_no);
	}

	// 인생문장 테이블에서 count +1
	@Override
	public int greatAddCount(int great_no) {
		return mapper.greatAddCount(great_no);
	}
	
	// 인생문장 테이블에서 count-1
	@Override
	public int greatMinusCount(int great_no) {
		return mapper.greatMinusCount(great_no);
	}
	
	
	// 인생문장 좋아요 요청 (좋아요 테이블에 추가)
	@Override
	public int likeGreat(int great_no, String id) {
		return mapper.likeGreat(great_no, id);
	}
	
	// 인생문장 좋아요 취소 (좋아요 테이블에 삭제)
	@Override
	public int likeCancleGreat(int great_no, String id) {
		return mapper.likeCancleGreat(great_no, id);
	}
	

	// 문장 카운트 가져오기
	@Override
	public int getCount(int great_no) {
		return mapper.getCount(great_no);
	}

	
	// 인생문장 추천순으로 가져오기
	@Override
	public List<SentenceVO> getTopSentence() {
		return mapper.getTopSentence();
	}

   // 회원의 인생문장 좋아요한 리스트 번호
	@Override
	public List<Integer> getGreatListNum(String id) {
		return mapper.getGreatListNum(id);
	}











	
	
}
