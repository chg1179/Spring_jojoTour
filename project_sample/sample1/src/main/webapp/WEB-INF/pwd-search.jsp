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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>��й�ȣ ã��</h2>
		<div v-if="messagePwd == ''">
			<div><input type="text" placeholder="���̵� �Է��ϼ���." v-model="userId"></div>
			<div><input type="text" placeholder="�ڵ��� ��ȣ�� �Է��ϼ���." v-model="phone"></div>
			<button @click="fnPwdSearch">��й�ȣ ã��</button>
		</div>
		<div v-else>
			<div>������ ��й�ȣ�� {{messagePwd}} �Դϴ�.</div>
			<div>�����Ͻðڽ��ϱ�?</div>
			<div><button>�����Ϸ� ����</button></div>
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
		phone : "",
		messageId : "",
		messagePwd : ""
	},// data
	methods : {
		fnPwdSearch : function(){
			var self = this;
			var param = {userId : self.userId, phone : self.phone};
			$.ajax({
                url : "pwdSearch.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.messageId = data.messageId;
                	self.messagePwd = data.messagePwd;
                	console.log(data.messageId);
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>