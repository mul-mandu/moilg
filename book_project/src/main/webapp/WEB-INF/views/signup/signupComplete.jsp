<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <%-- header 복붙 --%>
<%@ include file="../includes/header.jsp" %>

<script>
	let nick = '${nickname}';
	//console.log(nick);
</script>
	<div class="container" id="signupBG">
            	<div class= "row">
	            <h2> <b>회원가입 완료!</b></h2>
                	<div class="col">
	                        <br />
								<p>${nickname} 님의 가입을 진심으로 환영합니다🎉 <br />
								관심사 설정 후 더욱 정확한 북플레이리스트 추천을 받아보세요!
								</p>
	                           <br />
	                           <input type="button" onclick="window.location='/signup/signupInter'" class="btn btn-primary" value="관심사 설정"/>
	                           <input type="button" onclick="window.location='/main/main'" class="btn btn-primary" value="나중에하기"/>
                    </div>
                   
                    <div class="col">
                        <figure><img src="/resources/img/signup.png" alt="singupimage"  width="450px"></figure>
                    </div>
                
			</div>
		</div>
		


<%-- footer 복붙 --%>        
	<%@ include file="../includes/footer.jsp" %>