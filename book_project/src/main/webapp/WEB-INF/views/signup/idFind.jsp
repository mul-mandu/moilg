<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>

   <div class="container" id="idFindBG">
          <div class= "row">
           
                 <div class="col-6">
                      <figure><img src="/resources/img/idfind.png" alt="sing up image"  width="500px"></figure>
                  </div>
                 
                    
                 <div class="col">
                    <h2> <b>아이디 찾기 🔎</b></h2>
                    <div id="idfind_div">
                       <br />
                       
                       <form method="POST" action="/signup/idFind"  name="findform">
                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
                           
                           <table class="idFind_TBL">
                           <tr>
                              <td>* 이름</td>
                        <td> <input type="text" name="name" id="name" required/> </td>
                           </tr>

                           <tr>
                              <td>* 이메일</td>
                        <td>  <input type="text" name="email" id="email" required/> </td>
                           </tr>

                        </table>
                          <br />
                          <br />
                           <input type="submit" class="btn btn-primary"  value="아이디 찾기"/>
                       </form>
                      </div>
                           
                              <c:if test="${check == 1}">
                           <script>
                              $("#idfind_div").hide();
                           </script>
                           <h4>일치하는 정보가 존재하지 않습니다.</h4>
                           
                        </c:if>
                  

                        <c:if test="${check == 0 }">
                           <script>
                              $("#idfind_div").hide();
                           </script>
                           <h5>회원님의 아이디는</h5>
                           <h4> <b>'${id}'</b> 입니다.</h4>
                        </c:if>
                  
                           
                           
                          <br />
                          <br />
                          <br />
                          <br />
                          <br />
                          <br />
                           <button type="button" onclick="window.location='/signup/signup'" class="btn btn-outline-secondary btn-sm" >회원가입</button>
                           <button type="button" onclick="window.location='/signup/pwFind'" class="btn btn-outline-secondary btn-sm" >비밀번호 찾기</button>
                      
                  </div>
                  
                  
    
                  
                  
                  
                  
                 
      </div>
   </div>






<!-- footer 복붙 -->        
   <%@ include file="../includes/footer.jsp" %>