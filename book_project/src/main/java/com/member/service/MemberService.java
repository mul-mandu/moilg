package com.member.service;

import java.util.List;

import com.bookBoard.domain.keywordVO;
import com.member.domain.BookListVO;
import com.member.domain.BookPLKeyword;
import com.member.domain.MemberInterVO;
import com.member.domain.MemberVO;
import com.member.domain.OneBookListVO;
import com.member.domain.ScrapRDListVO;

public interface MemberService {

   //회원 가입 ( 추가)
   public int addMember(MemberVO member);
   
   //권한 추가
   public int addAuth(String auth, String id);
   
   //회원 정보 가져오기 
   public MemberVO getMember(String id);
   
   //회원 관심사 정보 담기
   //public MemberInterVO addInter(String id); 
   
   //회원 관심사 정보 담기
   public int addInter(int internum, String id); 
   
   
   //가입후 로그인처리 
   public void autoLogin(String username);
   
   
   //회원 mbti 정보 update 처리하기
   public int updateMbti(MemberVO member);
   
   //회원 프로필 update 
   public int modifyMyProfile(MemberVO member);
   
   //회원 마이페이지 BG이미지 update
   public int modifyMyBgImg(MemberVO member);
   
   
   //mbti에 해당하는 회원 id 가져오기
   public List<String> selectMbtiMem(String mbti);

   //해당 mbti에 맞는 회원의 공개 북플리가져오기
   public List<BookListVO> getMyBookPLOpenlist(String id);

   //내 키워드 가져오기 
   public List<Integer> getMyInterList(String id);
   
   
   
   //키워드 넘버 주고 북플리 list no 가져오기
   public List<Integer> getListNoList(int keynum);
   
   //키워드 넘버 주고 북플리List 가져오기 (장르)
   public List<BookListVO> getGBookList(List<Integer> list);
   
   
   // 아이디 찾기
   public String findId(MemberVO vo);
   
   // 비밀번호 찾기
   public String findPw(MemberVO vo);
   
   // 아이디 중복확인
   public int idCheck(MemberVO vo);
   
   // 비밀번호 맞나 확인
   public int pwCheck(MemberVO vo);
   
   // 닉네임 중복확인
   public int nickNameCheck(MemberVO vo);
   
   // 회원정보 수정 요청
   public int memberModify(MemberVO vo);
   
   // 회원정보 수정 요청(비밀번호만)
   public int memberPwModify(MemberVO vo);
   
   // 회원 탈퇴 요청
   public int deleteMember(String id);
   
   // 탈퇴 회원 권한 변경
   public int updateDelMemAuth(String id);
   
   //모든 회원 정보 가져오기 
   public List<MemberVO> getAllMember();
   
   //회원 권한 가져오기
   public String getMemAuth(String id);
   

   ///////////////////////////////////////////////////////////////////////////////
   
   
   
   // 북리스트 추가
   public int addBookList(BookListVO vo);
   
   // 북리스트 패키지추가
   public int addBookListPackage(BookListVO vo);  
   
   //북리스트 패키지 수정 
   public int modifyBookListPackage(BookListVO vo);
   
   // list_no_seq 마지막 인덱스 값 가져오기
   public int findLastSeq();
   
   // 플레이 리스트 요소 추가 
   public int addOneBookList(OneBookListVO vo);
   
   //플레이 리스트에 키워드 추가
   public int addPLKeyWord(int keyword_no);
   
   
   // 하나의 북리스트 가져오기
   public BookListVO getOneBookList(int list_no);
   
   // 하나의 북리스트에 포함되어있는 책들 가져오기
   public List<OneBookListVO> getPLBooksList(int list_no);
   
   // 하나의 북리스트에 포함되어 있는 키워드 가져오기
   public List<Integer> getPLKeyword(int list_no);
   
   // 키워드 no 에 해당하는 VO가져오기
   public keywordVO getKeywordVOList(int keynum);
   
   // 북리스트 수정
   public int modifyBookList(BookListVO vo);
   
   // 북리스트 책 목록 삭제
   public int deleteOneBookList(int listNum);
   
   // 북리스트 책 목록 수정
   public int ModifyOneBookList(OneBookListVO vo);
   
   // 북리스트 키워드 삭제
   public int deleteKeywordList(int listNum);
   
   // 북리스트 키워드 수정
   public int modifyPLKeyWord(BookPLKeyword vo);
   
   
   // 북리스트 삭제
   public int deleteBookList (int listNum);
   
   
   // 북리스트 찜하기
   public int addScrapRDList(ScrapRDListVO vo);
   
   // 북리스트 찜하기 해제
   public int cancelScrapRDList(ScrapRDListVO vo);
   
   // 북플레이 리스트에 책 추가하기
   public int addSavePlBooks(OneBookListVO vo);
   
   
   // 모달에서 새 북플리 생성
   public int newBookList(BookListVO vo); 
   
   // 이 책이 해당된 플레이리스트들 가져오기
   public List<Integer> getIncludBook(String isbn);
   
   // 관리자의 활성화 플리  가져오기
   public List<BookListVO> getPLNumList(String id);
   
   // mbti에 해당하는 플리 가져오기
   public List<BookListVO> getMbtiPLlist(String mbti);
   
   
}