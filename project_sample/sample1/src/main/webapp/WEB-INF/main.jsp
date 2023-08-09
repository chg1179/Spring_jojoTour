<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
            background-image: url(./img/main/main.jpg);
            background-repeat: no-repeat;
            background-size: cover;
            height: 500px;
            padding-top: 50px;
        }
        .banner_text{
            text-align: center;
            font-size: 20px;
            font-weight: 400;
            line-height: 32px;
            color: #fff;
            margin-bottom: 30px;
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
        .banner_question{
            width: 200px;
            height: 50px;
            margin: 0 auto;
            display: block;
            background-image: url(./img/main/icon_question.svg);
            background-repeat: no-repeat;
            background-color: #FF264D;
            background-position: 10px;
            border: none;
            color: #fff;
            font-size: 20px;
        }
        /* 배너 끝 */
        .accommodation_title{
            margin: 30px;
        }
        .accommodation>ul{
            display: flex;
            justify-content: space-around;
            margin: 30px 0;
        }
        .accommodation>ul>li{
            width: 120px;
            height: 120px;
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
            width: 120px;
            height: 120px;
            text-align: center;
            font-weight: 700;
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
        .w_img_box{
            width: 120px;
            height: 120px;
            margin-bottom: 30px;
        }
        .w_img_box, .l_img_box{
            border-radius: 100%;
            overflow: hidden;
        }
        /* 수상레저 예약 끝 */
        .land_leisure{
            margin-top: 70px;
        }
        .land_leisure_title{
            margin: 30px;
        }
        .land_leisure>ul{
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin: 30px 0;
            font-weight: 700;
        }
        .l_img_box{
            width: 120px;
            height: 120px;
            margin-bottom: 30px;
        }
</style>
</head>
<body>
<div id="app">
	<div id="container">
        <div class="banner_box">
            <p class="banner_text">
                여행 가기 전이나 여행중이라도 언제든지!<br>
                관광지, 숙박, 음식점, 쇼핑, 축제, 교통, 문화 등 제주 여행에 관해서라면 어떤 것이라도 제주관광 지식iN에 물어보세요<br>
                비짓제주 상주 전문가를 비롯해 제주를 잘 아는 사람이라면 누구에게라도 답변 받을 수 있습니다
            </p>
            <div class="banner_img">
                <img src="./img/main/banner_text.png" alt="">
            </div>
            <h3 class="banner_start">
                지금 시작하세요!
            </h3>
            <button class="banner_question">
                질문하기 >
                <!-- 1:1문의게시판으로 연결 -->
            </button>
        </div>
        <div class="inner_con">
            <div class="accommodation">
                <h2 class="accommodation_title">숙소 예약</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/hotel.png" alt="">
                            </div>
                            <span>호텔</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/motel.png" alt="">
                            </div>
                            <span>모텔</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/guest_house.png" alt="">
                            </div>
                            <span>게스트하우스</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/pension.png" alt="">
                            </div>
                            <span>펜션</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/camping.png" alt="">
                            </div>
                            <span>캠핑/글램핑</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="retal_car">
                <h2 class="retal_car_title">렌터카 예약</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/small.png" alt="">
                            </div>
                            <span>소형차</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/midium.png" alt="">
                            </div>
                            <span>중형차</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/large.png" alt="">
                            </div>
                            <span>대형차</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/very_large.png" alt="">
                            </div>
                            <span>승합차</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="water_leisure">
                <h2 class="water_leisure_title">수상 레저 예약</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/snorkeling.jpg" alt="">
                            </div>
                            <span>스노쿨링</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/surfing.jpg" alt="">
                            </div>
                            <span>서핑</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/yarcht.jpg" alt="">
                            </div>
                            <span>요트</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/jetSki.jpg" alt="">
                            </div>
                            <span>제트스키</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="land_leisure">
                <h2 class="water_leisure_title">지상 레저 예약</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="l_img_box">
                                <img src="./img/main/atv.jpg" alt="">
                            </div>
                            <span>ATV</span>
                        </a>
                    </li>  
                    <li>
                        <a href="javascript:;">
                            <div class="l_img_box">
                                <img src="./img/main/paragliding.jpg" alt="">
                            </div>
                            <span>페러글라이딩</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="l_img_box">
                                <img src="./img/main/horse.png" alt="">
                            </div>
                            <span>말타기</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
	},// data
	methods : {
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>