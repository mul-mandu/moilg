package com.bookBoard.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookBoard.domain.ReplyBoardVO;
import com.bookBoard.domain.ReplyLikeVO;
import com.bookBoard.service.BookSearchService;
import com.member.domain.BookListVO;
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
   
	int replyTotalCount; //총 댓글 수 가져올 변수
	
	
   @GetMapping("titleSearch")
   public void titleSearch() {
      log.info("타이틀 서치!!");
   } 
   
   
   @GetMapping("bookPLSearch")
   public void bookPLSearch() {
      log.info("북플리 서치 !! ");
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
    	log.info("댓글 아이디 :::::::::::::::::::::::::: " + id);
    	
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
    	log.info("댓글 리스트!!! +++++ : "  + list);
    	
    	return new ResponseEntity<List<ReplyBoardVO>>(list, HttpStatus.OK);
    }
    
    
    //책 상세페이지 (//총 댓글 수 카운트 해오기)
    @GetMapping(value="getReplyCount/{isbn}", consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<Integer> getReplyCount(@PathVariable("isbn") String isbn){
    	log.info("*************** 댓글 가져오기 !! getReply isbn : " + isbn);
        replyTotalCount = bookService.getReTot(isbn);
    	log.info("댓글 카운트!!! +++++ : "  + replyTotalCount);
    	
    	
    	return new ResponseEntity<Integer>(replyTotalCount, HttpStatus.OK);
    }
    
    
    //책 상세페이지 (댓글 삭제하기)
    @PostMapping(value="deleteReply", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> deleteReply(@RequestBody ReplyBoardVO vo){
    	log.info("*************** ajax로 받아온 re_num: " + vo.getRe_no());
    	int result;
    	
    	result = bookService.delReply(vo.getRe_no()); 
    	log.info("댓글 삭제 성공했으면 1 :::::::::::::::::::::::::: " + result);
    	
        return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
                : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    

    //책 상세페이지 (댓글 수정 처리하기)
    @PostMapping(value="modifyReply", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modifyReply(@RequestBody ReplyBoardVO vo){
    	log.info("*************** ajax로 받아서 채운 댓글 VO : " + vo);
    	int result;

    	result = bookService.modiReply(vo); 
    	log.info("댓글 수정 성공했으면 1 :::::::::::::::::::::::::: " + result);
    	
        return result == 1 ? new ResponseEntity<String>("success!", HttpStatus.OK)
                : new ResponseEntity<String>("fail....",HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    //책 상세페이지 (댓글 좋아요 처리 + goodCount update)
    @PostMapping(value="likeReply", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> likeReply(@RequestBody ReplyLikeVO vo , Authentication auth){
    	log.info("*************** ajax로 받아서 채운 공감댓글 VO : " + vo);
    	
    	int result;
    	int countResult;
    	List<String> likeIdList =null;
    	int renum = vo.getRe_no(); //받아온 re_no값
    	log.info("받아온 re_no :::::::" + renum);
    	
    	CustomUser user = (CustomUser)auth.getPrincipal();
    	String id = user.getUsername();
    	log.info("댓글 공감한 아이디 :::::::::::::::::::::::::: " + id);

    	//re_no주고 id 목록 먼저 받아오기
    	likeIdList = bookService.getLikeId(renum);
    	log.info("좋아요 한 아이디 리스트 ::::::::::::::::::::::::::::" + likeIdList);

    	if(likeIdList.contains(id)) {
    		int delResult = bookService.delLikeReply(id); // id값주고 공감한 데이터 삭제하기
    		log.info("공감 댓글 삭제 성공했으면 1 :::::::::::::::::::::" + delResult);
    		//카운트 -1하기
    		int delCountResult = bookService.delGoodCount(renum);
    		log.info("댓글 공감 카운트 빼기 성공했으면 1 ::::::::::::::::::::::::" + delCountResult);
    		result = 0;
    		
    	}else {
    		vo.setId(id);
    		result = bookService.likeAddReply(vo); 
    		log.info("댓글 공감 등록 성공했으면 1 :::::::::::::::::::::::::: " + result);
    		log.info("댓글 공감 등록 성공시 vo 내용 :::::::::::::::::::::::::: " + vo);
    		//카운트 +1 하기 
    		countResult = bookService.modifyGoodCount(renum);
    		log.info("댓글 공감 카운트 더하기 성공했으면 1 :::::::::::::::::::::::::: " + countResult);
    	}
    	
    	return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
                : new ResponseEntity<String>("minus",HttpStatus.OK);
    }
    
    
    // 키워드 검색에서 선택한 키워드가 포함된 북플리 가져오기
	@GetMapping(value="getIncludeKey/{keyword_val}")
	public ResponseEntity<List<BookListVO>> getIncludeKey(@PathVariable("keyword_val") int keyword_val){
		log.info("키워드 검색 북플리 가져오기 메서드!!");
		List<BookListVO> result = bookService.getKeyPLlist(keyword_val);
		 return new ResponseEntity<List<BookListVO>>(result, HttpStatus.OK);
	}
    
	
    // 키워드 검색에서 선택한 키워드가 포함된 북플리 가져오기 
	@GetMapping(value="searchBookPL/{search}")
	public ResponseEntity<List<BookListVO>> searchBookPL(@PathVariable("search") String search){
		
		log.info("검색한 북플리 가져오기 메서드!!");
		
		List<BookListVO> result = bookService.getSearchBPLlist(search);
		 return new ResponseEntity<List<BookListVO>>(result, HttpStatus.OK);
	}
	
	
    
}