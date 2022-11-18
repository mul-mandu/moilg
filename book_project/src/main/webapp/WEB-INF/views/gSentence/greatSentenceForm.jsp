<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>

<!-- header 복붙 -->
<%@ include file="../includes/header.jsp"%>
<br />
<h4>인생문장 작성하기</h4>
<br />
<div class="row">
   <div class="col-4">
      <div>
         <div style="position: relative;">
            <img src="/resources/img/imgDefault.jpg" class="bPlistCover card" id="preview" />
            <div style="position: absolute; top: 14px; left: 243px;">
               <label for="file"> 
                  <img id="editImg" src="/resources/img/edit.png" />
               </label>
            </div>
         </div>

      </div>
   </div>
   <div class="col-8">
      <form action="/gSentence/greatSentenceForm" method="post"
         enctype="multipart/form-data">
         <sec:csrfInput />
         <span id="textCount"> 0자 </span><span id="textTotal">/200자</span>
<!--          <pre> -->
            <textarea name="greatContent" id="contents"
               placeholder="* 인생문장을 적어주세요👀 *" maxlength="200"></textarea>
<!--          </pre> -->
            <button id="addbook" type="button" data-bs-target="#findBookModalToggle" data-bs-toggle="modal" class="btn btn-outline-secondary mx-auto">+ 도서 추가</button>
            <input type="text" id="isbn" name="greatIsbn" style="display: none;"/>
            <input type="text" id="bookTitle" name="greatBookTitle"/>
         <br /> <span> <input type="checkbox" value="0" name="greatContentStatus" />비공개
         <input type="file" id="file" name="greatImgFile" style="display: none;"/>
            <button type="submit" class="btn btn-outline-secondary btn-sm" style="float: right;">등록하기</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" style="float: right"
               onclick="window.location='/gSentence/greatSentence'">뒤로가기</button>
         </span>
      </form>
   </div>
</div>




 <!--******* 도서 추가 모달  ********  -->
   <div class="modal fade" id="findBookModalToggle" aria-hidden="true" aria-labelledby="findBookModalToggle" tabindex="-1" style="padding: 20px;" data-refresh="true" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-scrollable">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="findBookModalToggleLabel"><b>도서 검색 📘</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         
          <div class="modal-body">
                <div id="bookserch_bar_div">
               <input type="text"  id="booksearch_bar" placeholder="제목/작가로 검색" required/>
               <button type="button" id="booksearchPage_btn" data-refresh="true">검색</button>
               
            </div>
                <hr />
               
                 <div>
                    <form>
                    <table id="bookSearchTBL">
      
                    </table>
                 </form>
                 <br/><br/><br/>
                 
                  <label>선택한 도서</label>
                  <hr />
                  
            <!-- 선택한 도서 여기에 담김 -->
                  <table id="bookSelectedTBL">
                  
                </table>
                 
              <hr />

                 </div>
          </div>
          
         <div class="modal-footer">
            
              <button type="button" class="btn btn-primary" id="bookSelectedConfirm" data-bs-dismiss="modal" aria-label="Close">확인</button>
           
         </div>
       </div>
     </div>
   </div>




<script>
   $("#file").on('change', function() {
      var fileName = $("#file").val();
      console.log(fileName);
      $(".upload-name").val(fileName);
   });

   $("#contents").keyup(function(e) {
      let content = $(this).val();

      // 글자수 세기
      if (content.length == 0 || content == '') {
         $('#textCount').text('0자');
      } else {
         $('#textCount').text(content.length + '자');
      }

      // 글자수 제한
      if (content.length > 200) {
         // 200자 부터는 타이핑 되지 않도록
         $(this).val($(this).val().substring(0, 200));
         // 200자 넘으면 알림창 뜨도록
         alert('글자수는 200자까지 입력 가능합니다.');
      }
      ;

   });
</script>

<script>

   $('#file').change(function(){
      setImageFromFile(this, '#preview');
   });
       
   function setImageFromFile(input, expression) {
       if (input.files && input.files[0])
       {
           var reader = new FileReader();
    
               reader.onload = function (e) {
                   $(expression).attr('src', e.target.result);
              }
              reader.readAsDataURL(input.files[0]);
        }
   }

</script>

<script>
//책 관련 변수 ////////////////

var selectedBookArr = [];

   // 책 검색 이벤트
   function bookData(success, data){
        console.log(success);
        console.log(data);
        $("#bookSearchTBL").empty();
      $("#bookSelectedTBL").empty();
        console.log($("#bookSearchTBL").html());

        for(let i=0; i<data.item.length ; i++){
           var title=data.item[i].title;
            var cover=data.item[i].cover;
            var author=data.item[i].author;
            var isbn = data.item[i].isbn13;
            
            var booklist = "<tr><td><img src='"+cover+"' class='findBoookModal_img'/></td>";
            booklist += "<td><label><b id='title' data-isbn='"+isbn+"'>"+title+"</b></label></td>";
            booklist += "<td><label style='color: #898989; float: right;' id='author'>"+author+"</label></td>";
            booklist += "<td><input type='radio' name='chose' class='checkBtn' value='"+isbn+"' /></td></tr>";
            
            $("#bookSearchTBL").append(booklist);
        }
        
    }  // 책 검색
    
    
    // 선택 라디오 버튼 눌렀을 시 발생 이벤트
    $("#bookSearchTBL").on("click", ".checkBtn", function(){
       console.log("버튼 클릭함!!!");
        $("#bookSelectedTBL").empty();
        console.log($(this));
        trTag = $(this).parent().parent().clone(); 
        trTag.find("input[type='radio']").remove();
        console.log(trTag);
        $("#bookSelectedTBL").append(trTag);
        console.log(trTag);
    });
   

    // 확인 버튼시 발생 이벤트
    $("#bookSelectedConfirm").click(function(){
       console.log("확인 버튼 클릭!!!!!!!!!");
       
       var selected = $("#bookSelectedTBL");
       var coverImg = selected.find("img").attr("src");
       var title = selected.find("#title").text();
       var author = selected.find("#author").text();
       var isbn = selected.find("#title").data("isbn");
       
       console.log("isbn : " + isbn);
       console.log("title : " + title);
       console.log("author : " + author);
       
       // 값이 입력되어 있는지 체크
       if(title=="" && author == ""){
          alert('검색어를 입력해주세요!');
       } else {
          // 중복체크하기
           var check = 0; // 체크할 변수 생성
           for(let i=0; i<selectedBookArr.length; i++){
              if(isbn == selectedBookArr[i].isbn){
                 check = 1;
              }
              
           }
           
           if(check == 1){
              alert('이미 등록되어 있는 도서입니다!');
           }else{
              
              $("#isbn").val(isbn);
              $("#bookTitle").val(title);
              console.log("저장할 도서명 : " + title + "isbn : " + isbn);
           }
          
       }// else
       
    });// 확인 버튼시 발생 이벤트 끝
    
    
    
    

   // 도서 추가 버튼 눌렀을 시
   $('#addbook').on('click', function(){
      console.log("책 추가 모달 버튼 누름!");
      
      $("#findBookModalToggle").modal("show");
      $("#bookSearchTBL").empty();
      $("#bookSelectedTBL").empty();      
      $('#booksearch_bar').val("");
      
   });
   
    
   //책 검색 버튼을 눌렀을때
   $('#booksearchPage_btn').on('click', function (e) {
      console.log("책 검색 버튼 누름!");
      $("#bookSearchTBL").empty();
      
      var bookSearch = $('#booksearch_bar').val();
      
      if(bookSearch == ""){
         alert('검색어를 입력해주세요!');
      }else{
         //보낼 데이터 js객체로 만들기 
         ttbkey = "ttbhan_yurim1536001";
         let searchText = $("#booksearch_bar").val(); // 검색어 입력
         let url ="http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey="+ ttbkey + "&Query=" + searchText;
               
         console.log("검색어 : " + searchText);
         console.log("키값 : " + ttbkey);
      
           //요청에 대한 정보
           $.ajax({
               method: "get",
               dataType:"jsonp",
               jsonp: 'bookData',
               url: "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx",
               data: { 
                  TTBKey:"ttbhan_yurim1536001",
                  QueryType : "keyword",
                  Query: searchText,
                  output:"JS",
                  cover:"Big",
                  MaxResults:"30",
                  outofStockfilter:"1",
                  callback:"bookData"
               } 
           });
         
      } // else
      
   });   //책 검색 버튼을 눌렀을때 끝

</script>

<!-- footer 복붙 -->
<%@ include file="../includes/footer.jsp"%>


