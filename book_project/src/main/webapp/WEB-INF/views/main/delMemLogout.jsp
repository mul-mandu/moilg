<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!-- header 복붙 -->
   <%@ include file="../includes/header.jsp" %>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
   <br/>
    <!-- 탈퇴 되면 처리할 로그아웃처리  -->
    <form action="/logout" method="post" style="display:none;" id="logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
   </form> 
   
	<script>
   	alert("탈퇴한 회원입니다😥 회원가입후 이용해주세요.");
	let formObj = $("#logout");
    formObj.submit();
 
   	
	</script>      
    <!-- footer 복붙 -->
   <%@ include file="../includes/footer.jsp" %>
   
   