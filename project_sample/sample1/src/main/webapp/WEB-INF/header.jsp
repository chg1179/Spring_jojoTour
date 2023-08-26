<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
		*{
            margin: 0;
            padding: 0;
        }
        ul,li{
            list-style: none;
        }
        a{
            text-decoration: none;
            color: inherit;
            margin:10px;
        }
		img {
		    width: 150%;
		    height: 110%;
		}
        header{
        	background-color : #213555;
            /* background: linear-gradient(30deg, #FA163F, #0FABBC 55%); */
            position : fixed;
            width : 100%;
            z-index : 999;
        }
        .header_empty_box{
        	height : 100px;
        }
        #header_box{
            display: flex;
            justify-content: space-between;
            padding: 20px 5px;
            box-sizing: border-box;
            margin: 0 auto;
        }
        .logo_box{
            width: 80px;
            height: 80px;
        }
        .header_menu{
            display: flex;
            align-items: top;
            color: #FFF6F4;
        }
        .header_menu ul{
            display: flex;
            justify-content: end;
        }
        .header_menu ul li{
            margin-right: 20px;
        }
        .f_header{
            font-size: 12px;
            margin-bottom: 30px;
            font-weight: 700;
        }
        .f_header>li>a:hover{
            color: yellow;
        }
        .s_header{
            font-size: 18px;
            font-weight: 700;
            cursor: context-menu;
        }
        .s_header>li{
            position: relative;
        }
        .s_header>li>a:hover{
            color: yellow;
        }
        
        .s_header>li:hover ul{
            display: block;
        }
        .s_header>li ul{
            display: block;
            position: absolute;
            color: black;
            width: 161px;
            border: 1px solid;
            border-radius: 10px;
            background-color: #fff;
            padding: 5px;
            display: none;

        }
        .s_header>li ul li{
            margin-bottom: 5px;
        }
        .s_header>li ul li:hover{
            color: #F86F03;
        }
        .header_more ul{
            right: 0;
        }
        .header_more ul li{
            width: 200px;
        }
</style>
</head>
<body>
	<div id="header">
	    <header>
	        <div id="header_box">
	            <div class="logo_box">
	                <a href="javascript:;" @click="fnLogo"><img src="/img/header/logo2.png" alt="logo"></a>
	            </div>
	            <div class="header_menu">
	                <div class="header_inner">
	                    <ul class="f_header">
	                        <li v-if="status==''">
	                        	<a href="javascript:;" @click="fnLogin">로그인</a>
	                        </li>
	                        <li v-if="status==''">
	                        	<a href="javascript:;" @click="fnJoin">회원가입</a>
	                        </li>
	                        <li v-else>
	                        	<a href="javascript:;" @click="fnLogout">로그아웃</a>
	                        </li>
	                        <li v-if="status == 'H' || status == 'U'">
	                        	<a href="javascript:;" @click="fnMyHome">마이홈</a>
	                        </li>
	                        <li><a href="javascript:;" @click="fnJJim">찜목록</a></li>
	                        <li><a href="javascript:;" @click="fnCart">장바구니</a></li>
	                        <li v-if="status == 'H'">
	                        	<a href="javascript:;" @click="fnProduct">상품관리</a>
	                        </li>
	                        <li v-if="status == 'A'">
	                        	<a href="javascript:;" @click="fnAdminPage">관리 페이지</a>
	                        </li>
	                    </ul>
	                    <ul class="s_header">
	                        <li class="stay">
	                            <a href="javascript:;" @click="fnStay">숙박</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkStayKind('HOTEL')">호텔</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('MOTEL')">모텔</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('GUEST')">게스트하우스</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('PENSION')">펜션</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('CAMPING')">캠핑</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_rentCar">
	                            <a href="javascript:;" @click="fnRentCar">렌터카</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkKind('SMALL')">소형차</a></li>
	                                <li><a href="javascript:;" @click="checkKind('MIDDLE')">중형차</a></li>
	                                <li><a href="javascript:;" @click="checkKind('LARGE')">대형차</a></li>
	                                <li><a href="javascript:;" @click="checkKind('VAN')">승합차</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_water_leisure">
	                            <a href="javascript:;" @click="fnWaterLeisure">수상 레저</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkWaterKind('SNORKE')">스노쿨링</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('SURFING')">서핑</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('YACHT')">요트</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('JETSKI')">제트스키</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_land_leisure">
	                            <a href="javascript:;" @click="fnGroundLeisure">지상 레저</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkGroundKind('ATV')">ATV</a></li>
	                                <li><a href="javascript:;" @click="checkGroundKind('GLIDER')">페러글라이딩</a></li>
	                                <li><a href="javascript:;" @click="checkGroundKind('HORSE')">승마</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_board">
	                            <a href="javascript:;" @click="fnNotice">게시판</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="fnNotice">공지사항</a></li>
	                                <li><a href="javascript:;" @click="fnFAQ">FAQ 게시판</a></li>
	                                <li><a href="javascript:;" @click="fnInquiry">1:1문의</a></li>
	                                <li><a href="javascript:;" @click="fnFree">자유게시판</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_more">
	                            <a href="javascript:;">더보기</a>
	                            <ul>
	                                <li><a href="/terms.do">약관 및 정책</a></li>
	                            </ul>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </header>
	    <div class="header_empty_box"></div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#header',
	data : {
		status : "${sessionStatus}"
	},// data
	methods : {
        fnLogin :function(){
        	location.href="/login.do";
        },
        fnJoin : function(){
        	location.href="/join/select.do";
        },
        fnCart : function(){
        	if(this.status=="" || this.status == null){
        		alert("로그인 후 이용이 가능합니다.");
        		location.href="/login.do";
        		return;
        	} 
        	location.href="/cart.do";
        },
        fnLogo : function(){
        	location.href="/main.do";
        	/* ../main.do로 가면 경로가 한번 거쳐서 나감 */
        },
        fnLogout : function(){
        	location.href="/logout.do";
        },
        fnNotice : function(){
        	location.href="/notice/list.do";
        },
        fnFAQ : function(){
        	location.href="/faq/list.do";
        },
        //관리 페이지
        fnAdminPage : function(){
        	location.href="/admin/user.do";
        },
        //상품관리페이지
        fnProduct : function(){
        	location.href="/host/main.do";
        },
        fnMyHome : function(){
        	location.href="/my/order.do";
        },
        fnInquiry : function(){
            location.href="/inquiry/list.do";
        },
        fnFree : function(){
        	location.href="/free/list.do";
        },
        fnReview : function(){
        	location.href="/review/list.do";
        },
        fnRentCar : function(){
        	location.href="/rentcar.do";
        },
		checkKind : function(kind){
			$.pageChange("/rentcar.do", {rentKind : kind});
		},
        fnJJim : function(){
        	if(this.status=="" || this.status == null){
        		alert("로그인 후 이용이 가능합니다.");
        		location.href="/login.do";
        		return;
        	} 
        	location.href="/my/jjim.do";
        },
        fnWaterLeisure : function(){
        	location.href="/water/leisure.do";
        },
		checkWaterKind : function(kind){
			$.pageChange("/water/leisure.do", {leisureKind : kind});
		},
        fnGroundLeisure : function(){
        	location.href="/ground/leisure.do";
        },
		checkGroundKind : function(kind){
			$.pageChange("/ground/leisure.do", {leisureKind : kind});
		},
		fnStay : function(){
			location.href="/stay.do";
		},
		checkStayKind : function(kind){
			var self = this;
			$.pageChange("/stay.do", {stayKind : kind});
		},
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>