<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
   <link href="/resources/css/mypage.css" rel="stylesheet" type="text/css">   
   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

      <!-- bootstrap -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
      crossorigin="anonymous">
   </script>
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   
    <script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
  
      <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
     <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> 
<script>

  $( function() {
    $.widget( "custom.catcomplete", $.ui.autocomplete, {
      _create: function() {
        this._super();
        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
      },
      _renderMenu: function( ul, items ) {
        var that = this,
          currentCategory = "";
        $.each( items, function( index, item ) {
          var li;
          if ( item.category != currentCategory ) {
            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
            currentCategory = item.category;
          }
          li = that._renderItemData( ul, item );
          if ( item.category ) {
            li.attr( "aria-label", item.category + " : " + item.label );
          }
        });
      }
    });
    var data =[
       { label: "추리소설", category: "장르" },
       { label: "SF/판타지", category: "장르" },
       { label: "한국소설", category: "장르" },
        { label: "외국소설", category: "장르" },
        { label: "고전문학", category: "장르" },
        { label: "시", category: "장르" },
          { label: "에세이", category: "장르" },
            { label: "철학", category: "장르" },
        { label: "역사서", category: "장르" },
        { label: "예술", category: "장르" },
        { label: "자기계발", category: "장르" },
        { label: "경제", category: "장르" },
        { label: "요리", category: "장르" },
        { label: "여행", category: "장르" },
        { label: "심리", category: "장르" },
        { label: "꽃이 흩날리는 봄", category: "분위기" },
        { label: "청량한 여름", category: "분위기" },
        { label: "차분한 가을", category: "분위기" },
        { label: "찬란한 겨울", category: "분위기" },
        { label: "따뜻한", category: "분위기" },
        { label: "아련한", category: "분위기" },
        { label: "우울한", category: "분위기" },
        { label: "감성적인", category: "분위기" },
        { label: "밝은", category: "분위기" },
        { label: "희망적인", category: "분위기" },
        { label: "새로운 시작", category: "상황" },
        { label: "위로가 필요할 때", category: "상황" },
        { label: "이별했을 때", category: "상황" },
        { label: "기분전환이 필요할 때", category: "상황" },
        { label: "힐링이 필요할 때", category: "상황" },
        { label: "인간관계에 피로할때", category: "상황" },
        { label: "우울할때", category: "상황" }

      ];
 
    $( "#search" ).catcomplete({
      delay: 0,
      source: data
    });
  } );
  </script>

<!-- 마이페이지 이미지 -->
   <div class="container" >
      <div class="mypageTOP">
         <div class="image-box" >
         <c:choose>
            
            <c:when test="${empty member.bgImg}"> 
               <img src="/resources/save/bgDefault.jpg" class="mypageBg" id="backPreview" />
               <div style="position: absolute; top:150px; left: 80%;" >
                  <label for="backFile" >
                     <img id="backEditImg" src="/resources/img/edit.png" style="width: 25px;"/>
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
                     <li class="nav-link" >나의 댓글</li>
                     <li class="nav-link" >회원 관리</li>
                     <li class="nav-link disabled" >키워드 관리</li>   <!-- 추후 사용시 open -->
                     <li class="nav-link disabled">대문 관리</li>      <!-- 추후 사용시 open -->
                     <li class="nav-link disabled" >배너 관리</li>      <!-- 추후 사용시 open -->
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
                                <div class="col-3">
                                     <div id="onebPlist">
                                          <a href="/memData/bookPlistDetail" >
                                          <img id="mybpliListImg" src="/resources/img/sample4.jpg">
                                          </a>
                                      </div>
                                </div> <!-- item --> 
                              </div> <!-- row -->
                         </div>
                               </div>
                           </div>
                        </div> <!-- on -->
                        
                        
                         <!-- 나의 댓글 -->
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
                 <div class="tab_cont3">
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
      
            
                        
                        
            <!-- 회원관리 -->           
            <div style="display:none;">
                     <h2>회원관리</h2>
                     <hr />
                    <!-- contents 탭메뉴의 내용-->
                   <%-- 작성자/내용 검색 --%>
               <form action="adminMypage.jsp" align="right">
                  <select name="sel">
                     <option value="memId" selected>회원 ID</option>
                     <option value="memName">회원 이름</option>
                  </select>
                  <input type="text" name="search" /> 
                  <input class="btn btn-outline-secondary btn-sm" type="submit" value="검색" />
               </form>
               <button class="btn btn-outline-secondary btn-sm" style="float: right; margin-top:10px;"> 전체 회원보기 </button>
               
                          <br />   
                          <br />   
                   <!-- 회원 목록 뿌리기 -->
                       <table id="listTable"> 
                         <thead id="replyList">
                        <tr>
                           <th>ID</th>
                           <th>이름</th>
                           <th>이메일</th>
                           <th>활동상태</th>
                           <th>활동상태변경</th>
                        </tr>
                     </thead>
                          <tbody id="foreachTbody">
                        <c:forEach var="allMem" items="${memList}">
                           <tr>
                                 <td id="memberId">${allMem.id }</td>
                                 <td>${allMem.name }</td>
                                 <td>${allMem.email }</td>
                                 <c:set var="status"  value="${allMem.memStatus }" />
                                 <c:if test="${status == 1}">
                                    <td>활동중</td>
                                    <td><button type="button" class="btn btn-outline-danger btn-sm statusStopBtn" >활동정지</button></td>
                                 </c:if>
                                 <c:if test="${status == 0}">
                                    <td>활동정지</td>
                                    <td><button type="button" class="btn btn-outline-danger btn-sm statusStopBtn" disabled>활동정지</button></td>
                                 </c:if>
                           </tr>
                        </c:forEach>
                  </tbody>
                       </table>
          </div>   
          
         
         <!-- 키워드 관리 -->
         <div style="display:none;">
            <h2>키워드 관리</h2>
              <hr />
              <div class="container">
               <div id="serch_bar_div_admin">
                 <input type="text" class="search_bar_admin" id="search" placeholder="추가할 키워드를 입력하세요" />
                  <button type="submit" id="searchPage_btn">추가</button>
            </div>
            <br />
            <br />
            <!-- 키워드 리스트 보여주는 곳 -->
            <div>
               <h4><b>키워드 리스트</b></h4>
            </div>
            <div id="keywordList" class="container">
                  <div class="row">
                     <div class="col-md-auto">
                        <p class="hashTag_admin">아련한</p> <!-- for문 돌려서 뿌리기 -->
                  </div>            
                  </div>
            </div>
          </div>
         </div><!--키워드 관리 메뉴 끝 -->
         
         
         <!-- 대문관리 -->
         <div style="display:none;">
               <h2>대문 관리</h2>
              <hr />
              <!-- CONTENTS 안의 탭메뉴 -->            
                     <div>
                        <ul class="nav nav-tabs" >
                     <li class="nav-link onandon">오늘의 문구 관리</li>
                     <li class="nav-link onandon">대문 영상 관리</li>
                        </ul>
                     </div>
              <!-- contents 탭메뉴의 내용-->
                      <div class="tab_cont4">
                         <div class="onandon">
                          <!-- 나의 오늘의 문구 뿌리기 -->
                          <br />
                        <button type="button" id="todaySentenceAddBtn" class="btn btn-primary btn-sm" style="float: right"> + 추가</button>
                        <br />  
                        <br />
                          
                          <div id="demo">
                                <table id="listTable"> 
                                 <thead id="replyList">
                              <tr>
                                 <th><input type="checkbox" disabled></th>
                                 <th>No.</th>
                                 <th>카테고리</th>
                                 <th>내용</th>
                                 <th>날짜</th>
                                 <th>수정/삭제</th>
                              </tr>
                           </thead>
                                 <tbody>
                              <tr>
                                 <td><input type="checkbox"></td>
                                 <td>1</td>
                                 <td>눈</td>
                                 <td>우리 가장 행복할 그날, 첫눈처럼 내가 가겠다</td>
                                 <td>2022.09.30</td>
                                 <td>
                                    <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                                    <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                                    
                                 </td>
   
                              </tr>
                           </tbody>
                               </table>
                            </div>
                        </div> <!--  onandon -->
       
                        
                        
                        
                        
                        <div style="display:none;">
                        <!-- 대문 영상 뿌리기 -->
                          <br />
                          <form action="signupPro.jsp" method="post" enctype="multipart/form-data">
                             <table id="listTable"> 
                                 <thead id="replyList">
                              <tr>
                                 <th>카테고리</th>
                                 <th>파일명</th>
                                 <th>등록</th>
                              </tr>
                           </thead>
                                 <tbody>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>default_1.mp4</td>
                                 <td><input type="file" id="file" name="home_default1"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트2</td>
                                 <td>default_2.mp4</td>
                                 <td><input type="file" id="file" name="home_default2"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>home_sunny.mp4</td>
                                 <td><input type="file" id="file" name="home_sunny"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>home_cloudy.mp4</td>
                                 <td><input type="file" id="file" name="home_cloudy"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>home_shower.mp4</td>
                                 <td><input type="file" id="file" name="home_shower"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>home_rain.mp4</td>
                                 <td><input type="file" id="file" name="home_rain"/></td>
                              </tr>
                              <tr>
                                 <td>디폴트1</td>
                                 <td>home_snow.mp4</td>
                                 <td><input type="file" id="file" name="home_snow"/></td>
                              </tr>
                           </tbody>
                               </table>
                            </form>
                        </div>
                      </div> <!--  탭 콘3  -->
         </div> <!-- 대문관리 메뉴 끝 -->
         
         
         
           <!-- 배너관리 메뉴 -->
        <div style="display:none;">
           <h2>배너관리</h2>
                 <hr />
                 <form action="signupPro.jsp" method="post" enctype="multipart/form-data">   
                       <table id="listTable"> 
                              <thead id="replyList">
                           <tr>
                              <th>배너</th>
                              <th>파일명</th>
                              <th>등록</th>
                           </tr>
                        </thead>
                              <tbody>
                           <tr>
                              <td>배너1</td>
                              <td>default_1.png</td>
                              <td><input type="file" id="file" name="home_banner1"/></td>
                           </tr>
                           <tr>
                              <td>배너2</td>
                              <td>default_2.png</td>
                              <td><input type="file" id="file" name="home_banner2"/></td>
                           </tr>
                           <tr>
                              <td>배너3.jpg</td>
                              <td>default_3.png</td>
                              <td><input type="file" id="file" name="home_banner3"/></td>
                           </tr>
                           </tbody>
                   </table>
                </form>
        </div><!-- 배너 관리 메뉴 끝 -->
        
        
               </div> <!-- tab_cont -->
            </div>   <!-- col-9 -->
      </div> <!-- 큰 row -->
   </div>   <!-- 제일 큰 container -->
   
   
<script>

$(document).ready(function() {
 $("#foreachTbody").on("click", ".statusStopBtn",function(){
   console.log("활동 정지 버튼 클릭!!!");
   console.log($(this));
   
    trTag = $(this).parent().parent().clone();     
   console.log(trTag.html());
     var id = trTag.find("#memberId").text();
     console.log("id~~~~~~~~~~~~~~~~~ " + id); 
   var data = {"id" : id};
     
  //ajax 보내기
      $.ajax({
         url: "/mypage/adminMemberEdit",
         type: "post",
         contentType : "application/json;charset=utf-8",
         datatype: "JSON",
         data : JSON.stringify(data),
         beforeSend: function(xhr){
             xhr.setRequestHeader(header, token);
         },
         success: function(result) {
            console.log("ajax success");
            console.log(result);
              $(this).attr("disabled", true);
         },
         error: function(e){
            console.log("ajax error");
            console.log(e);
            
         }
         
      }); 
     
  
   }); //펑션 끝 




   
      //첫번째 탭(사이드메뉴 탭)
       $(".tab_title li").click(function() {
          var idx = $(this).index();
          $(".tab_title li").removeClass("on");
          $(".tab_title li").eq(idx).addClass("on");
          $(".tab_cont > div").hide();
          $(".tab_cont > div").eq(idx).show();
        });
        
    
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



</script>



<!--  footer 복붙 --> 
   <%@ include file="../includes/footer3.jsp" %>