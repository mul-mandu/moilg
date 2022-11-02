<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- header 복붙 -->
<%@ include file="../includes/header.jsp" %>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
  $( function() {
    var availableTags = [
      "추리/미스터리소설",
      "SF/판타지",
      "한국소설",
      "외국소설",
      "고전문학",
      "시",
      "에세이",
      "철학",
      "역사서",
      "예술",
      "자기개발",
      "경제",
      "요리",
      "여행",
      "심리",
      "따뜻한",
      "희망적인",
      "밝은",
      "감성적인",
      "아련한",
      "우울한",
      "가벼운",
      "어두운",
      "봄",
      "여름",
      "가을",
      "겨울",
      "새로운 시작",
      "위로가 필요할때",
      "이별했을때",
      "기분전환이 필요할때",
      "힐링이 필요할때",
      "인간관계에 피로할때",
      "우울할때"
    ];
    $( "#tags" ).autocomplete({
      source: availableTags
    });
  } );
  </script>
</head>
<body>
 
<div class="ui-widget">
  <label for="tags">Tags: </label>
  <input id="tags">
</div>
 
		<!-- footer 복붙 -->
	<%@ include file="../includes/footer.jsp"%>