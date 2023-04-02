<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- header 복붙 --%>
<%@ include file="../includes/header.jsp"%>
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>

<style>
      #columns{
        column-width: 22rem;
        column-gap: 15px;
      }
      #columns figure{
        display: inline-block;
        margin:0;
        /* margin-bottom: 15px; */
        padding:10px;
      }
      #columns figure img{
        width:100%;
      }
      #columns figure figcaption{
        padding:10px;
        margin-top:11px;
      }
</style>

	<h1 style="text-align: center"><b>인생 문장</b></h1>
	<br />
	<sec:authorize access="isAuthenticated()">
		<button type="button" onclick="window.location='greatSentenceForm'"
			class="btn btn-outline-primary " style="float: right"> + 작성하기</button>
		<br />
	</sec:authorize>
	<hr role="tournament4">
	<div>
		<h5 align="center">🏆BEST🏆</h5>
		<div class="container">
			<br />
			<div class="row">
			<%-- 반복  top 3개만 나오게 --%>
				<c:forEach var="great" items="${topGreat}" begin="0" end="2" step="1">
					<div class="col-4">
						<div class="userPickSTC_item">
							<c:choose>
								<c:when test="${great.greatImg == null}">
									<img class="userPickSTC_img" src="/resources/img/greatDefaultImg.jpg">
								</c:when>
								<c:otherwise>
									<img class="userPickSTC_img" src="/resources/save/${great.greatImg}" />
								</c:otherwise>
							</c:choose>
							<br/>
							<p class="userPickSTC_text">${great.greatContent}</p>
							<span id="greatbookT"> ${great.greatBookTitle} 中</span>
							<br/>
							<br/>
							<div class="topGreatBy">
								<span>By. ${great.nickName }</span>
								<span class="topLike">공감수 ${great.greatLikeCount}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			
			</div>
		</div>
		<br />
	</div>
	<hr role="tournament4">
	
	
	<div class="container">
		<br />
		<c:if test="${empty greatList }">
			<p align="center">등록된 인생문장이 없습니다.</p>
		</c:if>
		<c:if test="${greatList != null}">
			<%-- 등록된 인생문장 뿌리기 --%>
			<div id="columns">
				<c:forEach items="${greatList}" var="list">
					<c:set var="memLikeList" value="${memLikeList}" />
					<figure>
						<div class="userPickSTC_item">
							<c:choose>
								<c:when test="${list.greatImg == null}">
									<img class="userPickSTC_img"
										src="/resources/img/greatDefaultImg.jpg">
								</c:when>
								<c:otherwise>
									<img class="userPickSTC_img"
										src="/resources/save/${list.greatImg}" />
								</c:otherwise>
							</c:choose>
							<br />
							<p class="userPickSTC_text">${list.greatContent}</p>
							<span id="greatbookT"> ${list.greatBookTitle} 中</span> <br /> <br />
							<span class="nickname">By. ${list.nickName }</span>
							<br />
							
							<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal" var="princ" />
								<c:set var="name" value="${princ.member.id}" />
								<c:set var="id" value="${list.id}" />
								<c:set var="listNum" value="${list.great_no}" />
								<c:if test="${name ne id}">
									<div class="likeBtn_div${list.great_no}" id="btn_div">
										<span class="like">공감수 ${list.greatLikeCount}</span>
										<c:if test="${fn:contains(memLikeList, listNum)}">
											<button type='button' class='btn' id='noLikeBtn'
												value="${list.great_no}" data-like="${list.greatLikeCount}">
												<i class='fa-solid fa-heart fa-lg'></i>
											</button>
										</c:if>
										<c:if test="${not fn:contains(memLikeList, listNum)}">
											<button type="button" class="btn" id="likeBtn" data-like="${list.greatLikeCount}"
												value="${list.great_no}">
												<i class="fa-regular fa-heart fa-lg"></i>
											</button>
										</c:if>
									</div>
								</c:if>
	
								<c:if test="${name eq id}">
									<span class="like">공감수 ${list.greatLikeCount}</span>
									<br/>
									<button type="button" class="btn btn-secondary btn-sm"
										onclick="window.location='/gSentence/greatSentenceModify?great_no=${list.great_no}'">수정</button>
									<button type="button" class="btn btn-outline-secondary btn-sm"
										id='deleteGreat_btn' value="${list.great_no}">삭제</button>
								</c:if>
							</sec:authorize>
	
						</div>
					</figure>
				</c:forEach>
			</div>
		</c:if>
	</div>
	
	<br />
	<br />
	<br />
	
	
	<%-- 페이징 처리 --%>
	<%--  페이지 번호 Pagination  --%>
	<div class="container" >
		<div class="row">
			<div class="col">
				<ul class="pagination" id="pagingNum" >
					<c:if test="${pager.prev}">
						<li class="page-item"><a class="page-link"
							href="${pager.startPage-1}" tabindex="-1">Previous</a></li>
					</c:if>
					<c:forEach var="num" begin="${pager.startPage}"
						end="${pager.endPage}">
						<li class="page-item ${pager.cri.pageNum == num ?" active":""}">
							<a class="page-link" href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pager.next}">
						<li class="page-item"><a class="page-link"
							href="${pager.endPage+1}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		
		<form id="pagingForm" action="/gSentence/greatSentence">
			<input type="hidden" name="pageNum" value="${pager.cri.pageNum}" /> 
			<input type="hidden" name="listQty" value="${pager.cri.listQty}" /> 
		</form>
	</div>
	
	
	
	<%-- 삭제요청 눌렀을 때 모달  --%>
	<div class="modal fade"  id="cancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">📖인생문장 삭제</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>해당 문장을 삭제하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" id="deleteGreat">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%-- 삭제요청 완료 때 모달  --%>
	<div class="modal fade"  id="successCancelmodal" tabindex="-1" aria-hidden="true" aria-labelledby="cancelmodal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">📖인생문장 삭제</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>삭제가 완료 되었습니다.</p>
	      </div>
	      <div class="modal-footer">
	            <button type="button" class="btn btn-primary"  onclick="window.location='/gSentence/greatSentence'">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	

	
	
	// 페이지 번호 누르면 이동하는 처리 
	let pagingForm = $("#pagingForm"); // 숨긴 폼태그 가져오기 
	$(".pagination a").on("click", function(e){
		e.preventDefault(); 	// a 태그의 기본 이동 기능 취소 
		//console.log("a click!!click!!!");
		
		pagingForm.attr("action", "/gSentence/greatSentence");
		// form태그의 pageNum value 속성값을
		// 이벤트 발생시킨 a태그의 href 속성값으로 변경 
		pagingForm.find("input[name='pageNum']").val($(this).attr("href"));
		pagingForm.submit();  // 숨긴 폼태그 submit시키기 
	}); 
	
		var great_no;
	
		// 삭제 버튼 눌렀을 시
		$(document).on('click', "#deleteGreat_btn",function(){
			//console.log("삭제 버튼 클릭!!!");
			great_no = $(this).val();
			//console.log("great_no : " + great_no);
			$("#cancelmodal").modal("show");
		});
	
	
		// 삭제 처리
	
		$("#deleteGreat").on("click", function() {
			//console.log("진짜 삭제 버튼 클릭!!!");
			//console.log("삭제할 great_no : " + great_no);
			$("#cancelmodal").modal("hide");
			
			$.ajax({
				type : "POST",
				url : "/gSentence/greatDelete",
				data : JSON.stringify(great_no),
				contentType : "application/json;charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result) {
					//console.log("인생문장 삭제 요청 성공!!!!!");
					//console.log(result);
					$("#successCancelmodal").modal("show");
				},
				error : function(e) {
					//console.log("인생문장 삭제 요청 에러......");
					//console.log(e);
				}
			});
	
		});
		
	</script>
	
	<script>
	
	function getCount(LikeGreat_no) {
			// 방금 좋아요 누른 게시글 카운트 가져오기 
			//console.log("게시글 카운트할 문장번호 : " + LikeGreat_no);
			var gNo = LikeGreat_no;
	
			$.ajax({
				url : "/gSentence/getCount/"+gNo+".json",
				type : "GET",
				datatype: "JSON",
				success : function(result) {
					//console.log("좋아요 카운트 가져오기 성공!!!");
					//console.log(result);
				},
				error : function(e) {
					//console.log("좋아요 카운트 가져오기 실패...");
					//console.log(e);
				}
			});
	
		}
	
		var LikeGreat_no;
	
		// 좋아요 버튼 클릭
		$("[class^=likeBtn_div]").on('click', "#likeBtn", function() {
			//console.log("좋아요 버튼 클릭!!!");
			LikeGreat_no = $(this).val();
			//console.log("좋아요 누른 문장번호 : " + LikeGreat_no);
			
			var likeCountVal = $(this).attr("data-like");
			//console.log("likeCountVal : " + likeCountVal);
			var likeCountValPlus = parseInt(likeCountVal) + 1 ;
			//console.log("likeCountValPlus : " + likeCountValPlus);
			
			$(this).parent().html("<span class='like'>공감수 "+likeCountValPlus+"</span><button type='button' class='btn' id='noLikeBtn' value='"+LikeGreat_no+"' data-like='"+likeCountValPlus+"'><i class='fa-solid fa-heart fa-lg'></i></button>");
			
			
			
			// 좋아요 기능 구현
			$.ajax({
				type : "POST",
				url : "/gSentence/likeGreat",
				data : JSON.stringify(LikeGreat_no),
				contentType : "application/json;charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result) {
					//console.log("좋아요 요청 성공!!!!!");
					//console.log(result);
					// 좋아요 카운트 가져오기
					//getCount(LikeGreat_no);
				},
				error : function(e) {
					//console.log("좋아요 요청 에러......");
					//console.log(e);
				}
			});
	
		});
	
		// 좋아요 버튼 취소
		$("[class^=likeBtn_div]").on("click", "#noLikeBtn", function() {
			//console.log("좋아요 취소 클릭!!!");
			LikeGreat_no = $(this).val();
			//console.log("좋아요 취소 문장번호 : " + LikeGreat_no);
			
			var likeCountVal = $(this).attr("data-like");
			//console.log("likeCountVal : " + likeCountVal);
			var likeCountValMinus = parseInt(likeCountVal) - 1 ;
			//console.log("likeCountValMinus : " + likeCountValMinus);
			
			$(this).parent().html("<span class='like'>공감수 "+likeCountValMinus+"</span><button type='button' class='btn' id='likeBtn' value='"+LikeGreat_no+"' data-like='"+likeCountValMinus+"'><i class='fa-regular fa-heart fa-lg'></i></button>");
		
			// 좋아요 취소 기능 구현
			$.ajax({
				type : "POST",
				url : "/gSentence/cancleLikeGreat",
				data : JSON.stringify(LikeGreat_no),
				contentType : "application/json;charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(result) {
					//console.log("좋아요 취소 요청 성공!!!!!");
					//console.log(result);
					// 좋아요 카운트 가져오기
					//getCount(LikeGreat_no);
				},
				error : function(e) {
					//console.log("좋아요 취소 요청 에러......");
					//console.log(e);
				}
			});
			
		});
		
		
		
	
	</script>
	
	

<!-- footer 복붙 -->
<%@ include file="../includes/footer2.jsp"%>


