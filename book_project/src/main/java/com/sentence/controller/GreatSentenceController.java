package com.sentence.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.AuthenticatedPrincipal;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.member.domain.MemberVO;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;
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
	
	//인생문장 목록 가져오기 
	@GetMapping("greatSentence")
	public void getAllSentence(SentenceVO sentence, Model model,  Authentication auth) {
		//String id = ((CustomUser)auth.getPrincipal()).getUsername();
		
		log.info("************************* 전체 목록 가져오기 호출됨!!* *");
		//model로 list jsp에뿌려줄 글 목록 전달
		List<SentenceVO> list = greatService.getAllSentence(sentence);
		log.info("리스트는?????" + list + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
		model.addAttribute("greatList", list);
		
		
		
	}
	
	

}
