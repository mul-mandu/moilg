<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>

   <div class="container" id="idFindBG">
          <div class= "row">
           
                 <div class="col-6">
                      <figure><img src="/resources/img/pwfind.png" alt="sing up image"  width="380px"></figure>
                  </div>
                 
                    
                 <div class="col-6">
                    <h2> <b>비밀번호 찾기 🔐</b></h2>
                    <div id="pwfind_div">
                       <br />
                       
                       <form method="POST" >
	                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
		                           <table class="idFind_TBL">
		                           <tr>
										<td>* 이메일</td>
										<td><input type="text" name="email" id="email" required/></td> 
		                           		<td class="input-group-addon">
		                           			<button type="button" class="btn btn-outline-primary btn-sm" id="mail-Check-Btn">인증번호발송</button>
		                           		</td>
		                           </tr>
		                           <tr>
		                           		<td>* 인증번호</td>
										<td class="mail-check-box">
											<input type="text" class="mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
										</td>
										<td>
											<span id="mail-check-warn"></span>
										</td>
		                           </tr>
		                        </table>
		                          <br />
		                          <br />
		                          <div style="text-align: left;">
			                          <button type="button" onclick="window.location='/signup/idFind'" class="btn btn-primary btn-sm" style="display: inline-block;" >아이디 찾기</button>
			                          <button type="button" id="changePwBtn" class="btn btn-primary btn-sm" style="display: inline-block;" onclick="window.location='/signup/pwChange'" disabled>비밀번호 재설정</button>
                    			</div>	
                          </form>
                      </div>
               </div>
      </div>
   </div>





<script>
	$('#mail-Check-Btn').click(function() {
		var email = $('#email').val(); // 이메일 주소값 얻어오기!
		console.log('이메일 : ' + email); // 이메일 오는지 확인
		var data = {"email" : email};
		
		const checkInput = $('.mail-check-input'); // 인증번호 입력하는곳 
		
		$.ajax({
			type : 'post',
			url : "/signup/pwFind", 
			data : JSON.stringify(data),
		  	contentType : "application/json;charset=utf-8",
			beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
           	},
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code = data;
				alert('인증번호가 전송되었습니다.')
			},
			error: function(e){ //요청 실패시 실행할 코드 ...
	               console.log("저장실패");
	               console.log(e);
	            }      			
		}); // end ajax
		
	}); // end send eamil

	
	
	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('✔');
			$resultMsg.css('color','green');
			$('#mail-Check-Btn').attr('disabled',true);
			$('#userEamil1').attr('readonly',true);
			$('#changePwBtn').attr('disabled', false);
			
		}else{
			$resultMsg.html('❌');
			$resultMsg.css('color','red');
		}
	});
	
</script>












<!-- footer 복붙 -->        
   <%@ include file="../includes/footer.jsp" %>