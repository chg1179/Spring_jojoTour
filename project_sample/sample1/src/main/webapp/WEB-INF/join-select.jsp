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
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>회원가입 유형선택</h2>
		<div>개인회원과 호스트 중 원하는 유형을 선택해주세요.</div>
		<button @click="fnJoin('U')">개인 회원가입</button>
		<button @click="fnJoin('H')">호스트 회원가입</button>
	</div>
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