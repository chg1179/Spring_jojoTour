<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
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
            background-image: url(./img/main/main.jpg);
            background-repeat: no-repeat;
            background-size: cover;
            height: 700px;
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
            background-color: #F86F03;
            background-position: 10px;
            border: none;
            color: #fff;
            font-size: 20px;
            cursor : pointer;
        }
        /* ��� �� */
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
        /* ������ ���� �� */
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
        /* ������ �� */
        #mask_container{
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top : 50px;
            margin-bottom : 50px;
        }
        #mask{
            box-sizing: border-box;
            width: 600px;
            position: relative;
            overflow: hidden;
        }
        #slide_wrap{
            width: 1900px;
            height: inherit;
        }
        #slide_wrap img{
        	width : 600px;
        }

		/* �̹��� ���ư��鼭 �۾� �ø��� */
		.out_box{
			position: relative;
			display: block;
			transform: rotateY(0);
			transition-duration: 0.6s;
			height : 100%;
			width : 100%;
			
		}
		.rotate_box{
		    transform: rotateY(0);
		    transition-duration: 0.6s;
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
			transition-duration: 0.6s;
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
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%-- <%@ include file="header.jsp" %> --%>
	<div id="app">
		<div id="container">
	        <div class="banner_box">
	            <p class="banner_text">
	                ���� ���� ���̳� �������̶� ��������!<br>
	                ������, ����, ������, ����, ����, ����, ��ȭ �� ���� ���࿡ ���ؼ���� � ���̶� �������� ����iN�� �������<br>
	                �������� ���� �������� ����� ���� �� �ƴ� ����̶�� �������Զ� �亯 ���� �� �ֽ��ϴ�
	            </p>
	            <div class="banner_img">
	                <img src="./img/main/banner_text.png" alt="">
	            </div>
	            <h3 class="banner_start">
	                ���� �����ϼ���!
	            </h3>
	            <button class="banner_question" @click="fnFAQ">
	                �����ϱ� >
	                <!-- 1:1���ǰԽ������� ���� -->
	            </button>
	        </div>
	        <div id="mask_container">
		        <div id="mask">
		            <div id="slide_wrap">
		                <a href="javascript:;"><img src="./img/main/slide_leisure.jpg" alt=""></a>
		                <a href="javascript:;"><img src="./img/main/slide_rent_car.jpg" alt=""></a>
		                <a href="javascript:;"><img src="./img/main/slide_stay.jpg" alt=""></a>
		            </div>
		            <div class="slide_btn"></div>
		        </div>
		    </div>
	        <div class="inner_con">
	            <div class="accommodation">
	                <h2 class="accommodation_title" style="margin-top: 50px;">���� ����</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkStayKind('HOTEL')" class="out_box">
								<div class="rotate_box">
									<div class="a_img_box">
										<img class="hotel_img" src="./img/main/hotel.jpg" alt="">
									</div>
								</div>
								<div class="out_box_txt">
									<div>ȣ��</div>
									<div>�����Ϸ� ����</div>
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
									<div>����</div>
									<div>�����Ϸ� ����</div>
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
									<div>�Խ�Ʈ�Ͽ콺</div>
									<div>�����Ϸ� ����</div>
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
									<div>���</div>
									<div>�����Ϸ� ����</div>
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
									<div>ķ��/�۷���</div>
									<div>�����Ϸ� ����</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="retal_car">
	                <h2 class="retal_car_title">����ī ����</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkKind('SMALL')" class="out_box">
								<div class="rotate_box">
									<div class="r_img_box">
										<img src="./img/main/small.png" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>������</div>
									<div>�����Ϸ� ����</div>
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
									<div>������</div>
									<div>�����Ϸ� ����</div>
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
									<div>������</div>
									<div>�����Ϸ� ����</div>
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
									<div>������</div>
									<div>�����Ϸ� ����</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="water_leisure">
	                <h2 class="water_leisure_title">���� ���� ����</h2>
	                <ul>
	                    <li>
	                        <a href="javascript:;" @click="checkWaterKind('SNORKE')" class="out_box">
								<div class="rotate_box">
									<div class="w_img_box">
										<img src="./img/main/snorkeling.jpg" alt="">
									</div>
								</div>
	                            <div class="out_box_txt">
									<div>������</div>
									<div>�����Ϸ� ����</div>
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
									<div>����</div>
									<div>�����Ϸ� ����</div>
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
									<div>��Ʈ</div>
									<div>�����Ϸ� ����</div>
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
									<div>��Ʈ��Ű</div>
									<div>�����Ϸ� ����</div>
								</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="land_leisure">
	                <h2 class="land_leisure_title">���� ���� ����</h2>
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
										<div>�����Ϸ� ����</div>
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
										<div>�䷯�۶��̵�</div>
										<div>�����Ϸ� ����</div>
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
										<div>�¸�</div>
										<div>�����Ϸ� ����</div>
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
		}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
$(document).ready(function(){
    $('.slide_btn').click(function(){
        $('#slide_wrap').animate({
            left: -600
        }, function(){
            $('#slide_wrap').css({left: 0}).find('img').first().appendTo('#slide_wrap');
        });
    });
    function time(){
        auto = setInterval(function(){
            $('.slide_btn').trigger('click');
        },3000);
    }    
    time();
});
</script>