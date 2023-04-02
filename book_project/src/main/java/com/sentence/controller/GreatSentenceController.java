package com.sentence.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.AuthenticatedPrincipal;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.member.domain.MemberVO;
import com.member.domain.OneBookListVO;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;
import com.sentence.domain.GreatCriteria;
import com.sentence.domain.GreatePageDTO;
import com.sentence.domain.SentenceVO;
import com.sentence.service.GreatService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/gSentence/*")
@Log4j
public class GreatSentenceController {

	@Autowired
	private GreatService greatService;
	@Autowired
	private MemberService service;
	
	
	//인생문장 페이지 호출 
	@GetMapping("greatSentence")
	public void getAllSentence(SentenceVO sentence, Model model,  Authentication auth, GreatCriteria cri) {
		log.info("************************* 로그인 했는지 안했는지 체크");
		if(auth == null) {
			log.info("************************* 로그인 안함");
		} else {
			log.info("************************* 로그인 함");
			String id = ((CustomUser)auth.getPrincipal()).getUsername();
			log.info("************************* 로그인 함 ID는 : " + id);
			
			// 로그인 했으면 회원의 좋아요한 목록 불러오기
			List<Integer> likeNumList = greatService.getGreatListNum(id);
			model.addAttribute("memLikeList", likeNumList);
			log.info("좋아요한 목록!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11" + likeNumList);
		}
		
		// 로그인 여부 상관없이 전체 글목록 가져오기 
		log.info("************************* 전체 목록 가져오기 호출됨!!* *");
		//model로 list jsp에뿌려줄 글 목록 전달
		log.info("cri는?????" + cri + "!!!!!!!!!!!!!!!!!");
		List<SentenceVO> list = greatService.getAllSentence(cri);
		log.info("리스트는?????" + list + "!!!!!!!!!!!!!!!!!");
		
		model.addAttribute("greatList", list);
		
		// 게시글 개수 가져오기
		int total = greatService.getTotal(cri);
		log.info("개시글 수는?????" + total + "!!!!!!!!!!!!!!!!!");
		model.addAttribute("pager", new GreatePageDTO(cri, total));
		
		
		// 추천 수 상위 3개만 따로 쏴주기
		List<SentenceVO> topList = greatService.getTopSentence();
		model.addAttribute("topGreat", topList);

	}
	
	
	//인생문장 작성폼 
	@PreAuthorize("isAuthenticated()") //로그인한 사용자만 접근 가능하도록
	@GetMapping("greatSentenceForm")
	public void greatSentenceForm() {
		log.info("인생문장 작성폼");
	}
	
	//인생문장처리
	@PostMapping("greatSentenceForm")
	public String greatSentencePro(SentenceVO sentence, MultipartHttpServletRequest request, Authentication auth, MemberVO member) {
		log.info("인생문장처리 컨트롤러 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ");
		String id = ((CustomUser)auth.getPrincipal()).getUsername();
	
		//String id= principal.getName();
		log.info("id :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: " + id);
		log.info(request.getFile("greatImgFile").isEmpty());
		int result = 0;
		
		if(request.getFile("greatImgFile").isEmpty()) { // 파일이 안넘어왔을때 
			// db에 인서트
			sentence.setId(id);
			sentence.setGreatImg("greatDefaultImg.jpg");
			result = greatService.addSentence(sentence);
		}else { // 파일이 넘어왔을때 
			log.info("*********** 업로드 요청 **********");
			if(request.getFile("greatImgFile") != null) {
			try {
			
				//전송한 파일 정보 꺼내기 
				MultipartFile mf= request.getFile("greatImgFile"); //getFile(name) : form에서 설정한 name명 작성
				log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
				log.info("*********** 파일사이즈 : " + mf.getSize() );
				log.info("*********** 파일 타입 : " + mf.getContentType() );
				
				
				//파일 저장 경로 
				String path = "/var/lib/tomcat9/webapps/save"; // 서버상의 save 폴더 위치
				//String path = request.getRealPath("/resources/save"); // 로컬 save 폴더
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
				String  imgPath = (path + "/" + newFilename);
				log.info("************imgPath: " + imgPath );
				
				log.info("제발 저장좀 해주면 안되겠니?????????????????????????????????????????");
				//파일 저장 
				File copyFile = new File(imgPath);
				mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
				log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			
				// DB에 정보 저장 VO 던져주고 
				sentence.setGreatImg(newFilename);
				sentence.setId(id);
				log.info("sentece~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + sentence);
				
			}catch(IOException e) {
				e.printStackTrace();
			}
			}
			// db에 인서트
			result = greatService.addSentence(sentence);
		}
		
		return "redirect:/gSentence/greatSentenceAddFin";
	}
	
	
	@GetMapping("greatSentenceAddFin")
	public void greatSentenceAddFin() {
		log.info("완료");
		
	}

	
	
	// 인생문장 수정페이지 호출
	@GetMapping("greatSentenceModify")
	public void greatSentenceModify(int great_no, Model model) {
		log.info("인생문장 수정페이지 호출!!!!!");
		log.info("great_no 가져온거 : " + great_no);
		model.addAttribute("great_no", great_no);
		
		SentenceVO oneSen = greatService.getOneGreat(great_no);
		model.addAttribute("great", oneSen);
	}
	
	
	@GetMapping("greatModifyFin")
	public void greatModifyFin() {
		log.info("수정 완료");
		
	}
	
	// 인생문장 수정 처리
	@PostMapping("greatSentenceModify")
	public String greatSentenceModify(SentenceVO sen, MultipartHttpServletRequest request, Authentication auth, MemberVO mem){
		log.info("인생문장 수정처리!!!!!!!!!");
		log.info("인생문장 가져온거 : " + sen);
		log.info("사진 : " + request);
		 CustomUser user = (CustomUser)auth.getPrincipal();
         String id = user.getUsername(); // 멤버 아이디 
         mem = service.getMember(id);
		
		int result = 0;
		// 이미지 들어왔는지 안들어왔는지 체크하기
		if(request.getFile("greatImgFile").isEmpty()) {
			log.info("파일 안넘어왔을때 체크중~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			log.info("파일 출력 " + request);
			sen.setGreatImg(sen.getGreatImg());
			log.info("setPackCover 완료 ~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			sen.setId(mem.getId());
			sen.setId(mem.getNickName());
			result = greatService.modifyGreat(sen);
		}else {  // 파일이 넘어왔을 때 
			 log.info("파일 넘어왔을때 ~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			  log.info("*********** 파일 수정 업로드 요청 **********");
			  if(request.getFile("greatImgFile") != null) {
				  try {
					  // 전송할 파일 정보 꺼내기
					  MultipartFile mf= request.getFile("greatImgFile"); //getFile(name) : form에서 설정한 name명 작성
	                     log.info("*********** 원본이름 : " + mf.getOriginalFilename() );
	                     log.info("*********** 파일사이즈 : " + mf.getSize() );
	                     log.info("*********** 파일 타입 : " + mf.getContentType() );
	                     
	                     
	                     //파일 저장 경로 
	                     String path = "/var/lib/tomcat9/webapps/save"; // tomcat 서버상의 save 폴더 위치
	                     //String path = request.getRealPath("/resources/save"); // 테스트용 local save 폴더 위치
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
	                     //String  imgPath = path + "\\" + newFilename;
	                    String  imgPath = path + "/" + newFilename;
	                     log.info("************imgPath: " + imgPath );
	                     
	                     log.info("패키지 저장");
	                     //파일 저장 
	                     File copyFile = new File(imgPath);
	                     mf.transferTo(copyFile); //이것만 썼을때 언핸들드 익셉션 나옴 = try-catch묶어  서버폴더에 이미지 파일자체 저장 시킴 
	                     log.info("파일저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	                     
		         		 sen.setId(mem.getId());
		        		 sen.setId(mem.getNickName());
	                     sen.setGreatImg(newFilename);
	                     
				  }catch (IOException e) {
					  e.printStackTrace();
				}
			  }
			  result = greatService.modifyGreat(sen);
		}
		
		
		return "redirect:/gSentence/greatModifyFin";
	}

	
	// 인생문장 삭제 요청 (상태값 -1로 변경)
	@PostMapping(value="greatDelete", consumes = "application/json"
	         ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> greatDelete(@RequestBody int great_no){
	      log.info("*********** 삭제 요청된  great_no : " + great_no);
	      int result = greatService.deleteGreat(great_no); 
	      log.info("deleteGreat result!!!!!!! : " + result);
	      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
	            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	
	
	// 인생문장 좋아요 요청 likeGreat
	@PostMapping(value="likeGreat", consumes = "application/json"
	         ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> likeGreat(@RequestBody int great_no, Authentication auth){
	      log.info("*********** 좋아요 요청  great_no : " + great_no);
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      String id = user.getUsername(); // 멤버 아이디 
	      
	      // 인생문장에 해당 테이블 count +1
	      int countResult = greatService.greatAddCount(great_no);
	      log.info("countResult result!!!!!!! : " + countResult);
	      
	      // 좋아요 테이블에 추가
	      int result = greatService.likeGreat(great_no, id); 
	      log.info("likeGreat result!!!!!!! : " + result);
	      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
	            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	
	
	
	// 인생문장 좋아요 취소 요청 cancleLikeGreat
	@PostMapping(value="cancleLikeGreat", consumes = "application/json"
	         ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> cancleLikeGreat(@RequestBody int great_no, Authentication auth){
	      log.info("*********** 좋아요 취소 요청  great_no : " + great_no);
	      CustomUser user = (CustomUser)auth.getPrincipal();
	      String id = user.getUsername(); // 멤버 아이디 
	      
	      // 인생문장에 해당 테이블 count -1
	      int countResult = greatService.greatMinusCount(great_no);
	      log.info("countResult result!!!!!!! : " + countResult);
	      
	      // 좋아요 테이블에 삭제
	      int result = greatService.likeCancleGreat(great_no, id); 
	      log.info("likeGreat result!!!!!!! : " + result);
	      return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
	            : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
	   }
	
	
	
	// 인생문장 좋아요 카운트 가져오기
	@GetMapping(value="getCount/{great_no}", consumes = "application/json"
	         ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<Integer> getCount(@PathVariable("great_no") int great_no){
		log.info("인생문장 카운트 가져오기 요청!!!");
		Integer result = Integer.valueOf(greatService.getCount(great_no));
		 return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	
}
