package com.sentence.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sentence.domain.GreatCriteria;
import com.sentence.domain.SentenceVO;

public interface GreatMapper {


	//모든인생문장 가져오기 
	public List<SentenceVO> getAllSenten(@Param("pageNum")int pageNum, @Param("listQty")int listQty);
	
	// 모든 인생문장 메인에 뿌릴거(페이징 없음)
	public List<SentenceVO> getAllSentenceMain();
	
	// 문장 개수 가져오기
	public int getTotal(GreatCriteria cri);
		
	// 인생문장 추천순으로 가져오기
	public List<SentenceVO> getTopSentence();

	//아이디에 맞는 인생문장가져오기 
	public List<SentenceVO> getAllMemSen(String id);

	// 회원의 찜한 인생문장 가져오기
	public List<SentenceVO> getMemLikeSentence(String id);

	// 인생문장 번호주고 인생문장 가져오기
	public SentenceVO getOneGreat(int great_no);

	//인생문장 추가
	public int addSenten(SentenceVO senvo);

	// 인생문장 수정처리
	public int modifyGreat(SentenceVO sen);

	// 인생문장 삭제 처리 (상태값 -1로 변경)
	public int deleteGreat(int great_no);

	// 인생문장 테이블에서 count +1
	public int greatAddCount(int great_no);

	// 인생문장 테이블에서 count -1
	public int greatMinusCount(int great_no);

	// 인생문장 좋아요 요청 (좋아요 테이블에 추가)
	public int likeGreat(@Param("great_no")int great_no, @Param("id")String id);

	// 인생문장 좋아요 취소 (좋아요 테이블에 삭제)
	public int likeCancleGreat(@Param("great_no")int great_no, @Param("id")String id);


	// 문장 카운트 가져오기
	public int getCount(int great_no);

	// 회원의 인생문장 좋아요한 리스트 번호
	public List<Integer> getGreatListNum(String id);

}
