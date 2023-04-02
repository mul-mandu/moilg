package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bookBoard.domain.keywordVO;
import com.member.domain.BookListVO;
import com.member.domain.BookPLKeyword;
import com.member.domain.MemberVO;
import com.member.domain.OneBookListVO;
import com.member.domain.ScrapRDListVO;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/memData/*")
@Log4j
public class MemDataController {
   
   @Autowired
   private MemberService service;
   

   @GetMapping("bookPlistDetail")
   public void bookPlistDetail(int list_no, Model model) {
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
      
      //북플리 상세페이지 
      log.info("북 플레이리스트 상세페이지 호출");
      log.info("list_no 가져온거 : " + list_no);
      model.addAttribute("listNum", list_no);
      
      BookListVO onevo = service.getOneBookList(list_no);
      MemberVO pLMakeMember = service.getMember(onevo.getId());
      String plMKNickName = pLMakeMember.getNickName();
      
      
      model.addAttribute("plMKNickName",plMKNickName);
      model.addAttribute("oneBookPL",onevo);
      
      
      // 북플리 해당하는 책 리스트 가져오기
      model.addAttribute("booksList",service.getPLBooksList(list_no));
      
      
      // 북플리에 해당하는 키워드 가져오기
      List<Integer> keyWordNumList = service.getPLKeyword(list_no);
      
      // 가져온 list를 키워드VO로 가져오기
      List<keywordVO> keywordList = new ArrayList<keywordVO>();
      for(int i=0; i<keyWordNumList.size(); i++) {
         int keynum = (int)keyWordNumList.get(i);
         keywordList.add(service.getKeywordVOList(keynum));
      }
      
      model.addAttribute("keywordList",keywordList);
   }
   
   
   // 플레이 리스트 생성 폼 요청
   @GetMapping("bookPlistMakeForm")
   public void bookPlistMakeForm(MemberVO member,Authentication auth, Model model) {
      // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
         CustomUser user = (CustomUser)auth.getPrincipal();
         log.info("****************user : " + user );
         member = service.getMember(user.getUsername()); //principal.userName 
         model.addAttribute("member" , member); 
      
      log.info("북 플레이리스트 상세페이지 호출");
   }
   
   
   // 플레이 리스트 생성 요청
   @PostMapping(value="addBookList", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> addBookList(@RequestBody BookListVO vo){
      log.info("*********** body에서 보낸 vo : " + vo);
      int result = service.addBookList(vo); 
      log.info("addBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
      // 북플리 패키지 저장
      @PostMapping(value="addBookListPack") 
      public ResponseEntity<String> addBookListPack(BookListVO pack, MultipartHttpServletRequest request, Authentication auth, MemberVO mem){
         log.info("******************패키지 처리 들어옴!!!"); 
         log.info("******************request" + request); 
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         mem = service.getMember(id); 
         String mbti = mem.getMbti(); // 멤버 MBTI 꺼내기

         int result = 0;
         
      
         if(request.getFile("packCoverFile").isEmpty()) {//파일 안넘어왔을때 //db에 인서트
            pack.setPackCover("packDefaultImg.jpg"); 
            pack.setId(id);
            pack.setMbti(mbti);
            result = service.addBookListPackage(pack);
         }else { // 파일이 넘어왔을때 
            log.info("*********** 업로드 요청 **********");
               if(request.getFile("packCoverFile") != null) {
                  try {
               
                  //전송한 파일 정보 꺼내기 
                  MultipartFile mf= request.getFile("packCoverFile"); //getFile(name) : form에서 설정한 name명 작성
                  log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
                  log.info("*********** 파일사이즈 : " + mf.getSize() );
                  log.info("*********** 파일 타입 : " + mf.getContentType() );
                  
                  
                  //파일 저장 경로 
                  String path = "/var/lib/tomcat9/webapps/save"; // 서버상의 save 폴더 위치
                  log.info("************save path : " + path);
                  //새 파일명 생성
                  String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase(); 
                  log.info("************uuid : " + uuid);
                  //업로드한 파일 확장자만 가져오기
                  String orgName = mf.getOriginalFilename();
                  String ext = orgName.substring(orgName.lastIndexOf(".")); //확장자명 subString으로 떼어오기
                  log.info("************확장자 : " + ext);
                  //저장할 파일명
                  String newFilename = uuid + ext; 
                  log.info("************최종저장할 이름 : " + newFilename );
                  //저장할 파일 전체 경로
                  String  imgPath = path + "/" + newFilename;
                  log.info("************imgPath: " + imgPath );
                  
                  log.info("패키지 제발 저장좀 해주면 안되겠니?????????????????????????????????????????");
                  //파일 저장 
                  File copyFile = new File(imgPath);
                  mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
                  log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
               
                  // DB에 정보 저장 VO 던져주고 
                  pack.setId(id);
                  pack.setMbti(mbti);
                  pack.setPackCover(newFilename);
                  log.info("pack~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + pack);
                  
               }catch(IOException e) {
                  e.printStackTrace();
               }//try
             }//if
            // db에 인서트
            result = service.addBookListPackage(pack);
         }//else 
         
         
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....", HttpStatus.INTERNAL_SERVER_ERROR);
         }
      
   
   
   
   // 북플리 패키지 수정
         @PostMapping(value="modifyBookListPack") 
         public ResponseEntity<String> modifyBookListPack(BookListVO pack, MultipartHttpServletRequest request, Authentication auth, MemberVO mem){
            log.info("******************패키지 수정처리 들어옴!!!"); 
            log.info("******************pack list_no" + pack.getList_no()); 
            log.info("******************pack list_no" + pack.getListStatus()); 
            CustomUser user = (CustomUser)auth.getPrincipal();
            String id = user.getUsername(); // 멤버 아이디 
            mem = service.getMember(id);
            String mbti = mem.getMbti(); // 멤버 MBTI 꺼내기
            int result = 0;
            log.info("팩커버 get 해보기!!!!!!!!!!!!!!!!!!!!" + pack.getPackCover());
            
             log.info("request 체크 !!!!!!!!!!!!!!!!!!!!" + request);

               if(request.getFile("packCoverFile") == null) {//파일 안넘어왔을때 //db에 인서트
                  log.info("파일 안넘어왔을때 체크중~~~~~~~~~~~~~~~~~~~~~~~~~~~");
               //pack.setPackCover("packDefaultImg.jpg"); 
                  pack.setPackCover(pack.getPackCover());
                  log.info("setPackCover 완료 ~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                  pack.setId(id);
                  pack.setMbti(mbti);
                  result = service.modifyBookListPackage(pack);
            }else { // 파일이 넘어왔을때 
               log.info("*********** 파일 수정 업로드 요청 **********");
               if(request.getFile("packCoverFile") != null) {
                  try {
                     
                     //전송한 파일 정보 꺼내기 
                     MultipartFile mf= request.getFile("packCoverFile"); //getFile(name) : form에서 설정한 name명 작성
                     log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
                     log.info("*********** 파일사이즈 : " + mf.getSize() );
                     log.info("*********** 파일 타입 : " + mf.getContentType() );
                     
                     
                     //파일 저장 경로 
                     String path = "/var/lib/tomcat9/webapps/save"; // 서버상의 save 폴더 위치
                     //String path = request.getRealPath("/resources/save");
                     log.info("************save path : " + path);
                     //새 파일명 생성
                     String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase(); 
                     log.info("************uuid : " + uuid);
                     //업로드한 파일 확장자만 가져오기
                     String orgName = mf.getOriginalFilename();
                     String ext = orgName.substring(orgName.lastIndexOf(".")); //확장자명 subString으로 떼어오기
                     log.info("************확장자 : " + ext);
                     //저장할 파일명
                     String newFilename = uuid + ext; 
                     log.info("************최종저장할 이름 : " + newFilename );
                     //저장할 파일 전체 경로
                     String  imgPath = path + "/" + newFilename;
                     //String  imgPath = path + "\\" + newFilename;
                     log.info("************imgPath: " + imgPath );
                     
                     log.info("패키지 제발 저장좀 해주면 안되겠니?????????????????????????????????????????");
                     //파일 저장 
                     File copyFile = new File(imgPath);
                     mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
                     log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                     
                     // DB에 정보 저장 VO 던져주고 
                     pack.setId(id);
                     pack.setMbti(mbti);
                     pack.setPackCover(newFilename);
                     log.info("pack~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + pack);
                     
                  }catch(IOException e) {
                     e.printStackTrace();
                  }//try
               }//if
               // db에 인서트
               result = service.modifyBookListPackage(pack);
            }//else 
            
            
            return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
                  : new ResponseEntity<String>("fail....", HttpStatus.INTERNAL_SERVER_ERROR);
         }
         
      
      
      
      
      
   
   
   
   
   //하나의 플레이 리스트 생성 
   @PostMapping(value="AddOneBookList", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> AddOneBookList(@RequestBody List<OneBookListVO> bookList){
      log.info("*********** AddOneBookList 들어옴!!!!!!!! ");
      log.info("*********** 가져온 bookList : " + bookList);
   
      int result = 0;
      for(int i=0 ; i<bookList.size() ; i++) {
         result = service.addOneBookList(bookList.get(i));
      }
      
      log.info("AddOneBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   // 플레이 리스트에 키워드 추가!!!!
   @PostMapping(value="addPLKeyWord", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> AddPLKeyWord(@RequestBody List<String> keyWordList){
      log.info("*********** 플리에 키워드 추가 들어옴!!!!!!!! ");
      log.info("*********** 가져온 keyWordList : " + keyWordList);
      
      int result = 0;
      for(int i=0 ; i<keyWordList.size() ; i++) {
         String keyword = keyWordList.get(i);
         int keyword_no = Integer.parseInt(keyword);
         log.info("*********** 형변환한 키워드 : " + keyword_no);
         result = service.addPLKeyWord(keyword_no);
      }
      log.info("AddOneBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   // 수정 페이지 호출!!!
   @GetMapping("bookPLDetailModify")
   public void bookPLDetailModify(int list_no, Model model) {
      log.info("북 플레이리스트 수정 페이지 호출");
      log.info("list_no 가져온거 : " + list_no);
      model.addAttribute("listNum", list_no);
      
      BookListVO onevo = service.getOneBookList(list_no);// 책정보 가져오기 
      MemberVO pLMakeMember = service.getMember(onevo.getId()); // 회원정보가져오고 
      String plMKNickName = pLMakeMember.getNickName(); // 닉네임 꺼내기 
      
      
      model.addAttribute("plMKNickName",plMKNickName);
      model.addAttribute("oneBookPL",onevo);
      
   }
   
   
   // 수정 페이지에 뿌려줄 keyword get 함수 호출
   @GetMapping("getKeyListForModif")
   public ResponseEntity<List<keywordVO>> getKeyListForModif(int list_no) {
      log.info("키워드 리스트 ajax 호출");
      log.info("list_no 가져온거 : " + list_no);
      
      
      // 북플리에 해당하는 키워드 가져오기
      List<Integer> keyWordNumList = service.getPLKeyword(list_no);
      
      // 가져온 list를 키워드VO로 가져오기
      List<keywordVO> keywordList = new ArrayList<keywordVO>();

      for(int i=0; i<keyWordNumList.size(); i++) {
         int keynum = (int)keyWordNumList.get(i);
         log.info("키워드 VO로 가져오기 " + keynum);
         keywordList.add(service.getKeywordVOList(keynum));
         log.info("add한 keywordList " + keywordList);
      }
      log.info("최종 add한 keywordList " + keywordList);
      log.info("********** for 문 끝!!! ***********");
      //model.addAttribute("keyList",keywordList);

      
      return new ResponseEntity<List<keywordVO>>(keywordList, HttpStatus.OK); 
      
   }
   
   
   
   // 수정 페이지에 뿌려줄 booklist get 함수 호출
   @GetMapping("getBookListForModif")
   public ResponseEntity<List<OneBookListVO>> getBookListForModif(int list_no) {
      log.info("책 리스트 ajax 호출");
      log.info("list_no 가져온거 : " + list_no);
      
      // 북플리 해당하는 책 리스트 가져오기
      List<OneBookListVO> onebookList = new ArrayList<OneBookListVO>();
      onebookList = service.getPLBooksList(list_no);

      
      return new ResponseEntity<List<OneBookListVO>>(onebookList, HttpStatus.OK); 
      
   }
   
   
   
   // 북플레이리스트 수정 처리 메서드
   @PostMapping(value="modifyBookList", consumes = "application/json"
   ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> modifyBookList(@RequestBody BookListVO vo){
      log.info("*********** body에서 보낸 vo : " + vo);
      int result = service.modifyBookList(vo); 
      log.info("modifyBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   
   
   
   
   
   
   
   // 북플레이리스트 책 목록 수정 처리 메서드
   @PostMapping(value="modifyOneBookList", consumes = "application/json"
   ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> modifyOneBookList(@RequestBody List<OneBookListVO> bookList){
      log.info("*********** modifyOneBookList 들어옴!!!!!!!! ");
      log.info("*********** 가져온 bookList : " + bookList);
   
      int result = 0;
      int listNum =  bookList.get(0).getList_no();
      
      // 삭제하고 
      int delResult = service.deleteOneBookList(listNum);
      log.info("*********** 북리스트 책 내역 삭제 result : " + delResult);
      
      
      // 새로 생성하기
      for(int i=0 ; i<bookList.size() ; i++) {
        log.info("*********** bookList for문 result : " + i+ "번째 "+bookList.get(i));
         result = service.ModifyOneBookList(bookList.get(i));
      }
      
      log.info("AddOneBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   
   
   // 북플레이리스트 키워드 수정 처리 메서드
   @PostMapping(value="modifyPLKeyWord", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> modifyPLKeyWord(@RequestBody List<BookPLKeyword> keyWordList){
      log.info("*********** 플리에 키워드 추가 들어옴!!!!!!!! ");
      log.info("*********** 가져온 keyWordList : " + keyWordList);
      
      int listNum = keyWordList.get(0).getList_no();
      
      int result = 0;
      // 삭제하고
      int delResult = service.deleteKeywordList(listNum);
      
      for(int i=0 ; i<keyWordList.size() ; i++) {
         result = service.modifyPLKeyWord(keyWordList.get(i));
      }
      log.info("AddOneBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   
   
   // 북플레이 리스트 삭제 메서드
   @PostMapping(value="deleteBookList", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> deleteBookList(@RequestBody int listNum){
      log.info("*********** 삭제 요청된  listNum : " + listNum);
      int result = service.deleteBookList(listNum); 
      log.info("deleteBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   
   
   
   // 북플레이 리스트 찜하기
   @PostMapping(value="scrapRDList", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> scrapRDList(@RequestBody ScrapRDListVO vo){
      log.info("*********** 추가요청된  listNum : " + vo);
      int result = service.addScrapRDList(vo);
      log.info("addScrapRDList result!!!!!!! : " + result);
      
      int addresult = service.addBPCount(vo.getList_no());
      log.info("addBPCount result!!!!!!! : " + addresult);
      
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   
   // 북플리 찜하기 해제
   @PostMapping(value="cancelScrapRDList", consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      public ResponseEntity<String> cancelScrapRDList(@RequestBody ScrapRDListVO vo){
         log.info("*********** 삭제요청된  listNum : " + vo);
         int result = service.cancelScrapRDList(vo); 
         log.info("addScrapRDList result!!!!!!! : " + result);
         
         int cancleResult = service.cancelBPCount(vo.getList_no());
         log.info("cancleResult result!!!!!!! : " + cancleResult);
         
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      }
   
   
   
   
   // 북리스트에 책 추가하기 
      @PostMapping(value="addSavePlBooks", consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      public ResponseEntity<String> addSavePlBooks(@RequestBody List<OneBookListVO> bookList){
         log.info("*********** addSavePlBooks 들어옴!!!!!!!! ");
         log.info("*********** 가져온 bookList : " + bookList);
      
         int result = 0;
         for(int i=0 ; i<bookList.size() ; i++) {
            result = service.addSavePlBooks(bookList.get(i));
         }
         
         log.info("AddOneBookList result!!!!!!! : " + result);
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      }
   
      
   // 모달에서 새 북플리 생성요청
   @PostMapping(value="newBookList", consumes = "application/json"
         ,produces = {MediaType.TEXT_PLAIN_VALUE})
   public ResponseEntity<String> newBookList(@RequestBody BookListVO vo){
      log.info("*********** view에서 보낸 vo : " + vo);
      vo.setPackCover("packDefaultImg.jpg");
      vo.setListStatus(1);
      int result = service.newBookList(vo); 
      log.info("addBookList result!!!!!!! : " + result);
      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
   }
      
   
 
   
}