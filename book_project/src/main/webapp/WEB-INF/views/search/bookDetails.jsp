<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

   <%-- header 복붙 --%>
   <%@ include file="../includes/header.jsp" %>

   <script>
  
   
   var bookinfo;
   var title;        // 제목
   var cover;         // 커버
   var author;      // 작가
   var toc;   // 목차
   var desc;   // 책 소개
   var category; // 카테고리
   var ebook;  // ebook 링크
   var buylink;      // 책 구매 링크
   var authorName;      // 작가이름


    function bookData(success, data){
         //console.log("data넘어옴");
         //console.log(success);
         
         //console.log(data);
         //console.log("data : " +data.item[0].subInfo.bestSellerRank);


             bookinfo =data.item[0].bookinfo;
             title=data.item[0]["title"];        // 제목
             cover=data.item[0].cover;         // 커버
             author=data.item[0]["author"];      // 작가
             toc = data.item[0].bookinfo.toc;   // 목차
             desc = data.item[0].description;   // 책 소개
             category = data.item[0].categoryName; // 카테고리
             ebook = "no";
             
             if((data.item[0].bookinfo.ebookList).length != 0){
                ebook = data.item[0].bookinfo.ebookList[0].link;  // ebook 링크
             }
             var buylink = data.item[0].link;      // 책 구매 링크
             var authorName = data.item[0].bookinfo.authors[0].name;      // 작가이름
              
             //console.log(ebook);
             //console.log(authorName);
             
             $("#title").html(title);
             $("#author").html(author);
             $("#cover").attr("src",cover);
             $("#toc").html(toc);
             $("#desc").html(desc);
             $("#category").html(category);
             
             $("#bookDTL_btn3").attr("href",ebook);
             
             if(ebook == "no"){
                $("#linkBtn").html("<a class='btn btn-secondary' id='bookDTL_btn2' href='"+buylink+"' style='width:100%;'> 구매하기 </a>");
             }else{
               var buy = "<a class='btn btn-secondary' id='bookDTL_btn2' href='"+buylink+"'> 구매하기 </a>";
               buy += "<a class='btn btn-secondary' id='bookDTL_btn2' href='"+ebook+"'> e-book </a>";
                $("#linkBtn").html(buy);
             }
             
             
             $("#authorName").html(authorName);
             
             
             
             // 읽고 싶은 책 버튼 클릭!!!!!!!
           $(".wantBookBtn").on("click", function(){
              //console.log("읽고 싶은 책 버튼 클릭함!");
              
              let param = window.location.search
              //console.log(param);
              let isbnParam = param.split('=');
              //console.log(isbnParam[1]);
              let isbn = isbnParam[1];
              
              let au = data.item[0]["author"];
              let bt = data.item[0]["title"];
              let cov = data.item[0].cover;
              //console.log("작가 + " + au)
              let wantBook = {'isbn' : isbn, "author" : au, "bookTitle" : bt, "bookCover" : cov};
             
              $.ajax({
                     method: "POST",
                     data: JSON.stringify(wantBook),
                     url: "/mypage/wantBook",
                     contentType: "application/json;charset=utf-8",
                  beforeSend: function(xhr){
                           xhr.setRequestHeader(header, token);
                    },
                  success   : function(result){ //요청 성공시 실행할 코드
                     //console.log("읽고 싶은 책 데이터 등록 성공!");
                     //console.log("result!!!! : " + result);
                     $(".wantBookBtn").hide();
                     $("#wantBtn_div").html("<button type='button' class='btn btn-outline-secondary mt-2 cancelWantBookBtn' id='bookDTL_btn'> - 읽고 싶은 책 해제</button>");
                     $("#successWant").html("읽고 싶은 책 등록이 완료되었습니다.");
                     $("#successWantbook").modal("show");
                  },
                  error: function(e){
                     //console.log("읽고 싶은 책 데이터 등록 에러....");
                     //console.log(" e!!! 에러 값!!!!! :" + e);
                  }
               
                 })//ajax 끝   
              
              
           });
           
         
           // 읽고싶은 책 해제
            $("#wantBtn_div").on("click", ".cancelWantBookBtn", function(){
            //$(".cancelWantBookBtn").on("click", function(){
               //console.log("읽고 싶은 책 해제 버튼 클릭!!!");
               
               var isbn = "${abook}" // 현재 책의 isbn 번호
               var id = $("#loginId").val();     // 로그인한 아이디 보내기
               var cancelWant = {'id': id, 'isbn': isbn};
                 //console.log(cancelWant);
                 
                 // 읽고 싶은 책 해제!!
                 $.ajax({
                     type : "POST",
                     url : "/mypage/cancelWantBook",
                     data: JSON.stringify(cancelWant),
                     contentType: "application/json;charset=utf-8",
                        beforeSend: function(xhr){
                           xhr.setRequestHeader(header, token);
                        },
                        success: function(result){
                            //console.log("읽고 싶은 책 해제 성공!!");
                            //console.log(result);
                            $(".cancelWantBookBtn").hide();
                            $("#wantBtn_div").html("<button type='button' class='btn btn-secondary mt-2 wantBookBtn' id='bookDTL_btn'> + 읽고 싶은 책 추가</button>");
                            $("#successWant").html("읽고 싶은 책 해제가 완료되었습니다.");
                            $("#successWantbook").modal("show");
                          },
                         error: function(e){
                            //console.log("북 플레이 리스트 찜하기 요청 에러......");
                            //console.log(e);
                         }
                  });
            });
             
             
             
           // 읽은 책 버튼 클릭!!!!!!!
           //isbn으로 값 넘겨서 읽은 책 정보 저장 (mypageController에서 추가하자)
           $(".finBookBtn").on("click", function(){
              //console.log("읽은 책 버튼 클릭함!");
              
              let param = window.location.search
              //console.log(param);
              let isbnParam = param.split('=');
              //console.log(isbnParam[1]);
              let isbn = isbnParam[1];
              
              let au = data.item[0]["author"];
              let bt = data.item[0]["title"];
              let cov = data.item[0].cover;
              //console.log("작가 + " + au)
              let finBookData = {'isbn' : isbn, "author" : au, "bookTitle" : bt, "bookCover" : cov};
             
              $.ajax({
                     method: "POST",
                     data: JSON.stringify(finBookData),
                     url: "/mypage/finBook",
                     contentType: "application/json;charset=utf-8",
                  beforeSend: function(xhr){
                           xhr.setRequestHeader(header, token);
                    },
                  success   : function(result){ //요청 성공시 실행할 코드
                     //console.log("읽은 책 데이터 등록 성공!");
                     //console.log("result!!!! : " + result);
                     $(".finBookBtn").hide();
                     $("#finBtn_div").html("<button class='btn btn-outline-secondary mt-2 cancelFinBookBtn' id='bookDTL_btn'> - 읽은 책 해제 </button>");
                     $("#successFin").html("읽은 책으로 등록이 완료 되었습니다! :) ");
                     $("#successFinbook").modal("show");
                     
                  },
                  error: function(e){
                     //console.log("읽은 책 데이터 등록 에러....");
                     //console.log(" e!!! 에러 값!!!!! :" + e);
                  }
               
                 })//ajax 끝   
              
              
           });
           
           
        
        // 읽은 책 해제!!
           $("#finBtn_div").on("click", ".cancelFinBookBtn", function(){
              //console.log("읽고 싶은 책 해제 버튼 클릭!!!");
              
              var isbn = "${abook}" // 현재 책의 isbn 번호
              var id = $("#loginId").val();     // 로그인한 아이디 보내기
              var cancelFinRead = {'id': id, 'isbn': isbn};
                //console.log(cancelFinRead);
                
                // 읽고 싶은 책 해제!!
                $.ajax({
                    type : "POST",
                    url : "/mypage/cancelFinRead",
                    data: JSON.stringify(cancelFinRead),
                    contentType: "application/json;charset=utf-8",
                       beforeSend: function(xhr){
                          xhr.setRequestHeader(header, token);
                       },
                       success: function(result){
                           //console.log("읽은 책 해제 성공!!");
                           //console.log(result);
                           $(".cancelFinBookBtn").hide();
                           $("#finBtn_div").html("<button class='btn btn-outline-secondary mt-2 finBookBtn' id='bookDTL_btn'> + 읽은 책으로 추가</button>");
                           $("#successFin").html("읽은 책 해제가 완료 되었습니다! :) ");
                           $("#successFinbook").modal("show");
                         },
                        error: function(e){
                           //console.log("북 플레이 리스트 찜하기 요청 에러......");
                           //console.log(e);
                        }
                 });
           });
           
           
           
          
       

     }
   
    
  
    

    
   </script>
   
   
   
      <script>
      // 회원의 읽고싶은 책, 읽은 책 리스트 가져오기
      var wantReadList = new Array();
      var finReadList = new Array();
      function getUserwantBookList(){
         //console.log("getUserwantBookList 호출됨!!!"); 
         
         // 회원의 읽고싶은 책 리스트 가져오기
          $.ajax({
                url: "/mypage/getUserwantBookList.json",
                type: "get",
                datatype: "JSON",
                success: function(result) {
                   //console.log("ajax success");
                   //console.log(result);
                   for(let i=0 ; i < result.length ; i++){
                        //console.log("for문진입!!!");
                        wantReadList.push(result[i]);
                     }
                     //console.log(wantReadList);
                     // 읽은 책 리스트 가져오는 메서드 호출
                     getUserfinBookList();
                },
                error: function(e){
                   //console.log("ajax error");
                   //console.log(e);
                }
             });
      }
   
      
      function getUserfinBookList(){
         //console.log("getUserfinBookList 호출됨!!!"); 
         
         // 회원의 읽은 책 리스트 가져오기
          $.ajax({
                url: "/mypage/getUserfinBookList.json",
                type: "get",
                datatype: "JSON",
                success: function(result) {
                   //console.log("ajax success");
                   //console.log(result);
                   for(let i=0 ; i < result.length ; i++){
                        //console.log("for문진입!!!");
                        finReadList.push(result[i]);
                     }
                     //console.log(finReadList);
                     // 버튼들 화면에 뿌려주는 메서드 호출
                     settingBtn();
                },
                error: function(e){
                   //console.log("ajax error");
                   //console.log(e);
                }
             });
         
      }
      
      
      // 버튼 셋팅하는 함수
      function settingBtn(){
         //console.log("settingBtn 호출됨!!!");  
          var isbn = "${abook}" // 현재 책의 isbn 번호
         var checkWant = 0;   //  읽고 싶은 책에 있는지 체크
         var checkfin = 0;   // 읽은 책에 있는지 체크
         
         
         // 내가 읽고 싶은 책 목록에 해당 책 있는지 체크
           for(let i=0; i<wantReadList.length; i++){
              if(wantReadList[i].isbn == isbn){
                 checkWant = 1;  // 해당하는 isbn 있으면 1로 변경   
              }
           }
           
           //console.log("checkWant : " + checkWant);
           if(checkWant == 0){  // 안원했음
              //console.log("안원했음 checkWant : " + checkWant);
              $("#wantBtn_div").html("<button type='button' class='btn btn-secondary mt-2 wantBookBtn' id='bookDTL_btn'> + 읽고 싶은 책 추가</button>");
           }else{   // 원했음
              //console.log("원했음 checkWant : " + checkWant);
              $("#wantBtn_div").html("<button type='button' class='btn btn-outline-secondary mt-2 cancelWantBookBtn' id='bookDTL_btn'> - 읽고 싶은 책 해제</button>");
           } 
         
           
           
           // 내가 읽은 책 목록에 해당 책 있는지 체크
           for(let i=0; i<finReadList.length; i++){
              if(finReadList[i].isbn == isbn){
                 checkfin = 1;  // 해당하는 isbn 있으면 1로 변경   
              }
           }
         
           //console.log("checkfin : " + checkfin);
           if(checkfin == 0){  // 안읽음
              //console.log("안원했음 checkfin : " + checkfin);
              $("#finBtn_div").html("<button class='btn btn-outline-secondary mt-2 finBookBtn' id='bookDTL_btn'> + 읽은 책으로 추가</button>");
           }else{   // 읽음
              //console.log("원했음 checkfin : " + checkfin);
              $("#finBtn_div").html("<button class='btn btn-outline-secondary mt-2 cancelFinBookBtn' id='bookDTL_btn'> - 읽은 책 해제 </button>");
           } 
           
           
          
              //$("#wantfinBtn_div").html("'');
         
      }
      
   
            
        
        
   
   
   </script>

   
   
   
    
   <div class="container" id="bookitemDetails_con">
   <div id="resultTBL">
      
   </div>
   
        <div> <%-- 상단 이미지 / 제목 /  작가 / 버튼 등 --%>
           <div class="row">
              <div class="col" id="resultTBL_coverArea">
                 <img id="cover" src="/resources/img/imgDefault.jpg"  class="bookDetails_img"/>
              </div>
              <div class="col">
                 <h2> <b id="title"> 책 제목 </b></h2>
                 <h5 id="author"> 작가 </h5>
                 <hr />
                 <p id="category">  </p>
                 <hr />
                 <%-- 키워드 10개 최대 
                 <div class="hashTag_div">
                    <span class="hashTag">SF소설</span>
                    <span class="hashTag">감동적인</span>
                    <span class="hashTag">한국소설</span>
                    <span class="hashTag">찬란한</span>
                    <span class="hashTag">동물</span>
                    <br/>
                 </div>
                 <br />
                 <br />
                  --%>
                 <br />
                 <br />

              
                 
                 <%-- 버튼 --%>
                 <sec:authorize access="isAnonymous()">
                    <button type="button" class="btn btn-primary mt-2" id="bookDTL_btn" disabled>+ 나의 북플리에 추가 (로그인 후 사용가능)</button>
                    <button type="button" class="btn btn-secondary mt-2 wantBookBtn" id="bookDTL_btn" disabled> 읽고 싶은 책으로 추가 (로그인 후 사용가능)</button>
                    <button class="btn btn-outline-secondary mt-2 finBookBtn" id="bookDTL_btn" disabled> 읽은 책으로 추가 (로그인 후 사용가능)</button>
                    <hr />
                 </sec:authorize>

                 
                 <sec:authorize access="isAuthenticated()" >
                     <sec:authentication property="principal" var="princ" /> 
                     <input type="hidden" id="loginId" value="${princ.member.id}"/>
                     <script>
                          getUserwantBookList();
                     </script>
                    <button class="btn btn-primary mt-2" type="button" id="addmyBook" style="width:100%;">+ 나의 북플리에 추가</button>
                      <div id="wantBtn_div">
                        
                     </div>
                     <div id="finBtn_div">
                        
                     </div>
                       
                    <%-- <button type="button" class="btn btn-secondary mt-2 wantBookBtn" id="bookDTL_btn"> 읽고 싶은 책으로 추가</button>
                    <button class="btn btn-outline-secondary mt-2 finBookBtn" id="bookDTL_btn"> 읽은 책으로 추가</button> --%>
                    <hr />
                 </sec:authorize>
                 
                 <div id="linkBtn">
                 
                 
                 </div>
           
              </div>
           </div>
        </div> <%-- 상단 --%>
      
         <br />
         <hr />
       <br />
       <br />
      
      
     <c:if test="${desc ne 'undefind'}">
            <div> <%-- 책소개 --%>
               <div class="row">
                  <div class="col-3">   <%-- 책소개 제목  --%>
                     <h5><b>책소개</b>
                     </h5>
                  </div>
                  
                  <div class="col">   <%-- 책소개 내용  --%>
                     <p id="desc">
                     
                     </p>
                  </div>
               </div>
           </div> <%-- 책소개끝 --%>
           
         
         <br />
         <br />
         <div>
               <div class="row">
                  <div class="col-3"></div>
                  <div class="col"><hr /></div>
               </div>
         </div>
         <br />
         <br />
      </c:if>
       
      
      
      <c:if test="${desc ne 'toc'}">
            <div> <%-- 목차 --%>
               <div class="row">
                  <div class="col-3">
                     <h5><b>목차</b></h5>
                  </div>
                  
                  <div class="col">
                     <p id="toc">
                     
                     </p>
                  </div>
               </div>
           </div> <%-- 목차 끝 --%>
       </c:if>
    
       <br />
       <br />
       <hr />
       <br />
       <br />
       
        
   <c:if test="${bookPLlist ne null}">
      <div>
         <%-- 이 책을 선택한 유저들의 북플리  --%>
         <h4>
            <b>이 책을 선택한 유저들의 북플리 📚</b>
         </h4>
         <br />
         <div class="owl-carousel owl-theme">
            <c:forEach var="bookPL" items="${bookPLlist}">
               <div class="item">
                  <a href="/memData/bookPlistDetail?list_no=${bookPL.list_no}">
                     <img class="pointcard_img"
                     src="/resources/save/${bookPL.packCover}">
                  </a>
                  <div class="card-body">
                     <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                           <h5>
                              <b>${bookPL.bookPLTitle}</b>
                           </h5>
                        </div>
                     </div>
                  </div>
                  <%-- card body --%>
               </div>
               <%-- item --%>
            </c:forEach>
         </div>
         <%-- 올빼미 --%>

      </div>
      <%-- 이 책을 선택한 유저들의 북플리 끝 --%>

      <br />
      <hr />
      <br />
      <br />
   </c:if>
        

         <div> <%-- 북플 --%>
           <h4 id="replyCountBox"><b>댓글(1)</b></h4>
           <hr />
           <div class="book_replyForm">
                 <table class="book_replyFormTBL">
                    <tr>
                       <td><b>기억에 남는 문장</b></td>
                       <sec:authorize access="isAnonymous()"> 
                          <td> 
                        <pre><textarea rows="3" id="book_replyArea" placeholder="* 기억에 남는 문장을 적어주세요👀&#13;&#10;(로그인 후 이용해주세요) *" disabled></textarea></pre>
                          </td>
                       </sec:authorize>
                       <sec:authorize access="isAuthenticated()"> 
                          <td> 
                              <pre><textarea rows="3" id="book_replyArea" placeholder="* 기억에 남는 문장을 적어주세요👀 *" required="required"></textarea></pre>
                          </td>
                       </sec:authorize>
                    </tr>
                    
                    <tr>
                       <td><b>감상평</b></td>
                       <sec:authorize access="isAnonymous()"> 
                          <td> 
                           <pre><textarea rows="3" id="book_replyContentArea" placeholder="* user님의 감상평을 적어주세요✒&#13;&#10;(로그인 후 이용해주세요) *" disabled></textarea></pre>
                          </td>
                       </sec:authorize>
                       <sec:authorize access="isAuthenticated()"> 
                          <td> 
                           <pre><textarea rows="3" id="book_replyContentArea" placeholder="* user님의 감상평을 적어주세요✒ *" required="required"></textarea></pre>
                          </td>
                       </sec:authorize>
                    </tr>
                 </table>
            <sec:authorize access="isAuthenticated()"> 
               <button class="btn btn-primary btn-sm" id="replyBtn" >등록하기</button>
            </sec:authorize>
           </div>
              
              
               <br />
             <hr />
             <br />
              
              
           
           <div class="reply"> <%-- 댓글 뿌려주기  --%>
              <div class="row">
                 <div class="col-3" style="text-align: center;">
                    <img src="/resources/img/profile01.jpg" class="reply_ProImg"> <br/>
                    <p><b>불가사의</b></p> 
                 </div>
                 
                 <div class="col">
                    <h5 class="replytitle"><b>“꿈꾸던 삶을 살고 있어?”</b></h5>
                    <hr id="replyHr"/>
                    <pre>
               결말까지 계속 조마조마하며 읽었다,
               각 캐릭터들의 관계성이 너무나 흥미로웠고,  
               베리감동감동 앤드 쌔드쌔드 벗 인터레스팅팅팅
                    </pre>
                    <div style="text-align: right;">
                       <p style="text-align: right;">2022.09.28</p>
                    <hr />
                       <button class="btn btn-secondary btn-sm">수정</button>
                       <button class="btn btn-secondary btn-sm">삭제</button>
                       <span>200</span>
                       <sec:authorize access="isAnonymous()"> 
                     <button class="fa-regular fa-thumbs-up" style="border: none; background: transparent;">좋아요</button>
                       </sec:authorize>
                       <%-- <i class="fa-solid fa-thumbs-up"></i>    좋아요 눌렀을 때 이모티콘--%>
                       
                    </div>
                    
                 </div>
              </div>
           </div>
          
        
         <%--  페이징 관련 부분 --%>
      <div id ="pagingArea" style="text-align: center">
         <button id ="moreBtn" style="border: none; background: transparent; ">+ 댓글 더보기 </button>
      </div>
    
         
         
           
           
        </div> <%-- 북플 끝 --%>
     
   
   </div> <%-- container  --%>
   
   

<%--  북플레이 리스트 추가 모달!!!!!!!!!!!!!!!!!!!!!!!!!!!--%>
   <div class="modal fade" id="addtoMyPL" aria-hidden="true" aria-labelledby="addtoMyPL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="exampleModalToggleLabel"><b>북플리에 책 추가하기 📚</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         
          <div class="modal-body">
                <span>추가할 도서 &nbsp; &nbsp;</span> 
                
                <div id="selecBooks">
                
                </div>

                
                <hr />
                <button class="btn btn-primary btn-sm" id="newPLcreate"> + 새 북 플레이리스트 생성</button>
                 <br />
                 <div class="container">
                    <table id="settingMemPLlist">
                       
                 </table>
                 </div> <%-- div row 끝 --%>
          </div>
         
         <div class="modal-footer">
              <button type="button" id="saveBooks" class="btn btn-primary">저장</button>
         </div>
       </div>
     </div>
   </div>

   
   
   
   <%--******* + 새 북 플레이리스트 생성 모달 ********  --%>
   <div class="modal fade" id="newCreatePL" aria-hidden="true" aria-labelledby="newCreatePL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="exampleModalToggleLabel2"> + 새 북 플레이리스트 생성</h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
         <div class="form-control">
                <label>북 플레이리스트 명 </label>
               <input type="text" name="bookPLtitle" id="bookPLtitle" required /> 
               <br />
               <select name="listStatus" disabled>
                  <option value="1" selected> 비공개 </option>
               </select>
            </div>
         </div>
         
        <div class="modal-footer">
           <button class="btn btn-outline-secondary"  data-bs-target="#addtoMyPL" data-bs-toggle="modal">취소</button>
           <button type="button" class="btn btn-primary" id="creatPLBtn">생성</button>
        </div>
       </div>
     </div>
   </div>
   
   



<%-- 책추가 완료 때 모달  --%>
<div class="modal fade"  id="successAddBooksmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북플리에 책 추가하기 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>선택하신 도서가 북플리에 추가 완료 되었습니다. :)</p>
      </div>
      <div class="modal-footer">
      
         <sec:authorize access="hasRole('ROLE_MEMBER')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/memMypage'">확인</button>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/adminMypage'">확인</button>
         </sec:authorize>
        
      </div>
    </div>
  </div>
</div>
   
   
 <%-- 읽고 싶은책 설정 완료 모달  --%>
<div class="modal fade"  id="successWantbook" tabindex="-1" aria-hidden="true" aria-labelledby="successScrap">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">읽고 싶은 책 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p id="successWant"></p>
        <p>마이페이지에서 확인 가능합니다.</p>
      </div>
      <div class="modal-footer">
      
         <sec:authorize access="hasRole('ROLE_MEMBER')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/memMypage'">마이페이지</button>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/adminMypage'">마이페이지</button>
         </sec:authorize>
        
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>


 <%-- 읽은 책 설정 완료 모달  --%>
<div class="modal fade"  id="successFinbook" tabindex="-1" aria-hidden="true" aria-labelledby="successScrap">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">읽은 책 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p id="successFin"></p>
        <p>마이페이지에서 확인 가능합니다.</p>
      </div>
      <div class="modal-footer">
      
                <sec:authorize access="hasRole('ROLE_MEMBER')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/memMypage'">마이페이지</button>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/adminMypage'">마이페이지</button>
         </sec:authorize>
        
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
   
   
  <%-- ************************************ 스크립트!!!!!!!!!!!!!!!! ******************** --%> 
  
  
  
  
 <script>
  $(document).ready(function(){
     
     let isbn = "${abook}"
     //console.log("가져온 isbn : " + isbn);
      
     
        //요청에 대한 정보
           $.ajax({
               method: "get",
               dataType:"jsonp",
               jsonp: 'bookData',
               url: "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?OptResult=cardReviewImgList,bestSellerRank,previewImgList,authors,fulldescription,fulldescription2,Toc,Story,mdrecommend,phraseList,ebookList",
               data: { 
                  TTBKey:"ttbhan_yurim1536001",
                  ItemIdType: "ISBN13",
                  ItemId : "${abook}",
                  output:"JS",
                  cover:"Big",
                  callback:"bookData"
               }
           });
           
        
        
        //댓글 목록 가져와 뿌리기 호출 
         showReplyList();
          var isbnData = {"isbn" : isbn};  
         
         //댓글 목록 가져와 뿌려주기 함수 (페이징처리 X)
            function showReplyList(){
               //console.log("show reply list 호출!!"); 
               // 전체 댓글 가져오기 요청 
               $.ajax({
                  type: "GET",
                  url: "/search/getReply/" + isbn + ".json",
                  data: {isbn : isbn},
                  contentType: "application/json;charset=utf-8",
                  success: function(result){
                     //console.log("요청 성공!!!"); 
                     //console.log("댓글가져오기" + result);
                     makeList(result);
                     
                  }, 
                  error: function(e){
                     //console.log("요청 실패....");
                     //console.log(e);
                  }
               });
               
            }//showReplyList
            
            
            
         let replyContainer = $(".reply"); 
         let replyCountBox = $("#replyCountBox"); //댓글 작성하는 칸의 댓글 카운트 하는 div
         replyCountBox.empty();
         $("#pagingArea").hide();
         let username = "${princ.username}"; //로그인 한 사람 정보   
         
         // 댓글 목록 만들어서 화면에 부착 함수 
            function makeList(result){
               replyContainer.empty();
               replyCount();//댓글 카운트 수 가져오기 
               //console.log("makelist!!!!!" + result.length);
               
               // 댓글이 없을 경우 
               if(result == null || result.length == 0){
                  // 댓글 목록에 아래와 같이 태그 부착하고 
                  
                  replyContainer.html("<div class='reply' style='text-align: center;'>댓글이 없습니다.</div>"); 
                  return; // makeList 함수 강제 종료! 
               }
      
               
               // 부착할 html 목록 문자열로 만들기 
               let str = ""; 
               for(let i = 0; i < result.length; i++){
                  str += "<div class='reply'><div class='row'><div class='col-3' style='text-align: center;'>";
                  if(result[i].photo == null){
                     str += "<img src='/resources/save/user.png' class='reply_ProImg'><br/>";
                  }else{
                     str += "<img src='/resources/save/"+result[i].photo+"'class='reply_ProImg'><br/>";
                  }
                  str += "<p><b>"+result[i].nickName+"</b></p></div>";
                  
                  str += "<div class='col'><h5 class='replytitle'><b>“"+result[i].reTitle+"”</b></h5><hr />";
                  str += "<pre>"+result[i].reContent+"</pre>";
                  str += "<div style='text-align: right;'><p style='text-align: right;'>"+timeFormat(result[i].reReg)+"</p><hr />";
                  
                  str += "<sec:authorize access='isAuthenticated()'>";
                  if(username == result[i].id){ //댓글작성자가 로그인한 사람과 동일하면 && admin이면
                      str += "<button class='btn btn-secondary btn-sm' id='modifyReplyBtn"+i+"' data-repno='"+result[i].re_no+"' data-service='modify'>수정</button>"
                   str += "<button class='btn btn-danger btn-sm' id='deleteReplyBtn"+i+"' data-repno='"+result[i].re_no+"' data-service='delete'>삭제</button>";
                   }else if(username == "admin"){
                      str += "<button class='btn btn-danger btn-sm' id='deleteReplyBtn"+i+"' data-repno='"+result[i].re_no+"' data-service='delete'>삭제</button>";
                   };
                  str += "</sec:authorize>";
                  str += "&emsp;<span>"+result[i].goodCount+"</span>";
                  str += "<sec:authorize access='isAuthenticated()'>";
                  if(username != result[i].id){ //로그인 한 사람이 댓글작성자가 아닌경우의 댓글에만 공감하기 버튼 나오게
                  str += "<i><button class='fa-regular fa-thumbs-up' data-repno='"+result[i].re_no+"' style='border: none; background: transparent;'></button></i>";
                  }
                  str += "</sec:authorize></div></div></div></div>";
   
               }//for문
            if(result.length > 5){
               str += "<hr /><div id ='pagingArea' style='text-align: center'>"
               str += "<button id ='moreBtn' style='border: none; background: transparent; ''>+ 댓글 더보기 </button></div>"
            }
             
                  replyContainer.html(str);   // html 부착 
           
                  //댓글 더보기 눌렀을때 (5개씩 증가되는 function)
                  $(".reply").slice(0, 5).show();
                  $(".reply").slice(6).hide();
                    $("#moreBtn").click(function(e){ // click event for load more
                          e.preventDefault();
                    $(".reply:hidden").slice(0, 5).show(); // select next 10 hidden divs and show them
                    if($(".reply:hidden").length == 0){
                       $("#moreBtn").hide();
                    }
                   
                });
                  
                 //댓글 수 가져오기        
             var isbnData = {"isbn" : isbn};  
               
               function replyCount(){
                  //console.log("reply Count 호출!!"); 
                  
                  // 댓글 수 가져오기 요청 
                  $.ajax({
                     type: "GET",
                     url: "/search/getReplyCount/" + isbn + ".json",
                     data: {isbn : isbn},
                     contentType: "application/json;charset=utf-8",
                     success: function(result){
                        //console.log("요청 성공!!!"); 
                        //console.log(result);
                        replyCountBox.html("<h4 id='replyCount'><b>댓글("+result+")</b></h4>");
                       }, 
                     error: function(e){
                     //console.log("요청 실패....");
                     //console.log(e);
                     }
                  }); //ajax 끝
                  
            }//replyCount()
            
               
               
               //댓글 공감 버튼 이벤트
               $(".fa-thumbs-up").on("click", function(event){
                  let repno = $(this).data("repno"); 
                  //console.log("공감버튼 re_no :" + repno);
                  
                  renumData = {"re_no" : repno};
                  // ajax로 공감 처리 요청 (좋아요 table에 저장하고, 카운트 update해서 다시 목록보여주기)
               $.ajax({
                     type: "POST",
                     url: "/search/likeReply",
                     data: JSON.stringify(renumData),
                     contentType: "application/json;charset=utf-8",
                     beforeSend: function(xhr){
                        xhr.setRequestHeader(header, token);
                     },
                     success: function(result){
                        //console.log("공감 버튼 요청 성공!!!!!!!");
                        //console.log("result : " + result);
                        if (result == "success") {
                             //$(".fa-thumbs-up").attr("class", "fa-solid fa-thumbs-up");
                              location.reload();
                         } else {
                             //$(".fa-thumbs-up").attr("class", "fa-regular fa-thumbs-up");
                            //location.reload();
                         }
                       
                     },
                     error: function(e){  // 문제가 발생하면 에러 콘솔에 표시
                        //console.log("요청 에러.....");
                        //console.log(e);
                    }
                                     
               });//댓글 공감 ajax 끝
                  
               
               });
               
               
              //댓글 삭제 버튼 이벤트
            $("[id^=deleteReplyBtn]").on("click", function(event){
               //console.log("삭제 클릭!!!!");
               event.preventDefault();
               
               let service = $(this).data("service");
               //console.log($(this).data("service"));
               
               let repno = $(this).data("repno"); 
               //console.log("댓넘버" + repno);
               let delReData = {"re_no" : repno};
                       
               if(service == 'delete'){
               // ajax로 삭제 요청 
                  $.ajax({
                        type: "POST",
                        url: "/search/deleteReply",
                        data: JSON.stringify(delReData),
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function(xhr){
                           xhr.setRequestHeader(header, token);
                        },
                        success: function(result){
                           //console.log("요청 성공!!!!!!!");
                           //console.log("result : " + result);
                           showReplyList();
                        },
                        error: function(e){  // 문제가 발생하면 에러 콘솔에 표시
                           //console.log("요청 에러.....");
                           //console.log(e);
                       }
                                        
                  });//댓글 삭제 ajax 끝
                          
                     }
              });//펑션
              
              
              
              //댓글 수정 버튼 이벤트
                 $("[id^=modifyReplyBtn]").on("click", function(event){
               //console.log("수정 클릭!!!!");
               event.preventDefault();
               
               let service = $(this).data("service");
               //console.log($(this).data("service"));
               
               let repno = $(this).data("repno"); 
               //console.log("댓넘버" + repno);
               
                       
               if(service == 'modify'){
                  // 수정가능한 폼으로 html 변경 -> reply 내용물 입력가능하게 변경 
                       let reply = $(this).parent().parent().parent().parent(); //class="reply"
                       //console.log(reply);
                  
                   // 기존작성 내용 꺼내기
                    let profileImg = reply.find("img").attr('src'); //img 경로 뽑기
                   //console.log(profileImg);
                   let replyer = reply.find("b").html(); //작성자 뽑기
                   //console.log(replyer);
                   let replyTitle = reply.find("h5[class='replytitle']").find("b").html();
                   replyTitle = replyTitle.slice(0, -1);
                   replyTitle = replyTitle.slice(1);
                   //console.log("댓제목 : " + replyTitle);
                   let replyContent = reply.find("pre").html();
                   //console.log("댓내용 : " + replyContent);
                   
                   
                   
                   let modifyBox = "";
                        
                  modifyBox += "<div class='row'><div class='col-3' style='text-align: center;'>";
                  modifyBox += "<img src='"+profileImg+"'class='reply_ProImg'><br/>";
                  modifyBox += "<p><b>"+replyer+"</b></p></div>";
                               
                  modifyBox += "<div class='col'><h5 class='replytitle'><pre><textarea rows='2' class='modiReply' id='book_ReplyArea' required='required'>"+replyTitle+"</textarea></pre></h5><hr />";
                  modifyBox += "<pre><textarea rows='3' class='modiReplyer' id='book_ReplyContentArea' required='required'>"+replyContent+"</textarea></pre>";
                               
                  modifyBox += "<sec:authorize access='isAuthenticated()'>";
                               
                  modifyBox += "<button class='btn btn-secondary btn-sm' id='realModiBtn' data-repno='"+repno+"' data-service='modify'>수정</button>"
                  modifyBox += "<button class='btn btn-secondary btn-sm' onclick='history.go(0)'>이전으로</button>";
                               
                  modifyBox += "</sec:authorize>";
                  //modifyBox += "&emsp;<span>"+result[i].goodCount+"</span>";
                       //modifyBox += "<sec:authorize access='isAnonymous()'><button class='fa-regular fa-thumbs-up' style='border: none; background: transparent;'></button>";
                    modifyBox += "</sec:authorize></div></div><hr />"
                   
                   
                      reply.html(modifyBox);  
                 
                 
                    $("#realModiBtn").on('click', function(){
                       let modiTitle =$(".modiReply").val();
                         //console.log(modiTitle);
                         let modiContent = $(".modiReplyer").val();
                         //console.log(modiContent);
                         
                         let modifyReData = {"re_no" : repno, "reTitle" : modiTitle, "reContent" : modiContent};
                    
                  //ajax로 수정 요청 
                      $.ajax({
                           type: "POST",
                           url: "/search/modifyReply",
                           data: JSON.stringify(modifyReData),
                           contentType: "application/json;charset=utf-8",
                           beforeSend: function(xhr){
                              xhr.setRequestHeader(header, token);
                           },
                           success: function(result){
                              //console.log("요청 성공!!!!!!!");
                              //console.log("result : " + result);
                              showReplyList();
                           },
                           error: function(e){  // 문제가 발생하면 에러 콘솔에 표시
                              //console.log("요청 에러.....");
                              //console.log(e);
                          } 
                                           
                     });//댓글 수정 ajax 끝
                    });//modiBtn
                        }//if문
                 });//펑션

               
            }//makeList
         
       //시간 함수 : 오늘 댓글은 시간, 오늘 이전 댓글은 날짜
         function timeFormat(regVal){
             let today = new Date(); 
             let diff = today.getTime() - regVal; 
             let dateObj = new Date(regVal); 
             if(diff < (1000*60*60*24)) { // 24h 보다 작으면 
                let hh = dateObj.getHours(); 
                let mi = dateObj.getMinutes(); 
                let ss = dateObj.getSeconds(); 
                return (hh > 9 ? "" : "0") + hh + ":"  // 시간.....왜 9가 기준인가? !!!!!!!!!!!!!!!!!!!!!!!!!!????????????????????????????????
                   + (mi > 9 ? "" : "0") + mi + ":"
                   + (ss > 9 ? "" : "0") + ss;
             }else {
                let yy = dateObj.getFullYear(); 
                let mm = dateObj.getMonth() + 1; 
                let dd = dateObj.getDate(); 
                return yy + "/" + (mm > 9 ? "" : "0") + mm + "/" + (dd > 9 ? "":"0") + dd;
             }
          }
            
            
        
         //댓글 ajax 보내기
          $("#replyBtn").on('click', function(){
              //console.log("댓글 저장 버튼 누름 ");
              //console.log("isbn값 : " + isbn);
             
              var replyTitle = $('#book_replyArea').val();
              var replyContent =$('#book_replyContentArea').val();
          
              //console.log("댓 타이틀 : " + replyTitle);
              //console.log("댓 본문 : " + replyContent);
              
              
              // 책 제목이랑 표지 쏴줄거 정리
              var bookTitle = document.getElementById('title'); // 책 제목
              var bookT = bookTitle.innerText
      		  //console.log("댓글에 저정할 도서 제목 : " + bookT);

              var bookC = $("#cover").attr("src");
      		  //console.log("댓글에 저정할 도서 표지 주소 : " + bookC);
           
      		var replyData = {"reTitle" : replyTitle, "reContent" : replyContent, "isbn" : isbn, "bookTitle" : bookT, "bookCover" : bookC};
              
              $.ajax({
                  type : "POST",
                  url : "/search/bookDetails",
                  data: JSON.stringify(replyData),
                  contentType: "application/json;charset=utf-8",
                  processData: false,
                     beforeSend: function(xhr){
                        xhr.setRequestHeader(header, token);
                     },
                     success: function(result){
                         //console.log("댓글 저장 성공!");
                         //console.log(result);
                         showReplyList();
                            // 댓글 등록후 인풋란에 글 없애기
                            $("#book_replyArea").val("");
                            $("#book_replyContentArea").val("");
                      },
                      error: function(e){
                         //console.log("댓글 저장 실패......");
                         //console.log(e);
                      }
               });
              
           }); //댓글 ajax 끝
          

  }); //document
 //OptResult:"cardReviewImgList,bestSellerRank,previewImgList,authors,fulldescription,fulldescription2,Toc,Story,mdrecommend,phraseList,ebookList",
 


//뒤로가기 함수
   function goback(){
      window.history.back();   
   }


 
 // 저장하려는 도서의 정보 담기
 //let  = {'isbn' : isbn, "author" : au, "bookTitle" : bt, "bookCover" : cov};

     // 이 북플리를 나의 목록에 추가 버튼 눌렀을 시
    $("#addmyBook").on('click', function(){
       //console.log("북플리 나의목록에 추가 버튼 클릭!!");
       $("#addtoMyPL").modal("show");
       
       $("#selecBooks").html("<span><b>"+title+"</b></span> "); // 담으려는 책 모달에 뿌려주기
       
    // 회원이가지고 있는 북플리리스트 요청
      getMemPLlist();
       
    });
     
     
    var resultMemPLlist = new Array(); // 가져온 회원 플리 리스트 저장할 변수
    var ch = 0;
    function getMemPLlist(){
       //console.log("회원이 가지고 있는 북플리 다 불러오기");
       
       
       $.ajax({
          url: "/mypage/getMemPL.json",
          type: "get",
          datatype: "JSON",
          success: function(result) {
             //console.log("ajax success");
             //console.log(result);
             var resultMemPLlist = new Array();
                for(var i=0 ; i < result.length; i++){
                   resultMemPLlist.push({'list_no' : result[i].list_no, 'bookPLTitle': result[i].bookPLTitle, 'packCover' : result[i].packCover});
                }
                
                // 북플리 뿌리기
                $("#settingMemPLlist").empty();
                for(let i=0; i<resultMemPLlist.length; i++){
                   //var showList ="<tr><td><img src='"+ resultMemPLlist[i].packCover + "' class='addBookPL_img'></td>";
                   var showList ="<tr><td><img src='/resources/save/"+resultMemPLlist[i].packCover+"' class='addBookPL_img'></td>";
                   showList += "<td width='400px'>"+resultMemPLlist[i].bookPLTitle+"</td>";
                   showList += "<td><input class='saveSelect' type='radio' name='saveSelect' value='"+resultMemPLlist[i].list_no +"'/> </td></tr>";
                   $("#settingMemPLlist").append(showList);
                }
             //console.log(resultMemPLlist);
          },
          error: function(e){
             //console.log("ajax error");
             //console.log(e);
             
          }
          
       });
    }
    
    
    
    var selectedListNum; 
    // 모달안에서 북플레이 리스트 선택했을 때 처리 메서드
      $("#settingMemPLlist").on("click", ".saveSelect",function(){
              //console.log("플레이리스트 선택 !!");
         
        if($(this).is(":checked")){  // 체크 됐을때 
           selectedListNum = $(this).val();
              //console.log(selectedListNum);
        }
      });
    
    var isbn = "${abook}";
    
      // 모달 누르면 저장 하는 처리 메서드
      $("#saveBooks").on("click", function(){
         //console.log("저장 버튼 클릭!!");

         var savePlBooks = new Array();
         savePlBooks.push({"list_no": selectedListNum ,"isbn" : isbn, "bookTitle" : title, "author" :author, "bookCover" : cover});
         //console.log(savePlBooks);
         
         $.ajax({
            type: "POST",
            url : "/memData/addSavePlBooks",
            data: JSON.stringify(savePlBooks),
            contentType: "application/json;charset=utf-8",
               beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
               },
               success: function(result){
                   //console.log("책 추가 요청 성공!!!!!");
                   //console.log(result);
                   $("#addtoMyPL").modal("hide");
                   $("#successAddBooksmodal").modal("show");
                },
                error: function(e){
                   //console.log("책 추가 요청 에러......");
                   //console.log(e);
                }
            
         });
         
         
      });
       
      
      
      
      // 모달에서 새 플레이리스트 생성 버튼 메서드 처리
      $("#newPLcreate").on("click", function(){
         //console.log("새 플레이리스트 생성 버튼 클릭");
         
         $("#addtoMyPL").modal("hide");
         $("#newCreatePL").modal("show");
         $('#bookPLtitle').val("");
      });
      
      
      var id = $("#loginId").val();     // 로그인한 아이디 보내기
      // 새플레이리스트 생성 모달에서 생성 버튼 처리
      $("#creatPLBtn").on("click", function(){
         //console.log("새 플레이리스트 생성 요청!!!");
         
         var listTitle = $("#bookPLtitle").val();
         var status =  parseInt($("#listStatus").val());
         var createPL = {"id" : id, "bookPLTitle" : listTitle, "listStatus" : status};
         //console.log("새북플리 상태값 : " + status);
         //console.log("새 플레이리스트 생성 요청 : " + createPL );
         
         
         // 새 북 플레이 리스트 생성!!
         $.ajax({
            type : "POST",
            url : "/memData/newBookList",
            data: JSON.stringify(createPL),
            contentType: "application/json;charset=utf-8",
            processData: false,
               beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
               },
               success: function(result){
                   //console.log("북 플레이 리스트 생성 요청 성공!!!!!");
                   //console.log(result);
                 $("#newCreatePL").modal("hide");
                 getMemPLlist();
                  $("#addtoMyPL").modal("show");
                },
                error: function(e){
                   //console.log("북 플레이 리스트 생성 요청 에러......");
                   //console.log(e);
                }
         });
         
         
      });
        
      
      
   



   
   
   </script>
   
       <%-- footer 복붙 --%>
   <%@ include file="../includes/footer2.jsp" %>
   