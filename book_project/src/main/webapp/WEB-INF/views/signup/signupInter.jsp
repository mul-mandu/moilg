<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- header 복붙 -->
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
                                 <input type="checkbox"  name="keyBox" value="1" /> <label>추리/미스터리소설</label> 
                                 <input type="checkbox"  name="keyBox" value="2" /> <label>SF/판타지</label> 
                                 <input type="checkbox" name="keyBox" value="3" /> <label>한국소설</label>
                                 <input type="checkbox" name="keyBox" value="4" /> <label>외국소설</label>
                              </td>
                                 </tr>
                                 
                                 <tr>
                                    <td colspan="6">
                                       <input type="checkbox" name="keyBox" value="5" /> <label>고전문학</label>
                                 <input type="checkbox" name="keyBox" value="6" /> <label>시</label> 
                                 <input type="checkbox"  name="keyBox" value="7" /> <label>에세이</label> 
                                 <input type="checkbox"  name="keyBox" value="8" /> <label>철학</label> 
                                 <input type="checkbox" name="keyBox" value="9" /> <label>역사서</label>
                                 <input type="checkbox" name="keyBox" value="10" /> <label>예술</label>
                                    </td>
                                 
                                 </tr>
                                 
                                 <tr>
                              <td> 
                                 
                                 <input type="checkbox" name="keyBox" value="11" /> <label>자기계발</label>
                                 <input type="checkbox" name="keyBox" value="12" /> <label>경제</label> 
                                 <input type="checkbox"  name="keyBox" value="13" /> <label>요리</label> 
                                 <input type="checkbox"  name="keyBox" value="14" /> <label>여행</label> 
                                 <input type="checkbox" name="keyBox" value="15" /> <label>심리</label>
                              </td>
                                 </tr>
                                 
                                 
                                 
                                 <tr>
                                    <td rowspan="2"><b>선호분위기</b></td>
                              <td> 
                                 <input type="checkbox"  name="keyBox" value="16" /> <label>따뜻한</label> 
                                 <input type="checkbox"  name="keyBox" value="17" /> <label>희망적인</label> 
                                 <input type="checkbox" name="keyBox" value="18" /> <label>밝은</label>
                                 <input type="checkbox" name="keyBox" value="19" /> <label>감성적인</label>
                                 <input type="checkbox" name="keyBox" value="20" /> <label>아련한</label>
                              </td>
                                 </tr>
                                 
                                 <tr>
                              <td> 
                                 <input type="checkbox" name="keyBox" value="21" /> <label>우울한</label>
                                 <input type="checkbox" name="keyBox" value="22" /> <label>가벼운</label>
                                 <input type="checkbox" name="keyBox" value="23" /> <label>어두운</label>
                                 <input type="checkbox"  name="keyBox" value="24" /> <label>꽃이 흩날리는 봄</label> 
                                 <input type="checkbox"  name="keyBox" value="25" /> <label>청량한 여름</label> 
                                 <input type="checkbox" name="keyBox" value="26" /> <label>차분한 가을</label>
                                 <input type="checkbox" name="keyBox" value="27" /> <label>찬란한 겨울</label>
                              </td>
                                 </tr>
                                 
                                 
                                 <tr>
                                    <td rowspan="3"><b>상황</b></td>
                              <td> 
                                 <input type="checkbox"  name="keyBox" value="28" /> <label>새로운 시작</label> 
                                 <input type="checkbox"  name="keyBox" value="29" /> <label>위로가 필요할때</label> 
                                 <input type="checkbox" name="keyBox" value="30" /> <label>이별했을때</label>
                              </td>
                                 </tr>
                                 
                                 <tr>
                              <td> 
                                 <input type="checkbox" name="keyBox" value="31" /> <label>기분전환이 필요할때</label>
                                 <input type="checkbox" name="keyBox" value="32" /> <label>힐링이 필요할때</label>
                              
                              </td>
                                 </tr>
                                 
                                 <tr>
                                    <td>
                                       <input type="checkbox" name="keyBox" value="33" /> <label>인간관계에 피로할때</label>
                                 <input type="checkbox" name="keyBox" value="34" /> <label>우울할때</label>
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
         console.log(checkArr);
      });
      
      
      
      $("#interSubmitBtn").on("click", function(){
         console.log("버튼 누름");
         let id = $("#memId").val();
         console.log(id);
         //let keyData = {checkArr};
         console.log("키워드 데이터 : " + JSON.stringify(checkArr));
         
         $.ajax({
            method   : "POST",
            data    : JSON.stringify(checkArr),
            url    : "/signup/signupInterPro",
            contentType : "application/json;charset=utf-8",
            beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
              },
            success   :  function(result){ //요청 성공시 실행할 코드 ...
               console.log("관심사 저장 완료!");   
               console.log("result" + result);
               window.location.href = "/signup/signupInterComplete";
            
            },
            error : function(e){ //요청 실패시 실행할 코드 ...
               console.log("저장실패");
               console.log(e);
            }       
         }) //에이작스
         
         
      }); //btn onclick

   
   });// document.ready
</script>

<!-- footer 복붙 -->        
   <%@ include file="../includes/footer.jsp" %>