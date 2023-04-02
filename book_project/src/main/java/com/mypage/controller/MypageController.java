package com.mypage.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.domain.ReplyLikeVO;
import com.bookBoard.service.BookSearchService;
import com.member.domain.BookListVO;
import com.member.domain.MemberVO;
import com.member.service.CustomUserDetailsService;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;
import com.mypage.domain.FinBookVO;
import com.mypage.domain.WantBookVO;
import com.mypage.service.MypageService;
import com.sentence.domain.SentenceVO;
import com.sentence.service.GreatService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/mypage/*")
@Log4j
public class MypageController {

   @Autowired
   private MypageService service;
   
   @Autowired
   private MemberService memberservice;
   
   @Autowired
   private GreatService greatservice;
   
   @Autowired
   private CustomUserDetailsService customUserDetailsService;
   
   @Autowired
   private BookSearchService bookService;
   
   @GetMapping("memMypage")
   public void memMypage(MemberVO member, Authentication auth, Model model, SentenceVO sentence, WantBookVO want, FinBookVO fin) {
      log.info("마이페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      // 회원의 북 플레이리스트 가져오기
      model.addAttribute("myPLlist", service.getMyBookPLlist(memberId));
      
      // 회원의 북 플리 갯수 가져오기
      model.addAttribute("myPLlistCount", service.bookPlistCount(memberId)); 

      // 회원의 읽은 책 개수 가져오기
      model.addAttribute("readBookCount", service.readBookCount(memberId));
      
      
      
   }
   
   // 회원의 북플리 개수 가져오기 
   @GetMapping(value="getMyPLlistCount")
	public ResponseEntity<Integer> getMyPLlistCount(MemberVO member, Authentication auth, Model model){
		log.info("회원의 북플리 개수 가져오기 요청!!!");
	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      log.info("****************user : " + user );
	      member = memberservice.getMember(user.getUsername());
	      
	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	      model.addAttribute("member" , member); 
	      
	      String memberId = member.getId();
	      
	   // 회원의 북 플리 갯수 가져오기
	      Integer resultCount =  Integer.valueOf(service.bookPlistCount(memberId)); 
		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
	}
   
   
   
   // 회원의 찜한 북플리 개수 가져오기 
   @GetMapping(value="getMyScrapPLCount")
	public ResponseEntity<Integer> getMyScrapPLCount(MemberVO member, Authentication auth, Model model){
		log.info("회원이 찜한 북플리 갯수 가져오기 요청!!!");
	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      log.info("****************user : " + user );
	      member = memberservice.getMember(user.getUsername());
	      
	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	      model.addAttribute("member" , member); 
	      
	      String memberId = member.getId();
	      
	   // 회원의 북 플리 갯수 가져오기
	      Integer resultCount =  Integer.valueOf(service.scrapPLCount(memberId)); 
		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
	}
   
   
   // 회원이 읽고 싶은 책개수 가져오는 메서드 getMyWantBookCount
   @GetMapping(value="getMyWantBookCount")
	public ResponseEntity<Integer> getMyWantBookCount(MemberVO member, Authentication auth, Model model){
		log.info("회원의 읽고 싶은 책 개수 가져오기 요청!!!");
	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      log.info("****************user : " + user );
	      member = memberservice.getMember(user.getUsername());
	      
	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	      model.addAttribute("member" , member); 
	      
	      String memberId = member.getId();
	      
	   // 회원의 북 플리 갯수 가져오기
	      Integer resultCount =  Integer.valueOf(service.wantBookCount(memberId)); 
		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
	}
   
   
   // 회원이 읽은 책 갯수 가져오는 메서드 getMyFinishBookCount
   @GetMapping(value="getMyFinishBookCount")
	public ResponseEntity<Integer> getMyFinishBookCount(MemberVO member, Authentication auth, Model model){
		log.info("회원이 읽은 책 갯수 가져오기 요청!!!");
	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      log.info("****************user : " + user );
	      member = memberservice.getMember(user.getUsername());
	      
	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	      model.addAttribute("member" , member); 
	      
	      String memberId = member.getId();
	      
	   // 회원의 북 플리 갯수 가져오기
	      Integer resultCount =  Integer.valueOf(service.readBookCount(memberId)); 
		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
	}
   
   
   // 회원의 인생문장 개수 가져오는 메서드 getMySenetenceCount
   @GetMapping(value="getMySenetenceCount")
 	public ResponseEntity<Integer> getMySenetenceCount(MemberVO member, Authentication auth, Model model){
 		log.info("회원의 인생문장 카운트 가져오기 요청!!!");
 	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
 	      CustomUser user = (CustomUser)auth.getPrincipal();
 	      log.info("****************user : " + user );
 	      member = memberservice.getMember(user.getUsername());
 	      
 	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
 	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
 	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
 	      model.addAttribute("member" , member); 
 	      
 	      String memberId = member.getId();
 	      
 	   // 회원의 북 플리 갯수 가져오기
 	      Integer resultCount =  Integer.valueOf(service.mySentenceCount(memberId)); 
 		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
 	}
   
   
   
   // 회원의 좋아요한 인생문장 개수 가져오는 메서드 getMySenetenceCount
   @GetMapping(value="getMyLikeSentenceCount")
 	public ResponseEntity<Integer> getMyLikeSentenceCount(MemberVO member, Authentication auth, Model model){
 		log.info("회원이 좋아요한 인생문장 카운트 가져오기 요청!!!");
 	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
 	      CustomUser user = (CustomUser)auth.getPrincipal();
 	      log.info("****************user : " + user );
 	      member = memberservice.getMember(user.getUsername());
 	      
 	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
 	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
 	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
 	      model.addAttribute("member" , member); 
 	      
 	      String memberId = member.getId();
 	      
 	   // 회원의 좋아요한 인생문장 갯수 가져오기
 	      Integer resultCount =  Integer.valueOf(service.myLikeSentenceCount(memberId)); 
 		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
 	}  
   
   
   
   // 회원이 작성한 댓글 총 개수 가져오는 메서드 getMySenetenceCount
   @GetMapping(value="getMyReplyCount")
 	public ResponseEntity<Integer> getMyReplyCount(MemberVO member, Authentication auth, Model model){
 		log.info("회원이 작성한 댓글 개수 가져오기 요청!!!");
 	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
 	      CustomUser user = (CustomUser)auth.getPrincipal();
 	      log.info("****************user : " + user );
 	      member = memberservice.getMember(user.getUsername());
 	      
 	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
 	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
 	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
 	      model.addAttribute("member" , member); 
 	      
 	      String memberId = member.getId();
 	      
 	   // 회원의 좋아요한 인생문장 갯수 가져오기
 	      Integer resultCount =  Integer.valueOf(service.myReplyCount(memberId)); 
 		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
 	}  
   
   
   
   // 회원이 좋아요한 댓글 총 개수 가져오는 메서드 getMySenetenceCount
   @GetMapping(value="getMyLikeReplyCount")
 	public ResponseEntity<Integer> getMyLikeReplyCount(MemberVO member, Authentication auth, Model model){
 		log.info("회원이 좋아요한 댓글 개수 가져오기 요청!!!");
 	      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
 	      CustomUser user = (CustomUser)auth.getPrincipal();
 	      log.info("****************user : " + user );
 	      member = memberservice.getMember(user.getUsername());
 	      
 	      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
 	      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
 	      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
 	      model.addAttribute("member" , member); 
 	      
 	      String memberId = member.getId();
 	      
 	   // 회원의 좋아요한 인생문장 갯수 가져오기
 	      Integer resultCount =  Integer.valueOf(service.myLikeReplyCount(memberId)); 
 		 return new ResponseEntity<Integer>(resultCount, HttpStatus.OK);
 	}  
   
   
   
   
   //회원이 공감한 댓글 마이페이지에서 삭제하기
   @PostMapping(value="deleteLikeReply", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> likeReply(@RequestBody ReplyLikeVO vo , Authentication auth){
   	log.info("*************** ajax로 받아서 채운 공감댓글 VO : " + vo);
   	
   	int result;
   	int countResult;
   	int renum = vo.getRe_no();
   	
   	log.info("받아온 re_no :::::::" + renum);
   	
   	CustomUser user = (CustomUser)auth.getPrincipal();
   	String id = user.getUsername();
   	log.info("댓글 공감한 아이디 :::::::::::::::::::::::::: " + id);

   	
	int delResult = service.delLikeReplyInMypage(id, renum); // id값, renum값 주고 공감한 데이터 삭제하기
	log.info("공감 댓글 삭제 성공했으면 1 :::::::::::::::::::::" + delResult);
	//카운트 -1하기
	int delCountResult = bookService.delGoodCount(renum);
	log.info("댓글 공감 카운트 빼기 성공했으면 1 ::::::::::::::::::::::::" + delCountResult);
	result = 0;
   	
   	
   	return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
               : new ResponseEntity<String>("minus",HttpStatus.OK);
   }
   
   
   
   @GetMapping("adminMypage")
   public void adminMypage(MemberVO member, Authentication auth, Model model) {
      List<MemberVO> memList = null;
      
      log.info("관리자페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      String memberId = member.getId();
      
      log.info("************************************ 관리자 닉네임 : " + member.getNickName());
      log.info("************************************ 관리자 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 관리자 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      
      // 회원의 북 플레이리스트 가져오기
      model.addAttribute("myPLlist", service.getMyBookPLlist(memberId));
      
      // 회원의 북 플리 갯수 가져오기
      model.addAttribute("myPLlistCount", service.bookPlistCount(memberId)); 

      // 회원의 읽은 책 개수 가져오기
      model.addAttribute("readBookCount", service.readBookCount(memberId));
      
      //모든 멤버 정보 가져오기 
      memList = memberservice.getAllMember();
      //log.info("모든 멤버~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + memList);
      model.addAttribute("memList", memList);
   }
   
   
   
   //회원 활동상태 변경하기 
   @PostMapping(value="adminMemberEdit",  consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> adminMemberEdit(@RequestBody MemberVO member) {
      log.info("*********** 회원 상태값 처리하러 Pro컨트롤러 들어옴!!!!!!!! ");
      log.info("*********** 회원 상태값 가져온 member : " + member);
      String id = member.getId();

      int result = 0;
      result = memberservice.deleteMember(id);
      log.info("멤버 상태 변경 됐으면 1이라고 해: " + result);
      
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      
   }
  
   
   
   
   
   //mbti 등록하기
   @PostMapping(value="signupMbtiPro",  consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> signupMbtiPro(@RequestBody MemberVO member, Authentication auth) {
      log.info("*********** mbti 처리하러 Pro컨트롤러 들어옴!!!!!!!! ");
      log.info("*********** 가져온 member : " + member);
      CustomUser user = (CustomUser)auth.getPrincipal();
      String id = user.getUsername();
      member.setId(id);
      log.info("*********** 가져온 member + id set : " + member);
   
      int result = 0;
      result = memberservice.updateMbti(member);
      log.info("mbti 등록됐니????? 됐으면 1이라고 해: " + result);
      
      //renewalAuth();
      
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      
   }

   //읽고 싶은 책 등록하기
   @PostMapping(value="wantBook",  consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> wantBook(@RequestBody WantBookVO want, Authentication auth) {
      log.info("**************읽고 싶은 책 등록하러 Controller 들어옴");
      log.info("**************가져온 want : " + want);
      CustomUser user = (CustomUser)auth.getPrincipal();
      String id = user.getUsername();
      log.info("*************가져온 멤버ID : " + id);
      want.setId(id); //id먼저 세팅하기
      
      int result = 0; 
      result = service.addWantBook(want);
      
      
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }

   
   // 읽고 싶은 책 해제하기
   @PostMapping(value="cancelWantBook",  consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      public ResponseEntity<String> cancelWantBook(@RequestBody WantBookVO want) {
         log.info("**************읽고 싶은 책 해제하기 Controller 들어옴");
         log.info("**************가져온 want : " + want);
   
         int result = service.cancelWantBook(want);

         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      }
   
   
   
   //읽은 책 등록하기
   @PostMapping(value="finBook",  consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> finBook(@RequestBody FinBookVO finish, Authentication auth) {
      log.info("**************읽고 싶은 책 등록하러 Controller 들어옴");
      log.info("**************가져온 finish : " + finish);
      CustomUser user = (CustomUser)auth.getPrincipal();
      String id = user.getUsername();
      log.info("*************가져온 멤버ID : " + id);
      finish.setId(id); //id먼저 세팅하기
      
      int result = 0; 
      result = service.addFinBook(finish);
      
      
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   
   // 읽은 책 해제하기
   @PostMapping(value="cancelFinRead",  consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      public ResponseEntity<String> cancelFinRead(@RequestBody FinBookVO finish) {
         log.info("**************읽고 싶은 책 해제하기 Controller 들어옴");
         log.info("**************가져온 finish : " + finish);
   
         int result = service.cancelFinRead(finish);

         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      }
   
   

   
  // 북플리 디테일 모달에서 회원에 북리스트 뿌려주기
   @GetMapping("getMemPL")
   public ResponseEntity<List<BookListVO>> getMemPL(MemberVO member, Authentication auth, Model model) {
      log.info("마이페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      List<BookListVO> vo = service.getMyBookPLlist(memberId);
      log.info("*********** 북플리 리스트 가져옴 : " + vo);
      
      // 회원의 북 플레이리스트 가져오기
      return new ResponseEntity<List<BookListVO>>(vo, HttpStatus.OK);
   }
  
   
   
   // 회원의 찜한 리스트 뿌려주기
   @GetMapping("getUserScrap")
   public ResponseEntity<List<Integer>> getUserScrap(MemberVO member, Authentication auth, Model model) {
      log.info("마이페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      // 회원의 찜한 북플리 리스트 가져오기
      List<Integer> scrapVOList = service.getMyscrapRDList(memberId);
      model.addAttribute("scrapPL",scrapVOList);
      
      
      return new ResponseEntity<List<Integer>>(scrapVOList, HttpStatus.OK);
   }
   
   

  // 회원의 읽고 싶은 책 가져오기 
   @GetMapping("getUserwantBookList")
   public ResponseEntity<List<WantBookVO>> getUserwantBookList(MemberVO member, Authentication auth, Model model) {
      log.info("마이페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      // 회원의 찜한 북플리 리스트 가져오기
      List<WantBookVO> wantbookVOList = service.wantBookList(memberId);
      
      return new ResponseEntity<List<WantBookVO>>(wantbookVOList, HttpStatus.OK);
   }
   
   
   
   
   // 회원의 읽은 책 가져오기
   @GetMapping("getUserfinBookList")
   public ResponseEntity<List<FinBookVO>> getUserfinBookList(MemberVO member, Authentication auth, Model model) {
      log.info("마이페이지 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      // 회원의 찜한 북플리 리스트 가져오기
      List<FinBookVO> finBookList = service.finBookList(memberId);
  
      return new ResponseEntity<List<FinBookVO>>(finBookList, HttpStatus.OK);
   }
   
   
   
   
   
   
   public boolean renewalAuth() {
       // 기존 정보 꺼내기
       Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       CustomUser userAccount = (CustomUser)authentication.getPrincipal(); // principal만 꺼내서 담기

       // 현재 Authentication로 사용자 인증 후, 새 Authentication 정보를 SecurityContextHolder에 세팅
       SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, userAccount.getUsername()));

       return true;
   }
   
   /* 기존 권한과 사용자 id를 받아서,  new principal로 인증과 토큰 갱신해주는 메서드 */
   public Authentication createNewAuthentication(Authentication currentAuth, String username) {
      UserDetails newPrincipal = customUserDetailsService.loadUserByUsername(username); // DB 가서 새로운 정보로 가져와 pricipal 새로 만들기
   // 새로운 principal로 시큐리티 인증 권한(토큰) 생성
   UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
   newAuth.setDetails(currentAuth.getDetails()); // 현재 정보 추가

       return newAuth;
   }
   
   
   
   
   // 마이페이지 북플리 페이징하기
   @GetMapping(value="getMemPLPaging/{num}")
   public ResponseEntity<List<BookListVO>> getMemPLPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
      log.info("회원 북플리 페이징 가져오기 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      List<BookListVO> vo = service.getMyBookPLlistPaging(memberId, num);
      log.info("*********** 북플리 페이징해서 리스트 가져옴 : " + vo);
      
      // 회원의 북 플레이리스트 가져오기
      return new ResponseEntity<List<BookListVO>>(vo, HttpStatus.OK);
   }
   
   
   
   // 마이페이지 찜한 북플리 페이징하기 getMemScrapPLPaging
   @GetMapping(value="getMemScrapPLPaging/{num}")
   public ResponseEntity<List<BookListVO>> getMemScrapPLPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
      log.info("회원 찜한 북플리 가져오기 호출");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      CustomUser user = (CustomUser)auth.getPrincipal();
      log.info("****************user : " + user );
      member = memberservice.getMember(user.getUsername());
      
      log.info("************************************ 멤버 닉네임 : " + member.getNickName());
      log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
      model.addAttribute("member" , member); 
      
      String memberId = member.getId();
      
      List<BookListVO> vo = service.getMemScrapPLPaging(memberId, num);
      log.info("*********** 북플리 찜하기 페이징해서 리스트 가져옴 : " + vo);
      
      // 회원의 북 플레이리스트 가져오기
      return new ResponseEntity<List<BookListVO>>(vo, HttpStatus.OK);
   }
   

   // 읽고 싶은 책 페이징하기 
   @GetMapping(value="getWantBooksPaging/{num}")
   public ResponseEntity<List<WantBookVO>> getWantBooksPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원의 읽고 싶은 책 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<WantBookVO> vo = service.getWantBooksPaging(memberId, num);
	   log.info("*********** 읽고 싶은 책 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<WantBookVO>>(vo, HttpStatus.OK);
   }
   
   
   // 읽은 책 페이징하기 
   @GetMapping(value="getReadBooksPaging/{num}")
   public ResponseEntity<List<FinBookVO>> getReadBooksPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원의 읽고 싶은 책 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<FinBookVO> vo = service.readBooksPaging(memberId, num);
	   log.info("*********** 읽은 책 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<FinBookVO>>(vo, HttpStatus.OK);
   }
   
   
   // 회원의 인생문장 페이징
   @GetMapping(value="getMySentencesPaging/{num}")
   public ResponseEntity<List<SentenceVO>> getMySentencesPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원의 인생문장 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<SentenceVO> vo = service.mySentencesPaging(memberId, num);
	   log.info("*********** 인생문장 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<SentenceVO>>(vo, HttpStatus.OK);
   }
  
   // 회원의 좋아요한 인생문장 페이징
   @GetMapping(value="getLikeSentencePaging/{num}")
   public ResponseEntity<List<SentenceVO>> getLikeSentencePaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원의 좋아요한 인생문장 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<SentenceVO> vo = service.myLikeSentencePaging(memberId, num);
	   log.info("*********** 좋아요 인생문장 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<SentenceVO>>(vo, HttpStatus.OK);
   }
   
   
   
   
    //회원이 작성한 댓글 페이징해서 가져오기 getMyReplyPaging
   @GetMapping(value="getMyReplyPaging/{num}")
   public ResponseEntity<List<ReplyBoardVO>> getMyReplyPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원이 작성한 댓글 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<ReplyBoardVO> vo = service.getMyReplyPaging(memberId, num);
	   log.info("*********** 좋아요 인생문장 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<ReplyBoardVO>>(vo, HttpStatus.OK);
   }
   
   
   // 회원이 좋아요한 댓글 페이징해서 가져오기 getLikeReplyPaging
   @GetMapping(value="getLikeReplyPaging/{num}")
   public ResponseEntity<List<ReplyBoardVO>> getLikeReplyPaging(@PathVariable("num") int num, MemberVO member, Authentication auth, Model model) {
	   log.info("회원이 작성한 댓글 페이징 가져오기 호출");
	   // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
	   CustomUser user = (CustomUser)auth.getPrincipal();
	   log.info("****************user : " + user );
	   member = memberservice.getMember(user.getUsername());
	   
	   log.info("************************************ 멤버 닉네임 : " + member.getNickName());
	   log.info("************************************ 멤버 엠벼티아이 : " + member.getMbti());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   log.info("************************************ 멤버 마이페이지 백그라운드 : " + member.getBgImg());
	   model.addAttribute("member" , member); 
	   
	   String memberId = member.getId();
	   
	   List<ReplyBoardVO> vo = service.getLikeReplyPaging(memberId, num);
	   log.info("*********** 좋아요 인생문장 페이징해서 리스트 가져옴 : " + vo);
	   
	   // 회원의 북 플레이리스트 가져오기
	   return new ResponseEntity<List<ReplyBoardVO>>(vo, HttpStatus.OK);
   }
   
   
   
}