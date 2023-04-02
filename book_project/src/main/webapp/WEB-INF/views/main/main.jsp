<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %>
 

   <%-- header 복붙 --%>
   <%@ include file="../includes/header.jsp" %>
   
   <script>
      let url = new URL(window.location.href);
         let errorVal = url.searchParams.get('error');
         console.log(errorVal);
         if(errorVal != null){
            if(errorVal == '1') {
               alert("아이디 또는 비밀번호가 맞지 않습니다.");
            }else if(errorVal == '2'){
               alert("존재하지 않는 아이디 입니다.");
            }else {
               alert("알 수 없는 이유로 로그인이 안되고 있습니다.");
            }
            window.location = "/main/main";
         }
         
         
   </script>
   
   <%-- 메인 플레이 리스트창  --%>
   <div class="container">
         <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
           <div class="carousel-inner">
           <%-- 하나 반복 --%>
             <div class="carousel-item active">
                <div id="adminPick_PL">
                     <div id="wrap">
                        <div class="row">
                           <div class="col-5" id="main_img">
                              <div class="main_PLimg_div">
                                 <a href="/memData/bookPlistDetail?list_no=${oneBanner.list_no}" >
                                    <img  src="/resources/save/${oneBanner.packCover}" class="main_PLimg"/>
                                 </a>
                              </div>
                           </div>
                           <div class="col" id="adminPL_div">
                                 <a href="/memData/bookPlistDetail?list_no=${oneBanner.list_no}" >
                                    <h2 id="mainTitle">${oneBanner.bookPLTitle}</h2>
                                 </a>
                              <table class="adminPL_TBL">
                                 <tr>
                                    <c:forEach var="books" items="${oneB_book}">
                                       <td>
                                          <img  src="${books.bookCover}" class="adminPL_mainImg"/> <br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                     <c:forEach var="books" items="${oneB_book}">
                                       <td>
                                          <span><b>${books.bookTitle}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                      <c:forEach var="books" items="${oneB_book}">
                                       <td>
                                          <span><b>${books.author}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                              </table>
                           </div>
                        </div> <%-- row --%>
                     </div>
                </div>
             </div>
            <%-- 하나 반복 끝 --%>
            

            <%-- 하나 반복 --%>
             <div class="carousel-item">
                 <div id="adminPick_PL">
                     <div id="wrap1">
                        <div class="row">
                            <div class="col-5" id="main_img">
                              <div class="main_PLimg_div">
                                 <a href="/memData/bookPlistDetail?list_no=${twoBanner.list_no}" >
                                    <img  src="/resources/save/${twoBanner.packCover}" class="main_PLimg"/>
                                 </a>
                              </div>
                           </div>
                           <div class="col" id="adminPL_div">
                                 <a href="/memData/bookPlistDetail?list_no=${twoBanner.list_no}" >
                                    <h2 id="mainTitle">${twoBanner.bookPLTitle}</h2>
                                 </a>
                              <table class="adminPL_TBL">
                                 <tr>
                                    <c:forEach var="books" items="${twoB_book}">
                                       <td>
                                          <img  src="${books.bookCover}" class="adminPL_mainImg"/> <br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                     <c:forEach var="books" items="${twoB_book}">
                                       <td>
                                          <span><b>${books.bookTitle}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                      <c:forEach var="books" items="${twoB_book}">
                                       <td>
                                          <span><b>${books.author}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                              </table>
                           </div>
                        </div> <%-- row --%>
                     </div>
                </div>
             </div>
            <%-- 하나 반복 끝 --%>
            
            <%-- 하나 반복 --%>
             <div class="carousel-item">
                  <div id="adminPick_PL">
                     <div id="wrap2">
                        <div class="row">
                            <div class="col-5" id="main_img">
                              <div class="main_PLimg_div">
                                 <a href="/memData/bookPlistDetail?list_no=${threeBanner.list_no}" >
                                    <img  src="/resources/save/${threeBanner.packCover}" class="main_PLimg"/>
                                 </a>
                              </div>
                           </div>
                           <div class="col" id="adminPL_div">
                                 <a href="/memData/bookPlistDetail?list_no=${threeBanner.list_no}" >
                                    <h2 id="mainTitle">${threeBanner.bookPLTitle}</h2>
                                 </a>
                              <table class="adminPL_TBL">
                                 <tr>
                                    <c:forEach var="books" items="${threeB_book}">
                                       <td>
                                          <img  src="${books.bookCover}" class="adminPL_mainImg"/> <br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                     <c:forEach var="books" items="${threeB_book}">
                                       <td>
                                          <span><b>${books.bookTitle}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                                  <tr>
                                      <c:forEach var="books" items="${threeB_book}">
                                       <td>
                                          <span><b>${books.author}</b></span><br/>
                                       </td>
                                    </c:forEach>
                                 </tr>
                              </table>
                           </div>
                        </div> <%-- row --%>
                     </div>
                </div>
             </div>
             <%-- 하나 반복 끝 --%>
             
           </div>
           
           <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Previous</span>
           </button>
           <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Next</span>
           </button>
           
      </div> <%-- carouselExmple --%>
   </div> <%-- container  --%>

   
   
   <br/>
   <br/>

<%-- 인기 top 10 --%>
<div class="container">
   <h4>
      <b>인기 북플리 Top10 ✨</b>
   </h4>
   <br />
   <div class="owl-carousel owl-theme">
      <c:forEach var="list" items="${playList}" begin="0" end="9" step="1">
         <div class="item">
            <a href="/memData/bookPlistDetail?list_no=${list.list_no}"> <img
               class="pointcard_img" src="/resources/save/${list.packCover}">
            </a>
            <div class="card-body">
               <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                     <h5>
                        <b>${list.bookPLTitle}</b>
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

<br />
<br />


<sec:authentication property="principal" var="princ" /> 
   
   <%-- [ 선호장르 ]추천 플레이 리스트  --%>
<div class="container">
   <h4>
      <b> <sec:authorize access="isAuthenticated()">
            ${princ.member.nickName}님의
            </sec:authorize> 선호장르 추천 북플리 📚
      </b>
   </h4>
   <br />
   <div class="owl-carousel owl-theme">
      <c:forEach var="myGenre" items="${memGenreBPL}" begin="0" end="19" step="1">
         <div class="item">
            <a href="/memData/bookPlistDetail?list_no=${myGenre.list_no}"> <img
               class="pointcard_img" src="/resources/save/${myGenre.packCover}">
            </a>
            <div class="card-body">
               <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                     <h5>
                        <b>${myGenre.bookPLTitle}</b>
                     </h5>
                  </div>
               </div>
            </div>
            <%-- card body --%>


         </div>
         <%--  item --%>
      </c:forEach>
   </div>
   <%-- 올빼미 --%>
</div>

<br/>
<br/>




<%-- [ MBTI별 ]추천 플레이 리스트  --%>
<sec:authorize access="isAuthenticated()">
   <div class="container">
      <div class="row">
         <div class="col-8">
            <h4>
               <b> ${princ.member.nickName}님의 [MBTI] 추천 북플리 📚</b>
            </h4>
         </div>
         <div class="col-4">
            <%--  <button class="btn btn-outline-primary" type="button" style="float: right;" onclick="window.location='/main/mbti'">도서 유형 테스트</button> --%>
            <button class="btn btn-outline-primary" type="button"
               style="float: right;" onclick="window.location='/main/mbti'">도서
               유형 테스트</button>
            <br />
         </div>
      </div>


      <sec:authentication property="principal" var="princ" />
      <c:set var="memMbti" value="${princ.member.mbti}" />

      <c:if test="${memMbti eq 'mbti' }">
         <br />
         <%--  성격유형 검사 안했을 시--%>
         <div class="main_mbtiTest">
            <br /> <br />
            <h5>
               <a href="/main/mbti"><b>+ 도서 유형 테스트 하러가기! </b></a>
            </h5>
            <h6>내 성격 유형에 맞는 플레이리스트를 추천드려요! 😘</h6>

         </div>
      </c:if>
      <br />
      <c:if test="${memMbti != 'mbti'  }">
         <%--  성격유형 장르 뿌려주기 --%>
         <div class="owl-carousel owl-theme">
            <c:forEach var="mbtiBL" items="${mbtiBookPL }" begin="0" end="19" step="1">
               <div class="item">
                  <a href="/memData/bookPlistDetail?list_no=${mbtiBL.list_no}">
                     <img class="pointcard_img"
                     src="/resources/save/${mbtiBL.packCover}">
                  </a>
                  <div class="card-body">
                     <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                           <h5>
                              <b>${mbtiBL.bookPLTitle}</b>
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
      </c:if>
   </div>
</sec:authorize>

<sec:authorize access="isAnonymous()">
	<div class="container">
		<div class="row">
			<div class="col-8">
				<h4>
					<b> 나의 도서 [MBTI] 유형은 무엇일까? 📚</b>
				</h4>
			</div>
			<div class="col-4">
				<%--  <button class="btn btn-outline-primary" type="button" style="float: right;" onclick="window.location='/main/mbti'">도서 유형 테스트</button> --%>
				<button class="btn btn-outline-primary" type="button"
					style="float: right;" onclick="window.location='/main/mbtNotLogin'">도서
					유형 테스트</button>
				<br /> <br />
			</div>
			<div class="main_mbtiTest">
				<br /> <br />
				<h5>
					<a href="/main/mbtiNotLogin"><b>+ 도서 유형 테스트 하러가기! </b></a>
				</h5>
				<h6>로그인 후 MBTI를 등록하시면 내 도서 유형에 맞는 플레이리스트를 추천드려요! 😘</h6>

			</div>
		</div>
	</div>
</sec:authorize>
<br />
<br />




<%-- 인생문장 --%>
<div class="container">
   <div class="row">
      <div class="col-8">
         <h4>
            <b>독자 Pick! 문장이 주는 위로😀</b>
         </h4>
      </div>
      <div class="col-4">
         <button class="btn btn-outline-primary" type="button"
            style="float: right;"
            onclick="window.location='/gSentence/greatSentence'">+ 더보기
         </button>
      </div>
   </div>
   <br />
   <div class="row">
      <%-- 반복  3개만 나오게 --%>
      <c:forEach var="great" items="${great}" begin="0" end="2" step="1">
            <div class="col-4">
               <div class="userPickSTC_item">
                  <c:choose>
                     <c:when test="${great.greatImg == null}">
                        <img class="userPickSTC_img" src="/resources/img/greatDefaultImg.jpg">
                     </c:when>
                     <c:otherwise>
                        <img class="userPickSTC_img" src="/resources/save/${great.greatImg}" />
                     </c:otherwise>
                  </c:choose>
                  <br/>
                  <p class="userPickSTC_text">${great.greatContent}</p>
                  <span id="greatbookT"> ${great.greatBookTitle} 中</span>
                  <br/>
                  <br/>
                  <div class="greatBy">
                     <span>By. ${great.nickName }</span>
                     <span class="mainLike">공감수 ${great.greatLikeCount}</span>
                  </div>
               </div>
            </div>
      </c:forEach>


   </div>
   <%-- items --%>
</div>
<%-- container  --%>


<br/>
<br/>



<%-- [ 분위기별 ]추천 플레이 리스트  --%>
<div class="container">
   <h4>
      <b>선호하는 분위기 추천 북플리🎃</b>
   </h4>
   <br />
   <div class="owl-carousel owl-theme">
      <c:forEach var="moodBL" items="${memMoodBPL}" begin="0" end="19" step="1">
         <div class="item">
            <a href="/memData/bookPlistDetail?list_no=${moodBL.list_no}"> <img
               class="pointcard_img" src="/resources/save/${moodBL.packCover}">
            </a>
            <div class="card-body">
               <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                     <h5>
                        <b>${moodBL.bookPLTitle}</b>
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

<br/>
<br/>



<%-- [ 상황별 ]추천 플레이 리스트  --%>

<div class="container">
   <sec:authorize access="isAuthenticated()">
      <h4>
         <b> ${princ.member.nickName}님의 상황에 맞는 추천 북플리 ✨</b>
      </h4>
   </sec:authorize>
   <sec:authorize access="isAnonymous()">
      <h4>
         <b>당신을 위한 추천 북플리 ✨</b>
      </h4>
   </sec:authorize>
   <br />
   <div class="owl-carousel owl-theme">
      <c:forEach var="situBL" items="${memSituBPL}" begin="0" end="19" step="1">
         <div class="item">
            <a href="/memData/bookPlistDetail?list_no=${situBL.list_no}"> <img
               class="pointcard_img" src="/resources/save/${situBL.packCover}">
            </a>
            <div class="card-body">
               <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                     <h5>
                        <b>${situBL.bookPLTitle}</b>
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


<script type="text/javascript">
   var color = '#';
   var letters = [ '8C7A79', 'D9C7C5', 'D2DADA', '8C8579', 'D9D1C3', 'D9B6B6',
         'B1A9D1', 'C1D6C1', 'D1BCC0', '99A9D1', 'D1AFB5' ];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap').style.background = color; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.

   var color1 = '#';
   var letters = [ '6B343D', '9E392E', '425B6B', 'BFC7D7', 'ADC5D1', 'B7D192',
         'D19690', 'CFC0C5', 'CFCCB6', '9BD1CD', 'D6D6D4' ];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color1 += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap1').style.background = color1; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.

   var color2 = '#';
   var letters = [ 'D7D9C7', 'B9BF8E', '8C5346', 'F2B263', 'A3BFD9', '84A4BF',
         'F2916D', 'A6A197', 'CFC0C5', 'B8999F', '732626' ];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color2 += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap2').style.background = color2; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.
</script>
   
   <%-- 
   <script>
   let data = $("#memId").val();
   console.log(data);
         let id = { "id" : data };
      
      $.ajax({
         type: "post",
         url: "/main/main",
         data: JSON.stringify(id),
         contentType: "application/json;charset=utf-8",
         beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
           },
         success   : function(result){ //요청 성공시 실행할 코드
            console.log("아이디로 처리함");
            console.log("result!!!! : " + result);
         },
         error: function(e){
            console.log("메인 에러....");
            console.log(" e!!! 에러 값!!!!! :" + e);
         }
      
         
         
      })//ajax끝 
      
   
   
   </script>
    --%>
   
    <%-- footer 복붙 --%>
   <%@ include file="../includes/footer.jsp" %>
   
   