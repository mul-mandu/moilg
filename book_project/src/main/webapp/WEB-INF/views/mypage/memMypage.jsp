<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
<link href="/resources/css/mypage.css" rel="stylesheet" type="text/css">   

<!-- 마이페이지 이미지 -->
   <div class="container" >
      <div class="mypageTOP col-md">
         <div class="image-box col-md" >
         <c:choose>
            
            <c:when test="${empty member.bgImg}"> 
               <img src="/resources/save/bgDefault.jpg" class="mypageBg" id="backPreview" />
               <div style="position: absolute; top:150%; left: 80%;">
                  <label for="backFile" >
                     <img id="backEditImg" class="img-fluid" src="/resources/img/edit.png" style="width: 25px;"/>
                  </label>
                  <button type="button" id="bgCheckBtn"><img src="/resources/img/check.png" style="width: 20px;" /></button>
                   <input type="file" name="file" id="backFile" style="display: none;" >
               </div>
            </c:when>   
            
            
            <c:otherwise>   
               <img src="/resources/save/${member.bgImg}" class="mypageBg" id="backPreview" />
               <div style="position: absolute; top:150px; left: 80%;" >
               <label for="backFile" >
                  <img id="backEditImg" src="/resources/img/edit.png" style="width: 25px;"/>
               </label>
               <button type="button" id="bgCheckBtn"><img src="/resources/img/check.png" style="width: 20px;" /></button>
               <input type="file" name="file" id="backFile" style="display: none;" >
            </div>
            </c:otherwise>
            
         </c:choose>
         </div>
         
         <c:choose>
            
            <c:when test="${empty member.photo }">
               <img src="/resources/save/user.png" class="mypageProfile" id="preview" style="position: relative;"/>
            <div style="position: absolute; top:440px; left: 28%;" >
               <label for="file" >
                  <img id="editImg" src="/resources/img/edit.png" style="width: 25px;"/>
               </label>
               <button type="button" id="profileCheckBtn"><img src="/resources/img/check.png" style="width: 20px;" /></button>
            </div>
                <input type="file" name="file" id="file" style="display: none;" >
           </c:when>
           
          
           <c:otherwise>
               <img src="/resources/save/${member.photo}" class="mypageProfile" id="preview" style="position: relative;"/>
             <div style="position: absolute; top:440px; left: 28%;" >
               <label for="file" >
                  <img id="editImg" src="/resources/img/edit.png" style="width: 25px;"/>
               </label>
               <button type="button" id="profileCheckBtn"><img src="/resources/img/check.png" style="width: 20px;" /></button>
            </div>
            <input type="file" name="file" id="file" style="display: none;" >
           </c:otherwise>
         </c:choose>   
            <br/>
            <br/>
       </div> 
   
   
   
   
   
   
   
      <!-- 마이페이지 메뉴바 -->
         <div class="row">
            <div class="col-3">
               <div id="mpMbtiBox">
                  <div class="row countBox">
                     <div class="topDiv">${member.nickName }</div>
                     <div class="col-md-auto">
                           <span><b>${myPLlistCount}</b></span><br />
                           <span style="font-size:15px;">내 리스트</span>
                     </div>
                     <div class="col-md-auto">
                        <span><b>${readBookCount }</b></span><br />
                        <span style="font-size:15px;">읽은책</span>
                     </div>
                     <div class="col-md-auto">
                        <%-- <span><b>${member.mbti}</b></span><br /> --%>
                        <span><b>${member.mbti}</b></span><br />
                        <span style="font-size:15px;">독서유형</span>
                     </div>  
                  </div>
               </div> <!-- MBTI박스 -->
               <br />
               
               
               <!-- 사이드 메뉴바 -->
               <div>
                  <ul class="nav flex-column tab_title" >
                     <li class="nav-link on">나의 북플리</li>
                     <li class="nav-link" >나의 책</li>
                     <li class="nav-link" >문장 기록</li>
                     <li class="nav-link" >나의 댓글</li>
                     <li class="nav-link">회원정보</li>
                  </ul>
               </div>
            </div> <!-- 사이드 메뉴바 -->
          
            
            
            
            
            <!-- 사이드 메뉴 콘텐츠 -->
            <div class="col-9">
               <div class="tab_cont">
                  <div class="on">
                     <h2>나의 북플리</h2>
                     <hr />  
                      <!-- CONTENTS 안의 탭메뉴 -->            
                           <div>
                              <ul class="nav nav-tabs" >
                           <li class="nav-link onandon">나의 북플리</li>
                           <li class="nav-link onandon">찜한 북플리</li>
                              </ul>
                           </div>            
                      <!-- contents 탭메뉴의 내용-->
                      <div class="tab_cont2">
                         <div class="onandon">
                             <!-- 나의 북플리 뿌리기 -->
                             <br />
                            <button type="button" class="btn btn-outline-primary btn-sm" style="float: right;" onclick="window.location='/memData/bookPlistMakeForm'">+ 추가</button> 
                            <br />    
                            <br />
                            <div class="container">
                             <div class="row">
                                   <c:forEach var="bookPL" items="${myPLlist}">
                                      <div class="col-3">
                                         <div id="onebPlist">
                                                <a href="/memData/bookPlistDetail?list_no=${bookPL.list_no}" >
                                                <img id="mybpliListImg" src="/resources/save/${bookPL.packCover}">
                                                <span>${bookPL.bookPLTitle}</span>
                                             </a>
                                         </div>
                                      </div> <!-- item --> 
                                   </c:forEach>
                              </div> <!-- row -->
                            </div>
                         </div>
                         
                         
                         
                           <!-- 찜한 북플리 뿌리기 -->
                         <div style="display:none;">
                            <div class="container">
                             <div class="row">
                                  <c:forEach var="scrapBookPL" items="${scrapBookPLs}">
                                      <div class="col-3">
                                         <div id="onebPlist">
                                                <a href="/memData/bookPlistDetail?list_no=${scrapBookPL.list_no}" >
                                                <img id="mybpliListImg" src="/resources/save/${scrapBookPL.packCover}">
                                                <span>${scrapBookPL.bookPLTitle}</span>
                                             </a>
                                         </div>
                                      </div> <!-- item --> 
                                   </c:forEach> 
                              </div> <!-- row -->
                            </div>
                        </div>
                        </div>
                        </div>
                  
                  
                  
                  
                  <div style="display:none;">
                     <h2>나의 책</h2>
                     <hr />
                           <!-- CONTENTS 안의 탭메뉴 -->            
                           <div>
                              <ul class="nav nav-tabs" >
                           <li class="nav-link onandon">읽고 싶은 책</li>
                           <li class="nav-link onandon">읽은 책</li>
                              </ul>
                           </div>
                           <!-- contents 탭메뉴의 내용-->
                           <div class="tab_cont3">
                                 <div class="onandon">
                                     <!-- 나의 책목록 뿌리기 -->
                                     <br />
                                       <div class="container">
                                         <div class="row">
                                              <c:forEach var="wantBook" items="${wantBookList}">
                                               <div class="col-3">
                                                    <div id="oneBook">
                                                         <a href="/search/bookDetails/?isbn=${wantBook.isbn }" >
                                                            <img id="myBlistImg" src="${wantBook.bookCover }">
                                                         </a>
                                                         <hr />
                                                         <p style="float: center;"><b>${wantBook.bookTitle }</b></p>
                                                         <p style="float: center; font-size: 13px; color: grey;"><b>${wantBook.author}</b></p>
                                                     </div>
                                               </div> <!-- item --> 
                                              </c:forEach>
                                          </div> <!-- row -->
                                       </div>   <!-- 책목록 container끝 -->
                                 </div>
                                 <div style="display:none;">
                                    <!-- 나의 읽은 책목록 뿌리기 -->
                                    <br />
                                    <div class="container">
                                      <div class="row">
                                      <c:forEach var="finBook" items="${finBookList }">
                                            <div class="col-3">
                                                 <div id="oneBook">
                                                      <a href="/search/bookDetails/?isbn=${finBook.isbn }" >
                                                           <img id="myBlistImg" src="${finBook.bookCover }">
                                                      </a>
                                                      <hr />
                                                         <p style="float: center;"><b>${finBook.bookTitle }</b></p>
                                                         <p style="float: center; font-size: 13px; color: grey;"><b>${finBook.author}</b></p>
                                                  </div>
                                            </div> <!-- item --> 
                                         </c:forEach>
                                       </div> <!-- row -->
                                    </div>   <!-- 읽은 책목록 container끝 -->
                                 </div>
                              </div>
                        </div>
                        
                     
                        
                  <div style="display:none;">
                     <h2>문장 기록</h2>
                     <hr />
                           <!-- CONTENTS 안의 탭메뉴 -->            
                           <div>
                              <ul class="nav nav-tabs" >
                           <li class="nav-link onandon">나의 문장 카드</li>
                           <li class="nav-link onandon">좋아요한 문장 카드</li>
                              </ul>
                           </div>
                           <!-- contents 탭메뉴의 내용-->
                           <div class="tab_cont4">
                              <div class="onandon">
                                 <br />   
                                  <button type="button" class="btn btn-outline-primary btn-sm" style="float: right;" onclick="window.location='/gSentence/greatSentenceForm'">+ 추가</button> 
                                  <br />
                                  <br />
                                  <c:forEach var="sentence" items="${greatMemList }">
                                  <!-- 나의 문장 기록 뿌리기 -->
                                  <div class="row">
                                    <div class="col">
                                       <img class="userPickSTC_img" src="/resources/save/${sentence.greatImg}">
                                    </div>
                                    <div class="col">
                                       <p class="userPickSTC_text">
                                          ${sentence.greatContent }
                                       </p>

                                       <span></span>
                                       <span style="font-weight:bold; color: grey; font-size: 16px; float: right; ">공감수 10</span>
                                    </div>
                                    </div>
                                    </c:forEach>
                              </div>      
                              <hr />  
                              <div style="display:none;">            
                                  <!-- 내가 찜한 문장 뿌리기 -->
                               <div class="row">
                                    <div class="col">
                                       <img class="userPickSTC_img" src="/resources/img/leaf.jpg">
                                    </div>
                                    <div class="col">
                                       <p class="userPickSTC_text">
                                          오후 4시에 네가 온다면, 나는 3시부터 행복해지기 시작할거야
                                       </p>
                                       <p>
                                          어린왕자 中
                                       </p>
                                       <span>by. user_name</span>
                                       <span style="font-weight:bold; color: grey; font-size: 16px; float: right; ">공감수 10</span>
                                    </div>
                                    </div>
                              </div>
                              </div>
                  </div> <!-- 문장 기록 메뉴 끝 -->
                  
                  
                  <div style="display:none;">
                     <h2>나의 댓글</h2>
                     <hr />
                    <!-- CONTENTS 안의 탭메뉴 -->            
                           <div>
                              <ul class="nav nav-tabs" >
                           <li class="nav-link onandon">내가 작성한 댓글</li>
                           <li class="nav-link onandon">내가 공감한 댓글</li>
                              </ul>
                           </div>
                              <!-- contents 탭메뉴의 내용-->
                           <div class="tab_cont5">
                              <div class="onandon">
                                 <br />   
                                <!-- 나의 댓글 목록 뿌리기 -->
                                  <table id="listTable"> 
                                     <thead id="replyList">
                                 <tr>
                                    <th>No.</th>
                                    <th>내용</th>
                                    <th>날짜</th>
                                 </tr>
                              </thead>
                                     <tbody>
                              <tr>
                                 <td>1</td>
                                 <td>내용따리내용따</td>
                                 <td>regreg</td>
                              </tr>
                              </tbody>
                                  </table>
                              </div>   
                              <div style="display:none;">
                                 <br />   
                                <!-- 나의 공감 목록 뿌리기 -->
                                  <table id="listTable"> 
                                     <thead id="replyList">
                                 <tr>
                                    <th>No.</th>
                                    <th>내용</th>
                                    <th>날짜</th>
                                 </tr>
                              </thead>
                                     <tbody>
                              <tr>
                                 <td>1</td>
                                 <td>공감따리내용따</td>
                                 <td>regreg</td>
                              </tr>
                              </tbody>
                                  </table>
                              </div>   
                     </div> <!--  div tab_cont5 -->
                  </div><!-- 메뉴 끝 -->   
                  

                  
                  <div style="display:none;" id="modifyCheck">
                     <h2>회원정보수정</h2>
                     <hr />
                     <div id="memModifyPageBg">
                           <img id="memModifyIcon" src="/resources/img/catcat.jpg"/>
                           <br />
                           <br/>
                           <!-- contoller에서 비번 확인 결과 값이 true라면 페이지전환 (html 제이쿼리..?) -->
                           <h3>회원정보를 수정하시려면 비밀번호를 입력해주세요</h3>         
                           <h6>회원님의 개인정보 보호를 위한 본인 확인 절차이오니, 회원 로그인 사용하시는 비밀번호를 입력해주세요</h6>
                           <form>
                           <sec:authorize access="isAuthenticated()" >
                           <sec:authentication property="principal" var="princ" /> 
                           <input type="hidden" id="loginId" value="${princ.member.id}"/>
                          </sec:authorize>
                              <input type="password" id="mpdifyPw" name="mpdifyPw" style="width: 200px; text-align:center; margin: 5px;" placeholder="비밀번호를 입력해주세요"/> 
                              <br/>
                              <button type="reset" class="btn btn-outline-secondary" style="margin: 5px">취소</button>
                              <button type="button" class="btn btn-outline-primary" id="modifyPwCheck">확인</button>
                        </form>
                     </div>
               </div>
               
              
               
               <div style="display:none;" id="modifyMember">
                  <h2>회원정보수정</h2>
                  <hr />
                  <div id="memModifyPage">
                     <form method="POST" action="/signup/memberModify">
                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
                        <table class="signup_TBL">
                           <tr>
                              <td>* 이름</td>
                        <td> <input type="text" name="name" id="name" value="${member.name}" disabled/> </td>
                           </tr>
                           <tr>
                              <td>* 아이디</td>
                        <td> <input type="text" name="id" id="id"  value="${member.id}" disabled/> </td>
                           </tr>
                           <tr>
                              <td>* 비밀번호</td>
                        <td>  <input type="password" name="pw" id="pw"  required/> </td>
                           </tr>
                           
                           <tr>
                              <td>* 비밀번호 확인</td>
                        <td> <input type="password" name="pwCh" id="pwCh"  required/> </td>
                           </tr>
                           
                           <tr>
                                 <td></td>
                           <td> <input type="text" name="Checkpw" id="checkpw" placeholder="비밀번호 체크" disabled/> </td>
                           </tr>
                           
                           <tr>
                              <td>* 닉네임</td>
                        <td> <input type="text" name="nickName" id="nickName" value="${member.nickName}"  required/> </td>
                           </tr>
                           <tr>
                              <td></td>
                        <td> <input type="text" name="nickCheck" id="nickCheck" placeholder="닉네임 체크" disabled/> </td>
                           </tr>
                           
                           <tr>
                              <td>* 이메일</td>
                        <td>  <input type="text" name="email" id="email"  value="${member.email}"  required/> </td>
                           </tr>
                           
                           <tr>
                              <td>생년월일</td>
                        <td> 
                           <input type="date" name="birth" id="birth" value="${member.birth}"/>  &nbsp; &nbsp;
                            <input type="radio" id="female" name="gender" value="female" checked disabled>&nbsp; 여 &nbsp;&nbsp;
                                <input type="radio" id="male" name="gender" value="male" disabled>&nbsp; 남
                             </td>
                           </tr>
                           
                        </table>
                           <br />
                           <br />
                           <button class="btn btn-outline-secondary btn-sm" type="button" id="outMember">탈퇴하기</button>
                           <br />
                           <br />
                           
                        <button type="reset" class="btn btn-outline-secondary" style="margin: 5px">취소</button>
                        <button type="submit" class="btn btn-outline-primary">수정</button>
                      
                        <br/>
                     </form>
                         
                  </div>
               </div>
               
               
               </div> <!-- tab_cont -->
      </div><!-- col-9 -->
     </div>
   </div><!-- container 끝 -->
   
   
   <!-- 탈퇴눌렀을 때 모달  -->
   <div class="modal fade"  id="deleteMember_modal" tabindex="-1" aria-hidden="true" aria-labelledby="deleteMember_modal" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title">회원 탈퇴</h5>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
           <p id="deleteMent">탈퇴 하시겠습니까? </p>
         </div>
         <div class="modal-footer" id="delete-Footer">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
           <button type="button" class="btn btn-primary" id="deleteMember">탈퇴</button>
         </div>
       </div>
     </div>
   </div>
   
   
     <!-- 탈퇴 되면 처리할 로그아웃처리  -->
    <form action="/logout" method="post" style="display:none;" id="logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
   </form>  
   

<script>

$(document).ready(function() {
   
      //첫번째 탭(사이드메뉴 탭)
       $(".tab_title li").click(function() {
          var idx = $(this).index();
          $(".tab_title li").removeClass("on");
          $(".tab_title li").eq(idx).addClass("on");
          $(".tab_cont > div").hide();
          $(".tab_cont > div").eq(idx).show();
        })
        
    
        // ********************************************************************* //
     
       //두번째 탭(컨텐트 안의 탭))
       $(".nav-tabs li").click(function() {
          var idx = $(this).index();
          $(".nav-tabs li").removeClass("onandon");
          $(".nav-tabs li").eq(idx).addClass("onandon");
          $(".tab_cont2 > div").hide();
          $(".tab_cont2 > div").eq(idx).show();
        });

    
    

       //세번째 탭(컨텐트 안의 탭))
       $(".nav-tabs li").click(function() {
          var idx = $(this).index();
          $(".nav-tabs li").removeClass("onandon");
          $(".nav-tabs li").eq(idx).addClass("onandon");
          $(".tab_cont3 > div").hide();
          $(".tab_cont3 > div").eq(idx).show();
        });
       
       
       //세번째 탭(컨텐트 안의 탭))
       $(".nav-tabs li").click(function() {
          var idx = $(this).index();
          $(".nav-tabs li").removeClass("onandon");
          $(".nav-tabs li").eq(idx).addClass("onandon");
          $(".tab_cont4 > div").hide();
          $(".tab_cont4 > div").eq(idx).show();
        });
       

       //네번째 탭(컨텐트 안의 탭))
       $(".nav-tabs li").click(function() {
          var idx = $(this).index();
          $(".nav-tabs li").removeClass("onandon");
          $(".nav-tabs li").eq(idx).addClass("onandon");
          $(".tab_cont5 > div").hide();
          $(".tab_cont5 > div").eq(idx).show();
        });

       
       

       // 회원정보 수정
       $("#memModifyPageBg").on("click", "#modifyPwCheck", function(){
          // 회원정보 수정 비밀번호 체크 확인 클릭!!!
          console.log("회원정보 수정 비밀번호 체크 확인 클릭!!!");
          
          var pw = $("#mpdifyPw").val();
          var id = $("#loginId").val();
          console.log("입력한 비번 : " + pw);
          
          // 비밀번호 확인하기!!
             $.ajax({
                  type: "post",
                  url: "/signup/pwCheck.json",
                  data: {'id': id ,'pw' : pw},
                  beforeSend: function(xhr){
                         xhr.setRequestHeader(header, token);
                     },
                  success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
                     console.log("success");
                     console.log(result);
                     var re = result;
                     if(re == 1){
                        
                        $("#modifyCheck").hide();
                        $("#modifyMember").show();
                        
                        
                     }else{
                        alert("비밀번호가 맞지 않습니다.");
                        $("#mpdifyPw").val("");
                     }
                  },
                  error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
                     console.log(e);
                     }
               });
          
          
          
       });
  

       
});
</script>

  <script>
  
   $("#memModifyPage").on("click","#outMember", function(){
      console.log("탈퇴버튼 클릭!!!");
      $("#deleteMember_modal").modal("show");
   });
   
   
   
   
   $("#delete-Footer").on("click", "#deleteMember", function(){
      console.log("진짜 탈퇴 버튼 클릭!!");
      
       $.ajax({
           type: "post",
           url: "/signup/deleteMember.json",
           beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
           },
           success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
              console.log("success");
              console.log(result);
              if(result == 2){
                 $("#deleteMember_modal").modal("hide");
                 alert("탈퇴처리가 완료 되었습니다.");
                 let formObj = $("#logout");
                 formObj.submit();
              }else{
                 alert("탈퇴처리 실패했습니다... 다시 시도해주세요");
              }
              
           },
           error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
              console.log(e);
              }
        });
      
      
   });
   
  
  
  
  
   $("#memModifyPage").on("change", "#nickName", function(){
       console.log("닉네임 값 입력함!!!");
       let nickName = $(this).val();
       
         $.ajax({
           type: "post",
           url: "/signup/nickNameAvail",
           data: {'nickName' : nickName},
           beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
           success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
              console.log("success");
              console.log(result);
              // 결과를 아이디사용가능 여부 input테그에 value값으로 띄워주기
              $("#nickCheck").val(result);
           },
           error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
              console.log(e);
              }
        });
   });
   


   var pwVal = "";
      // 비밀번호 입력
         $("#memModifyPage").on("change", "#pw", function(){ 
        console.log("비밀번호 값 입력함!!!");
        pwVal = $(this).val();
        console.log("비밀번호 : " + pwVal);
        console.log("비밀번호 확인 : " + pwchVal);
     });
   
     
     // 비밀번호, 비밀번호 확인 체크
     $("#memModifyPage").on("change", "#pwCh", function(){
        console.log("비밀번호 확인 값 입력함!!!");
          let pwchVal = $(this).val();
        console.log("비밀번호 : " + pwVal);
        console.log("비밀번호 확인 : " + pwchVal);
       
       if(pwVal != pwchVal){
          $("#checkpw").val("확인란이 일치하지 않습니다.");
       }else{
          $("#checkpw").val("비밀번호 확인이 일치합니다");
       }
        
     });
     
   

   
</script>



<script>

   //프로필
   $('#file').change(function(){
       setImageFromFile(this, '#preview');
       
    }); //파일 change
    
 
 $('#profileCheckBtn').on("click", function(){
    console.log("프로필 수정 하기!!!!!")
    //프로필 이미지 담아서 ajax 날리기
    var data = new FormData();
    var file = $('#file')[0].files[0];
    
    data.append('profile', file);
    console.log(data.get('profile'));
    
    for (var pair of data.entries()) {
            console.log(pair[0]+ ', ' + pair[1]);
     }
    
       // 내 프로필 ajax 보내기
       $.ajax({
          type : "POST",
          url : "/signup/updateProfile",
          data: data,
          contentType: false,
          processData: false,
          enctype: 'multipart/form-data',
             beforeSend: function(xhr){
             xhr.setRequestHeader(header, token);
          },
          success: function(result){
              console.log("프로필 등록 성공!!!!!");
              console.log(result);
              alert("프로필 등록이 완료 되었습니다!🖼");
           },
           error: function(e){
              console.log("프로필 등록 요청 에러......");
              console.log(e);
           }
       })//에이작스
    
 });  //에딧이미지 클릭
     
 
 function setImageFromFile(input, expression) {
     if (input.files && input.files[0])
     {
         var reader = new FileReader();
  
             reader.onload = function (e) {
                 $(expression).attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
      }
 }
 
 
 
 
 
   //배경
   $('#backFile').change(function(){
       setImageFrombackFile(this, '#backPreview');
       
    }); //파일 change
    
 
 $('#bgCheckBtn').on("click", function(){
    console.log("프로필 수정 하기!!!!!")
    //프로필 이미지 담아서 ajax 날리기
    var data = new FormData();
    var file = $('#backFile')[0].files[0];
    
    data.append('bgFile', file);
    console.log(data.get('bgFile'));
    
    for (var pair of data.entries()) {
            console.log(pair[0]+ ', ' + pair[1]);
     }
    
       // 내 프로필 ajax 보내기
       $.ajax({
          type : "POST",
          url : "/signup/updateBackground",
          data: data,
          contentType: false,
          processData: false,
          enctype: 'multipart/form-data',
             beforeSend: function(xhr){
             xhr.setRequestHeader(header, token);
          },
          success: function(result){
              console.log("배경 등록 성공!!!!!");
              console.log(result);
              alert("배경 등록이 완료 되었습니다!😎");
           },
           error: function(e){
              console.log("배경 등록 요청 에러......");
              console.log(e);
           }
       })//에이작스
    
 });  //에딧이미지 클릭
     
 
 function setImageFrombackFile(input, expression) {
     if (input.files && input.files[0])
     {
         var reader = new FileReader();
  
             reader.onload = function (e) {
                 $(expression).attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
      }
 }

/* 


   //백그라운드 이미지 변경
   
   $('#backFile').change(function(){
      setImageFromBackFile(this, '#backPreview');
      
   }); //파일 change
   
   $("#bgCheckBtn").on("click", function(){
      console.log("프로필 수정 하기!!!!!")
      //백이미지 이미지 담아서 ajax 날리기
      var data = new FormData();
      var file = $('#backFile')[0].files[0];
      
      data.append('bgFile', file);
      console.log(data.get('bgFile'));
      
      for (var pair of data.entries()) {
              console.log(pair[0]+ ', ' + pair[1]);
       }
      
         // 내 백이미지 ajax 보내기
         $.ajax({
            type : "POST",
            url : "/signup/updateBackground",
            data: data,
            contentType: false,
            processData: false,
            enctype: 'multipart/form-data',
              beforeSend: function(xhr){
              xhr.setRequestHeader(header, token);
           },
           success: function(result){
               console.log("프로필 등록 성공!!!!!");
               console.log(result);
               alert("마이페이지 배경 사진이 등록되었습니다😎);
            },
            error: function(e){
               console.log("배경 등록 요청 에러......");
               console.log(e);
            }
         })//에이작스
      
   });  //체크클릭
       
   
   function setImageFromBackFile(input, expression) {
       if (input.files && input.files[0])
       {
           var reader = new FileReader();
    
               reader.onload = function (e) {
                   $(expression).attr('src', e.target.result);
              }
              reader.readAsDataURL(input.files[0]);
        }
   } */

   

</script>

<!-- footer 복붙 -->
<%@ include file="../includes/footer.jsp"%>