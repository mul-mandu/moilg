<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    <%-- header 복붙 --%>
   <%@ include file="../includes/header.jsp" %>

<link href="/resources/css/chartest.css" rel="stylesheet" type="text/css">
<script>
let typeResult = ""; 
</script>
   <div class="container">
      <article class="start">
         <div id="mbit_titleText">
            <h1 class="mt-5 text-center"><b>나의 도서 유형 테스트 ✨</b></h1>
            <br/>
               <h5>성격유형에 맞는 북 플레이리스트를 추천해드릴게요! </h5>
            <img src="/resources/img/mbti_main.jpg" width="500px">
         </div>
         <button type="button" class="btn btn-primary mt-4" onclick='start();'>테스트 시작하기</button>
      </article>
      
      <%--  질문   --%>
      <article class="question">
         <%--  프로그레스 바  --%>
         <div class="progress mt-5">
              <div class="progress-bar" role="progressbar" style="width: calc(100/12*1%)"></div>
         </div>
         
         <div id="mbit_titleText">
         <h2 id="title" class="text-center mt-5">문제</h2>
         <br />
         <img src="/resources/img/sample2.jpg" id="quImg" alt="mbtiQuImg">
         <br />
         <input id="type" type="hidden" value="EI"/>
         </div>
         
         <button id="A" type="button" class="btn btn-primary mt-4">Primary</button>
         <button id="B" type="button" class="btn btn-primary mt-4">Primary</button>
      </article>



	<%-- 결과화면 출력  --%>
	<div id="mbit_titleText">
		<article class="result">
			<h1 class="mt-5 text-center">
				<b>나의 도서 유형 테스트 ✨</b>
			</h1>
			<h5>도서 유형 검사 결과는!</h5>
			<img class="rounded-circle mt-5" id="img"
				src="/resources/img/lion.jpg" alt="bookType">
			<h2 id="bookType" class="text-center mt-5">
				<b>동물이름</b>
			</h2>
			<h4 id="explain" class="text-center mt-5">설명</h4>
			<h6>
				*로그인 후 MBTI를 등록하시면 내 도서 유형에 맞는 플레이리스트를 추천드려요!*
				</h5>
				<button class="btn btn-primary mt-5"
					onclick="window.location='/signup/signup'">회원가입하고 더 많은 북플리
					추천 받기</button>
				<button class="btn btn-secondary mt-5"
					onclick="window.location='/main/mbtiNotLogin'">
					테스트 다시하기 <i class="fa-solid fa-rotate-left"></i>
				</button>


				<br /> <br />

				<div class="result_recommend">
					<h4>같은 유형의 사용자들의 북 플레이리스트 👍</h4>
					<br />
					<div class="row" id="mbtiSet"></div>
				</div>
		</article>
	</div>



	<%-- 점수처리 로직  --%>
      <input type="hidden" id="EI" value="0" />
      <input type="hidden" id="SN" value="0" />
      <input type="hidden" id="TF" value="0" />
      <input type="hidden" id="JP" value="0" />
      
   
      <script>
         var num = 1  // 현재 어떤 문제에 있는지
         var q = { // 문제 객체 생성
            1: {"title": "Q1. 한가롭게 공원을 산책하다가 새로 생긴 독립 서점을 발견했습니다.", "type": "EI", "A": "재밌겠다! 들어가보자!", "B": "음...가볼까말까...", "quImg": "/resources/img/1.jpg"},
            2: {"title": "Q2. 독립서점에 들어간 당신 제일 먼저 하는 것은?", "type": "EI", "A": "신기하게 생긴 인테리어를 구경한다", "B": "평소부터 팬이었던 작가의 책을 구경한다", "quImg": "/resources/img/2.jpg"},
            3: {"title": "Q3. 직원 : 찾으시는 책이 있으신가요?", "type": "EI", "A": "구경 중이에요! 그나저나 이런 곳에 서점이 있는줄 몰랐네요!", "B": "어..그냥 구경중이에요...", "quImg": "/resources/img/Q3.jpg"},
            
            4: {"title": "Q4. 직원이 내게 다가와 어떤 스타일의 책을 좋아하는지 묻는다. ", "type": "SN", "A": "논리적으로 맞아 떨어지는 촘촘한 스토리의 책", "B": "다양한 해석이 나올 수 있는 열린 결말의 책", "quImg": "/resources/img/Q4.jpg"},
            5: {"title": "Q5. 또 다른 책을 추천 받고 싶은 당신 어떤 책이 끌리는가?", "type": "SN", "A": "현실적인 스토리의 책", "B": "상상의 나래를 펼칠 수 있는 스토리의 책", "quImg": "/resources/img/Q5.jpg"},
            6: {"title": "Q6. 점원에게 추천 받은 책을 찾으러 가던 중 Best 셀러 코너를 보게된다. 저기 중 관심 가는 책은?", "type": "SN", "A": "사건을 중심으로 진행되는 책", "B": "인물의 감정을 중심으로 진행되는 책", "quImg": "/resources/img/Q6.jpg"},
            
            7: {"title": "Q7. 서점에서 구매한 책을 다 읽은 당신, 친구에게 어떤 말로 추천할 것인가? ", "type": "TF", "A": "이거 내용 개연성이 장난 아님. 결말이 완전 납득 된다니까?", "B": "책 주인공 울때 나도 같이 울었다...", "quImg": "/resources/img/Q7.jpg"},
            8: {"title": "Q8. 당신의 영업에 친구가 관심을 보인다면? ", "type": "TF", "A": "줄거리, 등장인물 등 인터넷에서 스크랩해둔 글을 보낸다", "B": "오오오 진짜 볼거야???진짜???근데 이거 진짜 장난 아님", "quImg": "/resources/img/Q8.jpg"},
            9: {"title": "Q9. 친구 : 그것보단 내가 얼마전에 읽은 책이 더 재밌는것 같은데?", "type": "TF", "A": "그래? 그건 무슨 내용인데?", "B": "내 책이 제일 재밌거든?", "quImg": "/resources/img/Q9.jpg"},
            
            10: {"title": "Q10. 친구가 말한 책을 당신은? ", "type": "JP", "A": "검색부터 해본다", "B": "일단 산다", "quImg": "/resources/img/Q10.jpg"},
            11: {"title": "Q11. 결국 책을 구매했지만 배송이 늦어진다는 문자를 받았다", "type": "JP", "A": "아 이번주에 읽을려고 했는데...", "B": "오기만 하면 됐지 뭐", "quImg": "/resources/img/Q11.jpg"},
            12: {"title": "Q12. 친구가 추천한 책을 다 읽고 난 후 당신은?", "type": "JP", "A": "친구와 만나서 책에 대한 이야기를 나눈다.", "B": "나만의 SNS나 노트에 독후감을 쓴다.", "quImg": "/resources/img/Q12.jpg"}
         }
         var result = {
               "ISTJ": {"bookType":"고전소설형", "explain": "안정되고 전통적인 환경을 좋아하는 당신은 '고전소설형'입니다.", "img": "/resources/img/istj.png"},
               "ISFJ": {"bookType":"교과서형", "explain": "표준적인 절차를 중시하며 실질적인 판단과 조직적인 방식을 선호하는 당신은 '교과서형'입니다.", "img": "/resources/img/isfj.png"},
               "INFJ": {"bookType":"철학형", "explain": "가치관이나 신념, 윤리, 통찰력을 얻을 수 있는 것을 좋아하는 당신은 '철학형'입니다.", "img": "/resources/img/infj.png"},
               "INTJ": {"bookType":"제테크형", "explain": "스스로 혁신적이고 독창적으로 시스템을 개발하여 보상을 손에 쥐는 당신은 '제테크형'입니다.", "img": "/resources/img/intj.png"},
               "ISTP": {"bookType":"성장소설형", "explain": "자신의 뚜렷한 목표를 위해 나아가는 일을 선호하는 당신은 '성장소설형'입니다.", "img": "/resources/img/istp.png"},
               "ISFP": {"bookType":"에세이형", "explain": "넓은 포용력과 공감능력을 가지고 있는 당신은 '에세이형'입니다.", "img": "/resources/img/isfp.png"},
               "INTP": {"bookType":"현대시형", "explain": "분석하고 비판하며 복잡한 문제를 다루는 것을 좋아하는 당신은 '현대시형'입니다.", "img": "/resources/img/intp.png"},
               "INFP": {"bookType":"판타지소설형", "explain": "자신의 가치관과 이상을 자유롭게 표현하는 것을 좋아하는 것을 좋아하는 당신은 '판타지소설형'입니다.", "img": "/resources/img/infp.png"},
               
               "ESTJ": {"bookType":"백과사전형", "explain": "체계적이고 논리적인 결과를 중요시 여기는 당신은 '백과사전형'입니다.", "img": "/resources/img/estj.png"},
               "ESFJ": {"bookType":"참고서형", "explain": "타인에게 도움이 되는 일을 하는 것을 선호하는 당신은 '참고서형'입니다.", "img": "/resources/img/esfj.png"},
               "ENFJ": {"bookType":"동화책형", "explain": "따뜻한 인간관계를 중요시 여기는 당신은 '동화책형'입니다.", "img": "/resources/img/enfj.png"},
               "ENTJ": {"bookType":"사회형", "explain": "기획과 통솔에 뛰어나며 유능한 사람과 어울리는 것을 선호하는 당신은 '사회형'입니다.", "img": "/resources/img/entj.png"},
               "ESTP": {"bookType":"로맨스소설형", "explain": "아이디어를 고민하는 것 보다 사람과의 관계에서 더 흥미를 느끼는 당신은 '로맨스소설형'입니다.", "img": "/resources/img/estp.png"},
               "ESFP": {"bookType":"패션잡지형", "explain": "미적 감각이 뛰어나고 자유로운 분위기를 선호하는 당신은 '패션잡지형'입니다.", "img": "/resources/img/esfp.png"},
               "ENTP": {"bookType":"자기계발형", "explain": "개인적인 자유시간을 중요시하며 다양한 경험을 할 수 있는 환경을 선호하는 당신은 '자기계발서형'입니다.", "img": "/resources/img/entp.png"},
               "ENFP": {"bookType":"만화책형", "explain": "창의적이고 자유로운 환경을 선호하며, 새로운 아이디어 구상을 즐겨하는 당신은 '만화책형'입니다", "img": "/resources/img/enfp.png"}
         }
      
         
         
         function start(){
            $(".start").hide();
            $(".question").show();
            next();  // 바로 첫번째 문제가 나올 수 있도록
         }
         
         
         
         // 점수로직처리
         // A 버튼을 눌렀을때 값이 +1 되면서 어떤 타입을 선택했는지 type에 저장
         $("#A").click(function(){
            var type = $("#type").val();
            var preValue = $("#"+type).val();
            $("#"+type).val(parseInt(preValue)+1);
            next();
         });
   
         // B 버튼을 눌렀을 때는 그냥 next로 
         $("#B").click(function(){
            next();
         });
         
         
         
         // 다음문제로 넘어가는 함수 로직처리
         // .attr = 태그의 속성을 바꿔줌
         function next(){
            if(num == 13){  // 12번까지 다 풀었으면
               $(".question").hide();
               $(".result").show();
               $(".result_recommend").show();
               
               
               //mbti 판단 최종 로직!!!!
               var mbti = "";
               ($("#EI").val() <2) ? mbti+="I" : mbti+="E";
               ($("#SN").val() <2) ? mbti+="N" : mbti+="S";
               ($("#TF").val() <2) ? mbti+="F" : mbti+="T";
               ($("#JP").val() <2) ? mbti+="P" : mbti+="J";
               //alert(mbti);
               
               // 결과 나온거 html 에 연결하기 
               $("#img").attr("src",result[mbti]["img"]);
               $("#bookType").html(result[mbti]["bookType"]);
               typeResult = (result[mbti]["bookType"]); 
               //console.log(typeResult);
               //console.log("테스트 완료!");
               getMbti(typeResult);
               $("#explain").html(result[mbti]["explain"]);
   
            }else{ // 아직문제를 풀고있으면
               $(".progress-bar").attr('style',' width: calc(100/12*'+num+'%)');
               $("#title").html(q[num]["title"]);
               $("#type").val(q[num]["type"]);
               $("#quImg").attr("src",q[num]["quImg"]);
               $("#A").html(q[num]["A"]);
               $("#B").html(q[num]["B"]);
               num++;
            }
            
         }

         
         function getMbti(mbti){
       		var setmbtiList = new Array();
         	 
         	//console.log("mbit 가져오기 실행!!");
         	//console.log("mbit : " + typeResult);
         	
             $.ajax({
                   url: "/main/getMbtiPLlist.json",
                   type: "get",
                   data : {"mbti" : mbti},
                   datatype: "JSON",
                   success: function(result) {
                      //console.log("ajax success");
                     // console.log(result);
                      //console.log("mbti가져오기 성공!! ");
                      
                      for(let i=0; i<result.length; i++){
                     	  var mbtiList = "<div class='col-2'><div class='onebPlist'><a href='/memData/bookPlistDetail?list_no="+result[i].list_no+"'>";
                     	mbtiList += "<img class='pointcard_img' src='/resources/save/"+result[i].packCover+"'></a>";
                     	mbtiList += "<div class='card-body'><div class='d-flex justify-content-between align-items-center'>";
                     	mbtiList += "<div class='btn-group'><h5><b>"+ result[i].bookPLTitle +"</b></h5>";
                     	mbtiList += "</div></div></div></div></div>";
                     	$("#mbtiSet").append(mbtiList);
                      }
                     	//console.log(mbtiList);
                  
                      
                   },
                   error: function(e){
                      //console.log("ajax error");
                      //console.log(e);
                   }
                }); 
          } 
          
         
      
      </script>
   </div>

   

   
   <%-- footer  --%>

   <br />
   <br />

  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <div class="col-md-4 d-flex align-items-center">
        <a href="/main/main"><img src="/resources/img/logo_kr.png" width="80px"/></a>
      <span class="mb-3 mb-md-0 text-muted">&copy; molig company, 2022</span>
    </div>
    <div>
      <span class="mb-12 mb-md-0 text-muted">Partners</span>
      <a href="https://www.aladin.co.kr/home/welcome.aspx"><img src="/resources/img/aladin_logo.png" width="140px"/></a>
   </div>
  </footer>


<script>
$('.owl-carousel').owlCarousel({
    loop:true,
    margin:10,
    nav:true,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:3
        },
        1000:{
            items:5
        }
    }
})


$('.carousel').carousel()
</script>


<script src="jquery.min.js"></script>
<script src="owlcarousel/owl.carousel.min.js"></script>
   <%-- bootstrap --%>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
      crossorigin="anonymous">
   </script>

   
   
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>   
 <script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
</body>
</html>