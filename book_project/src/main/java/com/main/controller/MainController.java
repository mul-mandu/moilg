package com.main.controller;


import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.main.service.MainService;
import com.member.domain.BookListVO;
import com.member.domain.MemberVO;
import com.member.service.CustomUserDetailsService;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;
import com.mypage.controller.MypageController;
import com.mypage.service.MypageService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*")
@Log4j
public class MainController {
   
   @Autowired private MainService mainService;
   @Autowired private MemberService service;
   @Autowired private MypageService myService;
   @Autowired private MypageController mypageController;
   
   @GetMapping("main")
   public void main(Model model, Authentication auth) {
      log.info("메인호출");
      
     
      
      // 관리자가 생성한 북플리 리스트 배너에 쏴주기
      String adminId = "admin";
      
      //리스트로 가져와서 
      List<BookListVO> adminBPL = service.getPLNumList(adminId);
      List<BookListVO> threeAdminBPL = new ArrayList<BookListVO>();  // 3개로 담기
      
      // 3개로 다시 담기
      if(adminBPL.size() != 0) {  // 관리자가 작성한 플리가 있으면
         for(int i=0 ; i < 4; i++) {
            threeAdminBPL.add(adminBPL.get(i));
         }
      
      
      // 3개로 담고나서
      // 해당 vo에 해당하는 list_no 가져오기
         BookListVO vo1 = threeAdminBPL.get(0);
         int list_Num1 = vo1.getList_no();
         model.addAttribute("oneBanner", vo1);
         model.addAttribute("oneB_book", service.getPLBooksList(list_Num1));
         
         BookListVO vo2 = threeAdminBPL.get(1);
         int list_Num2 = vo2.getList_no();
         model.addAttribute("twoBanner", vo2);
         model.addAttribute("twoB_book", service.getPLBooksList(list_Num2));
         
         BookListVO vo3 = threeAdminBPL.get(2);
         int list_Num3 = vo3.getList_no();
         model.addAttribute("threeBanner", vo3);
         model.addAttribute("threeB_book", service.getPLBooksList(list_Num3));
      
      }
      
      List<BookListVO> bookPList = null;
      List<BookListVO> memGenreBPL = new ArrayList<>(); 
      List<BookListVO> memMoodBPL = new ArrayList<>(); 
      List<BookListVO> memSituBPL = new ArrayList<>(); 
      List<BookListVO> mbtiBookPL = new ArrayList<>(); 
      
      List<Integer> allGenreNo = null;
      List<Integer> allMoodNo = null;
      List<Integer> allSituNo = null;
      
      
      
      if(auth == null) {

      // 전체 북리스트 뿌리기
      List<BookListVO> vo = mainService.getAllPL();
      model.addAttribute("playList",vo);
      
      // 장르 전체 북리스트 뿌리기 
      allGenreNo = mainService.getGenreAll(); //장르 전체 list_no
      if(allGenreNo.size() != 0) {
         bookPList = service.getGBookList(allGenreNo);
         log.info("가져온 장르 리스트!! : " + bookPList);
         memGenreBPL.addAll(bookPList);
         model.addAttribute("memGenreBPL", memGenreBPL);
      }
      
      //무드 전체 뿌리기
      allMoodNo = mainService.getMoodAll(); //무드 전체 list_no
      if(allGenreNo.size() != 0) {
         bookPList = service.getGBookList(allMoodNo);
         log.info("가져온 장르 리스트!! : " + bookPList);
         memMoodBPL.addAll(bookPList);
         model.addAttribute("memMoodBPL", memMoodBPL);
      }
      
      //상황 전체 뿌리기
      allSituNo = mainService.getSituAll(); //무드 전체 list_no
      if(allSituNo.size() != 0) {
         bookPList = service.getGBookList(allSituNo);
         log.info("가져온 상황 리스트!! : " + bookPList);
         memSituBPL.addAll(bookPList);
         model.addAttribute("memSituBPL", memSituBPL);
      }
      
      
      
      //로그인 했을 시,
   }else if(auth != null) {
         // 전체 북리스트 뿌리기
         List<BookListVO> vo = mainService.getAllPL();
         model.addAttribute("playList",vo);  
      
         //선호 장르에 따른 북플리 뿌리기 
         log.info("************************main장르 처리 들어옴!!!!!!!!!!!!!!!!!!!!!!!!!!");
         
         CustomUser principal = (CustomUser)auth.getPrincipal();
         String id = principal.getUsername(); //멤버 id 
         log.info("확인용!!!!!!!!!!!!!!!!!!!!!!!! " + principal.getAuthorities());
         log.info("확인용!!!!!!!!!!!!!!!!!!!!!!!! " + principal.getMember().getMemStatus());

         List<Integer> memInterList = service.getMyInterList(id); // 선호 가져오기  
         
         log.info("***********************************memInterList : " + memInterList.size());
         
            if(memInterList.size() == 0) { // 선호 X
                  log.info("*********************************** no interest******** ");
                  //String[] names = {"memGenreBPL", "memMoodBPL", "memSituBPL" };
                  
                  //장르 전체 뿌리기
                  allGenreNo = mainService.getGenreAll(); //장르 전체 list_no
                  if(allGenreNo.size() != 0) {
                     bookPList = service.getGBookList(allGenreNo);
                     log.info("가져온 장르 리스트!! : " + bookPList);
                     memGenreBPL.addAll(bookPList);
                     model.addAttribute("memGenreBPL", memGenreBPL);
                  }
                  
                  
                  //무드 전체 뿌리기
                  allMoodNo = mainService.getMoodAll(); //무드 전체 list_no
                  if(allMoodNo.size() != 0) {
                     bookPList = service.getGBookList(allMoodNo);
                     log.info("가져온 무드 리스트!! : " + bookPList);
                     memMoodBPL.addAll(bookPList);
                     model.addAttribute("memMoodBPL", memMoodBPL);
                  }
                  
                  
                  //상황 전체 뿌리기
                  allSituNo = mainService.getSituAll(); //무드 전체 list_no
                  if(allSituNo.size() != 0) {
                     bookPList = service.getGBookList(allSituNo);
                     log.info("가져온 상황 리스트!! : " + bookPList);
                     memSituBPL.addAll(bookPList);
                     model.addAttribute("memSituBPL", memSituBPL);
                  }
            }else { // 선호 O 
               for(Integer i : memInterList) {
                  System.out.println("iiiiiiiiiiiiiiiiiiiiiiiiiiii" + i);
                  if(i > 0 && i < 16) { // 장르 
                     log.info("멤버 설정 키워드 리스트 ::" + i) ;
                     
                     List<Integer> listNoList = service.getListNoList(i);  
                     log.info("*************************listNoList : " + listNoList);
                     if(listNoList.size() != 0) {
                        bookPList = service.getGBookList(listNoList);
                        log.info("가져온 장르 리스트!! : " + bookPList);
                        memGenreBPL.addAll(bookPList);
                     }
                  }else if(i >= 16 && i < 28) { // 
                     List<Integer> listNoList = service.getListNoList(i);  
                     log.info("*************************listNoList : " + listNoList);
                     
                     if(listNoList.size() != 0) {
                        bookPList = service.getGBookList(listNoList);
                        log.info("가져온 무드 리스트!! : " + bookPList);
                        memMoodBPL.addAll(bookPList);
                     }
                  }else if(i >=28 && i < 35 ){
                     List<Integer> listNoList = service.getListNoList(i);  
                     log.info("*************************listNoList : " + listNoList);
                     
                     if(listNoList.size() != 0) {
                        bookPList = service.getGBookList(listNoList);
                        log.info("가져온 상황 리스트!! : " + bookPList);
                        memSituBPL.addAll(bookPList);
                     }
               }
            }//for 처음
            
            log.info("************************* 장르 개수 : " + memGenreBPL.size());
            log.info("************************* 무드 개수 : " + memMoodBPL.size());
            log.info("************************* 상황 개수 : " + memSituBPL.size());
            
            model.addAttribute("memGenreBPL", memGenreBPL);
            model.addAttribute("memMoodBPL", memMoodBPL);
            model.addAttribute("memSituBPL", memSituBPL);
            log.info("모델 보냈따따따ㄸ따따따따따따따");
            
         }
         
            
            //mbti에 따른 북플리 뿌리기
            log.info("************************mainMBTI 처리 들어옴!!!!!!!!!!!!!!!!!!!!!!!!!!");
            principal = (CustomUser)auth.getPrincipal();
            id = principal.getUsername(); //멤버 id 
            
            MemberVO member = service.getMember(id); //멤버 정보 가져오기      
            String mbti = member.getMbti(); //멤버 MBTI 정보 가져오기 
            log.info("************************mainMBTI 뭘까요???" + mbti);
            
            List<String> idList = service.selectMbtiMem(mbti); 
            for(String mbtiId : idList) {
               if(!(mbtiId.equals(id))) {
                  bookPList = service.getMyBookPLOpenlist(mbtiId);
                  //log.info("mbti로 가져온 북플리~~~~~~~~~" + bookPList);
                  mbtiBookPL.addAll(bookPList);
                 log.info("메인 엠비티아이 처리중!!!!" + bookPList);
               }
               
            }
           mypageController.renewalAuth();
            model.addAttribute("mbtiBookPL", mbtiBookPL);
            log.info("메인 엠비티아이 모델 보냄!!!!!!!!");
      
      }//if
      
  

   }//메서드 끝 
   
   
      
   //MBTI 페이지 호출
   @GetMapping("mbti")
   public void mbti(MemberVO member, Authentication auth, Model model) {
      
      List<BookListVO> bookPList = null;
      
      
      log.info("mibt테스트 페이지 호출!!");
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      String id = ((CustomUser)auth.getPrincipal()).getUsername();
      log.info("****************user : " + id );
      member = service.getMember(id);
      log.info("****** 멤버 정보 : " + member);
      member.getNickName();
      log.info("****** 멤버 닉 : " + member.getNickName());
   
      model.addAttribute("nick", member.getNickName());
         
      String mbti = member.getMbti(); //멤버 MBTI 정보 가져오기 
      log.info("************************mainMBTI 뭘까요???" + mbti);
      
      List<String> idList = service.selectMbtiMem(mbti); 
      for(String mbtiId : idList) {
         if(!(mbtiId.equals(id))) {
            bookPList = service.getMyBookPLOpenlist(mbtiId);
            model.addAttribute("mbtiBookPL", bookPList);
         }//if문
         
      }//for문
      
    }//메서드 끝

   
   
   //접근 불가페이지 호출
   @GetMapping("accessError")
   public void accessError() {
      log.info("접근 불가");
      
   }
   
   
   @GetMapping("delMemLogout")
   public void delMemLogout() {
      log.info("탈퇴 회원 로그아웃 페이지");
   }
   
   
   // mbti 에 해당하는 북플리 뿌리기
   @GetMapping("getMbtiPLlist")
   public ResponseEntity<List<BookListVO>> getMbtiPLlist(String mbti, Model model) {
      log.info("mbti 가져오기 호출!!");
      log.info("가져온 mbti : " + mbti);
      
      // 북플리 해당하는 책 리스트 가져오기
      List<BookListVO> bookList = new ArrayList<BookListVO>();
      bookList = service.getMbtiPLlist(mbti);

      model.addAttribute("mbtiList", bookList);
      return new ResponseEntity<List<BookListVO>>(bookList, HttpStatus.OK); 
      
   }
   
   
//   
//   //MBTI에 해당하는 북플리 뿌리기
//   @GetMapping("main")
//   public void mainMbti(Authentication auth, Model model, MemberVO member, List<BookListVO> bookPList) {
//      log.info("************************mainMBTI 처리 들어옴!!!!!!!!!!!!!!!!!!!!!!!!!!");
//      CustomUser principal = (CustomUser)auth.getPrincipal();
//      String id = principal.getUsername(); //멤버 id 
//      
//      member = service.getMember(id); //멤버 정보 가져오기      
//      String mbti = member.getMbti(); //멤버 MBTI 정보 가져오기 
//      log.info("************************mainMBTI 뭘까요???" + mbti);
//      
//      List<String> idList = service.selectMbtiMem(mbti); 
//      for(String mbtiId : idList) {
//         if(mbtiId != id) {
//            bookPList = mainService.getMyBookPLOpenlist(mbtiId);
//            model.addAttribute("mbtiBookPL", bookPList);
//         }
//         
//      }
//      
//      
//      
//   } //메서드 끝
   
   
   
   
   
   
}