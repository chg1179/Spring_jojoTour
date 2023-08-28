<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Admin Main Page</title>
<style>
	#app {
		margin : 20px auto;
		text-align: center;
		height:80vh;
	}
	#app input {
		margin : 50px;
		width : 200px;
		height : 200px;
		border : 1px solid #dddddd;
		border-radius : 10px;
		background-color: "#dddddd";
		transition: background-color 0.3s;
	}
	#app input:hover{
		background-color: white;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<jsp:include page="adminbar.jsp" flush="true"></jsp:include>
	<div id="app">
		<input type="button" value="회원 및 호스트 관리" @click="fnUserPage" style="font-size : 20px">
		<input type="button" value="패키지 신청 목록" @click="fnPackageReq" style="font-size : 20px">
		<input type="button" value="패키지 목록" @click="fnPackage" style="font-size : 20px">
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
		fnUserPage : function(){
			location.href = "/admin/user.do";
		},
		fnPackageReq : function(){
			location.href = "/admin/packagereq.do";
		},
		fnPackage : function(){
			location.href = "/admin/packagelist.do";
		}
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		if(self.status != 'A'){
			alert("권한 없음");
			location.href="../main.do";
		} 
	}// created
});
</script>