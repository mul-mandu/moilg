package com.member.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
			
		log.info("************************************************ logout handler 동작~~~~~~~~~~~~~~~~~~~~~~");
		
		//보던 페이지로 돌아가는 처리 (loginSeuccessHandler 와 동일)
		//로그아웃 처리 성공 후 보던 곳으로 가기 위한 처리 
		
		/*보던 페이지에서 바로 로그아웃 되는 효과
			-> request header에 담긴 referer 정보는 이전에 내가 보고 있던 페이지의 주소값을 저장해준다.
			-> 그렇기 때문에 referer값으로 sendredirect를 해주면 로그아웃 처리후 보고 있던 페이지로 가는 효과를 줄수 있다!! 
		*/
		response.sendRedirect(request.getHeader("referer"));
			
		
		
				
	}
	

	
}
