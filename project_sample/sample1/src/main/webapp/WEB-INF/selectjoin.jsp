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

</style>
</style>
</head>
<body>
<div id="app">
	<div>
		<button @click="fnUserJoin">�Ϲ�ȸ�� ȸ������</button>
		<button @click="fnHostJoin">ȣ��Ʈ ȸ������</button>
	</div>

</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
	},// data
	methods : {
		fnUserJoin : function(){
			location.href = "userjoin.do"
		},
		fnHostJoin : function(){
			location.href = "hostjoin.do"
		}

		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>