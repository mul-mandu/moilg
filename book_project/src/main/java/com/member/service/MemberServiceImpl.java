package com.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.bookBoard.domain.keywordVO;
import com.member.domain.AuthVO;
import com.member.domain.BookListVO;
import com.member.domain.BookPLKeyword;
import com.member.domain.MemberInterVO;
import com.member.domain.MemberVO;
import com.member.domain.OneBookListVO;
import com.member.domain.ScrapRDListVO;
import com.member.persistence.MemberMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{

   @Autowired //비밀번호 암호화를 위한 객체 자동 주입
   private BCryptPasswordEncoder bcryptPasswordEncoder;
   
   @Autowired
   private MemberMapper mapper;
   
   @Autowired
   private CustomUserDetailsService customUserDetailsService; 
   
      
   @Override
   public int addMember(MemberVO member) {
      log.info("************service AddMember pw before:" + member.getPw());
      member.setPw(bcryptPasswordEncoder.encode(member.getPw())); //pw를 받아와서 암호화 시킨 다음에, 암호화 된 pw를 다시 member에 셋팅! 
      log.info("************service AddMember pw after:" + member.getPw());
      
      return mapper.addMember(member);
         
   }

   // 권한 추가
      @Override
      public int addAuth(String auth, String id) {
         int result = -1;
         AuthVO authVo = new AuthVO();
         authVo.setId(id);
         if(id.equals("admin")) {
            authVo.setAuth("ROLE_ADMIN");
            result=mapper.addAuth(authVo);
         }else {
            authVo.setAuth("ROLE_MEMBER");
            result = mapper.addAuth(authVo);
         }
         return result;
      }

   
   
   @Override
   public MemberVO getMember(String id) {
      return mapper.getMember(id);
   }
   

//   @Override
//   public MemberInterVO addInter(String id) {
//      
//      return mapper.addInter(id);
//   }
   
   
    //멤버 관심사
    @Override
    public int addInter(int internum, String id) {
       return mapper.insertInter(internum, id);
    }
    
    
    //회원가입후 바로 로그인 되도록
    @Override
    public void autoLogin(String username) {
       
       UserDetails user = customUserDetailsService.loadUserByUsername(username);
         UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities()); 
         SecurityContextHolder.getContext().setAuthentication(token);
    }
    
    

   //멤버 mbti 정보 update
   @Override
   public int updateMbti(MemberVO member) {
      
      return mapper.updateMemMbti(member);
   }

   
   
   //mbti에 해당하는 회원 id 가져오기
   @Override
   public List<String> selectMbtiMem(String mbti) {
      return mapper.getMbtiMem(mbti);
   }
   
   //해당 mbti에 맞는 회원의 공개 북플리가져오기
   @Override
   public List<BookListVO> getMyBookPLOpenlist(String id) {
      return mapper.mbtiOpenList(id);
   }

   //나의 키워드 가져오기
   @Override
   public List<Integer> getMyInterList(String id) {
      return mapper.selectMyInterList(id);
   }
   
   
   //키워드 넘버 주고 북플리 list no 가져오기
   @Override
   public List<Integer> getListNoList(int keynum) {
      return mapper.selectListNoList(keynum);
   }
   
   //키워드 넘버 주고 북플리List 가져오기 (장르)
   @Override
   public List<BookListVO> getGBookList(List<Integer> list) {
      return mapper.selectGBookList(list);
   }
   

   
   // 북리스트 생성
   @Override
   public int addBookList(BookListVO vo) {
      return mapper.addBookList(vo);
   }
   
   
   
   //북플리 패키지 저장
   @Override
   public int addBookListPackage(BookListVO vo) {
      return mapper.insertBookPackage(vo);
   }
   
   
   //북플리 패키지 수정
   @Override
   public int modifyBookListPackage(BookListVO vo) {
      return mapper.modifyBookPackage(vo);
   }
   
   
   
   // list_no_seq 마지막 인덱스 값 가져오기
   @Override
   public int findLastSeq() {
      return mapper.findLastSeq();
   }


   

   // oneBookList 추가
   @Override
   public int addOneBookList(OneBookListVO vo) {
      return mapper.addOneBookList(vo);
   }

   
   // 북 리스트에 키워드 추가 
   @Override
   public int addPLKeyWord(int keyword_no) {
      
      return mapper.addPLKeyWord(mapper.getListNoCurrSeq(), keyword_no); 
   }


   
   // 하나의 북리스트 정보 가져오기
   @Override
   public BookListVO getOneBookList(int list_no) {
      return mapper.getOneBookList(list_no);
   }

   
   // 하나의 북리스트에 포함되어있는 책들 가져오기
   @Override
   public List<OneBookListVO> getPLBooksList(int list_no) {
      return mapper.getPLBooksList(list_no);
   }

   
   // 하나의 북 리스트에 포함되어있는 키워드 가져오기
   @Override
   public List<Integer> getPLKeyword(int list_no) {
      return mapper.getPLKeyword(list_no);
   }

   // 키워드 번호에 해당하는 키워드 VO 가져오기
   @Override
   public keywordVO getKeywordVOList(int keynum) {
      return mapper.getKeywordVOList(keynum);
   }

   // 북리스트 수정
   @Override
   public int modifyBookList(BookListVO vo) {
      return mapper.modifyBookList(vo);
   }
   
   
   // 북플레이리스트 책목록 삭제
   @Override
   public int deleteOneBookList(int listNum) {
      return mapper.deleteOneBookList(listNum);
   }
   
   
   // 북리스트 삭제
   @Override
   public int deleteBookList(int listNum) {
      return mapper.deleteBookList(listNum);
   }

   // 북리스트 책 목록 수정
   @Override
   public int ModifyOneBookList(OneBookListVO vo) {
      return mapper.ModifyOneBookList(vo);
   }

   
   // 북리스트 키워드 삭제
   @Override
   public int deleteKeywordList(int listNum) {
      return mapper.deleteKeywordList(listNum);
   }

   
   // 북리스트 키워드 수정
   @Override
   public int modifyPLKeyWord(BookPLKeyword vo) {
      return mapper.modifyPLKeyWord(vo);
   }

   
   // 북리스트 찜하기
   @Override
   public int addScrapRDList(ScrapRDListVO vo) {
      return mapper.addScrapRDList(vo);
   }

   // 북플리 찜하기 해제
   @Override
   public int cancelScrapRDList(ScrapRDListVO vo) {
      return mapper.cancelScrapRDList(vo);
   }
   
   // 북플레이 리스트에 책 추가하기
   @Override
   public int addSavePlBooks(OneBookListVO vo) {
      return mapper.addSavePlBooks(vo);
   }

   
   // 모달에서 새 북플리 생성
   @Override
   public int newBookList(BookListVO vo) {
      return mapper.newBookList(vo);
   }

   //프로필 업데이트
   @Override
   public int modifyMyProfile(MemberVO member) {
      return mapper.updateProfile(member);
   }
   
   //마이페이지 배경 업데이트
   @Override
   public int modifyMyBgImg(MemberVO member) {
      return mapper.updateBgImg(member);
   }


   // 아이디 찾기
   @Override
   public String findId(MemberVO vo) {
      return mapper.findId(vo);
   }

   
   // 비밀번호 찾기
   @Override
   public String findPw(MemberVO vo) {
      return mapper.findPw(vo);
   }

   
   // 아이디 중복확인
   @Override
   public int idCheck(MemberVO vo) {
      return mapper.idCheck(vo);
   }
   
   
   
   // pw 맞나 확인
   @Override
   public int pwCheck(MemberVO vo) {
      log.info("pwCheck 서비스 인포 들어옴!!!");
      // id pw 맞나 체크
      int result = 0;
      MemberVO dbMember = getMember(vo.getId());
      if(bcryptPasswordEncoder.matches(vo.getPw(), dbMember.getPw())) {  // 만약 둘이 같으면
         result = 1;
      } else {
         result = 0;
      }
      log.info("비번 맞는지 체크!! : " + result);
      return result;
   }
   
   
   // 닉네임 중복 확인
   @Override
   public int nickNameCheck(MemberVO vo) {
      return mapper.nickNameCheck(vo);
   }

   
   // 회원 정보 수정
   @Override
   public int memberModify(MemberVO vo) {
         log.info("************service AddMember pw before:" + vo.getPw());
         vo.setPw(bcryptPasswordEncoder.encode(vo.getPw())); //pw를 받아와서 암호화 시킨 다음에, 암호화 된 pw를 다시 member에 셋팅! 
         log.info("************service AddMember pw after:" + vo.getPw());
      
      
      return mapper.memberModify(vo);
   }
   
   
   // 회원 정보 수정(비밀번호만)
   @Override
   public int memberPwModify(MemberVO vo) {
      log.info("************service AddMember pw before:" + vo.getPw());
      vo.setPw(bcryptPasswordEncoder.encode(vo.getPw())); //pw를 받아와서 암호화 시킨 다음에, 암호화 된 pw를 다시 member에 셋팅! 
      log.info("************service AddMember pw after:" + vo.getPw());
      
      
      return mapper.memberPwModi(vo);
   }
   
   
   
   // 회원 탈퇴 요청
   @Override
   public int deleteMember(String id) {
      log.info("***********회원 상태값 변경");
       return mapper.deleteMember(id);
   }
   
   // 회원 탈퇴 요청
   @Override
   public int updateDelMemAuth(String id) {
      log.info("***********회원 상태값 변경");
      return mapper.updateAuth(id);
   }

   
   
   //모든 회원 정보 가져오기
   @Override
   public List<MemberVO> getAllMember() {
      return mapper.selectAllMember();
   }
   
   
   //회원 권한 가져오기 
   @Override
   public String getMemAuth(String id) {
      return mapper.selectMemAuth(id);
   }
   
   
   
   
   ///////////////////////////////////////////////////////////////////

   
   


   // 이 책이 해당된 플레이리스트 번호 가져오기
   @Override
   public List<Integer> getIncludBook(String isbn) {
      return mapper.getIncludBook(isbn);
   }
   
   
   // 관리자가 만든 북플리  가져오기
   @Override
   public List<BookListVO> getPLNumList(String id) {
      return mapper.getPLNumList(id);
   }

   
   // mbti에 해당하는 북플리 가져오기
	@Override
	public List<BookListVO> getMbtiPLlist(String mbti) {
		return mapper.getMbtiPLlist(mbti);
	}
   
   
}
   
   