package com.mypage.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookBoard.domain.ReplyBoardVO;
import com.member.domain.BookListVO;
import com.member.domain.ScrapRDListVO;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;
import com.mypage.persistence.MypageMapper;
import com.sentence.domain.SentenceVO;

@Service
public class MypageServiceImpl implements MypageService{
   
   @Autowired
   private MypageMapper mapper;

   // 회원의 북플리 개수 가져오기
   @Override
   public int bookPlistCount(String id) {

      return mapper.bookPlistCount(id); 
   }

   // 회원의 북플리 가져오기
   @Override
   public List<BookListVO> getMyBookPLlist(String id) {
      return mapper.getMyBookPLlist(id);
   }
   
	
	//회원이 생성한 북플리 페이징처리해서 가져오기
	@Override
	public List<BookListVO> getMyBookPLlistPaging(String id, int num) {
		return mapper.getMyBookPLlistPaging(id, num);
	}

	
	// 회원이 찜한 북플리 개수 가져오기
	@Override
	public int scrapPLCount(String id) {
		return mapper.scrapPLCount(id);
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

   //공감한 댓글 마이페이지에서 삭제 처리
	@Override
	public int delLikeReplyInMypage(String id, int renum) {
		return mapper.deleteLikeReplyInMypage(id, renum);
	}
	
	// 회원이 찜한 북플리 페이징해서 가져오기
	@Override
	public List<BookListVO> getMemScrapPLPaging(String id, int num) {
		return mapper.getMemScrapPLPaging(id, num);
	}
	

	// 읽고 싶은 책 개수 가져오기
	@Override
	public int wantBookCount(String id) {
		return mapper.wantBookCount(id);
	}

	
	// 읽고 싶은 책리스트 페이징 처리해서 가져오기
	@Override
	public List<WantBookVO> getWantBooksPaging(String id, int num) {
		return mapper.getWantBooksPaging(id, num);
	}

	
	// 읽은 책 페이징해서 가져오기
	@Override
	public List<FinBookVO> readBooksPaging(String id, int num) {
		return mapper.readBooksPaging(id, num);
	}

	// 회원의 인생문장 개수 가져오기
	@Override
	public int mySentenceCount(String id) {
		return mapper.mySentenceCount(id);
	}

	// 회원의 인생문장 페이징 처리해서 가져오기
	@Override
	public List<SentenceVO> mySentencesPaging(String id, int num) {
		return mapper.mySentencesPaging(id, num);
	}

	
	// 회원의 좋아요한 인생문장 개수 가져오기
	@Override
	public int myLikeSentenceCount(String id) {
		return mapper.myLikeSentenceCount(id);
	}

	// 회원의 좋아요한 인생문장 페이징 처리해서 가져오기 
	@Override
	public List<SentenceVO> myLikeSentencePaging(String id, int num) {
		return mapper.myLikeSentencePaging(id, num);
	}

	// 회원의 댓글 수 가져오기
	@Override
	public int myReplyCount(String id) {
		return mapper.myReplyCount(id);
	}

	// 회원이 작성한 댓글 페이징해서 가져오기
	@Override
	public List<ReplyBoardVO> getMyReplyPaging(String id, int num) {
		return mapper.getMyReplyPaging(id, num);
	}
	

	// 회원이 좋아요한 댓글 수 가져오기
	@Override
	public int myLikeReplyCount(String id) {
		return mapper.myLikeReplyCount(id);
	}

	// 회원이 좋아요한 댓글 페이징해서 가져오기
	@Override
	public List<ReplyBoardVO> getLikeReplyPaging(String id, int num) {
		return mapper.getLikeReplyPaging(id, num);
	}









   

}