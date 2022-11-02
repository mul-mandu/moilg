package com.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/includes/*")
@Log4j
public class CommonController {

	
	@Autowired MemberService service;
	
	
	//로그인 폼 요청(처리는 시큐리티가)
	@GetMapping("header")
	public void login(String error, HttpServletRequest request) {
		
		log.info("******************************** login 요청");
		log.info("************************** error : " + error);
		
		//접근 제한 때문에 로그인 폼으로 강제 이동되었다면 직전 url뽑아서 session 임시저장 
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", referer);
		
	}
	
	

}
