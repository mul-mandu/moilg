<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %>


   <!-- header 복붙 -->
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
   
   <!-- 메인 플레이 리스트창  -->
   <div class="container">
         <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
           <div class="carousel-inner">
           <!-- 하나 반복 -->
             <div class="carousel-item active">
                <div id="adminPick_PL">
                     <div id="wrap">
                        <div class="row">
                           <div class="col-5">
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
                        </div> <!-- row -->
                     </div>
                </div>
             </div>
            <!-- 하나 반복 끝 -->
            

            <!-- 하나 반복 -->
             <div class="carousel-item">
                 <div id="adminPick_PL">
                     <div id="wrap1">
                        <div class="row">
                           <div class="col-5">
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
                        </div> <!-- row -->
                     </div>
                </div>
             </div>
            <!-- 하나 반복 끝 -->
            
            <!-- 하나 반복 -->
             <div class="carousel-item">
                  <div id="adminPick_PL">
                     <div id="wrap2">
                        <div class="row">
                           <div class="col-5">
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
                        </div> <!-- row -->
                     </div>
                </div>
             </div>
             <!-- 하나 반복 끝 -->
             
           </div>
           
           <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Previous</span>
           </button>
           <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Next</span>
           </button>
           
      </div> <!-- carouselExmple -->
   </div> <!--container  -->

   
   
   <br/>
   <br/>
   
   <!-- 인기 top 5 -->
   <div class="container">
   <h4><b>최신 북플리 ✨</b></h4>
   <br />
     <div class="owl-carousel owl-theme">
     <c:forEach var="list" items ="${playList}">
        <div class="item"> 
             <div class="card" id="pointcard">
                  <a href="/memData/bookPlistDetail?list_no=${list.list_no}" >
                    <img class="pointcard_img" src="/resources/save/${list.packCover}">
                  </a>
                  <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                      <div class="btn-group">
                         <h5><b>${list.bookPLTitle}</b></h5>
                      </div>
                    </div>
                  </div> <%-- card body --%>
              </div>
        </div> <!-- item --> 
     </c:forEach>
      </div> <!-- 올빼미 -->
      
   </div>
   
   <br/>
   <br/>
   
   
   <sec:authentication property="principal" var="princ" /> 
   
   <!--[ 선호장르 ]추천 플레이 리스트  -->
   <div class="container">
         <h4><b>
            <sec:authorize access="isAuthenticated()">
            ${princ.member.nickName}님의
            </sec:authorize>
              선호장르 추천 북플리 📚</b></h4>
         <br />
           <div class="owl-carousel owl-theme">
            <c:forEach var="myGenre" items="${memGenreBPL}">
                    <div class="item"> 
                         <div class="card" id="pointcard">
                                    <a href="/memData/bookPlistDetail?list_no=${myGenre.list_no}" >
                                      <img class="pointcard_img" src="/resources/save/${myGenre.packCover}">
                                    </a>
                                    <div class="card-body">
                                      <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                           <h5><b>${myGenre.bookPLTitle}</b></h5>
                                        </div>
                                      </div>
                                    </div> <%-- card body --%>
                                  </div>
                    
                    </div> <!-- item --> 
            </c:forEach>
            </div> <!-- 올빼미 -->
      </div>
      
      <br/>
      <br/>
   
   
<!--[ MBTI별 ]추천 플레이 리스트  -->
   <sec:authorize access="isAuthenticated()">
   <div class="container">
      <div class="row">
         <div class="col-8">
            <h4><b> ${princ.member.nickName}님의 [MBTI] 추천 북플리 📚</b></h4>
         </div>
         <div class="col-4">
           <!--  <button class="btn btn-outline-primary" type="button" style="float: right;" onclick="window.location='/main/mbti'">도서 유형 테스트</button> -->
            <button class="btn btn-outline-primary" type="button" style="float: right;" onclick="window.location='/main/mbti'">도서 유형 테스트</button>
           <br />
         </div>
      </div>
     
      
      <sec:authentication property="principal" var="princ"/>
      <c:set var="memMbti" value="${princ.member.mbti}" />
      
      <c:if test ="${memMbti eq 'mbti' }" >
      <br />
      <!--  성격유형 검사 안했을 시-->
      <div class="main_mbtiTest">
            <br />
            <br />
            <h5><a href="/main/mbti"><b>+ 도서 유형 테스트 하러가기! </b></a></h5> 
            <h6> 내 성격 유형에 맞는 플레이리스트를 추천드려요! 😘 </h6>

      </div>
      </c:if>
      <br />
      <c:if test ="${memMbti != 'mbti'  }">
      <!--  성격유형 장르 뿌려주기 -->
        <div class="owl-carousel owl-theme">
              <c:forEach var="mbtiBL" items="${mbtiBookPL }">
                    <div class="item"> 
                         <div class="card" id="pointcard">
                                    <a href="/memData/bookPlistDetail?list_no=${mbtiBL.list_no}">
                                      <img class="pointcard_img" src="/resources/save/${mbtiBL.packCover}">
                                    </a>
                                    <div class="card-body">
                                      <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                           <h5><b>${mbtiBL.bookPLTitle}</b></h5>
                                        </div>
                                      </div>
                                    </div> <%-- card body --%>
                          </div>
                    </div> <!-- item --> 
               </c:forEach>
         </div> <!-- 올빼미 -->
         </c:if>
   </div>
  
   </sec:authorize>
   
   <br/>
   <br/>




	<!-- 인생문장 -->
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
			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/autumn.jpg">
					<br />
					<p class="userPickSTC_text">당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
						마지막까지 꼭 믿어주세요. 마지막의 마지막 순간까지 믿어야합니다. - 나미야 잡화점의 기적 中 당신의 노력은 절대로
						쓸데 없는 일이 되지는 않습니다. 마지막까지 꼭 믿어주세요.</p>
					<span>나미야 잡화점의 기적 중</span> <br /> <span>by. user_name</span> 
					<span
						style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10
					</span>
				</div>
			</div>

			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/sea.jpg"> <br />
					<p class="userPickSTC_text">
						"The bird fights its way out of the egg. The egg is the world. Who
						would be born must first destroy a world". <br /> 새는 알에서 나오기 위해
						투쟁한다. 알은 세계다. 태어나려고 하는 이는 먼저 세계를 파괴해야한다.
					</p>
					<span>데미안 中</span> <br /> 
					<span>by. user_name</span> 
					<span
						style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10 
					</span>
				</div>
			</div>

			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/friend-ed.jpg">
					<br />
					<p class="userPickSTC_text">
						우리는 그날 복숭아 빛 하늘을 걸었다. <br /> 사람들은 우리를 절친한 친구관계라고 정의했다. 그렇다면 짝사랑보다
						짝우정이 힘든게 아닐까 <br /> <br /> &nbsp;

					</p>
					<span>작자 미상 中</span> <br /> 
					<span>by. user_name</span> 
					<span
						style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10 
					</span>
				</div>
			</div>
		</div> <!-- items -->
	</div> <!--container  -->

<br/>
   
   <!-- [ 분위기별 ]추천 플레이 리스트  -->
   <div class="container">
      <h4><b>선호하는 분위기 추천 북플리🎃</b></h4>
      <br />
        <div class="owl-carousel owl-theme">
             <c:forEach var="moodBL" items="${memMoodBPL }">
                 <div class="item"> 
                      <div class="card" id="pointcard">
                                 <a href="/memData/bookPlistDetail?list_no=${moodBL.list_no}" >
                                   <img class="pointcard_img" src="/resources/save/${moodBL.packCover}">
                                 </a>
                                 <div class="card-body">
                                   <div class="d-flex justify-content-between align-items-center">
                                     <div class="btn-group">
                                        <h5><b>${moodBL.bookPLTitle}</b></h5>
                                     </div>
                                   </div>
                                 </div> <%-- card body --%>
                               </div>
                 
                 </div> <!-- item --> 
              </c:forEach>
         </div> <!-- 올빼미 -->
   </div>
   
   <br/>
   <br/>
   
   <!-- [ 상황별 ]추천 플레이 리스트  -->
   
   <div class="container">
      <sec:authorize access="isAuthenticated()">
         <h4><b> ${princ.member.nickName}님의 상황에 맞는 추천 북플리 ✨</b></h4>
      </sec:authorize>
      <sec:authorize access="isAnonymous()">
         <h4><b>당신을 위한 추천 북플리 ✨</b></h4>
      </sec:authorize>
      <br />
        <div class="owl-carousel owl-theme">
             <c:forEach var="situBL" items="${memSituBPL }">
                 <div class="item"> 
                      <div class="card" id="pointcard">
                                 <a href="/memData/bookPlistDetail?list_no=${situBL.list_no}" >
                                   <img class="pointcard_img" src="/resources/save/${situBL.packCover}">
                                 </a>
                                 <div class="card-body">
                                   <div class="d-flex justify-content-between align-items-center">
                                     <div class="btn-group">
                                        <h5><b>${situBL.bookPLTitle}</b></h5>
                                     </div>
                                   </div>
                                 </div> <%-- card body --%>
                               </div>
                 
                 </div> <!-- item --> 
              </c:forEach>
         </div> <!-- 올빼미 -->
   </div>

      
   <script type="text/javascript">

   var color = '#';
   var letters = ['8C7A79', 'D9C7C5', 'D2DADA', '8C8579', 'D9D1C3', 'D9B6B6', 'B1A9D1', 'C1D6C1', 'D1BCC0', '99A9D1', 'D1AFB5'];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap').style.background = color; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.
   
   
   
   var color1 = '#';
   var letters = ['6B343D', '9E392E', '425B6B', 'BFC7D7', 'ADC5D1', 'B7D192', 'D19690', 'CFC0C5', 'CFCCB6', '9BD1CD', 'D6D6D4'];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color1 += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap1').style.background = color1; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.
   
   
   
   var color2 = '#';
   var letters = ['D7D9C7', 'B9BF8E', '8C5346', 'F2B263', 'A3BFD9', '84A4BF', 'F2916D', 'A6A197', 'CFC0C5', 'B8999F', '732626'];
   // 원하는 색상을 'letters'에 지정한다. 변소는 맘데로 변경해도 무관하다.
   color2 += letters[Math.floor(Math.random() * letters.length)]; // 컬러는 상기 변수들을 조립하는데 랜덤으로 조립한다.
   document.getElementById('wrap2').style.background = color2; // 조립한 컬러를 프론트엔드에서 지정한 ID에 적용한다.
      
   </script>
   
   <!-- 
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
    -->
   
    <!-- footer 복붙 -->
   <%@ include file="../includes/footer.jsp" %>
   
   