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
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	*{
		margin: 0;
		padding: 0;
	}
	#join_select_container{
		display: flex;
		align-items: center;
		justify-content: center;
	}
	#join_select_container{
		margin: 100px 0;
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


</script>