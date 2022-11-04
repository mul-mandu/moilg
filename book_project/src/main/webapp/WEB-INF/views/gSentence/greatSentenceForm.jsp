<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
	<br />
	<h4>인생문장 작성하기</h4>
	<br />
	<form action="/gSentence/greatSentenceForm" method="post" enctype="multipart/form-data">
		<sec:csrfInput/>
		<span id="textCount"> 0자 </span><span id="textTotal">/200자</span>
		<pre><textarea name="greatContent" id="contents" placeholder="* 인생문장을 적어주세요👀 *" maxlength="200"></textarea></pre>
		<div class="filebox">
			<input class="upload-name" value="첨부파일" placeholder="첨부파일">
			<label for="file">파일찾기</label>
			<input type="file" id="file" name="greatImgFile"/>
        </div>
        <br/>
		<span>
			<input type="checkbox" value="0" name="greatContentStatus"/>비공개
			<button type="submit" class="btn btn-outline-secondary btn-sm" style="float:right;" >등록하기</button>
			<button type="button" class="btn btn-outline-secondary btn-sm" style="float:right" onclick="window.location='/gSentence/greatSentence'">뒤로가기</button>
		</span>
		
	</form>


<script>

	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  console.log(fileName);
	  $(".upload-name").val(fileName);
	});
	
	$("#contents").keyup(function (e) {
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
	    };
		
	});
	
	
	
	
	</script>

	<!-- footer 복붙 -->
<%@ include file="../includes/footer.jsp"%>


