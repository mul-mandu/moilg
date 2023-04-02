<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- header 복붙 --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../includes/header.jsp" %>
<link href="/resources/css/mypage.css" rel="stylesheet" type="text/css">
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>

<style>
      #columns{
        column-width: 22rem;
        column-gap: 15px;
      }
      #columns figure{
        display: inline-block;
        margin:0;
        /* margin-bottom: 15px; */
        padding:10px;
      }
      
     /*  #columns figure img{
        width:100%;
      } */
     /*  #columns figure figcaption{
         padding:10px;
        margin-top:11px;
      } */
</style>

<%-- 마이페이지 이미지 --%>
   <div class="container" >
      <div class="mypageTOP col-md">
         <div class="image-box col-md" >
         <c:choose>
            
            <c:when test="${empty member.bgImg}"> 
               <img src="/resources/save/bgDefault.jpg" class="mypageBg" id="backPreview" />
               <div style="position: absolute; top:17%; left: 80%;">
                  <label for="backFile" >
                     <img id="backEditImg" class="img-fluid" src="/resources/img/edit.png" style="width: 25px;"/>
                  </label>
                  <button type="button" id="bgCheckBtn"><img src="/resources/img/check.png" style="width: 25px;" /></button>
                   <input type="file" name="file" id="backFile" style="display: none;" >
               </div>
            </c:when>   
            
            
            <c:otherwise>   
               <img src="/resources/save/${member.bgImg}" class="mypageBg" id="backPreview" />
               <div style="position: absolute; top:150px; left: 80%;" >
               <label for="backFile" >
                  <img id="backEditImg" src="/resources/img/edit.png" style="width: 25px;"/>
               </label>
               <button type="button" id="bgCheckBtn"><img src="/resources/img/check.png" style="width: 25px;" /></button>
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
               <button type="button" id="profileCheckBtn"><img src="/resources/img/check.png" style="width: 25px;" /></button>
            </div>
                <input type="file" name="file" id="file" style="display: none;" >
           </c:when>
           
          
           <c:otherwise>
               <img src="/resources/save/${member.photo}" class="mypageProfile" id="preview" style="position: relative;"/>
             <div style="position: absolute; top:440px; left: 28%;" >
               <label for="file" >
                  <img id="editImg" src="/resources/img/edit.png" style="width: 25px;"/>
               </label>
               <button type="button" id="profileCheckBtn"><img src="/resources/img/check.png" style="width: 25px;" /></button>
            </div>
            <input type="file" name="file" id="file" style="display: none;" >
           </c:otherwise>
         </c:choose>   
            <br/>
            <br/>
       </div> 
   
   
   
   
   
   
   
      <%-- 마이페이지 메뉴바 --%>
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
               </div> <%-- MBTI박스 --%>
               <br />
               
               
               <%-- 사이드 메뉴바 --%>
               <div>
                  <ul class="nav flex-column tab_title" >
                     <li class="nav-link on">나의 북플리</li>
                     <li class="nav-link" >나의 책</li>
                     <li class="nav-link" >문장 기록</li>
                     <li class="nav-link" >나의 댓글</li>
                     <li class="nav-link">회원정보</li>
                  </ul>
               </div>
            </div> <%-- 사이드 메뉴바 --%>
          




            
            
            
            <%-- 사이드 메뉴 콘텐츠 --%>
            <div class="col-9">
               <div class="tab_cont">


				<div class="on">
					<h2>나의 북플리</h2>
					<hr />
					<%-- CONTENTS 안의 탭메뉴 --%>
					<div>
						<nav>
							<div class="nav nav-tabs myBookPL" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-myBookPL-tab" data-bs-toggle="tab" data-bs-target="#nav-myBookPL" type="button" role="tab" aria-controls="nav-myBookPL"
									aria-selected="true">나의 북플리</button>
								<button class="nav-link" id="nav-scriptBPL-tab" data-bs-toggle="tab" data-bs-target="#nav-scriptBPL" type="button" role="tab" aria-controls="nav-scriptBPL"
									aria-selected="false">찜한 북플리</button>
							</div>
						</nav>
					</div>


					<%-- contents 탭메뉴의 내용--%>
					<div class="tab-content" id="nav-tabContent">
						<%-- 나의 북플리 뿌리기 --%>
						<div class="tab-pane fade show active" id="nav-myBookPL"
							role="tabpanel" aria-labelledby="nav-myBookPL-tab" tabindex="0">
							<br />
							<button type="button" class="btn btn-outline-primary"
								style="float: right;"
								onclick="window.location='/memData/bookPlistMakeForm'">+
								북플리 생성하기</button>
							<br /> <br />
							<div class="container">
								<div class="row" id="setBook">
									<%-- 북플리 뿌리기  --%>
								</div>
								<%-- row --%>
							</div>

							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
						</div>
						<%-- 탭 1개  --%>


						<%-- 찜한 북플리 뿌리기 --%>
						<div class="tab-pane fade" id="nav-scriptBPL" role="tabpanel" aria-labelledby="nav-scriptBPL-tab" tabindex="0">
							<br/>
							<div class="container">
								<div class="row" id="setScrapBookPL">
									
								</div>
								<%-- row --%>
							</div>
							
							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination scrapPagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
						</div>
						
					</div> <%-- tab2  --%>
				</div>
				<%-- on --%>




				<%-- 나의 책 메뉴 ------------------------------------------------------------------------------------------%>
				<div style="display: none;">
					<h2>나의 책</h2>
					<hr />
					<%-- CONTENTS 안의 탭메뉴 --%>
					<div>
						<nav>
							<div class="nav nav-tabs myBooks" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-wantBook-tab" data-bs-toggle="tab" data-bs-target="#nav-wantBook" type="button" role="tab" aria-controls="nav-wantBook"
									aria-selected="true">읽고 싶은 책</button>
								<button class="nav-link" id="nav-finishBook-tab" data-bs-toggle="tab" data-bs-target="#nav-finishBook" type="button" role="tab" aria-controls="nav-finishBook"
									aria-selected="false">읽은 책</button>
							</div>
						</nav>
					</div>

					<br />
					<%-- contents 탭메뉴의 내용--%>
					<div class="tab-content tab3" id="nav-tabContent">
						<%-- 읽고 싶은 책 뿌리기 --%>
						<br />
						<div class="tab-pane fade show active" id="nav-wantBook" role="tabpanel" aria-labelledby="nav-wantBook-tab" tabindex="0">
							<div class="container">
								<div class="row" id="setWantBooks">
										
								</div> <%-- row --%>
							</div> <%-- container --%>
							
							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination wantBookPagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
							
						</div> <%-- fade --%>


						<%-- 나의 읽은 책목록 뿌리기 --%>
						<div class="tab-pane fade" id="nav-finishBook" role="tabpanel" aria-labelledby="nav-finishBook-tab" tabindex="0">
							<div class="container">
								<div class="row" id="setReadBooks">
									
									
								</div><%-- row --%>
							</div> <%-- 읽은 책목록 container끝 --%>
							
							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination readBookPagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
							
						</div>
					</div> <%-- tab3 --%>
				</div> <%-- 나의 책 끝 style div --%>





				<sec:authentication property="principal" var="princ" /> 
				<%-- 나의 문장 기록 --------------------------------------------------------------------------%>
				<div style="display: none;">
					<h2>문장 기록</h2>
					<hr />
					<%-- CONTENTS 안의 탭메뉴  --%>
					<div>
						<nav>
							<div class="nav nav-tabs mySentences" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-mySentence-tab" data-bs-toggle="tab" data-bs-target="#nav-mySentence" type="button" role="tab" aria-controls="nav-mySentence"
									aria-selected="true">나의 문장 카드</button>
								<button class="nav-link" id="nav-likeSentence-tab" data-bs-toggle="tab" data-bs-target="#nav-likeSentence" type="button" role="tab" aria-controls="nav-likeSentence"
									aria-selected="false">좋아요한 문장 카드</button>
							</div>
						</nav>
					</div>


					<%-- contents 탭메뉴의 내용--%>
					<div class="tab-content tab4" id="nav-tabContent">
						<br />
						<div class="tab-pane fade show active" id="nav-mySentence" role="tabpanel" aria-labelledby="nav-mySentence-tab" tabindex="0">
							<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="window.location='/gSentence/greatSentenceForm'">
								+ 문장 기록하기
							</button>
							<br /> <br />
							<div class="container">
								<div class="setMySentence" id="columns">
										<%-- 나의 문장 기록 뿌리기 --%>

								</div>
							</div> 
							
							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination mySentencePagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
							
						</div>


						<br />

						<%-- 내가 찜한 문장 뿌리기 --%>
						<div class="tab-pane fade" id="nav-likeSentence" role="tabpanel"
							aria-labelledby="nav-likeSentence-tab" tabindex="0">
							<div class="container">
								<div class="setLikeSentence" id="columns">
										
								</div>
							</div>
							
							<br />
							<br />
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination myLikeSentencePagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
							
						</div>

					</div>
					<%-- tab-content --%>
				</div>
				<%-- 문장 기록 메뉴 끝 div style--%>


				
				<%-- 나의 댓글 -------------------------------------------------------------------------------------------  --%>
				<div style="display: none;">
					<h2>나의 댓글</h2>
					<hr />
					<%-- CONTENTS 안의 탭메뉴 --%>
					<div>
						<nav>
							<div class="nav nav-tabs myReplys" id="nav-tab" role="tablist">
								<button class="nav-link active" id="nav-myReply-tab" data-bs-toggle="tab" data-bs-target="#nav-myReply" type="button" role="tab" aria-controls="nav-myReply"
									aria-selected="true">내가 작성한 댓글</button>
								<button class="nav-link" id="nav-likeReply-tab" data-bs-toggle="tab" data-bs-target="#nav-likeReply" type="button" role="tab" aria-controls="nav-likeReply"
									aria-selected="false">내가 공감한 댓글</button>
							</div>
						</nav>
					</div>


					<%-- contents 탭메뉴의 내용--%>
					<div class="tab-content tab5" id="nav-tabContent">
						<br />
						<%-- 나의 댓글 목록 뿌리기 --%>
						<div class="tab-pane fade show active" id="nav-myReply"
							role="tabpanel" aria-labelledby="nav-myReply-tab" tabindex="0">
							<div class="container">
								<div class="setMyReply">
									
									
								</div>
							</div>
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination myReplyPagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
							
						</div>


						<%-- 나의 공감 목록 뿌리기 --%>
						<div class="tab-pane fade" id="nav-likeReply"
							role="tabpanel" aria-labelledby="nav-likeReply-tab" tabindex="0">
							<div class="container">
								<div class="setLikeReply">
									
									
								</div>
							</div>
							
							<%-- 페이징네이션 --%>
							<div class="container">
								<div class="row">
									<div class="col">
										<ul class="pagination likeReplyPagingNum" id="pagingNum">

										</ul>
									</div>
								</div>
							</div>
						</div>

					</div> <%--  div tab_cont5 --%>
				</div> <%-- 메뉴 끝 --%>



				<%-- 회원정보 수정 탭! -------------------------------------------------------- --%>
				<div style="display:none;" id="modifyCheck">
                     <h2>회원정보수정</h2>
                     <hr />
                     <div id="memModifyPageBg">
                           <img id="memModifyIcon" src="/resources/img/catcat.jpg"/>
                           <br />
                           <br/>
                           <%-- contoller에서 비번 확인 결과 값이 true라면 페이지전환 (html 제이쿼리..?) --%>
                           <h3>회원정보를 수정하시려면 비밀번호를 입력해주세요</h3>         
                           <h6>회원님의 개인정보 보호를 위한 본인 확인 절차이오니, 로그인시 사용하시는 비밀번호를 입력해주세요.</h6>
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
               
               
               </div> <%-- tab_cont --%>
      </div><%-- col-9 --%>
     </div>
   </div><%-- container 끝 --%>
   
   
   <%-- 탈퇴눌렀을 때 모달  --%>
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
   
   
     <%-- 탈퇴 되면 처리할 로그아웃처리  --%>
    <form action="/logout" method="post" style="display:none;" id="logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
   </form>  
   
   
   
   
   <%-- 삭제요청 눌렀을 때 모달  --%>
	<div class="modal fade"  id="cancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">📖인생문장 삭제</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>해당 문장을 삭제하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" id="deleteGreat">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%-- 삭제요청 완료 때 모달  --%>
	<div class="modal fade"  id="successCancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">📖인생문장 삭제</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>삭제가 완료 되었습니다.</p>
	      </div>
	      <div class="modal-footer">
	            <button type="button" class="btn btn-primary"  data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
   

<script>

$(document).ready(function() {
	 getMyPLlistCount(); // 회원의 북플리 개수 가져오기 호출
	 getMyScrapPLCount(); // 회원의 찜한 북플리 개수 가져오기 호출
	 getMyWantBookCount(); // 회원의 읽고 싶은 책 총 개수 가져오는 메서드
	 getMyFinishBookCount(); // 회원의 읽은 책 총 개수 가져오는 메서드 
	 getMySenetenceCount(); // 회원의 인생문장 총 개수 가져오는 메서드
	 getMyLikeSentenceCount(); //  회원이 좋아요한 인생문장 총개수 가져오는 메서드
	 getMyReplyCount(); // 회원이 작성한 댓글 총 개수 가져오는 메서드
	 getMyLikeReplyCount(); // 회원이 좋아요한 댓글 총 개수 가져오는 메서드 
	 
	 
	 // 마이페이지 들어오자마자 회원 북플리가 첫번째 보여지니까 
	 // 회원이 생성한 북플리 부터 불러오기
 	 var num = 1; // 페이지 번호 초기화
 	 getMemBookPl(num);  // 회원이 생성한 북플리 가져오기 호출
 	 getWantBook(num);  // 읽고 싶은 책 가져오기 호출!!
 	 getMySentences(num);  // 나의 문장카드 가져오기 호출!!
 	 getMyReply(num); // 회원이 작성한 댓글 가져오기 호출!!
 	
 	 
      //첫번째 탭(사이드메뉴 탭)
       $(".tab_title li").click(function() {
          var idx = $(this).index();
          $(".tab_title li").removeClass("on");
          $(".tab_title li").eq(idx).addClass("on");
          $(".tab_cont > div").hide();
          $(".tab_cont > div").eq(idx).show();
        })
        
    
      // 나의 북플리 탭 눌렀을 시
      $(".myBookPL").on("click", "#nav-myBookPL-tab", function(){
    	  //console.log("나의 북플리 탭 클릭!!!");
    	  getMemBookPl(1);  // 회원의 북플리 가져오기 호출!!
      });
  
 	 
      // 찜한 북플리 탭 눌렀을 시
       $(".myBookPL").on("click", "#nav-scriptBPL-tab", function(){
     	  //console.log("찜한 북플리 탭 클릭!!!");
     	  getMemscrapRDList(1);  // 찜한 북플리 가져오기 호출!!
       });
   
      
      // 읽고 싶은 책 눌렀을 시
       $(".myBooks").on("click", "#nav-wantBook-tab", function(){
     	  //console.log("읽고 싶은 책 탭 클릭!!!");
     	  getWantBook(1);  // 읽고 싶은 책 가져오기 호출!!
       });
      
      
      // 읽은 책 눌렀을 시
       $(".myBooks").on("click", "#nav-finishBook-tab", function(){
     	  //console.log("읽은 책 탭 클릭!!!");
     	  getReadBooks(1);  // 읽은 책 가져오기 호출!!
       });
      
      
      // 나의 문장카드 눌렀을 시  
       $(".mySentences").on("click", "#nav-mySentence-tab", function(){
     	  //console.log("나의 문장 카드 탭 클릭!!!");
     	  getMySentences(1);  // 나의 문장카드 가져오기 호출!!
       });
       
      
      
      // 나의 문장카드 눌렀을 시  
       $(".mySentences").on("click", "#nav-likeSentence-tab", function(){
     	  //console.log("좋아요한 문장 카드 탭 클릭!!!");
     	  getLikeSentence(1);  // 좋아요한 문장 카드 호출!!
       });
      
      
      //내가 작성한 댓글 눌렀을 시 
        $(".myReplys").on("click", "#nav-myReply-tab", function(){
     	  //console.log("내가 작성한 댓글 탭 클릭!!!");
     	  getMyReply(1);  // 내가 작성한 댓글 가져오기 호출!!
       });
      
      
        //내가 공감한 댓글 눌렀을 시 
        $(".myReplys").on("click", "#nav-likeReply-tab", function(){
     	 // console.log("공감한 댓글 탭 클릭!!!");
     	  getLikeReply(1);  // 공감한 댓글 가져오기 호출!!
       });
  

       // 회원정보 수정
       $("#memModifyPageBg").on("click", "#modifyPwCheck", function(){
          // 회원정보 수정 비밀번호 체크 확인 클릭!!!
          //console.log("회원정보 수정 비밀번호 체크 확인 클릭!!!");
          
          var pw = $("#mpdifyPw").val();
          var id = $("#loginId").val();
         // console.log("입력한 비번 : " + pw);
          
          // 비밀번호 확인하기!!
             $.ajax({
                  type: "post",
                  url: "/signup/pwCheck.json",
                  data: {'id': id ,'pw' : pw},
                  beforeSend: function(xhr){
                         xhr.setRequestHeader(header, token);
                     },
                  success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
                    // console.log("success");
                    // console.log(result);
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
                     //console.log(e);
                     }
               });
          
          
          
       });
       
       
       
    
       
       
});



// 가져온 회원의 북플리 뿌려주는 메서드
function setBookPL(result, num){
    //console.log("회원의 북플리 뿌려주기");
	
    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $("#setBook").empty();
    
    getMyPLlistCount(); // 회원의 북플리 개수 가져오기 호출
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myPLlistCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 8;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getMemBookPl");
    $("#pagingNum").html(htmlStr);
    
    // 북플리 뿌리기
    for(let i=0; i<result.length; i++){
       var bookPL = "<div class='col-3'><div id='onebPlist'>";
       bookPL += "<a href='/memData/bookPlistDetail?list_no="+result[i].list_no+"'>";
       bookPL += "<img id='mybpliListImg' src='/resources/save/"+result[i].packCover+"'> <span>"+result[i].bookPLTitle+"</span>";
	   bookPL += "</a></div></div>";
 
		$("#setBook").append(bookPL);
    } // for문
 
    
} // function



// 회원이 찜한 북플리 뿌려주는 메서드
function setScrapBookPL(result, num){
    //console.log("찜한 북플리 화면에 뿌려주기");
	
	//console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $("#setScrapBookPL").empty();
    
    getMyScrapPLCount(); // 회원의 찜한 북플리 개수 가져오기 호출
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myScrapPLCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 8;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getMemscrapRDList");
    $(".scrapPagingNum").html(htmlStr);
    
    // 북플리 뿌리기
    for(let i=0; i<result.length; i++){
       var bookPL = "<div class='col-3'><div id='onebPlist'>";
       bookPL += "<a href='/memData/bookPlistDetail?list_no="+result[i].list_no+"'>";
       bookPL += "<img id='mybpliListImg' src='/resources/save/"+result[i].packCover+"'> <span>"+result[i].bookPLTitle+"</span>";
	   bookPL += "</a></div></div>";
 
		$("#setScrapBookPL").append(bookPL);
    } // for문
}



// 회원이 읽고 싶은 책 뿌려주는 메서드
function setWantBookList(result, num){
    //console.log("읽고 싶은 책 화면에 뿌려주기");

   // console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $("#setWantBooks").empty();
    
    getMyWantBookCount(); // 회원의 읽고 싶은 책 총 개수 가져오는 메서드
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myWantBookCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 8;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getWantBook");
    $(".wantBookPagingNum").html(htmlStr);
    
    // 북플리 뿌리기
    for(let i=0; i<result.length; i++){
       var books = "<div class='col-3'><div id='oneBook'>";
       books += "<a href='/search/bookDetails/?isbn="+result[i].isbn+"'>";
       books += "<img id='myBlistImg' src='"+result[i].bookCover+"'></a>";
       books += "<hr /><p style='float: center;'><b>"+result[i].bookTitle+"</b></p>";
       books += "<p style='float: center; font-size: 13px; color: grey;''><b>"+result[i].author+"</b></p></div></div>";
	   
		$("#setWantBooks").append(books);
    } // for문
	
	
}


// 회원이 읽은 책 뿌려주는 메서드 
function setReadBookList(result, num){
    //console.log("읽은 책 화면에 뿌려주기");

    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $("#setReadBooks").empty();
    
    getMyFinishBookCount(); // 회원의 읽은 책 총 개수 가져오는 메서드 
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myFinishBookCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 8;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getReadBooks");
    $(".readBookPagingNum").html(htmlStr);
    
    // 북플리 뿌리기
    for(let i=0; i<result.length; i++){
       var books = "<div class='col-3'><div id='oneBook'>";
       books += "<a href='/search/bookDetails/?isbn="+result[i].isbn+"'>";
       books += "<img id='myBlistImg' src='"+result[i].bookCover+"'></a>";
       books += "<hr /><p style='float: center;'><b>"+result[i].bookTitle+"</b></p>";
       books += "<p style='float: center; font-size: 13px; color: grey;''><b>"+result[i].author+"</b></p></div></div>";
	   
		$("#setReadBooks").append(books);
    } // for문
}



// 회원의 인생문장 뿌려주는 메서드
function setMySentenceList(result, num){
    //console.log("회원의 인생문장 뿌려주기");

    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $(".setMySentence").empty();
    
    getMySenetenceCount(); // 회원의 인생문장 총 개수 가져오는 메서드
    
    // 페이징 관련 데이터 뽑기
    var totalResult = mySenetenceCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 4;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getMySentences");
    $(".mySentencePagingNum").html(htmlStr);
    
    // 인생문장 뿌리기
    for(let i=0; i<result.length; i++){
       var sentences = "<figure><div class='userPickSTC_item'>";
       if(result[i].greatImg == null){
    	   sentences += "<img class='userPickSTC_img' src='/resources/img/greatDefaultImg.jpg'/>";
       }else{
    	   sentences += "<img class='userPickSTC_img' src='/resources/save/"+result[i].greatImg+"' />";
       }
       sentences += "<br /><p class='userPickSTC_text'>"+result[i].greatContent+"</p><span id='greatbookT'>"+result[i].greatBookTitle+"中</span> ";
       sentences += "<br /><br /><div class='greatBy'><span>By. "+result[i].nickName+"</span><span class='like'>공감수"+ result[i].greatLikeCount+ "</span></div><br />";
       sentences += "<button type='button' class='btn btn-secondary btn-sm' onclick='window.location=`/gSentence/greatSentenceModify?great_no="+result[i].great_no+"`'>수정</button>";
       sentences += "<button type='button' class='btn btn-outline-secondary btn-sm' id='deleteGreat_btn' value='"+result[i].great_no+"'>삭제</button>";
      
       if(result[i].greatStatus == 0){
       	sentences += "<span class='greatStatus'>비공개</span>";
       }
       sentences += "</div></figure>";
       
       
		$(".setMySentence").append(sentences);
    } // for문
    
    
    
    var great_no;
	
	// 삭제 버튼 눌렀을 시
	$(".userPickSTC_item").on('click', "#deleteGreat_btn",function(){
		//console.log("삭제 버튼 클릭!!!");
		great_no = $(this).val();
		//console.log("great_no : " + great_no);
		$("#cancelmodal").modal("show");
	});


	// 삭제 처리

	$("#deleteGreat").on("click", function() {
		//console.log("진짜 삭제 버튼 클릭!!!");
		//console.log("삭제할 great_no : " + great_no);
		$("#cancelmodal").modal("hide");
		
		$.ajax({
			type : "POST",
			url : "/gSentence/greatDelete",
			data : JSON.stringify(great_no),
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result) {
				//console.log("인생문장 삭제 요청 성공!!!!!");
				//console.log(result);
				getMySentences(1);  // 나의 문장카드 가져오기 호출!!
				$("#successCancelmodal").modal("show");
			},
			error : function(e) {
				//console.log("인생문장 삭제 요청 에러......");
				//console.log(e);
			}
		});

	});
	
	
    
}



//회원의 좋아요한 인생문장 뿌려주는 메서드
function setLikeSentenceList(result, num){
    //console.log("회원의 좋아요한 인생문장 뿌려주기");

    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $(".setLikeSentence").empty();
    
    getMyLikeSentenceCount(); //  회원이 좋아요한 인생문장 총개수 가져오는 메서드
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myLikeSentenceCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 4;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getLikeSentence");
    $(".myLikeSentencePagingNum").html(htmlStr);
    
    // 좋아요한 인생문장 뿌리기
    for(let i=0; i<result.length; i++){
       var sentences = "<figure><div class='userPickSTC_item'>";
       if(result[i].greatImg == null){
    	   sentences += "<img class='userPickSTC_img' src='/resources/img/greatDefaultImg.jpg'/>";
       }else{
    	   sentences += "<img class='userPickSTC_img' src='/resources/save/"+result[i].greatImg+"' />";
       }
       sentences += "<br /><p class='userPickSTC_text'>"+result[i].greatContent+"</p><span id='greatbookT'>"+result[i].greatBookTitle+"中</span> ";
       sentences += "<br /><br /><div class='greatBy'><span>By. "+result[i].nickName+"</span><span class='like'>공감수"+ result[i].greatLikeCount+ "</span></div><br />";
       sentences += "<div class='likeBtn_div"+result[i].great_no+"'><button type='button' class='btn' id='noLikeBtn' value='"+result[i].great_no+"'>";
       sentences += "<i class='fa-solid fa-heart fa-lg'></i></button></div>";
       sentences += "</div></figure>";
       
       
		$(".setLikeSentence").append(sentences);
    } // for문
    
    
  //좋아요 버튼 취소
    $("[class^=likeBtn_div]").on("click", "#noLikeBtn", function() {
    	//console.log("좋아요 취소 클릭!!!");
    	
    	
    	var LikeGreat_no = $(this).val();
    	//console.log("좋아요 취소 문장번호 : " + LikeGreat_no);

    	// 좋아요 취소 기능 구현
    	$.ajax({
    		type : "POST",
    		url : "/gSentence/cancleLikeGreat",
    		data : JSON.stringify(LikeGreat_no),
    		contentType : "application/json;charset=utf-8",
    		beforeSend : function(xhr) {
    			xhr.setRequestHeader(header, token);
    		},
    		success : function(result) {
    			//console.log("좋아요 취소 요청 성공!!!!!");
    			//console.log(result);
    			getLikeSentence(1);
    		},
    		error : function(e) {
    			//console.log("좋아요 취소 요청 에러......");
    			//console.log(e);
    		}
    	});
    	
    });
    
    
}





//회원의 댓글 뿌려주는 메서드
function setMyReplyList(result, num){
    //console.log("회원이 작성한 댓글 뿌려주기");

    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $(".setMyReply").empty();
    
    getMyReplyCount(); // 회원이 작성한 댓글 총 개수 가져오는 메서드
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myReplyCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 3;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getMyReply");
    $(".myReplyPagingNum").html(htmlStr);
    
    // 회원이 작성한 댓글 뿌리기
    for(let i=0; i<result.length; i++){
       var sentences = "<div class='reply'><div class='row'><div class='col-3' style='text-align: center;'>";
       sentences += "<a href='/search/bookDetails?isbn="+result[i].isbn+"'><img src='"+result[i].bookCover+"' class='replyBookIMG'></a><br/>";
       sentences += "<a href='/search/bookDetails?isbn="+result[i].isbn+"'><b>"+result[i].bookTitle+"</b></a></div>";
       sentences += "<div class='col'><h5 class='replytitle'><b>“"+result[i].reTitle+"”</b></h5><hr />";
       sentences += "<pre>"+result[i].reContent+"</pre><div style='text-align: right;'><p style='text-align: right;'>"+timeFormat(result[i].reReg)+"</p><hr />";
       sentences += "<button class='btn btn-danger btn-sm' id='replyDel' data-repno='"+result[i].re_no+"' data-service='delete'>삭제</button>";
       sentences += "</div></div></div></div>";
       
		$(".setMyReply").append(sentences);
    } // for문
    
    
    
    $("#replyDel").on('click', function(){
	  	let repno = $(this).data("repno"); 
   		//console.log("삭제버튼 re_no :" + repno);
   	
   		let delReData = {"re_no" : repno};
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
		         alert("댓글이 삭제되었습니다.");
		         getMyReply(1);
		      },
		      error: function(e){  // 문제가 발생하면 에러 콘솔에 표시
		         //console.log("요청 에러.....");
		         //console.log(e);
		     }
			    	            
		});//댓글 삭제 ajax 끝
   });
    
    
}



//회원이 공감한 댓글 뿌려주는 메서드
function setLikeReplyList(result, num){
    //console.log("회원이 공감한 댓글 뿌려주기");

    //console.log(result);
    //console.log("현재 페이지 번호 : " + num);
    
    $(".setLikeReply").empty();
    
    getMyLikeReplyCount(); // 회원이 좋아요한 댓글 총 개수 가져오는 메서드 
    
    // 페이징 관련 데이터 뽑기
    var totalResult = myLikeReplyCount;  // 토탈 검색 게시물 수
    var startIndex = num;  // 지금 현재 인덱스 번호
    
    //console.log("총 검색 결과 수 : " +  totalResult);
    //console.log("시작 인덱스 : " +  startIndex);
    
    // 페이징 계산
    var pageSize = 3;
    var totalPages = Math.ceil(totalResult / pageSize);
    var curPage = startIndex;
    
    //console.log("페이징 수는 : " +  totalPages);
    var htmlStr = pageLink(curPage, totalPages, "getLikeReply");
    $(".likeReplyPagingNum").html(htmlStr);
    
    // 회원이 공감한 댓글 뿌리기
    for(let i=0; i<result.length; i++){
       var sentences = "<div class='reply'><div class='row'><div class='col-3' style='text-align: center;'>";
       sentences += "<a href='/search/bookDetails?isbn="+result[i].isbn+"'><img src='"+result[i].bookCover+"' class='replyBookIMG'></a><br/>";
       sentences += "<a href='/search/bookDetails?isbn="+result[i].isbn+"'><b>"+result[i].bookTitle+"</b></a></div>";
       sentences += "<div class='col'><h5 class='replytitle'><b>“"+result[i].reTitle+"”</b></h5><hr />";
       sentences += "<pre>"+result[i].reContent+"</pre><div style='text-align: right;'><span>"+result[i].nickName+"</span><p style='text-align: right;'>"+timeFormat(result[i].reReg)+"</p><hr />";
       sentences += "<button id='DelLikeReply' style='border: none; background: transparent;' data-repno='"+result[i].re_no+"'><i class='fa-solid fa-thumbs-up'></button></i>";
       sentences += "</div></div></div></div>";
       
		$(".setLikeReply").append(sentences);
    } // for문
    
    
    $("#DelLikeReply").on('click', function(){
	  	let repno = $(this).data("repno"); 
   		//console.log("삭제버튼 re_no :" + repno);
   	
   		let delReData = {"re_no" : repno};
   	// ajax로 삭제 요청 
		$.ajax({
		      type: "POST",
		      url: "/mypage/deleteLikeReply",
		      data: JSON.stringify(delReData),
		      contentType: "application/json;charset=utf-8",
		      beforeSend: function(xhr){
		         xhr.setRequestHeader(header, token);
		      },
		      success: function(result){
		         //console.log("요청 성공!!!!!!!");
		         //console.log("result : " + result);
		         alert("댓글이 삭제되었습니다.");
		         getLikeReply(1);  // 공감한 댓글 가져오기 호출!!
		      },
		      error: function(e){  // 문제가 발생하면 에러 콘솔에 표시
		         //console.log("요청 에러.....");
		         //console.log(e);
		     }
			    	            
		});//댓글 삭제 ajax 끝
   });
   
    
    
}



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


// 페이징네이션하기
function pageLink(curPage, totalPages, funName) {
	var pageUrl = "";
	
	var pageLimit = 5;
	var startPage = parseInt((curPage - 1) / pageLimit) * pageLimit + 1;
	var endPage = startPage + pageLimit - 1;
	
	if (totalPages < endPage) {
	    endPage = totalPages;
	}
	
	var nextPage = endPage + 1;
	//console.log(curPage,"curPage,",startPage,"startPage,",endPage,"endPage,",nextPage,"nextPage")
	
	//이전 페이지
	if (curPage > pageLimit) {
	    pageUrl += " <li class='page-item'><a aria-label='Previous' class='page-link page prev' href='javascript:" + funName + "(" + (startPage == 1 ? 1 : startPage - 1) + ");' ><i class='fas fa-angle-left'></i></a></li>";
	}
	//~pageLimit 맞게 페이지 수 보여줌
	for (var i = startPage; i <= endPage; i++) {
	    //현재페이지면 진하게 표시
	    if (i == curPage) {
	        pageUrl += " <li class='page-item active'><a href='#' class='page-link'>" + i + "</a></li>"
	    } else {
	        pageUrl += " <li class='page-item'><a href='javascript:" + funName + "(" + i + ");' class='page-link'> " + i + " </a></li>";
	    }
	}
	//다음 페이지
	if (nextPage <= totalPages) {
	    pageUrl += "<li class='page-item'><a aria-label='Next' class='page-link page next' href='javascript:" + funName + "(" + (nextPage < totalPages ? nextPage : totalPages) + ");' ><i class='fas fa-angle-right'></i></a></li>";
	}
	
	return pageUrl;
}  // function




var myPLlistCount; // 회원의 북플리 총개수 
//회원의 북플리 총 개수 가져오기
function getMyPLlistCount(){
	
	$.ajax({
		url : "/mypage/getMyPLlistCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원의 북플리 총개수 가져오기 성공!!!");
			//console.log(result);
			myPLlistCount = result;
		},
		error : function(e) {
			//console.log("회원의 북플리 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
	
}  




// 회원의 찜한 북플리 총개수 가져오는 메서드 getMyScrapPLCount
var myScrapPLCount ; // 회원이 찜한 북플리 총개수 

//회원이 찜한 북플리 총 개수 가져오기
function getMyScrapPLCount(){
	$.ajax({
		url : "/mypage/getMyScrapPLCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원이 찜한 북플리 총개수 가져오기 성공!!!");
			//console.log(result);
			myScrapPLCount = result;
		},
		error : function(e) {
			//console.log("회원이 찜한 북플리 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
}  



// 회원이 읽고 싶은 책 개수 가져오는 메서드 getMyWantBookCount
var myWantBookCount; // 회원이 읽고 싶은책 총개수 

//회원이 읽고 싶은책 총 개수 가져오기
function getMyWantBookCount(){
	$.ajax({
		url : "/mypage/getMyWantBookCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원이 읽고 싶은책 총개수 가져오기 성공!!!");
			//console.log(result);
			myWantBookCount = result;
		},
		error : function(e) {
			//console.log("회원이 읽고 싶은책 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
}  



// 회원이 읽은 책 갯수 가져오는 메서드 getMyFinishBookCount
var myFinishBookCount ; // 회원이 읽은 책 총개수 

//회원이 읽은 책 총 개수 가져오기
function getMyFinishBookCount(){
	$.ajax({
		url : "/mypage/getMyFinishBookCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원이 읽은 책 총개수 가져오기 성공!!!");
			//console.log(result);
			myFinishBookCount = result;
		},
		error : function(e) {
			//console.log("회원이 읽은 책 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
}  



// 회원의 인생문장 총 개수 가져오는 메서드 getMySenetenceCount
var mySenetenceCount  ; // 회원의 인생문장 총개수 

//회원의 인생문장 총 개수 가져오기
function getMySenetenceCount(){
	$.ajax({
		url : "/mypage/getMySenetenceCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원의 인생문장 총개수 가져오기 성공!!!");
			//console.log(result);
			mySenetenceCount = result;
		},
		error : function(e) {
			//console.log("회원의 인생문장 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
} 


// 회원이 찜한 인생문장 총 개수 가져오는 메서드 
var myLikeSentenceCount; // 회원의 찜한 인생문장 총개수 

//회원의 인생문장 총 개수 가져오기
function getMyLikeSentenceCount(){
	$.ajax({
		url : "/mypage/getMyLikeSentenceCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원의 찜한 인생문장 총개수 가져오기 성공!!!");
			//console.log(result);
			myLikeSentenceCount  = result;
		},
		error : function(e) {
			//console.log("회원의 찜한 인생문장 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
} 



// 회원이 작성한 댓글 총 개수 가져오는 메서드
var myReplyCount;	// 회원이 작성한 댓글 총 개수 가져오는 메서드
 // 회원의 찜한 인생문장 총개수 

//회원의 인생문장 총 개수 가져오기
function getMyReplyCount(){
	$.ajax({
		url : "/mypage/getMyReplyCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원이 작성한 댓글 총개수 가져오기 성공!!!");
			//console.log(result);
			myReplyCount  = result;
		},
		error : function(e) {
			//console.log("회원이 작성한 댓글 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
}


// 회원이 좋아요한 댓글 총 개수 가져오는 메서드 
var myLikeReplyCount;
 // 회원의 찜한 인생문장 총개수 

//회원의 인생문장 총 개수 가져오기
function getMyLikeReplyCount(){
	$.ajax({
		url : "/mypage/getMyLikeReplyCount.json",
		type : "GET",
		datatype: "JSON",
		success : function(result) {
			//console.log("회원이 좋아요한 댓글 총개수 가져오기 성공!!!");
			//console.log(result);
			myLikeReplyCount  = result;
		},
		error : function(e) {
			//console.log("회원이 좋아요한 댓글 총개수 가져오기 실패...");
			//console.log(e);
		}
	});
}

 // 회원의 북플리 가져오는 메서드
 function getMemBookPl(num){
	 //console.log("회원의 북플리 가져오기 호출!!!");
	 //console.log("초기 페이지 번호 : " + num);
	 
	 $.ajax({
		 url : "/mypage/getMemPLPaging/"+num+".json",
		 type : "get",
		 datatype: "JSON",
		 success: function(result) {
             //console.log("회원의 북플리 가져오기 ajax success");
             //console.log(result);
             setBookPL(result, num);
          },
          error: function(e){
             //console.log("회원의 북플리 가져오기 ajax error");
             //console.log(e);
          }
	 });
 }



 // 회원의 찜한 북플리 가져오는 메서드
  function getMemscrapRDList(num){
	  //console.log("찜한 북플리 가져오기 호출!!!");
	  //console.log("초기 페이지 번호 : " + num);
	  
	  
		 $.ajax({
			 url : "/mypage/getMemScrapPLPaging/"+num+".json",
			 type : "get",
			 datatype: "JSON",
			 success: function(result) {
	            // console.log("찜한 북플리 가져오기 ajax success");
	            // console.log(result);
	             setScrapBookPL(result, num);
	          },
	          error: function(e){
	            // console.log("찜한 북플리 가져오기 ajax error");
	            // console.log(e);
	          }
		 });
	  
 }
 
 
 // 회원의 읽고 싶은 책 가져오는 메서드
 function  getWantBook(num){
	// console.log("읽고 싶은 책 가져오기 호출!!!");
	// console.log("초기 페이지 번호 : " + num);
	 
	 $.ajax({
		 url : "/mypage/getWantBooksPaging/"+num+".json",
		 type : "get",
		 datatype: "JSON",
		 success: function(result) {
            // console.log("읽고싶은책 가져오기 ajax success");
            // console.log(result);
             setWantBookList(result, num);
          },
          error: function(e){
           //  console.log("읽고싶은책 가져오기 ajax error");
            // console.log(e);
          }
	 });
	 
	 
 }
 
 // 회원의 읽은 책 가져오는 메서드
 function  getReadBooks(num){
	 //console.log("읽은 책 가져오기 호출!!!");
	// console.log("초기 페이지 번호 : " + num);
	 
	 $.ajax({
		 url : "/mypage/getReadBooksPaging/"+num+".json",
		 type : "get",
		 datatype: "JSON",
		 success: function(result) {
             //console.log("읽은책 가져오기 ajax success");
             //console.log(result);
             setReadBookList(result, num);
          },
          error: function(e){
             //console.log("읽은책 가져오기 ajax error");
             //console.log(e);
          }
	 });
	 
	 
 }
 
 
 // 회원의 인생문장 가져오는 메서드
 function getMySentences(num){
	 //console.log("회원의 인생문장 가져오기 호출!!!");
	 //console.log("초기 페이지 번호 : " + num);
	 
	 $.ajax({
		 url : "/mypage/getMySentencesPaging/"+num+".json",
		 type : "get",
		 datatype: "JSON",
		 success: function(result) {
             //console.log("회원 인생문장 가져오기 ajax success");
             //console.log(result);
             setMySentenceList(result, num);
          },
          error: function(e){
             //console.log("회원 인생문장 가져오기 ajax error");
             //console.log(e);
          }
	 });
	 
 }
 
 
  // 회원의 좋아요한 인생문장 가져오는 메서드 getLikeSentence
  function getLikeSentence(num){
	 //console.log("회원의 좋아요한 인생문장 가져오기 호출!!!");
	 //console.log("초기 페이지 번호 : " + num);
	 
	 $.ajax({
		 url : "/mypage/getLikeSentencePaging/"+num+".json",
		 type : "get",
		 datatype: "JSON",
		 success: function(result) {
             //console.log("회원 좋아요한 인생문장 가져오기 ajax success");
             //console.log(result);
             setLikeSentenceList(result, num);
          },
          error: function(e){
            // console.log("회원 좋아요한 인생문장 가져오기 ajax error");
            // console.log(e);
          }
	 });
	 
 }
  
  

  
  
  
  // 회원의 댓글 리스트 가져오기
  function getMyReply(num){
	  //console.log("회원이 작성한 댓글 가져오기 호출!!!");
		 //console.log("초기 페이지 번호 : " + num);
		 
		 $.ajax({
			 url : "/mypage/getMyReplyPaging/"+num+".json",
			 type : "get",
			 datatype: "JSON",
			 success: function(result) {
	            // console.log("회원이 작성한 댓글 가져오기 ajax success");
	             //console.log(result);
	             setMyReplyList(result, num);
	          },
	          error: function(e){
	             //console.log("회원이 작성한 댓글 가져오기 ajax error");
	             //console.log(e);
	          }
		 });
  }
  
  
	// 회원이 공감한 댓글 리스트 가져오기
	function getLikeReply(num){
		//console.log("회원이 공감한 댓글 리스트 가져오기 호출!!!");
		 //console.log("초기 페이지 번호 : " + num);
		 
		 $.ajax({
			 url : "/mypage/getLikeReplyPaging/"+num+".json",
			 type : "get",
			 datatype: "JSON",
			 success: function(result) {
	            // console.log("회원이 공감한 댓글 리스트 가져오기 ajax success");
	            // console.log(result);
	             setLikeReplyList(result, num);
	          },
	          error: function(e){
	            // console.log("회원이 공감한 댓글 리스트 가져오기 ajax error");
	            // console.log(e);
	          }
		 });
	}
  
 



	<%-- 회원 정보 변경 관련 스크립트 --%>

  
   $("#memModifyPage").on("click","#outMember", function(){
      //console.log("탈퇴버튼 클릭!!!");
      $("#deleteMember_modal").modal("show");
   });
   
   
   
   
   $("#delete-Footer").on("click", "#deleteMember", function(){
      //console.log("진짜 탈퇴 버튼 클릭!!");
      
       $.ajax({
           type: "post",
           url: "/signup/deleteMember.json",
           beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
           },
           success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
              //console.log("success");
              //console.log(result);
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
              //console.log(e);
              }
        });
      
      
   });
   
  
  
  
  
   $("#memModifyPage").on("change", "#nickName", function(){
       //console.log("닉네임 값 입력함!!!");
       let nickName = $(this).val();
       
         $.ajax({
           type: "post",
           url: "/signup/nickNameAvail",
           data: {'nickName' : nickName},
           beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
           success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
             // console.log("success");
              //console.log(result);
              // 결과를 아이디사용가능 여부 input테그에 value값으로 띄워주기
              $("#nickCheck").val(result);
           },
           error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
             // console.log(e);
              }
        });
   });
   


   var pwVal = "";
      // 비밀번호 입력
         $("#memModifyPage").on("change", "#pw", function(){ 
       // console.log("비밀번호 값 입력함!!!");
        pwVal = $(this).val();
        //console.log("비밀번호 : " + pwVal);
        //console.log("비밀번호 확인 : " + pwchVal);
     });
   
     
     // 비밀번호, 비밀번호 확인 체크
     $("#memModifyPage").on("change", "#pwCh", function(){
        //console.log("비밀번호 확인 값 입력함!!!");
          let pwchVal = $(this).val();
        //console.log("비밀번호 : " + pwVal);
       // console.log("비밀번호 확인 : " + pwchVal);
       
       if(pwVal != pwchVal){
          $("#checkpw").val("확인란이 일치하지 않습니다.");
       }else{
          $("#checkpw").val("비밀번호 확인이 일치합니다");
       }
        
     });
     
   

   //프로필
   $('#file').change(function(){
       setImageFromFile(this, '#preview');
       
    }); //파일 change
    
 
 $('#profileCheckBtn').on("click", function(){
    //console.log("프로필 수정 하기!!!!!")
    //프로필 이미지 담아서 ajax 날리기
    var data = new FormData();
    var file = $('#file')[0].files[0];
    
    data.append('profile', file);
    //console.log(data.get('profile'));
    
    for (var pair of data.entries()) {
            //console.log(pair[0]+ ', ' + pair[1]);
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
              //console.log("프로필 등록 성공!!!!!");
              //console.log(result);
              alert("프로필 등록이 완료 되었습니다!🖼");
           },
           error: function(e){
              //console.log("프로필 등록 요청 에러......");
              //console.log(e);
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
    //console.log("프로필 수정 하기!!!!!")
    //프로필 이미지 담아서 ajax 날리기
    var data = new FormData();
    var file = $('#backFile')[0].files[0];
    
    data.append('bgFile', file);
    //console.log(data.get('bgFile'));
    
    for (var pair of data.entries()) {
            //console.log(pair[0]+ ', ' + pair[1]);
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
              //console.log("배경 등록 성공!!!!!");
              //console.log(result);
              alert("배경 등록이 완료 되었습니다!😎");
           },
           error: function(e){
              //console.log("배경 등록 요청 에러......");
              //console.log(e);
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




</script>

<%-- footer 복붙 --%>
<%@ include file="../includes/footer.jsp"%>