<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-1.12.4.js"></script>
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
            height: 100px;
            padding-top: 50px;
        }
        .banner_text{
            text-align: center;
            font-size: 40px;
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
        
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<%-- <%@ include file="header.jsp" %> --%>
<div id="app">
	<div id="container">
        <div class="banner_box">
            <p class="banner_text">
                호텔
            </p>
        </div>
    </div>
    <ul>
    	<li></li>
    	<li></li>
    	<li></li>
    </ul>
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