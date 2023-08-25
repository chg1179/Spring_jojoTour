<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="../js/jquery-1.12.4.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	*{
		margin: 0;
		padding: 0;
	}
	#join_select_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
	}
	.join_select_wrap{
		margin-top : -200px;
	}
	.join_select_txt_box{
		background-color: rgba(255, 168, 69, 0.3);
		padding: 30px 50px;
		margin-top: 20px;
		box-sizing: border-box;
		border-radius: 20px;
		margin-bottom: 50px;
	}
	.join_select_txt_box div:first-child{
		font-weight: bold;
		font-size: 20px;
	}
	.join_select_box{
		display: flex;
	}
	.join_select_btn_box{
		border: 1px solid #ccc;
		padding: 40px;
	}
	.select_btn_box{
		display: flex;
		justify-content: center;
	}
	.select_btn_box button{
		width: 100%;
		height: 50px;
		cursor: pointer;
		color: #fff;
		border: none;
		font-size: 16px;
		font-weight: bold;
	}
	.select_user_btn{
		background-color: #F86F03;
	}
	.select_host_btn{
		background-color: #FFA41B;
	}
	.loading_active{
			position : absolute;
			top : 0;
			left : 0;
            display: flex;
            justify-content: center;
            align-items: center;
            width : 100%;
            height: 110vh;
            background-color: rgba(211, 211, 211, 0.4);
            z-index : 99;
        }
        .loading_active .loading{
            /* border: 1px solid black; */
            width: 50px;
            height: 50px;
            border-radius: 50%;
            position: relative;
        }
        .loading_active span{
            display: inline-block;
            background-color: black;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            position: absolute;
            animation: load 1.6s linear infinite;
        }
        .loading_active span:nth-child(1){
            top: 0;
            left: calc(50% - 5px);
            animation-delay: 0s;
        }
        .loading_active span:nth-child(2){
            top: calc(15% - 1.5px);
            left: calc(85% - 8.5px);
            animation-delay: 0.2s;

        }
        .loading_active span:nth-child(3){
            top: calc(50% - 5px);
            left: calc(100% - 10px);
            animation-delay: 0.4s;
        }
        .loading_active span:nth-child(4){
            left: calc(85% - 8.5px);
            top: calc(85% - 8.5px);
            animation-delay: 0.6s;
        }
        .loading_active span:nth-child(5){
            top: calc(100% - 10px);
            left: calc(50% - 5px);
            animation-delay: 0.8s;
        }
        .loading_active span:nth-child(6){
            top: calc(85% - 8.5px);
            left: calc(15% - 1.5px);
            animation-delay: 1s;
        }
        .loading_active span:nth-child(7){
            top: calc(50% - 5px);
            left: 0;
            animation-delay: 1.2s;
        }
        .loading_active span:nth-child(8){
            top: calc(15% - 1.5px);
            left: calc(15% - 1.5px);
            animation-delay: 1.4s;
        }
        @keyframes load{
            0%{
                opacity: 0;
            }
            100%{
                opacity: 1;
            }
        }
        .loading_btn{
            display: none;
        }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="join_select_container">
			<div class="join_select_wrap">
				<h2>회원가입 유형선택</h2>
				<div class="join_select_txt_box">
					<div>개인회원과 호스트 중 원하는 유형을 선택해주세요.</div>
					<div>조조투어는 개인회원과 호스트 두 개의 유형으로 회원가입이 가능합니다.</div>
				</div>
				<div class="join_select_box">
					<div class="join_select_btn_box">
						<div class="join_select_img_box">
							<img src="../img/join/join_user.png" alt="">
						</div>
						<div class="select_btn_box">
							<button class="select_user_btn" @click="fnJoin('U')">개인 회원가입</button>
						</div>
					</div>
					<div class="join_select_btn_box">
						<div class="join_select_img_box">
							<img src="../img/join/join_host.png" alt="">
						</div>
						<div class="select_btn_box">
							<button class="select_host_btn" @click="fnJoin('H')">호스트 회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	    <div class="loading_active">
	        <div class="loading">
	            <span></span>
	            <span></span>
	            <span></span>
	            <span></span>
	            <span></span>
	            <span></span>
	            <span></span>
	            <span></span>
	        </div>
	    </div>
    <div class="loading_btn">사라져</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : ""
	},// data
	methods : {
		fnJoin : function(status){
			$.pageChange("acess.do", {status : status});
		}
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
$(document).ready(function(){
    setTimeout(function(){
        $('.loading_btn').click(function(){
        $('.loading_active').fadeOut();
    });
        $('.loading_btn').trigger('click');
    },2500);
});

</script>