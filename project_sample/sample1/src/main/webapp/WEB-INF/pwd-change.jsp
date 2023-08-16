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
		<div>���̵� : {{userId}}</div>
		<div>�ٲ� ��� : <input type="password" v-model="pwd1"></div>
		<div>��� Ȯ�� : <input type="password" v-model="pwd2"></div>
		<button @click="fnPwdChange">�����ϱ�</button>
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
					alert(self.userId+"�� ����� ����Ǿ����ϴ�.");
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