<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>

<div class="container" id="idFindBG">
	<div class= "row">
		<div class="col-6">
			<figure><img src="/resources/img/pw_change.png" alt="sing up image"  width="380px"></figure>
		</div>
              <div class="col-6">
              	<div id="formform">
                 <h2><b>비밀번호 재설정 🔏</b></h2>
                 <div id="pwChange_div">
                    <br />
                    <form method="POST" id="form" >
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
                  			<table class="idFind_TBL">
			                   <tr>
									<td>* ID</td>
			                  		<td><input type="text" name="id" id="memId" required/> </td>
			                  		<td><span id="checkResult" ></span></td>
			                   </tr>
                   				<tr>
                   					<td>* PW</td>
									<td><input type="password" id="newPw" placeholder="새로운 비밀번호를 입력해주세요" disabled required/></td>
                   				</tr>
                			</table>

                 			<br />
                 			<br />
                  			<button type="button" id="submitBtn" class="btn btn-primary btn-sm" style="margin:0 auto;" disabled>확인</button>
                  		
					</form>
            </div>
            </div> 
					<div style="display:none;" id="mainGo"> 
						<h2><b>비밀번호가 변경되었습니다:)</b></h2>
						<p>로그인후 '뭐읽지?'의 다양한 서비스를 이용해 보세요😊<p>
						<button type="button" class="btn btn-primary btn-sm" onclick="window.location='/main/main'">메인으로</button>
					</div>
            
            
            
		</div>
	</div> 
</div>




<script>

$(document).ready(function(){
	

	$("#pwChange_div").on("change", "#memId", function(){ // id 입력란에 값을 입력했을 때
	     //console.log("아이디 값 입력함!!!");
	     // id 입력란에 사용자가 입력한 값이 필요
	    // let idVal = $("#id").val();
	     let idVal = $(this).val();
	     //console.log(idVal);  //출력해서 확인해보기!!!
	     const $resultMsg = $('#checkResult');
	     
	     
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
	           //console.log("success");
	           //console.log(result);
	           // 결과를 아이디사용가능 여부 input테그에 value값으로 띄워주기
	           if(result == "이미 사용중인 ID 입니다."){
					$resultMsg.html('✔');
					$resultMsg.css('color','green');
					$("#newPw").attr('disabled',false);
	           }else{
					$resultMsg.html('❌');
					$resultMsg.css('color','red');
	        	   
	           }
	        },
	        error: function(e){  // 만약 에러나면 콘솔에 띄워주기 
	           //console.log(e);
	        }
	     });//에이작스
	      
	     $("#pwChange_div").on("change", "#newPw", function(){
		     //비밀번호 변경 버튼 눌렀을때 (form 데이터 보냈을때 )
		     $("#submitBtn").attr('disabled',false);
		     
		     $('#submitBtn').click(function() {
		 		var id = $('#memId').val(); // 아이디 주소값 얻어오기!
		 		var pw =$('#newPw').val();// 비번값 
		 		//console.log('아이디 : ' + id); // 아이디 오는지 확인
		 		//console.log('비번 : ' + pw); // 비번값 오는지 확인
		 		var data = {"id" : id, "pw" : pw};
		 		
		 		
		 		$.ajax({
		 			type : 'post',
		 			url : "/signup/memberPwModify", 
		 			data : JSON.stringify(data),
		 		  	contentType : "application/json;charset=utf-8",
		 			beforeSend: function(xhr){
		                   xhr.setRequestHeader(header, token);
		            	},
		 			success : function (data) {
		 				//console.log("data : " +  data);
		 				alert('비밀번호가 변경되었습니다.');
		 				$("#formform").hide();
		 				$("#mainGo").show();
		 				
		 			},
		 			error: function(e){ //요청 실패시 실행할 코드 ...
		 	               //console.log("저장실패");
		 	               //console.log(e);
		 	            }      			
		 		}); // end ajax
		 		
		 	}); // end send eamil
	     
	     }); //newPw에 변화가 있을때
	     
	  });
});
	
</script>





<%-- footer 복붙 --%>        
   <%@ include file="../includes/footer.jsp" %>