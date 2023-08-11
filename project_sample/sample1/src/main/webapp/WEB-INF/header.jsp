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
        ul,li{
            list-style: none;
        }
        a{
            text-decoration: none;
            color: inherit;
        }
        img{
            width: 100%;
            height: 100%;
        }
        header{
            background-color: #F86F03;
            position : fixed;
            width : 100%;
            z-index : 1;
        }
        .header_empty_box{
        	height : 100px;
        }
        #header_box{
            display: flex;
            justify-content: space-between;
            padding: 10px;
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
            font-size: 20px;
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
            width: 120px;
            border: 1px solid;
            border-radius: 10px;
            background-color: #fff;
            padding: 10px;
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
<div id="app">
    <header>
        <div id="header_box">
            <div class="logo_box">
                <a href="javascript:;" @click="fnLogo"><img src="img/header/logo.jpg" alt="logo"></a>
            </div>
            <div class="header_menu">
                <div class="header_inner">
                    <ul v-if="uId == ''"class="f_header">
                        <li><a href="javascript:;" @click="fnLogin">로그인</a></li>
                        <li><a href="javascript:;" @click="fnJoin">회원가입</a></li>
                        <li><a href="javascript:;">장바구니</a></li>
                    </ul>
                    <ul v-else class="f_header">
                        <li><a href="javascript:;" @click="fnLogout">로그아웃</a></li>
                        <li><a href="javascript:;" @click="">마이홈</a></li>
                        <li><a href="javascript:;">장바구니</a></li>
                    </ul>
                    <ul class="s_header">
                        <li class="stay">
                            <a href="javascript:;">숙박업소</a>
                            <ul>
                                <li><a href="javascript:;">호텔</a></li>
                                <li><a href="javascript:;">모텔</a></li>
                                <li><a href="javascript:;">게스트하우스</a></li>
                                <li><a href="javascript:;">펜션</a></li>
                            </ul>
                        </li>
                        <li class="header_rentCar">
                            <a href="javascript:;">렌터카</a>
                            <ul>
                                <li><a href="javascript:;">소형차</a></li>
                                <li><a href="javascript:;">중형차</a></li>
                                <li><a href="javascript:;">대형차</a></li>
                                <li><a href="javascript:;">승합차</a></li>
                            </ul>
                        </li>
                        <li class="header_water_leisure">
                            <a href="javascript:;">수상 레저</a>
                            <ul>
                                <li><a href="javascript:;">스노쿨링</a></li>
                                <li><a href="javascript:;">서핑</a></li>
                                <li><a href="javascript:;">요트</a></li>
                                <li><a href="javascript:;">제트스키</a></li>
                            </ul>
                        </li>
                        <li class="header_land_leisure">
                            <a href="javascript:;">지상 레저</a>
                            <ul>
                                <li><a href="javascript:;">ATV</a></li>
                                <li><a href="javascript:;">페러글라이딩</a></li>
                                <li><a href="javascript:;">말타기</a></li>
                            </ul>
                        </li>
                        <li class="header_board">
                            <a href="javascript:;">게시판</a>
                            <ul>
                                <li><a href="javascript:;">공지사항</a></li>
                                <li><a href="javascript:;">1:1문의</a></li>
                                <li><a href="javascript:;">자유게시판</a></li>
                            </ul>
                        </li>
                        <li class="header_more">
                            <a href="javascript:;">더보기</a>
                            <ul>
                                <li><a href="javascript:;">이벤트</a></li>
                                <li><a href="javascript:;">약관 및 정책</a></li>
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
	el : '#app',
	data : {
		list : [],
		uId : "${sessionId}"
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                }
            }); 
        },
        fnLogin :function(){
        	location.href="login.do";
        },
        fnJoin : function(){
        	location.href="join.do";
        },
        fnLogo : function(){
        	location.href="main.do";
        },
        fnLogout : function(){
        	location.href="logout.do";
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>