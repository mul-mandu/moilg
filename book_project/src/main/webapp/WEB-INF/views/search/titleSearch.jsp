<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <!-- header 복붙 -->
<%@ include file="../includes/header2.jsp" %>


   <div class="container">
      <div style="text-align: center">
         <a href="/main/main"><img src="/resources/img/logo_title-05.png" width="200px" style="display: inline-block;"></a>
      </div>
   
      <div id="titleSerch_bar_div">
         <input type="text" class="titleSearch_bar" placeholder="제목/작가로 검색" />
         <div>
         
         </div>
         <button type="submit" id="titleSearchPage_btn"><i class="fa-solid fa-magnifying-glass"></i></button>
      </div>
   </div>
   <br />
   <br />
   <br />
   
   <div style="display:none;" id="search_resultTitle">
      <span id="search_result"> </span> <span style="font-size: 20px; font-weight: bold;"> &nbsp;의 검색결과 </span>
      <hr />
   </div>
   
 
     
     
   <div> <!--도서 검색 결과 뿌려주기!!!!! -->
      <table class="table table-hover" id="resultTBL">

      </table>
   </div>

	<br />
	<br />
	<br />

    <form id="detailsPage" action="/search/titleSearch">
        
    </form>
                    
    <sec:authorize access="isAuthenticated()" >
        <sec:authentication property="principal" var="princ" /> 
        <input type="hidden" id="loginId" value="${princ.member.id}"/>
   </sec:authorize>




<!--  북플레이 리스트 추가 모달!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
   <div class="modal fade" id="addtoMyPL" aria-hidden="true" aria-labelledby="addtoMyPL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="exampleModalToggleLabel"><b>북플리에 책 추가하기 📚</b></h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         
          <div class="modal-body">
                <span>추가할 도서 &nbsp; &nbsp;</span> 
                
                <div id="selecBooks">
                
                </div>

                
                <hr />
                <button class="btn btn-primary btn-sm" id="newPLcreate"> + 새 북 플레이리스트 생성</button>
                 <div class="container">
                    <table id="settingMemPLlist">
                       
                 </table>
                 </div> <!-- div row 끝 -->
          </div>
         
         <div class="modal-footer">
              <button type="button" id="saveBooks" class="btn btn-primary">저장</button>
         </div>
       </div>
     </div>
   </div>

   
    <!--******* + 새 북 플레이리스트 생성 모달 ********  -->
   <div class="modal fade" id="newCreatePL" aria-hidden="true" aria-labelledby="newCreatePL" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="exampleModalToggleLabel2"> + 새 북 플레이리스트 생성</h4>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         
         <div class="modal-body">
         <div class="form-control">
                <label>북 플레이리스트 명 </label>
               <input type="text" name="bookPLtitle" id="bookPLtitle" required /> 
               <br />
               <select name="listStatus" disabled>
                  <option value="1" selected> 비공개 </option>
               </select>
            </div>
         </div>
         
        <div class="modal-footer">
           <button class="btn btn-outline-secondary"  data-bs-target="#addtoMyPL" data-bs-toggle="modal">취소</button>
           <button type="button" class="btn btn-primary" id="creatPLBtn">생성</button>
        </div>
       </div>
     </div>
   </div>
   
   



<!-- 책추가 완료 때 모달  -->
<div class="modal fade"  id="successAddBooksmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">북플리에 책 추가하기 📚</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>선택하신 도서가 북플리에 추가 완료 되었습니다. :)</p>
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
   
   
     


   
   <script>
   

   
   
   $(".titleSearch_bar").keydown(function(e) {
        if (e.keyCode == 13) {
           $("#titleSearchPage_btn").trigger('click');
        }
    });
  
   
   function bookData(success, data){
        console.log(success);
        console.log(data);
        var id = $("#loginId").val();
        console.log("idididididid" +id);
        
        for(let i=0; i<data.item.length ; i++){
           var title=data.item[i].title;
            var cover=data.item[i].cover;
            var author=data.item[i].author;
            var isbn = data.item[i].isbn13;
            var contents=data.item[i].description;
           // var img = ("<img src='"+cover+"'/>");
           
      
           
           var bookList = "<tr><td width='180px'><a class='move' href='/search/bookDetails?isbn="+isbn+"'><img src='"+cover+"'/></a></td>";
            bookList += "<td width='300px'><a class='move' href='/search/bookDetails?isbn="+isbn+"'><span id='title' data-isbn='"+isbn+"'>"+title+"</span></a><input id='author' type='hidden' value='"+ author +"'/></td>";
            bookList += "<td width='150px'><p>" + author +"</p></td>";
            bookList += "<td width='400px'><p>" + contents + "</p></td>";
            
            if(id != undefined){
                  bookList += "<td  width='200px'><button type='button' class='btn btn-outline-primary mt-2 addmyBook' style='float:right;' value='"+isbn+"'> + 나의 북플리에 추가 </button></td></tr>";
                   $("#resultTBL").append(bookList); 
            }else{
                  bookList += "<td  width='200px'><button type='button' class='btn btn-outline-primary mt-2 notLogin' style='float:right;' value='"+isbn+"'> + 나의 북플리에 추가 </button></td></tr>";
                   $("#resultTBL").append(bookList); 
                 
             
                
            }//else
               
           }//for문
          
           
    }//function
    

   $(document).ready(function(){
     
      $("#titleSearchPage_btn").on("click",function() {
         console.log("책 검색 버튼 누름!")
         
         //보낼 데이터 js객체로 만들기 
         ttbkey = "ttbhan_yurim1536001";
         let searchText = $(".titleSearch_bar").val(); // 검색어 입력
         let url ="http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey="+ ttbkey + "&Query=" + searchText;
               
         console.log("검색어 : " + searchText);
         console.log("키값 : " + ttbkey);
         
         
         $("#resultTBL").empty();
          
         
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
                     MaxResults:"20",
                     outofStockfilter:"1",
                     callback:"bookData"
                  }
              });
            
    
               $("#search_resultTitle").show();
               $("#search_result").html(searchText);
                
        
      });   //책 검색 버튼을 눌렀을때 끝
   });   // $(document).ready(function() 끝 
      
         
   var isbn;
   var title;
   var author;
   var coverImg;

   
   //이 북플리를 나의 목록에 추가 버튼 눌렀을 시 (비로그인 상태)
   $(document).on('click','.notLogin',function(){
      alert("🔔로그인 후 사용 가능합니다🔔");
      
   });
   
   
   // 이 북플리를 나의 목록에 추가 버튼 눌렀을 시
   $(document).on('click','.addmyBook',function(){
   //$("#addmyBook").on('click', function(){
      console.log("북플리 나의목록에 추가 버튼 클릭!!");
      console.log($(this));
      var selected = $(this).parent().parent().clone();
      console.log(selected.html());
      
       isbn = selected.find("#title").data("isbn");
      title = selected.find("#title").text();
      author = selected.find("#author").val();
      coverImg = selected.find("img").attr("src");
      
      console.log("선택한 isbn : " + isbn);
      console.log("책제목 : " + title);
      console.log("작가 : " + author);
      console.log("이미지 : " + coverImg);
      
      
      
      
     $("#addtoMyPL").modal("show");
     $("#selecBooks").html("<span><b>"+title+"</b></span> "); // 담으려는 책 모달에 뿌려주기
     // 회원이가지고 있는 북플리리스트 요청
     getMemPLlist();
   });
   
   
   // 책 선택 후 추가 버튼 눌렀을 때 모달처리
   // 회원이 가지고 있는 북리스트 가져오기
   var resultMemPLlist = new Array(); // 가져온 회원 플리 리스트 저장할 변수
   var ch = 0;
   function getMemPLlist(){
      console.log("회원이 가지고 있는 북플리 다 불러오기");
      
      
      $.ajax({
         url: "/mypage/getMemPL.json",
         type: "get",
         datatype: "JSON",
         success: function(result) {
            console.log("ajax success");
            console.log(result);
            var resultMemPLlist = new Array();
               for(var i=0 ; i < result.length; i++){
                  resultMemPLlist.push({'list_no' : result[i].list_no, 'bookPLTitle': result[i].bookPLTitle, 'packCover' : result[i].packCover});
               }
               
               // 북플리 뿌리기
               $("#settingMemPLlist").empty();
               for(let i=0; i<resultMemPLlist.length; i++){
                  //var showList ="<tr><td><img src='"+ resultMemPLlist[i].packCover + "' class='addBookPL_img'></td>";
                  var showList ="<tr><td><img src='/resources/save/"+resultMemPLlist[i].packCover+"' class='addBookPL_img'></td>";
                  showList += "<td  width='400px'>"+resultMemPLlist[i].bookPLTitle+"</td>";
                  showList += "<td><input class='saveSelect' type='radio' name='saveSelect' value='"+resultMemPLlist[i].list_no +"'/> </td></tr>";
                  $("#settingMemPLlist").append(showList);
               }
            console.log(resultMemPLlist);
         },
         error: function(e){
            console.log("ajax error");
            console.log(e);
            
         }
         
      });
   }
   
   
   
   var selectedListNum; 
   // 모달안에서 북플레이 리스트 선택했을 때 처리 메서드
     $("#settingMemPLlist").on("click", ".saveSelect",function(){
             console.log("플레이리스트 선택 !!");
        
       if($(this).is(":checked")){  // 체크 됐을때 
          selectedListNum = $(this).val();
             console.log(selectedListNum);
       }
     });
   
   var isbn = "${abook}";
   
     // 모달 누르면 저장 하는 처리 메서드
     $("#saveBooks").on("click", function(){
        console.log("저장 버튼 클릭!!");

        var savePlBooks = new Array();
        savePlBooks.push({"list_no": selectedListNum ,"isbn" : isbn, "bookTitle" : title, "author" :author, "bookCover" : coverImg});
        console.log(savePlBooks);
        
        $.ajax({
           type: "POST",
           url : "/memData/addSavePlBooks",
           data: JSON.stringify(savePlBooks),
           contentType: "application/json;charset=utf-8",
              beforeSend: function(xhr){
                 xhr.setRequestHeader(header, token);
              },
              success: function(result){
                  console.log("책 추가 요청 성공!!!!!");
                  console.log(result);
                  $("#addtoMyPL").modal("hide");
                  $("#successAddBooksmodal").modal("show");
               },
               error: function(e){
                  console.log("책 추가 요청 에러......");
                  console.log(e);
               }
           
        });
        
        
     });
      
     
     
     
     // 모달에서 새 플레이리스트 생성 버튼 메서드 처리
     $("#newPLcreate").on("click", function(){
        console.log("새 플레이리스트 생성 버튼 클릭");
        
        $("#addtoMyPL").modal("hide");
        $("#newCreatePL").modal("show");
        $('#bookPLtitle').val("");
     });
     
     
     var id = $("#loginId").val();     // 로그인한 아이디 보내기
     // 새플레이리스트 생성 모달에서 생성 버튼 처리
     $("#creatPLBtn").on("click", function(){
        console.log("새 플레이리스트 생성 요청!!!");
        
        var listTitle = $("#bookPLtitle").val();
        var status =  parseInt($("#listStatus").val());
        var createPL = {"id" : id, "bookPLTitle" : listTitle, "listStatus" : status};
        console.log("새 플레이리스트 생성 요청 : " + createPL );
        
        
        // 새 북 플레이 리스트 생성!!
        $.ajax({
           type : "POST",
           url : "/memData/newBookList",
           data: JSON.stringify(createPL),
           contentType: "application/json;charset=utf-8",
           processData: false,
              beforeSend: function(xhr){
                 xhr.setRequestHeader(header, token);
              },
              success: function(result){
                  console.log("북 플레이 리스트 생성 요청 성공!!!!!");
                  console.log(result);
                $("#newCreatePL").modal("hide");
                getMemPLlist();
                 $("#addtoMyPL").modal("show");
               },
               error: function(e){
                  console.log("북 플레이 리스트 생성 요청 에러......");
                  console.log(e);
               }
        });
        
        
     });
       

         
   </script>
   
 

   <!-- footer 복붙 -->
   <%@ include file="../includes/footer2.jsp"%>