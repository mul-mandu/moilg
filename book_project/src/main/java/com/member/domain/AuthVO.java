package com.member.domain;

import lombok.Data;

@Data
public class AuthVO {
	
	private String id;
	private String auth;  //'ROLE_MEMBER' || 'ROLE_ADMIN'

}