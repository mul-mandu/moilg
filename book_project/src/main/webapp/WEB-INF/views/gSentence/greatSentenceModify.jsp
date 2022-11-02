<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
	<br />
	<h4>인생문장 작성하기</h4>
	<br />
	<form action="signupPro.jsp" method="post" enctype="multipart/form-data">
		<pre><textarea name="greatContent" id="contents" placeholder="* 인생문장을 적어주세요👀 *" value="${sentence.greatContent}" ></textarea></pre>
		<div class="filebox">
			<input class="upload-name" value="첨부파일" placeholder="첨부파일">
			<label for="file">파일찾기</label>
			<input type="file" id="file" name="greatImg"/>
        </div>
        <br/>
		<span>
			<button type="submit" class="btn btn-outline-secondary btn-sm" style="float:right;">등록하기</button>
			<button type="button" class="btn btn-outline-secondary btn-sm" style="float:right" onclick="window.location='/gSentence/greatSentence'">뒤로가기</button>
		</span>
		
	</form>

<script>
	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload-name").val(fileName);
	});
</script>
	<!-- footer 복붙 -->
<%@ include file="../includes/footer.jsp"%>


