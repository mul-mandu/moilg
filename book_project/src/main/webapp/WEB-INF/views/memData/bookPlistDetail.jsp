<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>

<script>
   // 회원의 찜하기 리스트 가져오기
   
   var resultMemPLlist = new Array();
   var resultVal;
   function getUserScrap(){
      console.log("getUserScrap 호출됨!!!");  
      
      //회원의 찜하기 리스트 가져오기
       $.ajax({
             url: "/mypage/getUserScrap.json",
             type: "get",
             datatype: "JSON",
             success: function(result) {
                console.log("ajax success");
                console.log(result);
                for(let i=0 ; i < result.length ; i++){
                     console.log("for문진입!!!");
                     resultMemPLlist.push(result[i]);
                  }
                  console.log(resultMemPLlist);
                
                setScrapBtn();  // 버튼 셋팅하는 함수 호출
             },
             error: function(e){
                console.log("ajax error");
                console.log(e);
             }
          });
   }

   
      
     
     function setScrapBtn(){
        console.log("setScrapBtn 호출됨!!!");  
        var list_no = "${listNum}";  // 현재 플리의 리스트 번호
        var check = 0;   // 번호 있는지 없는지 체크할 변수
        
        console.log("list_no : " + list_no);
        
        
        // 내가 찜한 리스트에 현재 플리가 있는지 체크
        for(let i=0; i<resultMemPLlist.length; i++){
           if(resultMemPLlist[i] == list_no){
              check = 1;  // 해당하는 플리가 있으면 1로 변경   
           }
        }
        
        console.log("check : " + check);
        if(check == 0){  // 찜하지 않았으면
           console.log("찜 안함 check : " + check);
           $("#scrapBtn_div").html("<button class='btn btn-primary mt-2' id='bookDTL_btn'> + 북플리 찜하기</button>");
        }else{   // 찜했으면
           console.log("찜 함 check : " + check);
           $("#scrapBtn_div").html("<button class='btn btn-secondary mt-2' id='cancelbookDTL_btn'> - 북플리 찜하기 해제</button>");
        } 
     }
      

</script>

<div class="container" id="bookitemDetails_con">
   <div> <!-- 상단 이미지 / 제목 /  작가 / 버튼 등 -->
        <div class="row">
           <div class="col-5">
              <img src="/resources/save/${oneBookPL.packCover}"  class="bPlistCover card" />
           </div>
           <div class="col">
              <h5> ${plMKNickName}</h5>
              <h2><b>${oneBookPL.bookPLTitle}</b></h2>
              <p>${booksList.size()}권</p>
              <c:if test="${oneBookPL.listStatus == 0}">
                 <p>공개</p>
              </c:if>
              <c:if test="${oneBookPL.listStatus == 1}">
                 <p>비공개</p>
              </c:if>
              <hr />
              <!-- 키워드 -->
              <c:forEach var="keyword" items="${keywordList}">
                    <span class="hashTag">${keyword.keyword}</span>
              </c:forEach>
              
              
              <br />
              <br />
              <br />
              <br />
             
            
              <!-- 버튼 -->
                <sec:authorize access="isAuthenticated()">
                  <sec:authentication property="principal" var="princ" /> 
                     <input type="hidden" id="loginId" value="${princ.member.id}"/>
                  
                     <script>
                           getUserScrap();
                     </script>
                       <c:set var="name" value="${princ.member.id}"/>
                     <c:set var="id" value="${oneBookPL.id}"/>
                     <c:if test= "${name ne id}">
                        <div id="scrapBtn_div">
                           
                           
                        </div>
                       
                       
                      </c:if>
               
                     <c:set var="name" value="${princ.member.id}"/>
                     <c:set var="id" value="${oneBookPL.id}"/>
                     <c:if test= "${name eq id}">
                          <button class="btn btn-secondary mt-2"  id="modifybookDTL_btn" onclick="window.location='/memData/bookPLDetailModify?list_no=${listNum}'" > 북플리 수정하기 </button>
                          <button class="btn btn-outline-dark mt-2" id="deletebookDTL_btn" > 북플리 삭제 </button>
                     </c:if>
                 </sec:authorize>
           </div>
        </div>
        <br />
        
        
        
        
      <!-- 체크박스 결과 담아서 내 리스트 추가 / 전체 선택 관련 -->
   <br />
   <div id="bPlistBox" style="display: none;">
      <div style="position: relative;" >
         <div id="countVal" >
         
         </div>
         <sec:authorize access="isAuthenticated()">
            <a data-bs-toggle="modal" href="#exampleModalToggle" >
            <button type="button" id="addBookBtn"><img src="/resources/img/folder.png" width="40px" /></button>
            내 북플리에 추가</a>
         </sec:authorize>
         <sec:authorize access="isAnonymous()">
            <a data-bs-toggle="modal" href="#exampleModalToggle" >
            <button type="button" id="addBookBtn"><img src="/resources/img/folder.png" width="40px" /></button>
            내 북플리에 추가</a>
         </sec:authorize>
      </div>
   </div>
      
      
      
      
   </div> <!-- 상단 이미지 / 제목 /  작가 / 버튼 등 끝-->
      <table id="listTable">
         <thead>
            <tr>
               <th>선택</th>
               <th>표지</th>
               <th>도서명</th>
               <th>저자</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach var="books" items="${booksList}">
               <tr>
                  <td id="small_td"><input type="checkbox" name="check" value="${books.isbn}" class="check"/></td>
                  <td><a href="/search/bookDetails?isbn=${books.isbn}"><img src="${books.bookCover}" id="bookCoverSize"/></a></td>
                  <td><label id="title">${books.bookTitle}</label></td>
                  <td><label id="author">${books.author}</label></td>
               </tr>
            </c:forEach>
            
         </tbody>
      </table>
      
      
      
      
      
      
      

      
   </div>



<!--  북플레이 리스트 추가 모달!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
    <!--******* 부모 모달 ********  -->
    <sec:authorize access="isAuthenticated()">
      <div class="modal fade" id="addtoMyPL" aria-hidden="true" aria-labelledby="addtoMyPL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-scrollable">
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
                    <div class="container">
                       <table id="settingMemPLlist">
                          
                    </table>
                    </div> <!-- div row 끝 -->
             </div>
            
            <div class="modal-footer">
                 <button type="button" id="saveBooks" class="btn btn-primary">저장</button>
            </div>
          </div>
        </div>
      </div>
   </sec:authorize>
   <sec:authorize access="isAnonymous()">
      <div class="modal fade" id="addtoMyPL" aria-hidden="true" aria-labelledby="addtoMyPL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
               <div class="modal-header">
                  <h4 class="modal-title" id="exampleModalToggleLabel"><b>로그인 후 이용하실 수 있습니다!📚</b></h4>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
            
               <div class="modal-body">
                  <span>아직 맞춤 북플리 추천 사이트 뭐읽지?의 회원이 아니신가요?</span> 
               </div>
               <div class="modal-footer">
                      <button type="button" class="btn btn-primary" onclick="window.location='/signup/signup'">회원가입</button>
               </div>
            </div>
         </div>
      </div>
   </sec:authorize>

   
   
   
   <!--******* + 새 북 플레이리스트 생성 모달 ********  -->
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
   
   
   
      <!--******* 자식모달2 ********  -->
   <div class="modal fade" id="exampleModalToggle3" aria-hidden="true" aria-labelledby="exampleModalToggleLabel3" tabindex="-1">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal- title" id="exampleModalToggleLabel3">새 북플레이리스트 완료</h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
         <p> 선택한도서 <b>[ 천개의 파랑 ]</b> 가</p>
         <h5><b>'내가 보려고 만든 북플리'</b> 으로 저장되었습니다.</h5>
         <label>나만의 북플레이 리스트를 꾸며보세요!</label>
         </div>
         
        <div class="modal-footer">
          <sec:authorize access="hasRole('ROLE_MEMBER')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/memMypage'">마이페이지</button>
        </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/adminMypage'">마이페이지</button>
         </sec:authorize>
           
           
           <button class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">확인</button>
         </div>
       </div>
     </div>
   </div>
<!--  북플레이 리스트 추가 모달 END !!!!!!!!!!!!!!!!!!!!!!!!!!!-->



<!-- 삭제요청 눌렀을 때 모달  -->
<div class="modal fade"  id="cancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북 플레이리스트 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>북 플레이리스트 [ ${oneBookPL.bookPLTitle} ] 를 삭제하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="deletePL">삭제</button>
      </div>
    </div>
  </div>
</div>



<!-- 삭제요청 완료 때 모달  -->
<div class="modal fade"  id="successCancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북 플레이리스트 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>삭제가 완료 되었습니다.</p>
      </div>
      <div class="modal-footer">
      
           <sec:authorize access="hasRole('ROLE_MEMBER')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/memMypage'">확인</button>
        </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/adminMypage'">확인</button>
         </sec:authorize>
        
      </div>
    </div>
  </div>
</div>



<!-- 책추가 완료 때 모달  -->
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
        <sec:authorize access="hasRole('ROLE_MEMBER')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/memMypage'">확인</button>
        </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/adminMypage'">확인</button>
         </sec:authorize>
       
        
      </div>
    </div>
  </div>
</div>
   
   
 
 <!-- 찜하기 완료 때 모달  -->
<div class="modal fade"  id="successScrap" tabindex="-1" aria-hidden="true" aria-labelledby="successScrap">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북플리 찜하기 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>북플리 찜하기가 완료되었습니다 :)</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>


 <!-- 찜하기 취소 완료때 모달  -->
<div class="modal fade"  id="successCancelScrap" tabindex="-1" aria-hidden="true" aria-labelledby="successScrap">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북플리 찜하기 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>북플리 찜하기 해제가 완료되었습니다 :)</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
   
   
  <!-- ************************************ 스크립트!!!!!!!!!!!!!!!! ******************** --> 
  <script>
  
      // 이 북플리를 나의 목록에 추가 버튼 눌렀을 시 
      $("#scrapBtn_div").on('click', "#bookDTL_btn",function(){
         console.log("북플리 나의목록에 추가 버튼 클릭!!");
         
            var list_no = ${listNum}; // 현재 리스트 번호 보내기
            var id = $("#loginId").val();     // 로그인한 아이디 보내기
            let bookListReqData = { 'id': id, 'list_no': list_no};
            console.log(bookListReqData);
            
            // 북 플레이 찜하기!!
            $.ajax({
               type : "POST",
               url : "/memData/scrapRDList",
               data: JSON.stringify(bookListReqData),
               contentType: "application/json;charset=utf-8",
                  beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
                  },
                  success: function(result){
                      console.log("북 플레이리스트 찜하기 요청 성공!!!!!");
                      console.log(result);
                      $("#successScrap").modal("show");
                      $("#bookDTL_btn").hide();
                      $("#scrapBtn_div").html("<button class='btn btn-secondary mt-2' id='cancelbookDTL_btn'> - 북플리 찜하기 해제</button>");
                   },
                   error: function(e){
                      console.log("북 플레이 리스트 찜하기 요청 에러......");
                      console.log(e);
                   }
            });

         });
      
      
      
         
   // 찜하기 해제 버튼 이벤트 처리  
   $("#scrapBtn_div").on('click', "#cancelbookDTL_btn",function(){
         console.log("추가한 북플리 취소 버튼 클릭!!");
         
            var list_no = ${listNum}; // 현재 리스트 번호 보내기
            var id = $("#loginId").val();     // 로그인한 아이디 보내기
            let bookListReqData = {'id': id, 'list_no': list_no};
            console.log(bookListReqData);

            // 북 플레이 찜하기 취소!!!
            $.ajax({
               type : "POST",
               url : "/memData/cancelScrapRDList",
               data: JSON.stringify(bookListReqData),
               contentType: "application/json;charset=utf-8",
                  beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
                  },
                  success: function(result){
                      console.log("북 플레이리스트 찜하기 요청 성공!!!!!");
                      console.log(result);
                      $("#successCancelScrap").modal("show");
                      $("#cancelbookDTL_btn").hide();
                      $("#scrapBtn_div").html("<button class='btn btn-primary mt-2' id='bookDTL_btn'> + 북플리 찜하기</button>");
                   },
                   error: function(e){
                      console.log("북 플레이 리스트 찜하기 요청 에러......");
                      console.log(e);
                   }
            });

         });
   
   
   
      
      // 삭제 버튼 눌렀을 시
      $("#deletebookDTL_btn").on('click', function(){
         
         $("#cancelmodal").modal("show");

      });
      
      // 삭제
      $("#deletePL").on('click', function(){
         $("#cancelmodal").modal("hide");
         var list_no = ${listNum}; // 현재 리스트 번호 보내기
         $.ajax({
            type : "POST",
            url : "/memData/deleteBookList",
            data: JSON.stringify(list_no),
            contentType: "application/json;charset=utf-8",
               beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
               },
               success: function(result){
                   console.log("북 플레이 리스트 삭제 요청 성공!!!!!");
                   console.log(result);
                   $("#successCancelmodal").modal("show");
                },
                error: function(e){
                   console.log("북 플레이 리스트 삭제 요청 에러......");
                   console.log(e);
                }
         });
      });

   // 임시저장 리스트   
   
   let isbnList = new Array();
   let imgValList = new Array();
   let titleList = new Array();
   let authorList = new Array();
   
      $(document).ready(function(){ 
   
         
         $("input[type='checkbox']").on('change', function(){
            if($(this).is(":checked")){  // 체크 됐을때 
            var isbn = $(this).val();
            trTag = $(this).parent().parent().clone();     
           var imgVal = trTag.find("img").attr("src");
           var title = trTag.find("#title").text();
           var author = trTag.find("#author").text();
           
            console.log(isbn);
            console.log(imgVal);
            console.log(title);
            console.log(author);
            
            isbnList.push(isbn);
            imgValList.push(imgVal);
            titleList.push(title);
            authorList.push(author);
            
            }else { // 체크 해제 됐을때 
               for(let i = 0; i < isbnList.length; i++){
                  if(isbnList[i] == $(this).val()){
                    isbnList.splice(i, 1);
                    imgValList.splice(i, 1);
                    titleList.splice(i, 1);
                    authorList.splice(i, 1);
                  }
               }
            }
            console.log(isbnList);
            console.log(imgValList);
            console.log(titleList);
            console.log(authorList);
         var selectVal = isbnList.length;
         $('#countVal').html(selectVal);
            
            
         });
      });
         
      
      $('.check').on('click', function(){
         let isChk = $('.check').is(':checked');
             if(isChk){
                $("#bPlistBox").show();
              } else {
                 $("#bPlistBox").hide();
              }
      });
     
      
      
   // 책 선택 후 북플리에 추가 눌렀을 때  !!!!!!!!! 수정해야함
   $("#addBookBtn").on('click', function(e){
         var id = $("#loginId").val();
         
         if(id == "" || id == "undefined" || id === null){
            e.stopPropagation();
         }else{
            //var id = $("#loginId").val();     // 로그인한 아이디 보내기
         
         console.log("로그인 아이디 : " + id);
         $("#addtoMyPL").modal("show");
         $("#selecBooks").empty();
         
         var showBooks ;
         for(let i=0; i<isbnList.length; i++){
            showBooks = "<span>";
            showBooks += "<b>"+titleList[i]+"</b></span>";
         }//for문
            console.log(showBooks);
            $("#selecBooks").html(showBooks);
         
            // 회원이가지고 있는 북플리리스트 요청
            getMemPLlist();
         };
            
   });
   
   
   // 책 선택 후 추가 버튼 눌렀을 때 모달처리
   // 회원이 가지고 있는 북리스트 가져오기
   var resultMemPLlist = new Array(); // 가져온 회원 플리 리스트 저장할 변수
   var ch = 0;
   function getMemPLlist(){
      console.log("회원이 가지고 있는 북플리 다 불러오기");
      
      
      $.ajax({
         url: "/mypage/getMemPL.json",
         type: "get",
         datatype: "JSON",
         success: function(result) {
            console.log("ajax success");
            console.log(result);
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
            console.log(resultMemPLlist);
         },
         error: function(e){
            console.log("ajax error");
            console.log(e);
            
         }
         
      });
   }
   
   
   
   var selectedListNum; 
   // 모달안에서 북플레이 리스트 선택했을 때 처리 메서드
     $("#settingMemPLlist").on("click", ".saveSelect",function(){
             console.log("플레이리스트 선택 !!");
        
       if($(this).is(":checked")){  // 체크 됐을때 
          selectedListNum = $(this).val();
             console.log(selectedListNum);
       }
     });

   
   
   // 모달 누르면 저장 하는 처리 메서드
   $("#saveBooks").on("click", function(){
      console.log("저장 버튼 클릭!!");
      
      var savePlBooks = new Array();
      
      for(let i=0 ; i<isbnList.length ; i++){
         savePlBooks.push({"list_no": selectedListNum ,"isbn" : isbnList[i], "bookTitle" : titleList[i], "author" :authorList[i], "bookCover" : imgValList[i]});
      }
      console.log(savePlBooks);
      
      $.ajax({
         type: "POST",
         url : "/memData/addSavePlBooks",
         data: JSON.stringify(savePlBooks),
         contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
            },
            success: function(result){
                console.log("책 추가 요청 성공!!!!!");
                console.log(result);
                $("#addtoMyPL").modal("hide");
                $("#successAddBooksmodal").modal("show");
             },
             error: function(e){
                console.log("책 추가 요청 에러......");
                console.log(e);
             }
         
      });
      
      
   });
  
   
   // 모달에서 새 플레이리스트 생성 버튼 메서드 처리
   $("#newPLcreate").on("click", function(){
      console.log("새 플레이리스트 생성 버튼 클릭");
      
      $("#addtoMyPL").modal("hide");
      $("#newCreatePL").modal("show");
      $('#bookPLtitle').val("");
   });
   
   
   var id = $("#loginId").val();     // 로그인한 아이디 보내기
   // 새플레이리스트 생성 모달에서 생성 버튼 처리
   $("#creatPLBtn").on("click", function(){
      console.log("새 플레이리스트 생성 요청!!!");
      
      var listTitle = $("#bookPLtitle").val();
      var status =  parseInt($("#listStatus").val());
      var createPL = {"id" : id, "bookPLTitle" : listTitle, "listStatus" : status};
      console.log("새 플레이리스트 생성 요청 : " + createPL );
      
      
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
                console.log("북 플레이 리스트 생성 요청 성공!!!!!");
                console.log(result);
              $("#newCreatePL").modal("hide");
              getMemPLlist();
               $("#addtoMyPL").modal("show");
             },
             error: function(e){
                console.log("북 플레이 리스트 생성 요청 에러......");
                console.log(e);
             }
      });
      
      
   });
   
   
   
     
   
   
  </script>



<!-- footer 복붙 -->
<%@ include file="../includes/footer2.jsp"%>