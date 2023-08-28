<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<title>호스트 제품 관리 페이지</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
		background-color: #f2f2f2;
	}
	#host_container{
		margin: 50px auto;
		text-align: center;
		max-width: 900px;
	}
	#host_container input{
		margin: 20px;
		width: 100px;
		height: 40px;
		border-radius: 5px;
		background-color: #213555;
		color: #fff;
		cursor: pointer;
		border: none;
		font-weight: bold;
		box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	}
	.btn-box {
		background-color: #fff;
		width: 100%;
		border-radius: 5px;
		margin: 20px auto;
		text-align: center;
		display: inline-block;
		box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	}
	.btn-box .main-text{
		text-align: center;
		margin-top: 20px; 
		font-size: 13px;
	}
	
	.user-text{
		 font-weight: bold; 
		 font-size: 24px;
	}
	.host-img-box{
		width: 900px;
		box-shadow: 0px 4px -5px rgba(0, 0, 0, 0.1);
		border-radius: 5px;
	}
	.host-img-box img{
		width: 100%;
		height: 100%;
		border-radius: 5px;
		margin-top: 20px;
		margin-bottom: 30px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="host_container">
			<div class="text-box">
				<div class="user-text">{{uId}}님 환영합니다!</div>
			</div>
			<div class="btn-box">
				<div class="main-text">
					<div>당신의 등록상품을 확인하세요.</div>
				</div>
				<input type="button" value="숙소" @click="fnStayPage"/>
				<input type="button" value="레저" @click="fnLeisurePage"/>
				<input type="button" value="렌트카" @click="fnRentcarPage"/>
			</div>
			<div class="btn-box">
				<div class="main-text">
					<div class="main-text">
						<div>고객의 예약 정보를 확인하세요.</div>
					</div>
					<input type="button" value="고객 예약 정보" @click="fnOrderPage"/>
				</div>
			</div>
			<div class="host-img-box">
				<img src="../img/host/host.jpg" alt="호스트 이미지">
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
		status : "${sessionStatus}",
		uId : "${sessionId}"
	},// data
	methods : {
		fnStayPage : function(){
			location.href = "stay.do";
		},
		fnLeisurePage : function(){
			location.href = "leisure.do";
		},
		fnRentcarPage : function(){
			location.href = "rentcar.do";
		},
		fnOrderPage : function(){
			location.href = "order.do";
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../main.do";
		} 
	}// created
});
</script>