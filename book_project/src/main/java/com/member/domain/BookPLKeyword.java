package com.member.domain;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
public class BookPLKeyword {
	
	private int list_no;
	private int keyword_no;
	
	
}
