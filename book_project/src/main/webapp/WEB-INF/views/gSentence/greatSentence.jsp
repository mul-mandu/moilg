<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!-- header 복붙 -->
<%@ include file="../includes/header.jsp"%>
<br />
<!-- 이게 피자입니다 -->
<h4>인생 문장</h4>
<hr role="tournament4">
<div>
	<h5 align="center">🏆BEST🏆</h5>
	<div class="container">
		<br />
		<div class="row">
			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/autumn.jpg">
					<br/>
					<p class="userPickSTC_text">
						당신의 노력은 절대로 쓸데 없는 일이 되지는 않습니다. 마지막까지 꼭 믿어주세요. 
						마지막의 마지막 순간까지 믿어야합니다. - 나미야 잡화점의 기적 中 당신의 노력은 
						절대로 쓸데 없는 일이 되지는 않습니다. 마지막까지 꼭 믿어주세요.
					</p>
					<span>나미야 잡화점의 기적 중</span>
					<br />
					<span>by. user_name</span>
					<span style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10 
					</span>
				</div>
			</div>
			
			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/sea.jpg">
					<br/>
					<p class="userPickSTC_text">
						"The bird fights its way out of the egg. The egg is the world.
						Who would be born must first destroy a world". <br/>
						새는 알에서 나오기 위해 투쟁한다. 알은 세계다. 태어나려고 하는 이는 먼저 세계를 파괴해야한다.
					</p>
					<span>데미안 中</span>
					<br />
					<span>by. user_name</span>
					<span style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10 
					</span>
				</div>
			</div>
			
			<div class="col-4">
				<div class="userPickSTC_item">
					<img class="userPickSTC_img" src="/resources/img/friend-ed.jpg">
					<br/>
					<p class="userPickSTC_text"> 
						우리는 그날 복숭아 빛 하늘을 걸었다. <br/>
						사람들은 우리를 절친한 친구관계라고 정의했다.
						그렇다면 짝사랑보다 짝우정이 힘든게 아닐까
						<br/>
						<br/>
						&nbsp; 
						
					</p>
					<span>작자 미상 中</span>
					<br />
					<span>by. user_name</span>
					<span style="font-weight: bold; color: grey; font-size: 16px; float: right;">
						공감수10 
					</span>
				</div>
			</div>
		</div>
	</div>
	<br />
</div>
<hr role="tournament4">
<sec:authorize access="isAuthenticated()">
	<button type="button" onclick="window.location='greatSentenceForm'"
		class="btn btn-outline-secondary btn-sm" style="float: right">작성하기</button>
	<br />
</sec:authorize>

<div class="container">
	<br />
	<c:if test="${empty greatList }">
		<p align="center">등록된 인생문장이 없습니다.</p>
	</c:if>
	<c:if test="${greatList != null}">
		<!-- 등록된 인생문장 뿌리기 -->
		<div class="row">
			<c:forEach items="${greatList}" var="list">
				<div class="col-4">
					<div class="userPickSTC_item">
						<c:choose>
							<c:when test="${list.greatImg == null}">
								<img class="userPickSTC_img" src="/resources/img/greatDefaultImg.jpg">
							</c:when>
							<c:otherwise>
								<img class="userPickSTC_img" src="/resources/save/${list.greatImg}" />
							</c:otherwise>
						</c:choose>
						<br />
						<p class="userPickSTC_text">${list.greatContent}</p>
						<span id="greatbookT"> ${list.greatBookTitle} 中</span>
						<br /> <span>By. ${list.nickName }</span>
						<span style="font-weight: bold; color: grey; font-size: 16px; float: right;">공감수0</span>
					</div>
				</div>
		</c:forEach>
		</div>
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
<%@ include file="../includes/footer.jsp"%>