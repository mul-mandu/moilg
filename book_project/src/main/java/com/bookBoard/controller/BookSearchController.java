package com.bookBoard.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.member.domain.BookListVO;
import com.member.domain.OneBookListVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

// 주석
// 주석2
@Controller
@RequestMapping("/search/*")
@Log4j
public class BookSearchController {
   
   
   @Autowired
      private MemberService service;
   
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
    
    
    @GetMapping("test")
    public void test() {
       log.info("마이페이지 호출");
    }

}