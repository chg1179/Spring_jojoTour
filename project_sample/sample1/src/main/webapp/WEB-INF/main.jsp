<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />

<link href="../css/main.css" rel="stylesheet"/>
   
<meta charset="EUC-KR">
<title>JOJO TOUR</title>
<style>
		/* �������� ���� */
		.swiper {
          width: 100%;
          height: 100vh;
          margin-top: -100px;
        }
    	.swiper-wrapper {
    	height:100vh;
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
          background: url(./img/main/img1.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-2{
          background: url(./img/main/img2.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-3{
          background: url(./img/main/img3.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-4{
          background: url(./img/main/img4.jpg) no-repeat center;
          background-size: cover;
        }
        .slide-5{
          background: url(./img/main/img5.jpg) no-repeat center;
          background-size: cover;
        }
        .swiper-pagination-bullet-active{
          background-color: #000;
        }

		.swiper-horizontal>.swiper-pagination-bullets, .swiper-pagination-bullets.swiper-pagination-horizontal, .swiper-pagination-custom, .swiper-pagination-fraction {
	    bottom: var(--swiper-pagination-bottom,85px);
	    top: var(--swiper-pagination-top,auto);
	    left: 0;
	    width: 100%;
		}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div class="swiper mySwiper banner_box">
				<div class="banner_inbox">
					<p class="banner_text">
						���� ���� ���̳� �������̶� ��������!<br>
						������, ����, ������, ����, ����, ����, ��ȭ �� ���� ���࿡ ���ؼ���� � ���̶� �������� ����iN�� �������<br>
						�������� ���� �������� ����� ���� �� �ƴ� ����̶�� �������Զ� �亯 ���� �� �ֽ��ϴ�<br>
						���ݹٷ� �����ϼ���!!
					</p>
					<div class="banner_img">
						<img src="./img/main/banner_text.png" alt="">
					</div>
					<h3 class="banner_start">
						<!-- <span>���� �����ϼ���!</span> -->
					</h3>
					<button class="banner_question">
						�����ϱ� >
						<!-- 1:1���ǰԽ������� ���� -->
					</button>
				</div>
				<div class="swiper-wrapper">
					<div class="swiper-slide slide-1">
					</div>
					<div class="swiper-slide slide-2">
					</div>
					<div class="swiper-slide slide-3">
					</div>
					<div class="swiper-slide slide-4">
					</div>
					<div class="swiper-slide slide-5">
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="link_list">
				<ul>
					<li>
						<a href="javascript:;" @click="fnStay">����</a>
						
					</li>
					<li>
						<a href="javascript:;" @click="fnRentCar">����ī</a>
						<span></span>
					</li>
					<li>
						<a href="javascript:;" @click="fnWaterLeisure">���� ����</a>
						<span></span>
					</li>
					<li>
						<a href="javascript:;" @click="fnGroundLeisure">���� ����</a>
						<span></span>
					</li>
				</ul>
			</div>


	        <div class="inner_con">
	            <div class="accommodation">
	                <h2 class="accommodation_title" style="margin-top: 50px;">���� ����</h2>
	                <ul>
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkStayKind('HOTEL')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkStayKind('MOTEL')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkStayKind('GUEST')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkStayKind('PENSION')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkStayKind('CAMPING')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkKind('SMALL')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkKind('MIDDLE')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkKind('LARGE')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkKind('VAN')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkWaterKind('SNORKE')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkWaterKind('SURFING')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkWaterKind('YACHT')" class="out_box">
								<div class="scale_box">
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
	                    <li class="shadow_class">
	                        <a href="javascript:;" @click="checkWaterKind('JETSKI')" class="out_box">
								<div class="scale_box">
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
							<li class="shadow_class">
								<a href="javascript:;" @click="checkGroundKind('ATV')" class="out_box">
									<div class="scale_box">
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
							<li class="shadow_class">
								<a href="javascript:;" @click="checkGroundKind('GLIDER')" class="out_box">
									<div class="scale_box">
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
							<li class="shadow_class">
								<a href="javascript:;" @click="checkGroundKind('HORSE')" class="out_box">
									<div class="scale_box">
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
      // //�����̴� ������ ������ ��������
      // spaceBetween: 30,
      // //�����̴� �ϳ� ���̿� ���鰪�� ��������
      // slidesPerGroup: 1,
      // // �Ѿ �����̵� ������ �׷����� ���� ����
      loop : true, // �����̵� �ݺ�����
      speed : 2000, //�Ѿ�� �����̵��� duration��
      autoplay:{
        //�ڵ����� �Ѿ�� �����̵�
        delay : 2500,
        disableOnInteraction:false
        // �ٸ� ���ͷ��� ����� �ڵ� ���� ����
      },
      pagination: {
        el: ".swiper-pagination",
        //���������̼� ���� ��ư�� ���� �±׼���(���׶� ��ư�� �ǹ�)
        clickable: true,
        // ��ư�� Ŭ�����θ� ������
      }
    });
</script>