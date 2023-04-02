<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%-- header 복붙 --%>
<%@ include file="../includes/header.jsp" %>


   <div class="container" id="signupBG_inter">
               <div class= "row">
               <h2> <b>관심사 설정 💖</b></h2>
                   <div class="col">
                      <div>
                           <br />
                           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
                            <sec:authentication property="principal" var="princ" /> 
                              <input type="hidden" id="memId" value="${princ.username}" />
                          
                              <table class="signupIter_TBL">
                                 <tr>
                                    <td rowspan="3"><b>선호장르</b></td>
		                              <td> 
		                                 <input type="checkbox"  name="keyBox" value="1" id="chk1" /><label for="chk1">&nbsp;추리/미스터리소설&nbsp;</label> 
		                                 <input type="checkbox"  name="keyBox" value="2" id="chk2" /><label for="chk2">&nbsp;SF/판타지&nbsp;</label> 
		                                 <input type="checkbox" name="keyBox" value="3" id="chk3" /><label for="chk3">&nbsp;한국소설&nbsp;</label>
		                                 <input type="checkbox" name="keyBox" value="4" id="chk4" /><label for="chk4">&nbsp;외국소설&nbsp;</label>
		                              </td>
                                 </tr>
                                 
                                 <tr>
		                              <td colspan="6">
		                                 <input type="checkbox" name="keyBox" value="5" id="chk5" /><label for="chk5">&nbsp;고전문학&nbsp;</label>
		                                 <input type="checkbox" name="keyBox" value="6" id="chk6" /><label for="chk6">&nbsp;시&nbsp;</label> 
		                                 <input type="checkbox"  name="keyBox" value="7" id="chk7" /><label for="chk7">&nbsp;에세이&nbsp;</label> 
		                                 <input type="checkbox"  name="keyBox" value="8" id="chk8" /><label for="chk8">&nbsp;철학&nbsp;</label> 
		                                 <input type="checkbox" name="keyBox" value="9" id="chk9" /><label for="chk9">&nbsp;역사서&nbsp;</label>
		                                 <input type="checkbox" name="keyBox" value="10" id="chk10" /><label for="chk10">&nbsp;예술&nbsp;</label>
		                              </td>
                                 </tr>
                                 
                                 <tr>
		                              <td> 
		                                 <input type="checkbox" name="keyBox" value="11" id="chk11" /><label for="chk11">&nbsp;자기계발&nbsp;</label>
		                                 <input type="checkbox" name="keyBox" value="12" id="chk12" /><label for="chk12">&nbsp;경제&nbsp;</label> 
		                                 <input type="checkbox"  name="keyBox" value="13" id="chk13" /><label for="chk13">&nbsp;요리&nbsp;</label> 
		                                 <input type="checkbox"  name="keyBox" value="14" id="chk14" /><label for="chk14">&nbsp;여행&nbsp;</label> 
		                                 <input type="checkbox" name="keyBox" value="15" id="chk15" /><label for="chk15">&nbsp;심리&nbsp;</label>
		                              </td>
                                 </tr>
                                 
                                 
                                 
                                 <tr>
                                    <td rowspan="2"><b>선호분위기</b></td>
                              <td> 
                                 <input type="checkbox"  name="keyBox" value="16" id="chk16" /><label for="chk16">&nbsp;따뜻한&nbsp;</label> 
                                 <input type="checkbox"  name="keyBox" value="17" id="chk17" /><label for="chk17">&nbsp;희망적인&nbsp;</label> 
                                 <input type="checkbox" name="keyBox" value="18" id="chk18" /><label for="chk18">&nbsp;밝은&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="19" id="chk19" /><label for="chk19">&nbsp;감성적인&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="20" id="chk20" /><label for="chk20">&nbsp;아련한&nbsp;</label>
                              </td>
                                 </tr>
                                 
                                 <tr>
                              <td> 
                                 <input type="checkbox" name="keyBox" value="21" id="chk21" /><label for="chk21">&nbsp;우울한&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="22" id="chk22" /><label for="chk22">&nbsp;가벼운&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="23" id="chk23" /><label for="chk23">&nbsp;어두운&nbsp;</label>
                                 <input type="checkbox"  name="keyBox" value="24" id="chk24" /><label for="chk24">&nbsp;꽃이 흩날리는 봄&nbsp;</label>
                                 <input type="checkbox"  name="keyBox" value="25" id="chk25" /><label for="chk25">&nbsp;청량한 여름&nbsp;</label> 
                                 <br /> 
                                 <input type="checkbox" name="keyBox" value="26" id="chk26" /><label for="chk26">&nbsp;차분한 가을&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="27" id="chk27" /><label for="chk27">&nbsp;찬란한 겨울&nbsp;</label>
                              </td>
                                 </tr>
                                 
                                 
                                 <tr>
                                    <td rowspan="3"><b>상황</b></td>
                              <td> 
                                 <input type="checkbox"  name="keyBox" value="28" id="chk28" /><label for="chk28">&nbsp;새로운 시작&nbsp;</label> 
                                 <input type="checkbox"  name="keyBox" value="29" id="chk29" /><label for="chk29">&nbsp;위로가 필요할때&nbsp;</label> 
                                 <input type="checkbox" name="keyBox" value="30" id="chk30" /><label for="chk30">&nbsp;이별했을때&nbsp;</label>
                              </td>
                                 </tr>
                                 
                                 <tr>
                              <td> 
                                 <input type="checkbox" name="keyBox" value="31" id="chk31"/><label for="chk31">&nbsp;기분전환이 필요할때&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="32" id="chk32"/><label for="chk32">&nbsp;힐링이 필요할때&nbsp;</label>
                              
                              </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>
                                       <input type="checkbox" name="keyBox" value="33" id="chk33"/><label for="chk33">&nbsp;인간관계에 피로할때&nbsp;</label>
                                 <input type="checkbox" name="keyBox" value="34" id="chk34"/><label for="chk34">&nbsp;우울할때&nbsp;</label>
                                    </td>
                                 </tr>
                   
                              </table>
                              <br />
                              
                              <button type="button" class="btn btn-primary" id="interSubmitBtn" >등록하기</button>
                        </div>
                    </div>
                    
                    <div class="col">
                        <img src="/resources/img/signup2.png" alt="sing up image"  width="500px">
                    </div>
               
         </div>
      </div>
   
   

<script>

   let checkArr = new Array();
   
   $(document).ready(function(){ 

      
      $("input[type='checkbox']").on('change', function(){
         if($(this).is(":checked")){  // 체크 됐을때 
            checkArr.push($(this).val());
         
         }else { // 체크 해제 됐을때 
            for(let i = 0; i < checkArr.length; i++){
               if(checkArr[i] == $(this).val()){
                  checkArr.splice(i, 1);
               }
            }
         }
         //console.log(checkArr);
      });
      
      
      
      $("#interSubmitBtn").on("click", function(){
         //console.log("버튼 누름");
         let id = $("#memId").val();
         //console.log(id);
         //let keyData = {checkArr};
         //console.log("키워드 데이터 : " + JSON.stringify(checkArr));
         
         $.ajax({
            method   : "POST",
            data    : JSON.stringify(checkArr),
            url    : "/signup/signupInterPro",
            contentType : "application/json;charset=utf-8",
            beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
              },
            success   :  function(result){ //요청 성공시 실행할 코드 ...
               //console.log("관심사 저장 완료!");   
               //console.log("result" + result);
               window.location.href = "/signup/signupInterComplete";
            
            },
            error : function(e){ //요청 실패시 실행할 코드 ...
               //console.log("저장실패");
               //console.log(e);
            }       
         }) //에이작스
         
         
      }); //btn onclick

   
   });// document.ready
</script>

<%-- footer 복붙 --%>        
   <%@ include file="../includes/footer.jsp" %>