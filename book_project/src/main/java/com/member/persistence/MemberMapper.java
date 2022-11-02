package com.member.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bookBoard.domain.keywordVO;
import com.member.domain.AuthVO;
import com.member.domain.BookListVO;
import com.member.domain.BookPLKeyword;
import com.member.domain.MemberInterVO;
import com.member.domain.MemberVO;
import com.member.domain.OneBookListVO;
import com.member.domain.ScrapRDListVO;

public interface MemberMapper {

   //회원 추가
   public int addMember(MemberVO member);

   //권한 추가
   public int addAuth(AuthVO auth);
   
   //회원 한명 정보 가져오기 
   public MemberVO getMember(String id);

   //회원 관심사 저장
   //public MemberInterVO addInter(String id);
   
   //회원 관심사 저장
   public int insertInter(@Param("keyword_no")int internum,  @Param("id") String id);
   
   //회원 mbti 정보 update
   public int updateMemMbti(MemberVO member);
   
   //회원 프로필 업데이트
   public int updateProfile(MemberVO member);
   
   //회원 마이페이지 배경 업데이트
   public int updateBgImg(MemberVO member);
   
   
   //mbti에 해당하는 회원 id 가져오기
   public List<String> getMbtiMem(String mbti);
   
   //mbti에 맞는 북플리 가져오기 (공개)
   public List<BookListVO> mbtiOpenList(String id);
   
   //내 관심사 목록 가져오기
   public List<Integer> selectMyInterList(String id);
   
   //키워드 넘버 주고 북플리 list no 가져오기
   public List<Integer> selectListNoList(int keynum);

 //키워드 넘버 주고 북플리List 가져오기 (장르)
   public List<BookListVO> selectGBookList(List<Integer> list);

   
   
   // 아이디 찾기
   public String findId(MemberVO vo);
   
   // 비밀번호 찾기
   public String findPw(MemberVO vo);
   
   // 아이디 중복확인
   public int idCheck(MemberVO vo);
   
   // 닉네임 중복확인
   public int nickNameCheck(MemberVO vo);
   
   // 회원정보 수정
   public int memberModify(MemberVO vo);
   
   // 회원정보 수정(비밀번호만)
   public int memberPwModi(MemberVO vo);
 
   // 회원 탈퇴
   public int deleteMember(@Param("id") String id);
   
   // 회원 권한 삭제
   public int updateAuth(@Param("id") String id);
   
   
   //모든 회원정보 가져오기
   public List<MemberVO> selectAllMember(); 

   // 회원 권한 삭제
   public String selectMemAuth(@Param("id") String id);
  
  
   ///////////////////////////////////////////////////////////////////////
   
   
   // 마지막 인덱스 값 가져오기
   public int findLastSeq();   
   
   
   // 북리스트 추가
   public int addBookList(BookListVO vo);
   
   // 북플리 패키지 추가
   public int insertBookPackage(BookListVO vo);
   
   //북플리 패키지 수정 
   public int modifyBookPackage(BookListVO vo);
   
   // onebooklist 추가
   public int addOneBookList(OneBookListVO vo);
   
   //키워드 추가
   public int addPLKeyWord(@Param("list_no") int list_no, @Param("keyword_no") int keyword_no);
   
   // 마지막으로 생성된 시퀀스 번호 가져오기
   public int getListNoCurrSeq();
   
   // 하나의 북리스트 정보 가져오기
   public BookListVO getOneBookList(int list_no);
   
   // 하나의 북 리스트에 해당하는 책들 가져오기
   public List<OneBookListVO> getPLBooksList(int list_no);
   
   // 하나의 북 리스트에 해당하는 키워드들 가져오기
   public List<Integer> getPLKeyword(int list_no);
   
   //하나의 키워드에 해당하는 키워드 VO 가져오기
   public keywordVO getKeywordVOList(int keynum);
   
   // 북플리 수정
   public int modifyBookList(BookListVO vo);
   
   
   // 북리스트에 있는 책 목록 삭제
   public int deleteOneBookList(int listNum);
   
   // 북리스트 책 목록 수정
   public int ModifyOneBookList(OneBookListVO vo);
   
   
   // 북리스트 삭제
   public int deleteBookList(int listNum);
   
   
   // 북플리 키워드 삭제
   public int deleteKeywordList(int listNum);
   
   // 북플리 키워드 수정
   public int modifyPLKeyWord(BookPLKeyword vo);
   
   
   // 북플리 찜하기
   public int addScrapRDList(ScrapRDListVO vo);
   
   // 북플리 찜하기 해제
   public int cancelScrapRDList(ScrapRDListVO vo);
   
   // 북플레이 리스트에 도서 추가하기
   public int addSavePlBooks(OneBookListVO vo);
   
   
   // 모달에서 새 북플리 생성
   public int newBookList(BookListVO vo);
   
   // 이 책이 해당된 플레이리스트들 가져오기
   public List<Integer> getIncludBook(@Param("isbn") String isbn);
   
   
   
   // 관리자의 플리 가져오기
   public List<BookListVO> getPLNumList(@Param("id") String id);
   
   
   // mbti에 해당하는 플리 가져오기
   public List<BookListVO> getMbtiPLlist(@Param("mbti") String mbti);
   
}