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
		<h2>ȸ������ ��������</h2>
		<div>����ȸ���� ȣ��Ʈ �� ���ϴ� ������ �������ּ���.</div>
		<button @click="fnJoin('U')">���� ȸ������</button>
		<button @click="fnJoin('H')">ȣ��Ʈ ȸ������</button>
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