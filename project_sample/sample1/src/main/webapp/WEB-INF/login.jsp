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
		<label for="user">�Ϲ�ȸ��</label>
		<input type="radio" name="selectLogin" id="host" value="H" v-model="status">
		<label for="host">����/����</label>
		<input type="radio" name="selectLogin" id="rentCar" value="R" v-model="status">
		<label for="rentCar">����ī</label>
		<input type="radio" name="selectLogin" id="admin" value="A" v-model="status">
		<label for="admin">������</label>
	</div>
	<div v-if="status == 'H' || status == 'R'">
		<label>����� ��Ϲ�ȣ : <input v-model="userId"></label>
	</div>
	<div v-else>
		<label>���̵� : <input v-model="userId"></label>
	</div>
	<div>
		<label>�н����� : <input type="password" v-model="pwd"></label>
	</div>
	<div>
		<button @click="fnLogin">�α���</button>
		<a href="javascript:;" @click="fnSearch">���̵�/��й�ȣ ã��</a>
		<a href="javascript:;" @click="fnJoin">ȸ������</a>
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