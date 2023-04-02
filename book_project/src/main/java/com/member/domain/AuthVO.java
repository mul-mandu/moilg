package com.member.domain;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Data;


@Data
public class AuthVO {
	
	private String id;
	private String auth;  //'ROLE_MEMBER' || 'ROLE_ADMIN'

}
