<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>


   <div class="container" id="signupBG">
               <div class= "row">
               <h2> <b>회원가입📚</b></h2>
                   <div class="col">
                      <div>
                           <br />
                           
                           <form method="POST" action="/signup/signup">
                              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
                              <table class="signup_TBL">
                                 <tr>
                                    <td>* 이름</td>
                              		<td><input type="text" name="name" id="name"  required/> </td>
                                 </tr>
                                 <tr>
                                    <td>* 아이디</td>
                              		<td><input type="text" name="id" id="id"  required/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td></td>
                              		<td><input type="text" name="name" id="checkResult" placeholder="아이디 사용 가능 여부" disabled/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>* 비밀번호</td>
                             		<td><input type="password" name="pw" id="pw" required/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>* 비밀번호 확인</td>
                              		<td><input type="password" name="pwCh" id="pwCh"  required/> </td>
                                 </tr>
                                 <tr>
                                    <td></td>
                              <td> <input type="text" name="name" id="checkpw" placeholder="비밀번호 체크" disabled/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>* 닉네임</td>
                              <td> <input type="text" name="nickName" id="nickName"  required/> </td>
                                 </tr>
                                 <tr>
                                    <td></td>
                              <td> <input type="text" name="name" id="nickCheck" placeholder="닉네임 체크" disabled/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>* 이메일</td>
                              <td>  <input type="text" name="email" id="email"  required/> </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>생년월일</td>
                              <td> 
                                 <input type="date" name="birth" id="birth" />  &nbsp; &nbsp;
                                  <input type="radio" id="female" name="gender" value="female" checked>&nbsp; 여 &nbsp;&nbsp;
                                    <input type="radio" id="male" name="gender" value="male" >&nbsp; 남
                                 </td>
                                 </tr>
                                 
                              </table>
                              <br />
                              <br />
                               <input type="submit" class="form-submit btn btn-primary" value="가입하기"/>
                           </form>
                        </div>
                    </div>
                    
                    <div class="col">
                        <figure><img src="/resources/img/signup.png" alt="sign up image"  width="600px"></figure>
                    </div>
               
         </div>
      </div>


   <script>
   $(document).ready(function(){
   $("#signupBG").on("change", "#id", function(){ // id 입력란에 값을 입력했을 때
        console.log("아이디 값 입력함!!!");
        // id 입력란에 사용자가 입력한 값이 필요
       // let idVal = $("#id").val();
        let idVal = $(this).val();
          console.log(idVal);  //출력해서 확인해보기!!!
     
         // js에서 에러난거는 웹에서 F12 눌러서 console에서 확인
          
        // 꺼낸 입력값을 서버에 보냇 DB에 동일한 id가 있는지 체크 
         $.ajax({
           type: "post",
           url: "/signup/idAvail",
           data: {id : idVal},
           beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
              },
           success: function(result){  // 성공하면 result객체 여기에 담겨서 콘솔에 찍기
              console.log("success");
              console.log(result);
              // 결과를 아이디사용가능 여부 input테그에 value값으로 띄워주기
              $("#checkResult").val(result);
           },
           error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
              console.log(e);
              }
        });
         
        
     });
   
   
   $("#signupBG").on("change", "#nickName", function(){
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
   
   
   
   
   
   }); // document
   
   

   
   
   var pwVal = "";
      // 비밀번호 입력
         $("#signupBG").on("change", "#pw", function(){ 
        console.log("비밀번호 값 입력함!!!");
        pwVal = $(this).val();
        console.log("비밀번호 : " + pwVal);
        console.log("비밀번호 확인 : " + pwchVal);
     });
   
     
     // 비밀번호, 비밀번호 확인 체크
     $("#signupBG").on("change", "#pwCh", function(){
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









<!-- footer 복붙 -->        
   <%@ include file="../includes/footer.jsp" %>