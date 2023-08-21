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
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>비밀번호 찾기</h2>
		<div v-if="messagePwd == '' || messagePwd == undefined">
			<div>아이디 : <input type="text" placeholder="아이디를 입력하세요." v-model="userId" value="userId"></div>
			<div>핸드폰 번호 : <input type="text" placeholder="핸드폰 번호를 입력하세요." v-model="phone"></div>
			<button @click="fnPwdSearch">비밀번호 찾기</button>
		</div>
		<div v-else>
			<div>귀하의 비밀번호는 {{messagePwd}} 입니다.</div>
			<div>변경하시겠습니까?</div>
			<div><button @click="fnPwdChange">변경하러 가기</button></div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${map.userId}",
		phone : "",
		messageId : "",
		messagePwd : ""
	},// data
	methods : {
		fnPwdSearch : function(){
			var self = this;
			var param = {userId : self.userId, phone : self.phone};
			if(self.userId == ''){
				alert("아이디를 입력하세요.");
				return;
			}
			if(self.phone == ''){
				alert("핸드폰 번호를 입력하세요.");
				return;
			}
			$.ajax({
                url : "/pwd/search.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.messageId = data.messageId;
                	self.messagePwd = data.messagePwd;
                	self.confirm = data.confirm;
                	console.log(self.messageId);
                	alert(self.confirm);
                }
            }); 
		},
		fnPwdChange : function(){
			var self = this;
			console.log(self.userId);
			$.pageChange("/pwd/change.do", {userId : self.userId});
		}
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>