package com.member.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginFailHandler extends SimpleUrlAuthenticationFailureHandler {

    @Override
    //httpServletRequest -> request 에 대한 정보 , httpServletResponse -> response 에 대해 설정할 수 있는 변수
    //AuthenticationException e -> 로그인 실패 시 예외에 대한 정보를 담고 있음.
    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        log.info("login fail handler");
        log.info("eeeeeeeeeeeeeeeeeeeeeeee" + e);
        String errorMessage;
        
        if (e instanceof BadCredentialsException){
            errorMessage="1"; //"아이디 또는 비밀번호가 맞지 않습니다.";
        }else if (e instanceof UsernameNotFoundException || e instanceof InternalAuthenticationServiceException){
            errorMessage="2"; //"존재하지 않는 아이디 입니다.";
        }
        else{
            errorMessage="3"; //"알 수 없는 이유로 로그인이 안되고 있습니다.";
        }

        //errorMessage= URLEncoder.encode(errorMessage,"UTF-8");//한글 인코딩 깨지는 문제 방지
        setDefaultFailureUrl("/main/main?error=" + errorMessage);
        super.onAuthenticationFailure(httpServletRequest,httpServletResponse,e);
    
    }
	

}
