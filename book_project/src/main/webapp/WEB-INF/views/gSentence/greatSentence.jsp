<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
	<br/>
	<h4>인생 문장</h4>
	<!-- 제발 되라 git -->
	<hr role="tournament4">
		<div>
			<h5 align="center">🏆BEST🏆</h5>
		   	<div class="container">
		      <br />
		      <div class="userPickSTC_item">
		         <div class="row">
		            <div class="col">
		               <img class="userPickSTC_img" src="/resources/img/autumn.jpg">
		            </div>
		            <div class="col">
		               <p class="userPickSTC_text">
		                  당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中
		                  당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다.
		                  마지막까지 꼭 믿어주세요.
		                  마지막의 마지막 순간까지 믿어야합니다.
		                  - 
		                  나미야 잡화점의 기적 中
		               </p>
		                  <br />
		               <span>by. user_name</span>
		               <span style="font-weight:bold; color: grey; font-size: 16px; float: right; ">공감수 10</span>
		            </div>
		         </div>
		      </div>
		   </div>
		   	<br/>
			</div>
	<hr role="tournament4">
	<sec:authorize access="isAuthenticated()">  
		<button type="button" onclick="window.location='greatSentenceForm'" class="btn btn-outline-secondary btn-sm" style="float:right">작성하기</button>
		<br />
	</sec:authorize>
	
	<div class="container">
		<br />
		<c:if test="${empty greatList }">
			<p align="center"> 등록된 인생문장이 없습니다. </p>
		</c:if>
		<c:if test="${greatList != null}">
			<c:forEach items="${greatList}" var="list" > 
				<div class="userPickSTC_item">
					<div class="row">
				    	<div class="col">
							<c:choose>
								<c:when test="${list.greatImg == null}"> 
				              		<img class="userPickSTC_img" src="/resources/img/greatDefaultImg.jpg">
				          		</c:when>
				          		<c:otherwise>
				              		<img class="userPickSTC_img" src="/resources/save/${list.greatImg}" />
				          		</c:otherwise>
				          	</c:choose>
						</div>
						<div class="col">
			           	  	<p class="userPickSTC_text">${list.greatContent}</p>
			                <br />
			             	<span>By. ${list.nickName }</span>
			             	<span style="font-weight:bold; color: grey; font-size: 16px; float: right; ">공감수0</span>
						</div>
					</div>
				</div>
				<br />
			</c:forEach>
		</c:if>
	</div>
	<!-- 아래에 jstl로 for문 돌리기 -->
	<%-- 
			<div class="container">
		      <br />
		      <c:choose>
		      	<c:when test="${not empty greatList}">
		      		<c:forEach var="great" items="${greatList}">
				      <div class="userPickSTC_item">
				         <div class="row">
				            <div class="col">
				            <c:choose>
			            		<c:when test="${empty great.greatImg }"> 
					               <img class="userPickSTC_img" src="/resources/img/greatDefaultImg.jpg">
				            	</c:when>
				            	<c:otherwise>
					               		<img class="userPickSTC_img" src="/resources/save/${great.greatImg}" />
				            	</c:otherwise>
				            </c:choose>
				            </div>
				            <div class="col">
				             	  <p class="userPickSTC_text">${great.greatContent}</p>
				                  <br />
				               <span>by. user_name</span>
				               <span style="font-weight:bold; color: grey; font-size: 16px; float: right; ">공감수 10</span>
				            </div>
				         </div>
				      </div>
			      </c:forEach>
		      </c:when>
		      <c:otherwise>
				<p align="center"> 등록된 인생문장이 없습니다. </p>
		      </c:otherwise>
		      </c:choose>
		   </div>
	--%>
		<!-- footer 복붙 -->
	<%@ include file="../includes/footer.jsp" %>