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
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
</style>
</head>
<body>
	<div id="app">
		<div v-if="message == ''">
			<div><input type="text" placeholder="이름을 입력하세요." v-model="name"></div>
			<div><input type="text" placeholder="핸드폰 번호를 입력하세요." v-model="phone"></div>
			<button @click="fnIdsearch">아이디 검색</button>
			<button @click="fnPwdSearch">비밀번호 찾기</button>
		</div>
		<div v-else>
			<div>회원님의 정보와 일치하는 아이디 입니다.</div>
			<div>회원 아이디 : {{message}}</div>
			<button @click="fnPwdSearch">비밀번호 찾기</button>
			<button @click="fnLogin">로그인 하러가기</button>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		name : "",
		phone : "",
		message : "",
		confirm : ""
	},// data
	methods : {
		fnIdsearch : function(){
			var self = this;
			
			var param = {name : self.name, phone : self.phone};
			$.ajax({
                url : "id-search.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.message = data.message;
                	self.confirm = data.confirm;
                	alert(self.confirm);
					console.log(data);
                }
            }); 
		},
		fnLogin : function(){
			location.href="login.do";
		},
		fnPwdSearch : function(){
			location.href="pwd-search.do";
		}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>
