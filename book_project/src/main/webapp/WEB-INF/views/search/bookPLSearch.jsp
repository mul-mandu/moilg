<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <%-- header 복붙 --%>
<%@ include file="../includes/header.jsp" %>


 
   	<div>
   		<a href="/search/bookPLSearch"><h3 id="bookPLearch_s">북플리 검색</h3></a>
   		<a href="/search/titleSearch"><h3 id="titleSearch_s">도서 검색</h3></a>
   	</div>
   	<br/>
      <div id="titleSerch_bar_div">
         <input type="text" class="titleSearch_bar" placeholder="북플리 검색" />
         <button type="submit" id="titleSearchPage_btn"><i class="fa-solid fa-magnifying-glass"></i></button>
      </div>

   <br />

   
  <div class="menu">
	<ul>
		<li><h5><b>Keyword</b></h5></li>
		<li><a href="#" id='genre'>장르</a></li>
		<li><a href="#" id="mood">분위기</a></li>
		<li><a href="#" id="situ">상황</a></li>
	</ul>  
  </div>
  
  <%-- 키워드 뿌려줄 부분 --%>
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

<br/>
<br/>
<br/>


<div style="display: none;" id="search_resultTitle">
	<span id="search_result"> </span>
	<span style="font-size: 20px; font-weight: bold;" id="search_titleEnd"> &nbsp;의 검색결과 </span>
	<hr />
</div>

<div>
	<%--북플리 검색 결과 뿌려주기!!!!! --%>
	<div class="row" id="bookPLresult">
		
	</div>
</div>


<br />
<br />
<br />

                    
   
   <script>
   
   /* 장르 키워드 선택시 */
    $(".menu").on('click', '#genre', function(){
    	//console.log("장르 키워드 선택!!");
    	$('.keywords').empty();
    	
    	var key = "<button type='button' class='keyWord_btn' value='1' data-word='추리/미스터리소설'>추리/미스터리소설</button>";
    	key += "<button type='button' class='keyWord_btn' value='2' data-word='SF/판타지'>SF/판타지</button>";
    	key += "<button type='button' class='keyWord_btn' value='3' data-word='한국소설'>한국소설</button>";
    	key += "<button type='button' class='keyWord_btn' value='4' data-word='외국소설'>외국소설</button>";
    	key += "<button type='button' class='keyWord_btn' value='5' data-word='고전문학'>고전문학</button>";
    	key += "<button type='button' class='keyWord_btn' value='6' data-word='시'>시</button> ";
    	key += "<button type='button' class='keyWord_btn' value='7' data-word='에세이'>에세이</button>";
    	key += "<button type='button' class='keyWord_btn' value='8' data-word='철학'>철학</button>";
    	key += "<button type='button' class='keyWord_btn' value='9' data-word='역사서'>역사서</button>";
    	key += "<button type='button' class='keyWord_btn' value='10' data-word='예술'>예술</button>";
    	key += "<button type='button' class='keyWord_btn' value='11' data-word='자기계발'>자기계발</button>";
    	key += "<button type='button' class='keyWord_btn' value='12' data-word='경제'>경제</button>";
    	key += "<button type='button' class='keyWord_btn' value='13' data-word='요리'>요리</button>";
    	key += "<button type='button' class='keyWord_btn' value='14' data-word='여행'>여행</button>";
    	key += "<button type='button' class='keyWord_btn' value='15' data-word='심리'>심리</button>";
    	$('.keywords').html(key);
    });
    
	
	
    
    /* 분위기 키워드 선택시 */
    $(".menu").on('click', '#mood', function(){
    	//console.log("무드 키워드 선택!!");
    	$('.keywords').empty();
    	
    	var key = "<button type='button' class='keyWord_btn' value='16' data-word='따뜻한'>따뜻한</button>";
    	key += "<button type='button' class='keyWord_btn' value='17' data-word='희망적인'>희망적인</button>";
    	key += "<button type='button' class='keyWord_btn' value='18' data-word='밝은'>밝은</button>";
    	key += "<button type='button' class='keyWord_btn' value='19' data-word='감성적인'>감성적인</button>";
    	key +=	"<button type='button' class='keyWord_btn' value='20' data-word='아련한'>아련한</button>";
    	key += "<button type='button' class='keyWord_btn' value='21' data-word='우울한'>우울한</button> ";
    	key += "<button type='button' class='keyWord_btn' value='22' data-word='가벼운'>가벼운</button>";
    	key += "<button type='button' class='keyWord_btn' value='23' data-word='어두운'>어두운</button>";
    	key +=	"<button type='button' class='keyWord_btn' value='24' data-word='꽃이 흩날리는 봄'>꽃이 흩날리는 봄</button>";
    	key += "<button type='button' class='keyWord_btn' value='25' data-word='청량한 여름'>청량한 여름</button>";
    	key += "<button type='button' class='keyWord_btn' value='26' data-word='차분한 가을'>차분한 가을</button>";
    	key +=	"<button type='button' class='keyWord_btn' value='27' data-word='찬란한 겨울'>찬란한 겨울</button>";
    	$('.keywords').html(key);
    });
   
    
    /*  상황 키워드 선택시  */
        $(".menu").on('click', '#situ', function(){
    	//console.log("상황 키워드 선택!!");
    	$('.keywords').empty();
    	
    	var key = "<button type='button' class='keyWord_btn' value='28' data-word='새로운 시작'>새로운 시작</button>";
    	key += "<button type='button' class='keyWord_btn' value='29' data-word='위로가 필요할때'>위로가 필요할때</button>";
    	key += "<button type='button' class='keyWord_btn' value='30' data-word='이별했을때'>이별했을때</button>";
    	key += "<button type='button' class='keyWord_btn' value='31' data-word='기분전환이 필요할때'>기분전환이 필요할때</button>";
    	key += "<button type='button' class='keyWord_btn' value='32' data-word='힐링이 필요할때'>힐링이 필요할때</button>";
    	key += "<button type='button' class='keyWord_btn' value='33' data-word='인간관계에 피로할때'>인간관계에 피로할때</button> ";
    	key += "<button type='button' class='keyWord_btn' value='34' data-word='우울할때'>우울할때</button>";
    	$('.keywords').html(key);
    });
    
    
    /* 버튼 클릭!! */
    $('.keywords').on("click",'.keyWord_btn', function(){
    	//console.log("키워드 버튼 클릭!!");
		
    	$('#bookPLresult').empty();
    	
    	var keyword_val = parseInt($(this).val());
    	//console.log("선택한 키워드 번호 : " + keyword_val);
    	
    	var word = $(this).data('word');
    	//console.log("선택한 키워드 : " + word);
    	
    	// ajax로 해당 키워드가 포함된 북플리 모두 불러오기
		$.ajax({
			type : "GET",
			datatype: "JSON",
			url : "/search/getIncludeKey/"+ keyword_val +".json",
			success : function(result) {
				//console.log("키워드 포함 북플리 가져오기 성공!!!");
				//console.log(result);
				// 화면에 뿌리기
				$("#search_resultTitle").show();
				$("#search_result").html(word);
				$("#search_titleEnd").html("키워드의 검색결과");

				 for(let i=0; i<result.length; i++){
                	  var resultList = "<div class='col-2'><div class='onebPlist'><a href='/memData/bookPlistDetail?list_no="+result[i].list_no+"'>";
                	  resultList += "<img class='onePl_img' src='/resources/save/"+result[i].packCover+"'></a>";
                	  resultList += "<div class='card-body'><div class='d-flex justify-content-between align-items-center'>";
                	  resultList += "<div class='btn-group'><h5><b>"+ result[i].bookPLTitle +"</b></h5>";
                	  resultList += "</div></div></div></div></div>";
                	$("#bookPLresult").append(resultList);
                 }
			},
			error : function(e) {
				//console.log("키워드 포함 북플리 가져오기 실패...");
				//console.log(e);
			}
		});
    	
    });
   
   </script>
   
   <script>
   
   
   $(".titleSearch_bar").keydown(function(e) {
       if (e.keyCode == 13) {
          $("#titleSearchPage_btn").trigger('click');
       }
   });
   
   // 검색 버튼 클릭시 
    $('#titleSerch_bar_div').on("click",'#titleSearchPage_btn', function(){
		//console.log("검색버튼 클릭!!!");
		var search = $(".titleSearch_bar").val();
		//console.log("검색할 단어 : " + search);
		
		// ajax로 검색 단어 던져주고 받아오기
		$.ajax({
			type : "GET",
			datatype: "JSON",
			data : search,
			url : "/search/searchBookPL/"+ encodeURI(search,"UTF-8") + ".json",
			success : function(result) {
				//console.log("북플리 검색 가져오기 성공!!!");
				//console.log(result);
				// 화면에 뿌리기
				$('#bookPLresult').empty();
				$("#search_resultTitle").show();
				$("#search_result").html(search);
				$("#search_titleEnd").html("의 검색결과");

				 for(let i=0; i<result.length; i++){
                	  var resultList = "<div class='col-2'><div class='onebPlist'><a href='/memData/bookPlistDetail?list_no="+result[i].list_no+"'>";
                	  resultList += "<img class='onePl_img' src='/resources/save/"+result[i].packCover+"'></a>";
                	  resultList += "<div class='card-body'><div class='d-flex justify-content-between align-items-center'>";
                	  resultList += "<div class='btn-group'><h5><b>"+ result[i].bookPLTitle +"</b></h5>";
                	  resultList += "</div></div></div></div></div>";
                	$("#bookPLresult").append(resultList);
                 }
			},
			error : function(e) {
				//console.log("북플리 검색 가져오기 실패...");
				//console.log(e);
			}
		});
		
    	
    });
   
   
   </script>
   
 

   <%-- footer 복붙 --%>
   <%@ include file="../includes/footer2.jsp"%>