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
		<button @click="fnUserLogin">�α���</button>
		<button @click="fnHostLogin">ȣ��Ʈ �α���</button>
	</div>
		<button @click="fnJoin">ȸ������</button>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
	},// data
	methods : {
		fnUserLogin : function(){
			location.href = "userlogin.do"
		},
		fnHostLogin : function(){
			location.href = "hostlogin.do"
		},
		fnJoin : function(){
			location.href = "selectjoin.do"
		}
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>