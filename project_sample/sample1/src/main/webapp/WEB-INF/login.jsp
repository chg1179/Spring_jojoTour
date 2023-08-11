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
</head>
<body>
<div id="app">
	<div>
		<input type="radio" name="selectLogin" id="user" value="U" v-model="status" checked>
		<label for="user">일반회원</label>
		<input type="radio" name="selectLogin" id="host" value="H" v-model="status">
		<label for="host">숙박/레저</label>
		<input type="radio" name="selectLogin" id="rentCar" value="R" v-model="status">
		<label for="rentCar">렌터카</label>
		<input type="radio" name="selectLogin" id="admin" value="A" v-model="status">
		<label for="admin">관리자</label>
	</div>
	<div v-if="status == 'H' || status == 'R'">
		<label>사업자 등록번호 : <input v-model="userId"></label>
	</div>
	<div v-else>
		<label>아이디 : <input v-model="userId"></label>
	</div>
	<div>
		<label>패스워드 : <input type="password" v-model="pwd"></label>
	</div>
	<div>
		<button @click="fnLogin">로그인</button>
		<a href="javascript:;" @click="fnSearch">아이디/비밀번호 찾기</a>
		<a href="javascript:;" @click="fnJoin">회원가입</a>
	</div>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "",
		pwd : "",
		status: ""
	},// data
	methods : {
		fnLogin : function(){
			var self = this;
			var param = {userId : self.userId, pwd : self.pwd, status : self.status};
			$.ajax({
                url : "login.dox",
                dataType:"json",	 
                type : "POST",
                data : param,
                success : function(data) {
                	console.log(data);
                	if(data.success){
                		alert(data.message);
                		location.href="main.do"; 
                	} else {
                		alert(data.message);
                	}
                }
            }); 
		},
		fnSearch : function(){
			location.href='id-search.do';
		},
		fnJoin : function(){
			location.href='join-acess.do';
		}
	}, // methods
	created : function() {
		var self = this;
	//	self.fnGetList();
	}// created
});
</script>