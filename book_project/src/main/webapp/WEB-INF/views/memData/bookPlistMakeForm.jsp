<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

      <!-- bootstrap -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
      crossorigin="anonymous">
   </script>
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   
    <script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
  
      <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
     <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> 


<div class="container" id="bookitemDetails_con">
   <div> <!-- 상단 이미지 / 제목 /  작가 / 버튼 등 -->
        <div class="row">
           <div class="col-5">
                <div>
                   <div style="position: relative;">
                     <img src="/resources/img/imgDefault.jpg"  class="bPlistCover card" id="preview"/>
                   <div style="position: absolute; top:14px; left: 287px;">
                      <label for="file" >
                       <img id="editImg" src="/resources/img/edit.png"/>
                    </label>
                   </div>
                   </div>
                
                </div>
           </div>
           <div class="col">
              <h5> ${member.nickName} 님의 북 플레이리스트 생성</h5>
            <div class="form-control">
                 <form id="fileForm" method="Post" enctype="multipart/form-data">
                  <input type="file" name="file" id="file" style="display: none;" >
                  <input type="text" id="bookPLTitle" name="bookPLTitle" placeholder="북 플레이리스트 명" required /> 
                  <input type="hidden" id="bookPLmakeUser" name="bookPLmakeUser" value="${member.id}" placeholder="북 플레이리스트 명" /> 
                  <input type="radio" name="listStatus" value="0" checked/> 공개
                  <input type="radio" name="listStatus" value="1"/> 비공개
               </form>
                 </div>
   
              
                 <table>
                    <tr id="finalSelecKeyword">
                    
                    </tr>
                    
                    
                 </table>
                 
                 
             <br />
            <button id="addHashTag" type="button" class="btn btn-outline-secondary mx-auto" >+ 키워드 추가</button>
                 
                 <br/><br/><br/><br/><br/><br/>
                 <p style="color: #9e9e9e;">* 키워드는 최대 10개까지 설정 가능합니다.</p>
               
              </div>
           </div>
           <br />
      </div> <!-- 상단 이미지 / 제목 /  작가 / 버튼 등 끝-->
      
      <div>
         <table id="listTable">
            <thead>
               <tr>
                  <th>선택</th>
                  <th>표지</th>
                  <th>도서명</th>
                  <th>저자</th>
               </tr>
            </thead>
            
            
            <!-- 추가한 도서 여기에 담김 -->
            <tbody id="addBookList">
            
         
            </tbody>
         </table>
         <br/>
         <br/>
         <div style="text-align: center">
             <p style="color: #9e9e9e; text-align: center">* 도서는 최대 10개까지 설정 가능합니다.</p>
            <button id="addbook" type="button" data-bs-target="#findBookModalToggle" data-bs-toggle="modal" class="btn btn-outline-secondary mx-auto" style="margin: 0 auto; display :inline-block;">+ 도서 추가</button>
      
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
   
               <button type="button" class="btn btn-secondary mx-auto" style="margin: 0 auto;" onclick="history.go(-1)">취소</button>
               <button type="button" class="btn btn-primary mx-auto" style="margin: 0 auto;" id="savePlist">저장</button>
              
      </div>
      
      
      
      
      </div>
   </div>

<!--  키워드 추가 모달!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
   <div class="modal fade" id="keywordModalToggle" aria-hidden="true" aria-labelledby="keywordModalToggle" tabindex="-1" style="padding: 20px;" data-bs-backdrop="static" data-bs-keyboard="false" data-refresh="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="keywordModalToggleLabel"><b>키워드 추가하기 🔮</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
          <div class="modal-body">
                <div id="serch_bar_div">
                   <form>
                  <input type="text" class="search_bar" id="search" placeholder="키워드 검색" required/>
                  <input type="hidden" class="search_bar" id="searchValue" />
                  <button type="button" id="searchPage_btn">등록</button>
               </form>
            </div>
                <hr />
                   
         
                 <div>
                    <br/><br/><br/>
                     <label>선택한 키워드 &nbsp;&nbsp;&nbsp;</label>
                 <label style="color: #9e9e9e; font-size: 13px; float: right;">* 최대 10개</label>
                 <hr />
                 
                 <table>
                    <tr id="selectedKeyword">

                    
                    </tr>
                 </table>
          
                 
         
                 </div>
          </div>
              
         <div class="modal-footer">
            <div id="keyOK">
              <button id="keyWordSelectedConfirm" type="button" class="btn btn-primary">확인</button>
            </div>
         
         </div>
       </div>
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
   
   
   
   <!--  저장완료 확인 모달!!!!  -->
   <div class="modal fade" id="savedFinishModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">북 플레이리스트 생성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       북플리 리스트 생성이 완료되었습니다! 😇📖  
       </div>
      <div class="modal-footer">
         <sec:authorize access="hasRole('ROLE_MEMBER')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/memMypage'">확인</button>
         </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')">
              <button type="button" class="btn btn-secondary" onclick="window.location='/mypage/adminMypage'">확인</button>
         </sec:authorize>
      </div>
    </div>
  </div>
</div>
   

   
  <!-- ************************************책 검색 스크립트!!!!!!!!!!!!!!!! ******************** --> 
  
  
<script>

// 책 관련 변수 ////////////////

var selectedBookArr = [];

/////////////////////////////////


// 키워드 관련 변수들 //////////////////

var keyWordList = [];  // 키워드 저장 변수 

var item;
var itemLabel;
var itemValue;

///////////////////////////


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
              
              var addList = "<tr><td id='small_td'><button type='button' id='cancleAdd'><i class='fa-solid fa-xmark'></i></button></td>";
               addList += "<td><img src='"+coverImg+"' id='bookCoverSize'/></td>";
               addList += "<td>"+title+"</td>";
               addList += "<td>"+author+"</td></tr>";

                  
               $("#addBookList").append(addList);
               

               selectedBookArr.push({'isbn' : isbn,'bookTitle' : title, 'author' : author, 'bookCover' : coverImg});
               console.log("저장할 도서리스트 : " + selectedBookArr);
              
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
    
   
   
      //북 패키지 먼저 저장하기
      $("#savePlist").on("click", function(){   
         console.log("저장 버튼 클릭!!!!!!!");
               
         // 원하는 것만 넘겨주는 방식
         var data = new FormData();
         var title = $("#bookPLTitle").val();
         var status = $('input[name=listStatus]:checked').val();
         var file = $('#file')[0].files[0];

         //console.log("타이틀 " + title);
         //console.log("상태값" + status);
         //console.log("파일" + file);
         
         data.append('bookPLTitle', title);
         data.append('listStatus', status);
         data.append('packCoverFile', file);
         
         console.log(data.get('bookPLTitle'));
         console.log(data.get('listStatus'));
         console.log(data.get('packCoverFile'));


         for (var pair of data.entries()) {
              console.log(pair[0]+ ', ' + pair[1]);
         }
         
         if(keyWordList.length == 0 || selectedBookArr.length == 0 ){
            alert("키워드와 도서가 등록되어 있지 않습니다");
         }else{
            // 북 플레이 패키지 ajax 보내기
            $.ajax({
               type : "POST",
               url : "/memData/addBookListPack",
               data: data,
               contentType: false,
               processData: false,
               enctype: 'multipart/form-data',
                  beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
                  },
                  success: function(result){
                      console.log("북 플레이 리스트 커버 등록 성공!!!!!");
                      console.log(result);
                      addOnebookList();
                   },
                   error: function(e){
                      console.log("북 플레이 리스트 생성 요청 에러......");
                      console.log(e);
                   }
            });//에이작스

            
         }
         
        
         
      
   });//세이브 버튼 펑션 
   
   
   
   
   
   function addOnebookList(){
      console.log("하나의 북리스트 추가 ajax 호출!!!!!......");
      $.ajax({
         type : "POST",
         url : "/memData/AddOneBookList",
         data: JSON.stringify(selectedBookArr),
         contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
            },
            success: function(result){
                console.log("하나의 북리스트 추가 요청 성공!!!!!");
                console.log(result);
                addPLKeyWord();
             },
             error: function(e){
                console.log("하나의 북리스트 추가 요청 에러......");
                console.log(e);
             }
      });
   }
   
   
   
   
   
   
   function addPLKeyWord(){
      console.log("키워드 등록 ajax호출!!!!!......");
      
         
      $.ajax({
         type : "POST",
         url : "/memData/addPLKeyWord",
         data: JSON.stringify(keyWordList),
         contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
            },
            success: function(result){
                console.log("키워드 등록 요청 성공!!!!!");
                console.log(result);
                $("#savedFinishModal").modal("show");
             },
             error: function(e){
                console.log("키워드 등록 요청 에러......");
                console.log(e);
             }
      });
      
   }

   
   // 책 선택 삭제 시 발생 이벤트 등록!!!!!
    $("#addBookList").on("click", "#cancleAdd", function(){
       console.log("책 선택 취소 버튼 클릭함!!!");
        console.log($(this));
      
        var index = $(this).closest('tr').index();
        console.log("index : " +index);
        
        var val = selectedBookArr[index];
        console.log("저장한 selectedBookArr : " + selectedBookArr);
        console.log("삭제할 selectedBookArr : " + selectedBookArr[index]);
        
        for(var i = 0; i < selectedBookArr.length; i++){ 
          if (selectedBookArr[i] === val) { 
           selectedBookArr.splice(index, 1); 
            i--; 
          }
        }
      console.log("for문 거친 selectedBookArr : " + selectedBookArr);
        $(this).parent().parent().remove(); // 화면에서 지우기
        
    });
    


  //- ************************************  키워드 스크립트!!!!!!!!!!!!!!!! ******************** 


   var data = new Array();
   
  
   $('#addHashTag').on('click', function(){
      console.log("키워드 추가 호출!!!!!!!");

      $("#keywordModalToggle").modal("show");

      $( function() {
          $.widget( "custom.catcomplete", $.ui.autocomplete, {
            _create: function() {
              this._super();
              this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
            },
            _renderMenu: function( ul, items ) {
              var that = this,
                currentCategory = "";
              $.each( items, function( index, item ) {
                var li;
                if ( item.category != currentCategory ) {
                  ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
                  currentCategory = item.category;
                }
                li = that._renderItemData( ul, item );
                if ( item.category ) {
                  li.attr( "aria-label", item.category + " : " + item.label );
                }
              });
            }
          });
          data =[
              { label: "추리소설", category: "장르", value : 1},
              { label: "SF/판타지", category: "장르", value : 2 },
              { label: "한국소설", category: "장르", value : 3 },
               { label: "외국소설", category: "장르", value : 4 },
               { label: "고전문학", category: "장르", value : 5 },
               { label: "시", category: "장르", value : 6 },
              { label: "에세이", category: "장르", value : 7 },
              { label: "철학", category: "장르", value : 8 },
               { label: "역사서", category: "장르", value : 9 },
               { label: "예술", category: "장르", value : 10 },
               { label: "자기계발", category: "장르", value : 11 },
               { label: "경제", category: "장르", value : 12 },
               { label: "요리", category: "장르", value : 13 },
               { label: "여행", category: "장르", value : 14 },
               { label: "심리", category: "장르", value : 15 },
               { label: "따뜻한", category: "분위기", value : 16 },
               { label: "희망적인", category: "분위기", value : 17 },
               { label: "밝은", category: "분위기", value : 18 },
               { label: "감성적인", category: "분위기", value : 19 },
               { label: "아련한", category: "분위기", value : 20 },
               { label: "우울한", category: "분위기", value : 21 },
               { label: "가벼운", category: "분위기", value : 22 },
               { label: "어두운", category: "분위기", value : 23 },
               { label: "꽃이 흩날리는 봄", category: "분위기", value : 24 },
               { label: "청량한 여름", category: "분위기", value : 25 },
               { label: "차분한 가을", category: "분위기", value : 26 },
               { label: "찬란한 겨울", category: "분위기", value : 27 },
               { label: "새로운 시작", category: "상황", value : 28 },
               { label: "위로가 필요할 때", category: "상황", value : 29 },
               { label: "이별했을 때", category: "상황", value : 30 },
               { label: "기분전환이 필요할 때", category: "상황", value : 31},
               { label: "힐링이 필요할 때", category: "상황", value : 32 },
               { label: "인간관계에 피로할때", category: "상황" , value : 33},
               { label: "우울할때", category: "상황", value : 34 }

             ];
       
          $( "#search" ).catcomplete({
            delay: 0,
            source: data,
            
            appendTo: "#keywordModalToggle",
            focus: function(event, ui) {
                 $(this).val(ui.item.label);
                 return false;
               },
            select: function(event, ui) {
              $('#searchValue').val(ui.item.value);
              $(this).val(ui.item.label);
              return false;
            }
          });
          
          function OnSelect(event, ui)
            {
                item = ui.item;
                itemLabel = item.label;
                itemValue = item.value;

                $("#searchValue").val(itemValue);
                $("#search").val(itemLabel);

            }
          
          
        } );
   
  
   });
   

   
   
   // 등록 버튼 눌렀을때 처리 이벤트
    $("#serch_bar_div").on("click", "#searchPage_btn", function(){
       console.log("키워드 등록 버튼 클릭함!!!");
       
       console.log($("#search").val());
       console.log($("#searchValue").val());
       
       
       
       // 만약 공백이면 등록 안되게하기
       var search = $("#search").val();
       var searchVal = $("#searchValue").val();
       
       var check = 0;  // 목록 검색할때 해당하는게 있으면 1로 변환
       var overlap = 0; // 저장된 목록에 중복 체크 메서드. 중복되는게 있으면 1로 변환
       
       var keyWord = new Array();
       
       console.log("검색어 : " + search);
       if(($("#search").val()) == "" && ($("#searchValue").val()) == ""){
          
          alert('키워드를 입력해주세요!');
          
       }else { // 검색어가 있으면 검색어가 목록에 해당되는게 있는지 체크
          
          for(let i=0; i<data.length; i++){
             if(search == data[i].label && searchVal == data[i].value){
                check = 1;
             }
          }
          
            // 검색어가 해당하는 키워드에 있으면 등록하기 전에 중복처리하기
            if(check == 1){
               
               // 중복체크
               for(let i=0; i<keyWordList.length; i++){
                  if(searchVal == keyWordList[i]){
                     overlap = 1;
                  }
               }
               // 중복된게 없으면 최종 추가
               if(overlap === 1){
                  
                  alert('이미 등록된 키워드 입니다!');
                  
               }else{
                  
                  console.log("selectedKeyword : " + $("#selectedKeyword").html());
                   
                   console.log("라벨 값 : " + $("#search").val());
                   console.log("벨류 값 : " + $("#searchValue").val());
               
                   
                   // 최종 저장할 키워드 리스트
                   var saveKeyWord = $("#searchValue").val();
                   keyWordList.push(saveKeyWord);
                   console.log("저장한 keyWordList : " + keyWordList);
                   
                   
                   keyWord.push("<td id='" + $("#searchValue").val() +"'><span class='hashTag_td'><button id='cancelKey' type='button'><img src='/resources/img/cancel.png' width='15px' style='margin-bottom: 4px;'/></button><input type='hidden' name='keywordVal' value='"+ $("#searchValue").val() +"'/><span class='selectHashTag'>"+$("#search").val()+"</span></span></td>");
                   
                   for(let i=0; i<keyWord.length; i++){
                      $("#selectedKeyword").append(keyWord[i]);
                   }
                   
                   console.log("selected키워드  append부분 ");
                  //$("#selectedKeyword").append(keyWord);
               }
               
            }else{
               
               alert('존재하지 않는 키워드입니다! 다시 시도해주세요');
               
            }
          
       } // else
       
       $("#search").val("");
       $("#searchValue").val("");

    });
   
   
   
   
   // 키워드 확인버튼 클릭시 처리 이벤트 
    $("#keyOK").on("click","#keyWordSelectedConfirm", function(){
       console.log("키워드 확인 버튼 클릭!!!!!!!!!");
      
       var copySelecteyKeyword = $("#selectedKeyword").clone();  //최종 선택한 키워드 복사하기
      console.log("복사한 clone : " + copySelecteyKeyword.html());
      $("#finalSelecKeyword").append(copySelecteyKeyword.html());
       
      $("#selectedKeyword").empty();
      
       //console.log("최종 선택한 키워드 : " + keyWordList);
       $("#keywordModalToggle").modal("hide");
      

    });// 확인 버튼시 발생 이벤트 끝
    
    
   


    // 키워드 선택 삭제 버튼 눌렀을 때 처리 이벤트
    $("#selectedKeyword").on("click", "#cancelKey", function(){
       console.log("키워드 삭제 버튼 클릭함!!!");
        console.log($(this));
      
        var index = $(this).closest('td').index();
        console.log("index : " +index);
        
        var val = keyWordList[index];
        console.log("저장한 keyWordList : " + keyWordList);
        console.log("삭제할 keyWordList : " + keyWordList[index]);
        
        for(var i = 0; i < keyWordList.length; i++){ 
          if (keyWordList[i] === val) { 
           keyWordList.splice(index, 1); 
            i--; 
          }
        }
      console.log("for문 거친 keyWordList : " + keyWordList);
        $(this).parent().remove(); // 화면에서 지우기
        
    });
    

    
    
    // 페이지에서 키워드 선택 삭제시 처리 이벤트
    $("#finalSelecKeyword").on("click", "#cancelKey", function(){
       console.log("화면 키워드 삭제 버튼 클릭함!!!");
        console.log($(this));
      
        var index = $(this).closest('td').index();
        console.log("index : " +index);
        
        var val = keyWordList[index];
        console.log("저장한 keyWordList : " + keyWordList);
        console.log("삭제할 keyWordList : " + keyWordList[index]);
        
        for(var i = 0; i < keyWordList.length; i++){ 
          if (keyWordList[i] === val) { 
           keyWordList.splice(index, 1); 
            i--; 
          }
        }
      console.log("for문 거친 keyWordList : " + keyWordList);
        $(this).parent().remove(); // 화면에서 지우기
        
    });
    
    

    

</script>



<!-- 기타 스크립트 처리!!!!  -->
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
   

 <!-- footer 복붙 -->
<%@ include file="../includes/footer3.jsp"%>