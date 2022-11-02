package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.member.domain.MemberVO;
import com.member.service.MailSendService;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;
import com.mypage.controller.MypageController;

import lombok.extern.log4j.Log4j;
@Controller
@RequestMapping("/signup/*")
@Log4j
public class SignupController {
   @Autowired
   private MemberService service;
   
   @Autowired
   private MailSendService mailService;
   
   @Autowired
   private MypageController mypageController;
   
   
   
   @GetMapping("signup")
   public void signup() {
      log.info("signup맵핑 호출"); 
   }
   
   // 회원가입 로직처리
   @PostMapping("signup")
   public String signupPro(MemberVO member, String au, RedirectAttributes rttr, Model model, Authentication auth, HttpServletRequest request) {
      log.info("************************************** " + "signupPro 요청~~~");   
      log.info("*** memberVO " + member);
      
      int result = service.addMember(member); //회원추가
      service.addAuth(au, member.getId()); //권한추가 
      
      
      if(result == 1) {
        System.out.println("11111" + member.getNickName());
        
         rttr.addFlashAttribute("nickname", member.getNickName()); // flash로 보내기  -> ${nickname} 으로 꺼내기 (데이터 숨겨서 넘어감) 
         //rttr.addAttribute("nickname", member.getNickName());  // singupComplete?nickname=값 --> ${param.nickname}
         
         
         String id = member.getId();
         log.info("************************************************회원가입한 멤버 ID: " + id);
         String pw = member.getPw();
         log.info("************************************************회원가입한 멤버 Pw: " + pw);
         
         service.autoLogin(id);
         
         /*
         try {
         request.login(id, bCryptPasswordEncoder.encode(pw)); 
        }catch(ServletException e) {
            e.printStackTrace();
            log.error("자동으로 로그인하기 에러 : " + e.getMessage() );
            
         }finally {
            
         }
        */
         
      }
   
       return "redirect:/signup/signupComplete";
   }

   
   
      
      //회원가입 완료 페이지
      @GetMapping("signupComplete")
      public void signupComplete(Authentication auth){
         log.info("회원가입 완료 호출");
         log.info(auth);
         
      }

      
      
      //회원가입 관심사 설정 페이지
      @GetMapping("signupInter")
      public void signupInter(Authentication auth){
         log.info("관심사 설정 페이지 호출!!!");
         log.info(auth);
      }
      
      
      
      //회원가입 관심사 설청 처리 요청
      @PostMapping(value="signupInterPro", consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      public ResponseEntity<String> signupInterPro(@RequestBody List<String> interList, Authentication auth) {
         log.info("********************************************* + signupInter 처리  요청!!!!!!!!");
         log.info("********************************************* + 가져온 inter : " + interList);
         
         // Authentication 매개변수 선언하면 principal등 정보 꺼낼 수 있다.
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername();
         log.info("멤버 아뒤: " + id);
         
         int result = 0;
         for(int i = 0; i < interList.size(); i++) {
            String internum = interList.get(i);
            int keyword_no = Integer.parseInt(internum);
            log.info("*********int 형변환 키워드 넘버 : " + keyword_no);
            
            result = service.addInter(keyword_no, id);
         }
         
         log.info("관심사 등록 result!!!! (성공시 1) : " + result );
         
         
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
      }
      
      
   

      
      
      //관심사 설정 완료 페이지 ==> 이거 나중에 지우고 로직처리 끝나면 redirect로 페이지 넘기기
      @GetMapping("signupInterComplete")
      public void signupInterComplete(){
         log.info("관심사 설정 완료");
      }
      
      
      
      //mbti 검사후 멤버 데이터에 mbti 결과 등록하기
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
         result = service.updateMbti(member);
         log.info("mbti 등록됐니????? 됐으면 1이라고 해: " + result);
         
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
         
      }
      
      
    //내 프로필 업데이트 하기
      @PostMapping(value="updateProfile") 
      public ResponseEntity<String> updateProfile( MultipartHttpServletRequest request, Authentication auth, MemberVO mem){
         log.info("******************내 프로필 수정처리 들어옴!!!"); 
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         log.info("수정처리 ID + "  + id);
         int result = 0;
         
         // 파일이 넘어왔을때 
            log.info("*********** 업로드 요청 **********");
            if(request.getFile("profile") != null) {
               try {
                  //전송한 파일 정보 꺼내기 
                  MultipartFile mf= request.getFile("profile"); //getFile(name) : form에서 설정한 name명 작성
                  log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
                  log.info("*********** 파일사이즈 : " + mf.getSize() );
                  log.info("*********** 파일 타입 : " + mf.getContentType() );
                  
                  
                  //파일 저장 경로 
                  String path = request.getRealPath("/resources/save"); // 서버상의 save 폴더 위치
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
                  String  imgPath = path + "\\" + newFilename;
                  log.info("************imgPath: " + imgPath );
                  
                  log.info("패키지 제발 저장좀 해주면 안되겠니?????????????????????????????????????????");
                  //파일 저장 
                  File copyFile = new File(imgPath);
                  mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
                  log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  
                  // DB에 정보 저장 VO 던져주고 
                  mem.setId(id);
                  mem.setPhoto(newFilename);
                  log.info("mem~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + mem);
                  
               }catch(IOException e) {
                  e.printStackTrace();
               }//try
            }//if
            // db에 인서트
            result = service.modifyMyProfile(mem);
            mypageController.renewalAuth();
            
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....", HttpStatus.INTERNAL_SERVER_ERROR);
      }
      
      
      
      //내 프로필 업데이트 하기
      @PostMapping(value="updateBackground") 
      public ResponseEntity<String> updateBackground( MultipartHttpServletRequest request, Authentication auth, MemberVO mem){
         log.info("******************내 프로필 수정처리 들어옴!!!"); 
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         log.info("수정처리 ID + "  + id);
         int result = 0;
         
         // 파일이 넘어왔을때 
         log.info("*********** 업로드 요청 **********");
         if(request.getFile("bgFile") != null) {
            try {
               //전송한 파일 정보 꺼내기 
               MultipartFile mf= request.getFile("bgFile"); //getFile(name) : form에서 설정한 name명 작성
               log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
               log.info("*********** 파일사이즈 : " + mf.getSize() );
               log.info("*********** 파일 타입 : " + mf.getContentType() );
               
               
               //파일 저장 경로 
               String path = request.getRealPath("/resources/save"); // 서버상의 save 폴더 위치
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
               String  imgPath = path + "\\" + newFilename;
               log.info("************imgPath: " + imgPath );
               
               log.info("패키지 제발 저장좀 해주면 안되겠니?????????????????????????????????????????");
               //파일 저장 
               File copyFile = new File(imgPath);
               mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
               log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
               
               // DB에 정보 저장 VO 던져주고 
               mem.setId(id);
               mem.setBgImg(newFilename);
               log.info("mem~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + mem);
               
            }catch(IOException e) {
               e.printStackTrace();
            }//try
         }//if
         // db에 인서트
         result = service.modifyMyBgImg(mem);
         
         
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
               : new ResponseEntity<String>("fail....", HttpStatus.INTERNAL_SERVER_ERROR);
      }
      
      
      
      // ID 찾기 페이지 요청
      @GetMapping("idFind")
      public void idFind() {
         log.info("아이디 찾기 페이지 요청!!!");
      }
      
      
      // ID 찾기 처리
      @PostMapping("idFind")
      public String idFindRequest(MemberVO vo, Model model){
         
         // id 찾기
         String findId = service.findId(vo);
         
         if(findId == null) { 
           model.addAttribute("check", 1);
        } else { 
           model.addAttribute("check", 0);
           model.addAttribute("id", findId);
        }
        
        return "/signup/idFind";
       
      }
     
      
      
      
      // 비밀번호 찾기 페이지 요청
      @GetMapping("pwFind")
      public void pwFind() {
         log.info("비밀번호 찾기 페이지 요청!!!");
      }
      
      
      
//      // 비밀번호 찾기 처리
//      @PostMapping("pwFind")
//      public String pwFindRequest(MemberVO vo, Model model) {
//         
//         // pw 찾기
//         String findPw = service.findPw(vo);
//         
//         if(findPw == null) { 
//             model.addAttribute("check", 1);
//          } else { 
//             model.addAttribute("check", 0);
//             model.addAttribute("pw", findPw);
//          }
//         
//         return "/signup/pwFind";
//      }
      
      
      
      //메일 인증번호 보내기
      @PostMapping(value="pwFind", consumes = "application/json"
            ,produces = {MediaType.TEXT_PLAIN_VALUE})
      @ResponseBody
      public String pwFind(@RequestBody MemberVO member){
         int result = 0;
         log.info("이메일 인증 요청!!!!!!"); 
         log.info("가져온 이메일 : " + member.getEmail());
         String memEmail = member.getEmail();
         
         return mailService.joinEmail(memEmail);
  
      }
      
      
      
      // 비밀번호 찾기 페이지 요청
      @GetMapping("pwChange")
      public void pwChange() {
         log.info("비밀번호 재설정 페이지 요청!!!");
      }
      
     
      
      
      
      // 아이디 중복 확인
      @PostMapping("idAvail")
        public ResponseEntity<String> idAvail(MemberVO vo) {
        int result = service.idCheck(vo);
        log.info("result : " + result);
        // resutl == 1 => 이미존재한
        // rssult == 0 => 사용가능한 아이디
        String data = null;   // jsp ajax success 함수 매개변수에 전달할 결과 변수
        if(result ==1) {
           data ="이미 사용중인 ID 입니다.";
        }else {
           data ="사용 가능한 ID 입니다.";
        }
        
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/plain;charset=UTF-8");
        
        return new ResponseEntity<String>(data, headers, HttpStatus.OK);
        // HttpStatus.OK : 응답할 때 보여줄 상태코드 
        
     }
      
     
      // 회원 정보수정(비번만)
      @PostMapping("memberPwModify")
      public ResponseEntity<String> memberPwModify(@RequestBody MemberVO vo) {
         log.info("패스워드 수정 요청!!!");
         log.info("요청된 정보 : " + vo);
         
         int result = service.memberPwModify(vo);
         return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
                 : new ResponseEntity<String>("fail....", HttpStatus.INTERNAL_SERVER_ERROR);
      }
      
      
     
      
     // 비밀번호 확인
     @PostMapping("pwCheck")
     public ResponseEntity<Integer> pwCheck(MemberVO member, Authentication auth, Model model) {
        log.info("비밀번호 체크 메서드 실행!!!!");

         int result = service.pwCheck(member);
         
         log.info("서비스에서 받은 result : " + result);
         
         return new ResponseEntity<Integer>(result, HttpStatus.OK);
              
        
     }
    
     
     
     // 닉네임 중복처리
     // 아이디 중복 확인
     @PostMapping("nickNameAvail")
       public ResponseEntity<String> nickNameAvail(MemberVO vo) {
       int result = service.nickNameCheck(vo);
       log.info("result : " + result);
       // resutl == 1 => 이미존재한
       // rssult == 0 => 사용가능한 아이디
       String data = null;   // jsp ajax success 함수 매개변수에 전달할 결과 변수
       if(result ==1) {
          data ="이미 사용중인 닉네임 입니다.";
       }else {
          data ="사용 가능한 닉네임 입니다.";
       }
       
       HttpHeaders headers = new HttpHeaders();
       headers.add("Content-Type", "text/plain;charset=UTF-8");
       
       return new ResponseEntity<String>(data, headers, HttpStatus.OK);
       // HttpStatus.OK : 응답할 때 보여줄 상태코드 
       
    }
     
     
     // 회원 정보수정
     @PostMapping("memberModify")
     public String memberModify(MemberVO vo, Authentication auth, Model model, RedirectAttributes rttr) {
        log.info("회원정보 수정 요청!!!");
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         vo.setId(id);
        log.info("요청된 정보 : " + vo);
        
        int result = service.memberModify(vo);
        mypageController.renewalAuth();
        //model.addAttribute("modifyresult", result);  
        rttr.addFlashAttribute("modifyresult" , result);
        
        return "redirect:/mypage/memMypage";
     }
     
     
     
     // 회원 탈퇴 요청
     @PostMapping("deleteMember")
     public ResponseEntity<Integer> deleteMember(MemberVO member, Authentication auth, Model model) {
        log.info("회원 탈퇴 요청!!!");
         CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         
         int result = service.deleteMember(id);
         log.info("회원 상태값 변경하고 돌아옴");
         log.info("서비스에서 받은 result : " + result);
         
         result += service.updateDelMemAuth(id);
         log.info("회원 권한 변경하고 돌아옴");
         log.info("서비스에서 받은 result (2면 권한까지 변경 완료) : " + result);
         
         
         return new ResponseEntity<Integer>(result, HttpStatus.OK);
              
        
     }
    
     
     
     
     
     
     
     
     
     
     
     
  
   
}