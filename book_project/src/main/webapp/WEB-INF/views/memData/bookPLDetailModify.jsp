<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%-- header 복붙 --%>
<%@ include file="../includes/header.jsp" %>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

      <%-- bootstrap --%>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
      crossorigin="anonymous">
   </script>
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   
    <script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
  
      <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
     <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> 

<script>

	var keyWordList = new Array();  // 키워드 저장 변수 
	var keyWord = new Array();// 화면에 보여줄 데이터 
   
   var selectedBookArr = new Array();   // 최종 저장할 책
   var addList2; // 화면에 뿌릴거 저장하는 변수
   
   var list_no = '${listNum}';
   //console.log(list_no);
   
   $(document).ready(function(){
      
      /* status 값 설정하기 */
     var getStatus = parseInt("${oneBookPL.listStatus}");
      //console.log("북플리 상태 값 : " + getStatus );
     
     if(getStatus == 0){
        $("input:radio[name='listStatus']:radio[value='0']").attr('checked', true);
     }else{
        $("input:radio[name='listStatus']:radio[value='1']").attr('checked', true);
     }
      
      
      
      
     // 키워드랑 책 뿌려주기
      $.ajax({
         url: "/memData/getKeyListForModif.json",
         type: "get",
         data: {"list_no": list_no},
         beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
              },
         success: function(result) {
            //console.log("ajax success");
            //console.log(result);
            for(let i = 0; i < result.length; i++){
               keyWordList.push({'list_no': list_no ,'keyword_no' : result[i].keyword_no});
               keyWord.push("<li class='hashTag_li'><button id='cancelKey' type='button' value='"+ result[i].keyword_no +"'><img src='/resources/img/cancel.png' width='15px' style='margin-bottom: 4px;'/></button><span class='selectHashTag'>"+result[i].keyword+"</span></li>");
            }
            //console.log(keyWordList);
            //console.log(keyWord);
            $("#finalSelecKeyword").append(keyWord);  // 화면에 뿌리기
            getBookListForModif();
         },
         error: function(e){
            //console.log("ajax error");
            //console.log(e);
         }
         
      }); 
      
      

   function getBookListForModif(){
      
      //console.log("책 리스트 가져오기 메서드 실행!!");
      
      $.ajax({
         url: "/memData/getBookListForModif.json",
         type: "get",
         data: {"list_no": list_no},
         beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
              },
         success: function(result) {
            //console.log("ajax success");
            //console.log(result);
            for(let i = 0; i < result.length; i++){
               selectedBookArr.push({'list_no': list_no ,'isbn' : result[i].isbn,'bookTitle' : result[i].bookTitle, 'author' : result[i].author, 'bookCover' : result[i].bookCover});
            }
            //console.log("저장할 도서리스트 : " + selectedBookArr);
            setBookList();  // 화면에 뿌리기
         },
         error: function(e){
            //console.log("ajax error");
            //console.log(e);
         }
         
      }); 
      
   }
   
   
   }); // docucment.ready
   
</script>


<div class="container" id="bookitemDetails_con">
   <div> <%-- 상단 이미지 / 제목 /  작가 / 버튼 등 --%>
        <div class="row">
           <div class="col-5">
                <div>
                   <div style="position: relative;">
                     <img src="/resources/save/${oneBookPL.packCover}"  class="bPlistCover card" id="preview"/>
                   <div style="position: absolute; top:14px; left: 255px;">
                      <label for="file" >
                       <img id="editImg" src="/resources/img/edit.png"/>
                    </label>
                   </div>
                   </div>
                
                </div>
           </div>
			<div class="col">
				<h5>${plMKNickName} 님의 북 플레이리스트 수정</h5>
				<div class="form-control">
					<form>
						<input type="file" name="file" id="file" style="display: none;">
						<input type="text" id="bookPLTitle" name="bookPLTitle" value="${oneBookPL.bookPLTitle}" placeholder="북 플레이리스트 명" required /> 
						<input type="hidden" id="bookPLmakeUser" name="bookPLmakeUser" value="${member.id}" placeholder="북 플레이리스트 명" />
					</form>
				</div>
				<input type="radio" name="listStatus" value="0" checked /> 공개 &nbsp;
				<input type="radio" name="listStatus" value="1" /> 비공개 
				<br /> 
				<br />

				<%-- 키워드 for문으로 뿌리기--%>
				<div class="keywords">
					<ul id="finalSelecKeyword">

					</ul>
				</div>
				<br />
				<button id="addHashTag" type="button" class="btn btn-outline-secondary mx-auto">+ 키워드 추가</button>

				<br />
				<br />
				<br />
				<br />
				<p style="color: #9e9e9e;">* 키워드는 최대 10개까지 설정 가능합니다.</p>
			</div>
		</div>
           <br />
      </div> <%-- 상단 이미지 / 제목 /  작가 / 버튼 등 끝--%>
      
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
            
            
            <%-- 추가한 도서 여기에 담김 --%>
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
             <button type="button" class="btn btn-primary mx-auto" style="margin: 0 auto;" id="savePlistModify">수정</button>
      </div>
      
      
      
      
      </div>
   </div>


<%--  키워드 추가 모달!!!!!!!!!!!!!!!!!!!!!!!!!!!--%>
   <div class="modal fade" id="keywordModalToggle" aria-hidden="true" aria-labelledby="keywordModalToggle" tabindex="-1" style="padding: 20px;" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="keywordModalToggleLabel"><b>키워드 추가하기 🔮</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
          <div class="modal-body">
          	 <span>장르 키워드</span>
					<div class="keywords">
						<button type='button' class='keyWord_btn' value='1' data-word='추리/미스터리소설'>추리/미스터리소설</button>
						<button type='button' class='keyWord_btn' value='2' data-word='SF/판타지'>SF/판타지</button>
						<button type='button' class='keyWord_btn' value='3' data-word='한국소설'>한국소설</button>
						<button type='button' class='keyWord_btn' value='4' data-word='외국소설'>외국소설</button>
						<button type='button' class='keyWord_btn' value='5' data-word='고전문학'>고전문학</button>
						<button type='button' class='keyWord_btn' value='6' data-word='시'>시</button>
						<button type='button' class='keyWord_btn' value='7' data-word='에세이'>에세이</button>
						<button type='button' class='keyWord_btn' value='8' data-word='철학'>철학</button>
						<button type='button' class='keyWord_btn' value='9' data-word='역사서'>역사서</button>
						<button type='button' class='keyWord_btn' value='10' data-word='예술'>예술</button>
						<button type='button' class='keyWord_btn' value='11' data-word='자기계발'>자기계발</button>
						<button type='button' class='keyWord_btn' value='12' data-word='경제'>경제</button>
						<button type='button' class='keyWord_btn' value='13' data-word='요리'>요리</button>
						<button type='button' class='keyWord_btn' value='14' data-word='여행'>여행</button>
						<button type='button' class='keyWord_btn' value='15' data-word='심리'>심리</button>
					</div>
					<br>
				<span>분위기 키워드</span>
					<div class="keywords">
				    	<button type='button' class='keyWord_btn' value='16' data-word='따뜻한'>따뜻한</button>
				    	<button type='button' class='keyWord_btn' value='17' data-word='희망적인'>희망적인</button>
				    	<button type='button' class='keyWord_btn' value='18' data-word='밝은'>밝은</button>
				    	<button type='button' class='keyWord_btn' value='19' data-word='감성적인'>감성적인</button>
				    	<button type='button' class='keyWord_btn' value='20' data-word='아련한'>아련한</button>
				    	<button type='button' class='keyWord_btn' value='21' data-word='우울한'>우울한</button> 
				    	<button type='button' class='keyWord_btn' value='22' data-word='가벼운'>가벼운</button>
				    	<button type='button' class='keyWord_btn' value='23' data-word='어두운'>어두운</button>
				    	<button type='button' class='keyWord_btn' value='24' data-word='꽃이 흩날리는 봄'>꽃이 흩날리는 봄</button>
				    	<button type='button' class='keyWord_btn' value='25' data-word='청량한 여름'>청량한 여름</button>
				    	<button type='button' class='keyWord_btn' value='26' data-word='차분한 가을'>차분한 가을</button>
				    	<button type='button' class='keyWord_btn' value='27' data-word='찬란한 겨울'>찬란한 겨울</button>
					</div>
					<br>
				<span>상황 키워드</span>	
					<div class="keywords">
						<button type='button' class='keyWord_btn' value='28' data-word='새로운 시작'>새로운 시작</button>
				    	<button type='button' class='keyWord_btn' value='29' data-word='위로가 필요할때'>위로가 필요할때</button>
				    	<button type='button' class='keyWord_btn' value='30' data-word='이별했을때'>이별했을때</button>
				    	<button type='button' class='keyWord_btn' value='31' data-word='기분전환이 필요할때'>기분전환이 필요할때</button>
				    	<button type='button' class='keyWord_btn' value='32' data-word='힐링이 필요할때'>힐링이 필요할때</button>
				    	<button type='button' class='keyWord_btn' value='33' data-word='인간관계에 피로할때'>인간관계에 피로할때</button> 
				    	<button type='button' class='keyWord_btn' value='34' data-word='우울할때'>우울할때</button>
					</div>
  
                <hr />

				<div>
					<br /> 
					<label>선택한 키워드 &nbsp;&nbsp;&nbsp;</label> 
					<label style="color: #9e9e9e; font-size: 13px; float: right;">* 최대 10개</label>
					<hr />

					<div class="keywords">
	                    <ul id="selectedKeyword">
	
	                    
	                    </ul>
                    </div>
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

   
   <%--******* 도서 추가 모달  ********  --%>
   <div class="modal fade" id="findBookModalToggle" aria-hidden="true" aria-labelledby="findBookModalToggle" tabindex="-1" style="padding: 20px;" data-refresh="true" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-scrollable">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="findBookModalToggleLabel"><b>도서 검색 📘</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>


			<div class="modal-body">
				<div id="bookserch_bar_div">
					<input type="text" id="booksearch_bar" placeholder="제목/작가로 검색" required />
					<button type="button" id="booksearchPage_btn" data-refresh="true">검색</button>

				</div>
				<hr />

				<div>
					<form>
						<table id="bookSearchTBL">

						</table>
					</form>
					
					<%-- 페이징네이션 --%>
					<div class="container">
						<div class="row">
							<div class="col">
								<ul class="pagination" id="pagingNum">

								</ul>
							</div>
						</div>
					</div>
					
					<br />
					<br />
					<br /> <label>선택한 도서</label>
					<hr />

					<%-- 선택한 도서 여기에 담김 --%>
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
   
   
   
   <%--  수정 완료 확인 모달!!!!  --%>
   <div class="modal fade" id="savedFinishModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">북 플레이리스트 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        북플리 리스트 수정이 완료되었습니다! 😇📖  
       </div>
      <div class="modal-footer">
       <sec:authorize access="hasRole('ROLE_MEMBER')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/memMypage'">확인</button>
        </sec:authorize>
         <sec:authorize access="hasRole('ROLE_ADMIN')" > 
            <button type="button" class="btn btn-primary"  onclick="window.location='/mypage/adminMypage'">확인</button>
         </sec:authorize>
      </div>
    </div>
  </div>
</div>
   


   
  <%-- ************************************책 검색 스크립트!!!!!!!!!!!!!!!! ******************** --%> 
  
  
<script>




// 키워드 관련 변수들 //////////////////

var item;
var itemLabel;
var itemValue;

///////////////////////////


   
   // 저장했었던 책 뿌리기
   function setBookList(){
      
      for(let i=0 ; i < selectedBookArr.length ; i++){
         var addList = "<tr><td id='small_td'><button type='button' id='cancleAdd'><i class='fa-solid fa-xmark'></i></button></td>";
         addList += "<td><img src='"+selectedBookArr[i].bookCover+"' id='bookCoverSize'/></td>";
         addList += "<td>"+selectedBookArr[i].bookTitle+"</td>";
         addList += "<td>"+selectedBookArr[i].author+"</td></tr>";
         $("#addBookList").append(addList);
      }
   }


 
   // ajax로 책 검색 후 뿌리기 
   function bookData(success, data){
        //console.log(success);
        //console.log(data);
        $("#bookSearchTBL").empty();
      	$("#bookSelectedTBL").empty();
        //console.log($("#bookSearchTBL").html());
        
        
     	// 페이징 관련 데이터 뽑기
        var totalResult = data.totalResults;  // 토탈 검색 게시물 수
        var startIndex = data.startIndex;  // 지금 현재 인덱스 번호 
        
        //console.log("총 검색 결과 수 : " +  totalResult);
        //console.log("시작 인덱스 : " +  startIndex);
        
        // 페이징 계산
        var pageSize = 10;
        var totalPages = Math.ceil(totalResult / pageSize);
        var curPage = startIndex;
        
        //console.log("페이징 수는 : " +  totalPages);
        var htmlStr = pageLink(curPage, totalPages, "getBook");
        $("#pagingNum").html(htmlStr);

        
        if(totalResult == 0){
    		 $("#resultTBL").append("<h4>검색 결과가 없습니다.</h4>"); 
    	}else{ // 검색 결과가 있으면
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
	        } // for문
    	} // else
        
    }  // 책 검색
    
    
    
 	// 페이징네이션하기
    function pageLink(curPage, totalPages, funName) {
    	var pageUrl = "";
    	
    	var pageLimit = 5;
    	var startPage = parseInt((curPage - 1) / pageLimit) * pageLimit + 1;
    	var endPage = startPage + pageLimit - 1;
    	
    	if (totalPages < endPage) {
    	    endPage = totalPages;
    	}
    	
    	var nextPage = endPage + 1;
    	//console.log(curPage,"curPage,",startPage,"startPage,",endPage,"endPage,",nextPage,"nextPage")
    	
    	//이전 페이지
    	if (curPage > pageLimit) {
    	    pageUrl += " <li class='page-item'><a aria-label='Previous' class='page-link page prev' href='javascript:" + funName + "(" + (startPage == 1 ? 1 : startPage - 1) + ");' ><i class='fas fa-angle-left'></i></a></li>";
    	}
    	//~pageLimit 맞게 페이지 수 보여줌
    	for (var i = startPage; i <= endPage; i++) {
    	    //현재페이지면 진하게 표시
    	    if (i == curPage) {
    	        pageUrl += " <li class='page-item active'><a href='#' class='page-link'>" + i + "</a></li>"
    	    } else {
    	        pageUrl += " <li class='page-item'><a href='javascript:" + funName + "(" + i + ");' class='page-link'> " + i + " </a></li>";
    	    }
    	}
    	//다음 페이지
    	if (nextPage <= totalPages) {
    	    pageUrl += "<li class='page-item'><a aria-label='Next' class='page-link page next' href='javascript:" + funName + "(" + (nextPage < totalPages ? nextPage : totalPages) + ");' ><i class='fas fa-angle-right'></i></a></li>";
    	}
    	
    	return pageUrl;
    }  // function
    
    
    
    
    // 선택 라디오 버튼 눌렀을 시 발생 이벤트
    $("#bookSearchTBL").on("click", ".checkBtn", function(){
       //console.log("버튼 클릭함!!!");
        $("#bookSelectedTBL").empty();
        //console.log($(this));
        trTag = $(this).parent().parent().clone(); 
        trTag.find("input[type='radio']").remove();
        //console.log(trTag);
        $("#bookSelectedTBL").append(trTag);
        //console.log(trTag);
    });
   

    
    // 확인 버튼시 발생 이벤트
    $("#bookSelectedConfirm").click(function(){
       //console.log("확인 버튼 클릭!!!!!!!!!");
       
       var selected = $("#bookSelectedTBL");
       var coverImg = selected.find("img").attr("src");
       var title = selected.find("#title").text();
       var author = selected.find("#author").text();
       var isbn = selected.find("#title").data("isbn");
       
       //console.log("isbn : " + isbn);
       //console.log("title : " + title);
       //console.log("author : " + author);
       
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
               

               selectedBookArr.push({'list_no': list_no, 'isbn' : isbn,'bookTitle' : title, 'author' : author, 'bookCover' : coverImg});
               //console.log("저장할 도서리스트 : " + JSON.stringify(selectedBookArr));
              
           }
          
       }// else
       
    });// 확인 버튼시 발생 이벤트 끝
    

    
    
   // 도서 추가 버튼 눌렀을 시
   $('#addbook').on('click', function(){
      //console.log("책 추가 모달 버튼 누름!");
      
      $("#findBookModalToggle").modal("show");
      $("#bookSearchTBL").empty();
      $("#bookSelectedTBL").empty();      
      $('#booksearch_bar').val("");
      
   });
   
    
    
   $("#booksearch_bar").keydown(function(e) {
       if (e.keyCode == 13) {
          $("#booksearchPage_btn").trigger('click');
       }
   }); 
    
    
 //책 검색 버튼을 눌렀을때
   $('#booksearchPage_btn').on('click', function (e) {
      //console.log("책 검색 버튼 누름!");
      $("#bookSearchTBL").empty();
      var num = 1; // 페이지 번호 초기화
      getBook(num);  // 책 검색하기 호출
      
   });   //책 검색 버튼을 눌렀을때 끝
      
   
   function getBook(num){
      var bookSearch = $('#booksearch_bar').val();
      
      if(bookSearch == ""){
         alert('검색어를 입력해주세요!');
      }else{
         //보낼 데이터 js객체로 만들기 
         ttbkey = "ttbhan_yurim1536001";
         let searchText = $("#booksearch_bar").val(); // 검색어 입력
         let url ="http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey="+ ttbkey + "&Query=" + searchText;
               
         //console.log("검색어 : " + searchText);
         //console.log("키값 : " + ttbkey);
      
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
                  MaxResults:"10",
                  outofStockfilter:"1",
                  callback:"bookData",
                  start : num
               } 
           });
         
      } // else
   }
      

    
   
   
   
   
   
   
// 수정 누를때 이벤트 !!!!!!
   $("#savePlistModify").on("click", function(){
      //console.log("수정 버튼 클릭!!!!!!!");
      
         // 원하는 것만 넘겨주는 방식
         var data = new FormData();
         var title = $("#bookPLTitle").val();
         var status = $('input[name=listStatus]:checked').val();
         var file = $('#file')[0].files[0];
         var coverOrg = "${oneBookPL.packCover}"; 
         

         //console.log("타이틀 " + title);
         //console.log("상태값" + status);
         //console.log("파일" + file);
         
      data.append('list_no', list_no);
      data.append('bookPLTitle', title);
      data.append('listStatus', status);
      data.append('packCoverFile', file);
      data.append('packCover', coverOrg);
         
         //console.log(data.get('list_no'));
         //console.log(data.get('bookPLTitle'));
         //console.log(data.get('listStatus'));
         //console.log(data.get('packCoverFile'));
         //console.log(data.get('packCover'));


         for (var pair of data.entries()) {
              //console.log(pair[0]+ ', ' + pair[1]);
         }
         if(keyWordList.length == 0 || selectedBookArr.length == 0 ){
            alert("키워드와 도서가 등록되어 있지 않습니다");
         }else{
         
            // 북 플레이 패키지 ajax 보내기
            $.ajax({
               type : "POST",
               url : "/memData/modifyBookListPack",
               data: data,
               contentType: false,
               processData: false,
               enctype: 'multipart/form-data',
                  beforeSend: function(xhr){
                     xhr.setRequestHeader(header, token);
                  },
                  success: function(result){
                     // console.log("북 플레이 리스트 커버 등록 성공!!!!!");
                      //console.log(result);
                      modifyOnebookList();
                   },
                   error: function(e){
                      //console.log("북 플레이 리스트 생성 요청 에러......");
                      //console.log(e);
                   }
            });//에이작스
         }
      
   });//세이브 버튼 펑션 
   
   
               
   function modifyOnebookList(){
     // console.log("북리스트 책 리스트 수정 호출!!!!!......");
      $.ajax({
         type : "POST",
         url : "/memData/modifyOneBookList",
         data: JSON.stringify(selectedBookArr),
         contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
            },
            success: function(result){
               // console.log("북리스트 책 리스트 수정 요청 성공!!!!!");
               // console.log(result);
                modifyPLKeyWord();
             },
             error: function(e){
               // console.log("북리스트 책 리스트 수정 요청 에러......");
               // console.log(e);
             }
      });
   }
   
   
   function modifyPLKeyWord(){
     // console.log("키워드 수정 ajax호출!!!!!......");
      
      $.ajax({
         type : "POST",
         url : "/memData/modifyPLKeyWord",
         data: JSON.stringify(keyWordList),
         contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
               xhr.setRequestHeader(header, token);
            },
            success: function(result){
              //  console.log("키워드 수정 요청 성공!!!!!");
              //  console.log(result);
                $("#savedFinishModal").modal("show");
             },
             error: function(e){
               // console.log("키워드 수정 요청 에러......");
               // console.log(e);
             }
      });
      
   }

   
   
   
   
   // 책 선택 삭제 시 발생 이벤트 등록!!!!!
    $("#addBookList").on("click", "#cancleAdd", function(){
       //console.log("책 선택 취소 버튼 클릭함!!!");
       // console.log($(this));
      
        var index = $(this).closest('tr').index();
        //console.log("index : " +index);
        
        var val = selectedBookArr[index];
        //console.log("저장한 selectedBookArr : " + JSON.stringify(selectedBookArr));
       // console.log("삭제할 selectedBookArr : " + selectedBookArr[index]);
        
        for(var i = 0; i < selectedBookArr.length; i++){ 
          if (selectedBookArr[i] === val) { 
           selectedBookArr.splice(index, 1); 
            i--; 
          }
        }
      //console.log("for문 거친 selectedBookArr : " +JSON.stringify(selectedBookArr));
        $(this).parent().parent().remove(); // 화면에서 지우기
        
    });
    
   


  //- ************************************  키워드 스크립트!!!!!!!!!!!!!!!! ******************** 

   $('#addHashTag').on('click', function(){
     // console.log("키워드 추가 호출!!!!!!!");
      
      $("#keywordModalToggle").modal("show");
      $("#selectedKeyword").html(keyWord);
    });

   
 	//키워드 뿌린 버전 (버튼 클릭시 이벤트)
    $(".keyWord_btn").on("click", function(){
        //console.log("키워드 클릭!!!!!");
    	
    	 var check = 0;  // 목록 검색할때 해당하는게 있으면 1로 변환
        // console.log("check 값!!! : " + check );
         
         var clickKeywordName = $(this).attr('data-word');
        // console.log("클릭한 키워드!!!" + clickKeywordName );
         
         var clickValue = parseInt($(this).val());
         //console.log("클릭한 키워드 밸류 값!!!" + clickValue );

        var keyVals = new Array() ; // 현재 keyWordList에 저장된 키값만 따로 저장하기 (중복확인 위해서)
         
         if(keyWordList.length == 10 ){ //키워드 10개 제한하기
      	   alert("키워드는 최대 10까지 등록 가능합니다😅");
         
         }else{ //키워드 10개 이하면 중복 값 체크하기
        	//console.log("중복 체크 하기전 keyWordList : " + JSON.stringify(keyWordList));
        	
        	for(var i=0; i < keyWordList.length; i++){
        		keyVals.push(parseInt(keyWordList[i].keyword_no));
        	}
        	//console.log("keyVals : " + keyVals);
        	
  		   if(keyVals.includes(clickValue)){
  				alert("이미 등록된 키워드 입니다"); 
  			}else{
  				keyWord.push("<li class='hashTag_li'><button id='cancelKey' type='button' value='"+ clickValue +"'><img src='/resources/img/cancel.png' width='15px' style='margin-bottom: 4px;'/></button><span class='selectHashTag'>"+ clickKeywordName + "</span></li>");
  				keyWordList.push({'list_no': list_no ,'keyword_no' : clickValue});
  				//console.log("보여줄 키워드 담은거 !!!" + keyWord );
  				//console.log("진짜 저장할 키워드 값!!!" + JSON.stringify(keyWordList) );
  				
  			}//안 if
  	       
         }
   
  		$("#selectedKeyword").html(keyWord); //선택한 키워드 목록 보여주기 (모달)

   });
   
   
 // 키워드 확인버튼 클릭시 처리 이벤트 
    $("#keyOK").on("click","#keyWordSelectedConfirm", function(){
      // console.log("키워드 확인 버튼 클릭!!!!!!!!!");
      
       var copySelecteyKeyword = $("#selectedKeyword").clone();  //최종 선택한 키워드 복사하기
      //console.log("복사한 clone : " + copySelecteyKeyword.html());
      $("#finalSelecKeyword").html(copySelecteyKeyword.html());
       
      //$("#selectedKeyword").empty();
      
       //console.log("최종 선택한 키워드 : " + keyWordList);
       $("#keywordModalToggle").modal("hide");
      

    });// 확인 버튼시 발생 이벤트 끝
    
    
    

    // 키워드 선택 삭제 버튼 눌렀을 때 처리 이벤트
    $("#selectedKeyword").on("click", "#cancelKey", function(){
       //console.log("키워드 삭제 버튼 클릭함!!!");
        //console.log($(this));
      
        var delIndex = $(this).parent().index();
       // console.log("index : " + delIndex);
        
        var val = keyWordList[delIndex];
        //console.log("val : " + val);
        //console.log("저장한 keyWordList : " + JSON.stringify(keyWordList));
        //console.log("삭제할 keyWordList : " + JSON.stringify(keyWordList[delIndex]));
        
        for(var i = 0; i < keyWordList.length; i++){
      //console.log("for문 들어옴");
        	
          if (keyWordList[i] === val) {
      //console.log("if문 들어옴");
        	  
        	  keyWordList.splice(delIndex, 1);
        	  keyWord.splice(delIndex, 1);
            i--; 
          }
        }
      //console.log("for문 거친 keyWordList : " + keyWord);
        $(this).parent().remove(); // 화면에서 지우기
        //console.log("저장할 keyWordList : " + JSON.stringify(keyWordList));
    });
    
    
    
    
	   // 페이지에서 키워드 선택 삭제시 처리 이벤트
	   $("#finalSelecKeyword").on("click", "#cancelKey", function(){
	      //console.log("화면 키워드 삭제 버튼 클릭함!!!");
	       //console.log($(this));
	     
	       var index = $(this).parent().index();
	       //console.log("index : " +index);
	       
	       var val = keyWordList[index];
	       //console.log("저장한 keyWordList : " + JSON.stringify(keyWordList));
	       //console.log("삭제할 keyWordList : " + JSON.stringify(keyWordList[index]));
	        
	       for(var i = 0; i < keyWordList.length; i++){
	    	      //console.log("for문 들어옴");
	    	        	
	    	          if (keyWordList[i] === val) {
 	      			//console.log("if문 들어옴");
	    	        	  
	    	        	  keyWordList.splice(index, 1);
	    	        	  keyWord.splice(index, 1);
	    	            i--; 
	    	          }
	    	        }
	    	      //console.log("for문 거친 keyWordList : " + keyWord);
 	        	$(this).parent().remove(); // 화면에서 지우기
	    	        //console.log("저장할 keyWordList : " + JSON.stringify(keyWordList));
	   });
    
   

</script>



<%-- 기타 스크립트 처리!!!!  --%>
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
   

<%-- footer 복붙 --%>
<%@ include file="../includes/footer2.jsp"%>