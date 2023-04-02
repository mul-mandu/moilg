package com.member.domain;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
public class MemberInterVO {

	private String id;
	private int keyword_no;
	private String keyCategory;
	
	
	
}
