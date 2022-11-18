package com.bookBoard.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.service.BookSearchService;
import com.member.domain.BookListVO;
import com.member.domain.OneBookListVO;
import com.member.service.MemberService;
import com.member.service.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/search/*")
@Log4j
public class BookSearchController {
   
   
	@Autowired
	private MemberService service;
   
	@Autowired
	private BookSearchService bookService;
   
   @GetMapping("titleSearch")
   public void titleSearch() {
      log.info("타이틀 서치!!");
   } 
   @GetMapping("bookKeywordSearch")
   public void bookKeywordSearch() {
      log.info("타이틀 서치!!");
   } 
   
    //책 상세페이지 
    @GetMapping("bookDetails")
    public void bookDetails(String isbn, Model model) {
       log.info("책 상세보기 페이지 요청!");
       log.info("isbn 가져온거 : " + isbn);
       model.addAttribute("abook", isbn);
       
       // 이 책이 포함된 플레이 리스트가 있으면 그것도 같이 가져오기
       List<Integer> bookList = service.getIncludBook(isbn);
       List<BookListVO> playList = new ArrayList<BookListVO>();
       if(bookList.size() != 0) {
          for(int i=0; i<bookList.size(); i++) {
             int listNum = (int)bookList.get(i);
             playList.add(service.getOneBookList(listNum));
          }
          model.addAttribute("bookPLlist", playList);
       }
       
       
       
       
    }
    
    
  //책 상세페이지 (댓글 처리하기)
    @PostMapping(value="bookDetails", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> bookDetails(@RequestBody ReplyBoardVO vo, Authentication auth){
    	log.info("*************** ajax로 받아서 채운 댓글 VO : " + vo);
    	int result;
    	CustomUser user = (CustomUser)auth.getPrincipal();
    	String id = user.getUsername();
    	log.info("댓글 아이디 1 :::::::::::::::::::::::::: " + id);
    	
    	vo.setId(id);
    	result = bookService.addReply(vo); 
    	log.info("댓글 저장 성공했으면 1 :::::::::::::::::::::::::: " + result);
    	
        return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
                : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    
    
    
    
    //책 상세페이지 (댓글 가져오기)
    @GetMapping(value="getReply/{isbn}", consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<List<ReplyBoardVO>> getReply(@PathVariable("isbn") String isbn){
    	log.info("*************** 댓글 가져오기 !! getReply isbn : " + isbn);
    	List<ReplyBoardVO> list = bookService.getReply(isbn);
    	
    	
    	return new ResponseEntity<List<ReplyBoardVO>>(list, HttpStatus.OK);
    }
    

    
    

}