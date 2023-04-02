<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <%-- header 복붙 --%>
<%@ include file="../includes/header.jsp" %>
<script>
	let nick = '${nickname}';
	//console.log(nick);

</script>

   <div class="container" id="signupBG_inter">
	<sec:authentication property="principal.member" var="mem" />
               <div class= "row">
               <h2> <b>관심사 설정 완료 !</b></h2>
               <h4> ${mem.nickName}님의 관심사에 맞는 북플리를 추천드릴게요! 😊</h4>
                   <div class="col">
                      <div>
                           <br />

                           <br />
                              <br />
                              <input type="button" onclick="window.location='/main/main'" class="btn btn-primary" value="메인"/>
                              &nbsp;
                              <input type="button" onclick="window.location='/mypage/memMypage'" class="btn btn-light" value="마이페이지"/>
                        </div>
                    </div>
                    
                    <div class="col">
                        <figure><img src="/resources/img/signup2.png" alt="sing up image"  width="500px"></figure>
                    </div>
               
         </div>
      </div>

	



<%-- footer 복붙 --%>        
	<%@ include file="../includes/footer.jsp" %>