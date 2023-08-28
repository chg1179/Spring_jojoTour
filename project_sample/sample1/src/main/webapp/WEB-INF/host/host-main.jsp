<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>호스트 제품 관리 페이지</title>
<style>
	.container{
		margin: 30px auto;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<input type="button" value="숙소관리" @click="fnStayPage"/>
			<input type="button" value="레저관리" @click="fnLeisurePage"/>
			<input type="button" value="렌트카관리" @click="fnRentcarPage"/>
			<input type="button" value="예약상품관리" @click="fnOrderPage"/>
		</div>
	</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		status : "${sessionStatus}"
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