<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
   
<meta charset="EUC-KR">
<title>JOJO TOUR</title>
<style>
	*{
            margin: 0;
            padding: 0;
        }
        a{
            text-decoration: none;
            color: inherit;
        }
        ul, li{
            list-style: none;
        }
        img{
            width: 100%;
            height: 100%;
        }
        .inner_con{
            width: 1200px;
            margin: 0 auto;
        }
        .banner_box{
            height: 700px;
			position: relative;
        }
		.banner_inbox{
			position: absolute;
			z-index: 99;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			width: 100%;
			padding: 30px;
			margin-top: 50px;
		}
        .banner_text{
            text-align: center;
            font-size: 20px;
            font-weight: 400;
            color: #fff;
            margin-bottom: 30px;
			background-color: rgba(0, 0, 0, 0.5);
			width: 100%;
			padding: 30px 0px;
        }

        .banner_img{
            display: flex;
            justify-content: center;
            margin-bottom: 50px;
        }
        .banner_img>img{
            width: 600px;
        }
        .banner_start{
            text-align: center;
            font-weight: 700;
            color: #fff;
            margin-bottom: 30px;
        }
		.banner_start span{
			background-color: rgba(0, 0, 0, 0.5);
			padding: 5px 20px;
		}
        .banner_question{
            width: 200px;
            height: 50px;
            margin: 0 auto;
            display: block;
            background-image: url(./img/main/icon_question.svg);
            background-repeat: no-repeat;
            background-color: #F86F03;
            background-position: 10px;
            border: none;
            color: #fff;
            font-size: 20px;
            cursor : pointer;
        }
        /* 배너 끝 */
        .accommodation_title{
            margin-left: 30px;
			margin-bottom: 30px;
        }
        .accommodation>ul{
            display: flex;
            justify-content: space-around;
            margin-bottom: 50px;
        }
        .accommodation>ul>li{
            width: 230px;
			height: 230px;
			border-radius: 20px;
			overflow: hidden;
            text-align: center;
            font-weight: 700;
        }
        /* 숙소예약 끝 */
        .retal_car{
            margin-top: 70px;
        }
        .retal_car_title{
            margin: 30px;
        }
        .retal_car>ul{
            display: flex;
            justify-content: space-around;
            margin: 30px 0;
        }
        .retal_car>ul>li{
            width: 290px;
            height: 290px;
            text-align: center;
            font-weight: 700;
			border-radius: 20px;
			overflow: hidden;
            text-align: center;
            font-weight: 700;
        }
        .retal_car>ul>li:last-child>a{
			display: flex;
			align-items: center;
			justify-content: center;
        }
		.retal_car>ul>li:last-child>a>.rotate_box{
			width: 200px;
			height: 200px;
		}
        /* 렌터카 예약 끝 */
        .water_leisure{
            margin-top: 70px;
        }
        .water_leisure_title{
            margin: 30px;
        }
        .water_leisure>ul{
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin: 30px 0;
            font-weight: 700;
        }
        .water_leisure>ul>li{
            width: 290px;
            height: 290px;
            text-align: center;
            font-weight: 700;
			border-radius: 20px;
			overflow: hidden;
            text-align: center;
            font-weight: 700;
        }
        .w_img_box{
            width: 290px;
            height: 290px;
            margin-bottom: 30px;
        }
        /* 수상레저 예약 끝 */
        .land_leisure{
            margin-top: 70px;
        }
        .land_leisure_title{
			margin-left: 200px;
        }
		.land_leisure_inbox{
			display: flex;
			justify-content: center;
		}
        .land_leisure>.land_leisure_inbox>ul{
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin: 30px 0;
            font-weight: 700;
			width: 900px;
        }
        .land_leisure>.land_leisure_inbox>ul>li{
            width: 290px;
            height: 290px;
            text-align: center;
            font-weight: 700;
			border-radius: 20px;
			overflow: hidden;
            text-align: center;
            font-weight: 700;
        }
        .l_img_box{
            width: 290px;
            height: 290px;
            margin-bottom: 30px;
        }
        /* 지상레져 끝 */

		/* 이미지 돌아가면서 글씨 올리기 */
		.out_box{
			position: relative;
			display: block;
			transform: rotateY(0);
			transition-duration: 1s;
			height : 100%;
			width : 100%;
			
		}
		.rotate_box{
		    transform: rotateY(0);
		    transition-duration: 1s;
			height : 100%;
			width : 100%;
		
		}
		.out_box:hover .rotate_box{
			transform: rotateY(360deg);
		}
		.out_box .out_box_txt{
			position: absolute;
			bottom: -40px;
			left: 50%;
			transform: translateX(-50%);
			background-color: rgba(0, 0, 0, 0.5);
			width: 100%;
			color: #fff;
			font-size: 20px;
			transition-duration: 1s;
		}
		.out_box:hover .out_box_txt{
			bottom: 0;
		}
		.out_box .out_box_txt div:first-child{
			margin-top: 10px;
		}
		.out_box .out_box_txt div:last-child{
			color : yellow;
		}
		.out_box .out_box_txt div{
			margin-bottom: 10px;
		}
		.a_img_box, .r_img_box, .w_img_box, .l_img_box{
			height : 100%;
			width : 100%;
		}

		/* 스와이퍼 시작 */
		.swiper {
          width: 100%;
          height: 100vh;
          margin-top: -100px;
        }
    
        .swiper-slide {
          text-align: center;
          font-size: 18px;
          background: #fff;
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .slide-1{
          background: url(./img/main/main.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-2{
          background: url(./img/main/main2.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-3{
          background: url(./img/main/main3.jpg) no-repeat center;
          background-size: cover;
        }
        .swiper-pagination-bullet-active{
          background-color: #000;
        }

		
		.link_list{
			width: 1000px;
			margin: 0 auto;
			margin-top: 50px;
		}
		.link_list ul{
			border-top: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
			width: 100%;
			display: flex;
			justify-content: space-around;
			margin: 20px 0;
			font-weight: bold;
			font-size: 20px;
		}
		.link_list ul li{
			width: 250px;
			height: 100%;
			text-align: center;
		}
		
		.link_list ul li a{
			width: 100%;
			height: 100%;
			display: block;
			position: relative;
			z-index: 9;
			padding: 20px 0;
		}
		
		.link_list ul li a:hover{
			color: #F86F03;
		}
		.link_list ul li a::after{
			content: "";
			position: absolute;
			left: 50%;
			bottom: -1px;
			width: 0;
			height: 2px;
			background-color: #F86F03;
		}
		.link_list ul li a:hover::after{
			width: 100%;
			left: 0;
			transition-duration: 0.8s;
		}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%-- <%@ include file="header.jsp" %> --%>
	<div id="app">
		<div id="container">
			<div class="swiper mySwiper banner_box">
				<div class="banner_inbox">
					<p class="banner_text">
						여행 가기 전이나 여행중이라도 언제든지!<br>
						관광지, 숙박, 음식점, 쇼핑, 축제, 교통, 문화 등 전국 여행에 관해서라면 어떤 것이라도 조조투어 지식iN에 물어보세요<br>
						조조투어 상주 전문가를 비롯해 여행 잘 아는 사람이라면 누구에게라도 답변 받을 수 있습니다
					</p>
					<div class="banner_img">
						<img src="./img/main/banner_text.png" alt="">
					</div>
					<h3 class="banner_start">
						<span>지금 시작하세요!</span>
					</h3>
					<button class="banner_question" @click="fnFAQ">
						질문하기 >
						<!-- 1:1문의게시판으로 연결 -->
					</button>
				</div>
				<div class="swiper-wrapper">
					<div class="swiper-slide slide-1">
					</div>
					<div class="swiper-slide slide-2">
					</div>
					<div class="swiper-slide slide-3">
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="link_list">
				<ul>
					<li>
						<a href="javascript:;" @click="fnStay">숙박</a>
						
					</li>
					<li>
						<a href="javascript:;" @click="fnRentCar">렌터카</a>
						<span></span>
					</li>
					<li>
						<a href="javascript:;" @click="fnWaterLeisure">수상 레저</a>
						<span></span>
					</li>
					<li>
						<a href="javascript:;" @click="fnGroundLeisure">지상 레저</a>
						<span></span>
					</li>
				</ul>
			</div>


	        <div class="inner_con">
	            <div class="accommodation">
	                <h2 class="accommodation_title" style="margin-top: 50px;">숙소 예약</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('HOTEL')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img class="hotel_img" src="./img/main/hotel.jpg" alt="">
									</div>
								</div>
								<div class="out_box_txt">
									<div>호텔</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('MOTEL')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img src="./img/main/motel.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>모텔</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('GUEST')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img src="./img/main/guest.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>게스트하우스</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('PENSION')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img src="./img/main/pension.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>펜션</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('CAMPING')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img src="./img/main/camping.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>캠핑/글램핑</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="retal_car">
	                <h2 class="retal_car_title">렌터카 예약</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkKind('SMALL')" class="out_box">
								<div class="rotate_box">
									<div class="r_img_box">
										<img src="./img/main/small.png" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>소형차</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkKind('MIDDLE')" class="out_box">
								<div class="rotate_box">
									<div class="r_img_box">
										<img src="./img/main/midium.png" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>중형차</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkKind('LARGE')" class="out_box">
								<div class="rotate_box">
									<div class="r_img_box">
										<img src="./img/main/large.png" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>대형차</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkKind('VAN')" class="out_box">
								<div class="rotate_box">
									<div class="r_img_box">
										<img src="./img/main/very_large.png" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>승합차</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="water_leisure">
	                <h2 class="water_leisure_title">수상 레저 예약</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkWaterKind('SNORKE')" class="out_box">
								<div class="rotate_box">
									<div class="w_img_box">
										<img src="./img/main/snorkeling.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>스노쿨링</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkWaterKind('SURFING')" class="out_box">
								<div class="rotate_box">
									<div class="w_img_box">
										<img src="./img/main/surfing.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>서핑</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkWaterKind('YACHT')" class="out_box">
								<div class="rotate_box">
									<div class="w_img_box">
										<img src="./img/main/yarcht.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>요트</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="javascript:;" @click="checkWaterKind('JETSKI')" class="out_box">
								<div class="rotate_box">
									<div class="w_img_box">
										<img src="./img/main/jetSki.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>제트스키</div>
									<div>예약하러 가기</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="land_leisure">
	                <h2 class="land_leisure_title">지상 레저 예약</h2>
					<div class="land_leisure_inbox">
						<ul>
							<li>
								<a href="javascript:;" @click="checkGroundKind('ATV')" class="out_box">
									<div class="rotate_box">
										<div class="l_img_box">
											<img src="./img/main/atv.jpg" alt="">
										</div>
									</div>
									<div class="out_box_txt">
										<div>ATV</div>
										<div>예약하러 가기</div>
									</div>
								</a>
							</li>  
							<li>
								<a href="javascript:;" @click="checkGroundKind('GLIDER')" class="out_box">
									<div class="rotate_box">
										<div class="l_img_box">
											<img src="./img/main/paragliding.jpg" alt="">
										</div>
									</div>
									<div class="out_box_txt">
										<div>페러글라이딩</div>
										<div>예약하러 가기</div>
									</div>
								</a>
							</li>
							<li>
								<a href="javascript:;" @click="checkGroundKind('HORSE')" class="out_box">
									<div class="rotate_box">
										<div class="l_img_box">
											<img src="./img/main/horse.png" alt="">
										</div>
									</div>
									<div class="out_box_txt">
										<div>승마</div>
										<div>예약하러 가기</div>
									</div>
								</a>
							</li>
						</ul>
					</div>
	            </div>
	        </div>
	    </div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

<script>
var app = new Vue({
	el : '#app',
	data : {
	},// data
	methods : {
		checkKind : function(kind){
			$.pageChange("/rentcar.do", {rentKind : kind});
		},
		checkWaterKind : function(kind){
			$.pageChange("/water/leisure.do", {leisureKind : kind});
		},
		checkGroundKind : function(kind){
			$.pageChange("/ground/leisure.do", {leisureKind : kind});
		},
		checkStayKind : function(kind){
			var self = this;
			$.pageChange("/stay.do", {stayKind : kind});
		},
		fnStay : function(){
        	location.href="/stay.do";
        },
        fnRentCar : function(){
        	location.href="/rentcar.do";
        },
        fnWaterLeisure : function(){
        	location.href="/water/leisure.do";
        },
        fnGroundLeisure : function(){
        	location.href="/ground/leisure.do";
        }
	}, // methods
	created : function() {
		var self = this;
	}// created
});

var swiper = new Swiper(".mySwiper", {
      // slidesPerView: 3,
      // //슬라이더 보여줄 갯수를 지정해줌
      // spaceBetween: 30,
      // //슬라이더 하나 사이에 여백값을 설정해줌
      // slidesPerGroup: 1,
      // // 넘어갈 슬라이드 갯수를 그룹으로 묶어 지정
      loop : true, // 슬라이드 반복여부
      speed : 2000, //넘어갈때 슬라이드의 duration값
      autoplay:{
        //자동으로 넘어가는 슬라이드
        delay : 2500,
        disableOnInteraction:false
        // 다른 인터렉션 진행시 자동 멈춤 해제
      },
      pagination: {
        el: ".swiper-pagination",
        //페이지네이션 사용시 버튼을 담을 태그선택(동그란 버튼을 의미)
        clickable: true,
        // 버튼의 클릭여부를 결정함
      }
    });
</script>