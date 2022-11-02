package com.member.service.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.member.domain.MemberVO;

import lombok.Getter;


@Getter
public class CustomUser extends User { //  == principal 

	private MemberVO member;

	//아래의 모든 변수들*username, password은 바꾸면 안됨. (스프링 시큐리티에서 쓰는 키워드라서)
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getId(), vo.getPw(), vo.getAuthList().stream()
			.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
			.collect(Collectors.toList())
				);
		this.member = vo; 
	}
	
	

}
