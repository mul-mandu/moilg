<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <!-- security csrf 추가 -->
   <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    
    
   <title>뭐읽지? 📚취향대로 골라주는 북플리!📚</title>
   

   
<!-- bootstrap -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
   crossorigin="anonymous">

<!-- 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- style CSS  -->
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">


<!-- js및 스크립트  -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" 
 integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" 
 crossorigin="anonymous" 
 referrerpolicy="no-referrer"></script>
 
  <link rel="stylesheet" href="/resources/css/owl.carousel.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
 <script src="/resources/js/owl.carousel.min.js"></script>
 

 
 

 

 <!-- 아이콘  -->
 <script src="https://kit.fontawesome.com/00f484499b.js" crossorigin="anonymous"></script>
 
 
 
 
  
  
  
 
 
 
</head>


<style>
.bd-placeholder-img {
   font-size: 1.125rem;
   text-anchor: middle;
   -webkit-user-select: none;
   -moz-user-select: none;
   user-select: none;
}

@media ( min-width : 768px) {
   .bd-placeholder-img-lg {
      font-size: 3.5rem;
   }
}

.b-example-divider {
   height: 3rem;
   background-color: rgba(0, 0, 0, .1);
   border: solid rgba(0, 0, 0, .15);
   border-width: 1px 0;
   box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
      rgba(0, 0, 0, .15);
}

.b-example-vr {
   flex-shrink: 0;
   width: 1.5rem;
   height: 100vh;
}

.bi {
   vertical-align: -.125em;
   fill: currentColor;
}

.nav-scroller {
   position: relative;
   z-index: 2;
   height: 2.75rem;
   overflow-y: hidden;
}

.nav-scroller .nav {
   display: flex;
   flex-wrap: nowrap;
   padding-bottom: 1rem;
   margin-top: -1px;
   overflow-x: auto;
   text-align: center;
   white-space: nowrap;
   -webkit-overflow-scrolling: touch;
}

.form-control {
   width: 400px;
}

.d-block {
   display: inline-block;
   float: right;
}
</style>

<body>
   <div class="container-fluid d-grid align-items-center"
      style="grid-template-columns: 1fr 8fr;">

      <div class="col-md-2">
         <a href="/main/main"><img src="/resources/img/logo_kr.png" class="bi me-2" width="120px" role="img" aria-label="logo" /></a>
      </div>
      <div class="d-flex align-items-center">
         <form class="w-100 me-3" role="search">
            <a href="/search/titleSearch" id="search_button" ><img src="/resources/img/search_icon.png" width="30px" />검색하기</a>
         </form>


      <sec:authentication property="principal" var="prin"/>
      
         <div class="flex-shrink-0 dropdown">
            <sec:authorize access="isAnonymous()">
               <a href="#"
                  class="d-block link-dark text-decoration-none dropdown-toggle"
                  data-bs-toggle="dropdown" aria-expanded="false"> <img src="/resources/save/user.png" alt="profile" width="45" height="45"
                  class="rounded-circle">
               </a>
           </sec:authorize>
            <sec:authorize access="isAuthenticated()">
               <c:set var="memPhoto" value="${prin.member.photo}" />
            
               <c:if test="${memPhoto eq null}" >
                  <a href="#"
                     class="d-block link-dark text-decoration-none dropdown-toggle"
                     data-bs-toggle="dropdown" aria-expanded="false"> <img src="/resources/save/user.png" alt="profile" width="45" height="45"
                     class="rounded-circle">
                  </a>
               </c:if>
               <c:if test="${memPhoto != null}" >
                  <a href="#"
                     class="d-block link-dark text-decoration-none dropdown-toggle"
                     data-bs-toggle="dropdown" aria-expanded="false"> <img src="/resources/save/${prin.member.photo }" alt="profile" width="45" height="45"
                     class="rounded-circle">
                  </a>
               </c:if>
            </sec:authorize>
            <ul class="dropdown-menu text-small shadow">
               <!-- 로그인 했을 때, 로그아웃으로 -->
             <sec:authorize access="isAnonymous()">
                <li><button type="button" id="dropdown_btn" data-bs-toggle="modal" data-bs-target="#login_modal" data-backdrop="static">로그인</button></li>
             </sec:authorize>
             <sec:authorize access="isAuthenticated()">   
            <form action="/logout" method="post">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />            
                  <li><button type="submit" id="dropdown_btn" data-backdrop="static">로그아웃</button></li>
                </form>
            </sec:authorize>
             
               <!-- mypage 분기 처리 -->
               <sec:authorize access="hasRole('ROLE_MEMBER')" > 
                   <li><button type="button" id="dropdown_btn" onclick="window.location='/mypage/memMypage'" >마이페이지</button></li>
               </sec:authorize>
                <sec:authorize access="hasRole('ROLE_ADMIN')" > 
                   <li><button type="button" id="dropdown_btn" onclick="window.location='/mypage/adminMypage'" >마이페이지</button></li>
                </sec:authorize>
              <li><hr class="dropdown-divider"></li>
              
              <!-- 회원가입 분기처리 (로그인 하면 안 보이게) -->
                <sec:authorize access="isAnonymous()">
                     <li><a class="dropdown-item" href="/signup/signup">회원가입</a></li>
               </sec:authorize>
            </ul>
         </div>
      </div>
   </div>
   
   
   

    <!-- Modal -->
         <div class="modal fade" id="login_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" >
            <div class="modal-dialog modal-dialog-centered">
               <div class="modal-content">
                  <div class="modal-header">
                     <h4 class="modal-title" id="exampleModalLabel"><b>LOGIN</b></h4>
                     <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                  </div>
                     <div class="modal-body">
                     
                 <form action="/login" method="post"> <!-- 로그인 처리는 security가 해줄거라 경로는 /login , 메서드는 post!!!★ -->
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <!-- 스프링 시큐리티로 회원가입하기 위해서 필요함! -->  
                           <div class="form-control">
                              <label>아이디</label>
                              <input type="text" name="username" id="id" required /> 
                           </div>
            
                           <div class="form-control">
                              <label>비밀번호</label>
                              <input type="password" name="password" id="pw" required /> 
                           </div>
                        <input type="checkbox" name="remember-me" id="remember-me"/> 자동로그인  <!-- 자동로그인 할때 value 안보내고 name 속성을 remember-me로 지정해주면 security가 처리 -->
                           <br />
                           <button type="submit" class="btn btn-secondary" id="login-button" >로그인</button>
                        </form>
                     </div>
                  <div class="modal-footer">
                     <a href="/signup/idFind">아이디 찾기</a><br />
                     <a href="/signup/pwFind">비밀번호 찾기</a><br />
                  </div>
               </div>
            </div>
         </div>

<br />
<br />
   

   
   <script>
 
   
   //토큰 , 헤더 변수담기
      let token = $("meta[name='_csrf']").attr("content");
   let header = $("meta[name='_csrf_header']").attr("content");
   
   
   
   //로그인 submit버튼 클릭시,
   $(function(){
      $("#login-button").click(function(){
         login();
      })      
   
   }); //로그인 버튼 클릭시 끝
   
   
    
   //로그인 ajax로 넘기기
   function login(){
      let username = $("#id").val();
      let password = $("#pw").val();
      console.log("아이디 : " + username + "패스워드 :" +  password );
      let logindata = {"username":username, "password":password};
      
      $.ajax({
         url:"/login",
         type :  "POST",
         dataType : "json",
         data : logindata,
         beforeSend : function(xhr)
            {   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
            xhr.setRequestHeader(header, token);
            },
         success: function(data){
            console.log(data);
            location.replace("/main/main")
         },
         error:function(xhr,status,error){
            console.log('error:'+error);
         }
      });
   }//ajax끝
   


   
   </script>