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
        /* ��� �� */
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
        /* ���ҿ��� �� */
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
        /* ����ī ���� �� */
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
        /* ������ ���� �� */
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
                ���� ���� ���̳� �������̶� ��������!<br>
                ������, ����, ������, ����, ����, ����, ��ȭ �� ���� ���࿡ ���ؼ���� � ���̶� ���ְ��� ����iN�� �������<br>
                �������� ���� �������� ����� ���ָ� �� �ƴ� ����̶�� �������Զ� �亯 ���� �� �ֽ��ϴ�
            </p>
            <div class="banner_img">
                <img src="./img/main/banner_text.png" alt="">
            </div>
            <h3 class="banner_start">
                ���� �����ϼ���!
            </h3>
            <button class="banner_question">
                �����ϱ� >
                <!-- 1:1���ǰԽ������� ���� -->
            </button>
        </div>
        <div class="inner_con">
            <div class="accommodation">
                <h2 class="accommodation_title">���� ����</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/hotel.png" alt="">
                            </div>
                            <span>ȣ��</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/motel.png" alt="">
                            </div>
                            <span>����</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/guest_house.png" alt="">
                            </div>
                            <span>�Խ�Ʈ�Ͽ콺</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/pension.png" alt="">
                            </div>
                            <span>���</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="a_img_box">
                                <img src="./img/main/camping.png" alt="">
                            </div>
                            <span>ķ��/�۷���</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="retal_car">
                <h2 class="retal_car_title">����ī ����</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/small.png" alt="">
                            </div>
                            <span>������</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/midium.png" alt="">
                            </div>
                            <span>������</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/large.png" alt="">
                            </div>
                            <span>������</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="r_img_box">
                                <img src="./img/main/very_large.png" alt="">
                            </div>
                            <span>������</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="water_leisure">
                <h2 class="water_leisure_title">���� ���� ����</h2>
                <ul>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/snorkeling.jpg" alt="">
                            </div>
                            <span>������</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/surfing.jpg" alt="">
                            </div>
                            <span>����</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/yarcht.jpg" alt="">
                            </div>
                            <span>��Ʈ</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="w_img_box">
                                <img src="./img/main/jetSki.jpg" alt="">
                            </div>
                            <span>��Ʈ��Ű</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="land_leisure">
                <h2 class="water_leisure_title">���� ���� ����</h2>
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
                            <span>�䷯�۶��̵�</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <div class="l_img_box">
                                <img src="./img/main/horse.png" alt="">
                            </div>
                            <span>��Ÿ��</span>
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