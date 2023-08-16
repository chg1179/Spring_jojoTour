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
	<div id="app">
		<div>아이디 : {{userId}}</div>
		<div>바꿀 비번 : <input type="password" v-model="pwd1"></div>
		<div>비번 확인 : <input type="password" v-model="pwd2"></div>
		<button @click="fnPwdChange">변경하기</button>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${map.userId}",
		pwd1 : "",
		pwd2 : ""
		
	},// data
	methods : {
		fnPwdChange : function(){
			var self = this;
			var param = {userId : self.userId, pwd1 : self.pwd1};
			$.ajax({
                url : "/pwd/change.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert(self.userId+"의 비번이 변경되었습니다.");
					location.href="../login.do";
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
		/* self.fnGetList(); */
	}// created
});
</script>