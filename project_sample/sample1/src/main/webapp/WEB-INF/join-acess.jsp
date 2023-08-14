<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div><label><input type="checkbox" v-model="acess" value="1">동의</label></div>
		<div><label><input type="checkbox" v-model="acess" value="2">동의</label></div>
		
		<div>
			<label><input type="radio" v-model="acessRadio" value="3" name="agree">동의</label>
			<label><input type="radio" v-model="acessRadio" value="4" name="agree">동의하지 않음</label>
		</div>
		<div v-if="status == 'U'">
			<button @click="fnAcess">14세 이상 회원가입</button>
			<button v-else @click="fnAcess">14세 미만 회원가입</button>
		</div>
		<div v-else>
			<button @click="fnAcess">호스트 회원가입</button>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		acess : [],
		acessRadio : "",
		status : "${map.status}"
	},// data
	methods : {
		fnAcess : function(){
			var self = this;
			console.log(self.acessRadio[0]);
			if(self.acess[0] == null){
				alert("회원가입 약관에 동의하셔야 합니다.");
				return;
			}else if(self.acess[1] == null){
				alert("개인정보 수집·이용 동의를 하셔야 회원가입이 가능합니다.");
				return;
			}else if(self.acessRadio[0] == null){
				alert("이메일·문자 수신 동의를 선택해주세요.");
				return;
			}else{
				$.pageChange("../join.do", {status : status});
			}

		}
	}, // methods
	created : function() {
		var self = this;
	//	self.fnGetList();
	}// created
});
</script>