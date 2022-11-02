package com.member.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		
		log.info("**************************login Success****************");
		
		List<String> roleNames = new ArrayList<String>();		
		//로그인한 사람의 권한 목록 얻어오기 
		authentication.getAuthorities().forEach(authority -> roleNames.add(authority.getAuthority()));
		log.info("*************ROLE NAMES 커스텀 로그인 석세스 핸들러요~~~: " + roleNames);
		log.info("*************ROLE NAMES 커스텀 로그인 석세스 핸들러요를레히히~~~: " + roleNames.get(0));
		
	
		if(roleNames.get(0).equals("ROLE_DELMEM")) {
			response.sendRedirect("/main/delMemLogout");
			return;
		}
		
		
		
		//만약에 로그인 폼으로 강제이동되어, 로그인 처리 성공 후 보던 곳으로 가기 위한 처리
		if(session != null) {
			String redirectURL = (String)session.getAttribute("prevPage");
			if(redirectURL != null) {
				session.removeAttribute("prevPage");
				response.sendRedirect(redirectURL);
			}else {
				response.sendRedirect("/main/main");
			}
		}else {
			response.sendRedirect("/main/main");
		}
		
		

	}//메서드 끝
	
	

}
