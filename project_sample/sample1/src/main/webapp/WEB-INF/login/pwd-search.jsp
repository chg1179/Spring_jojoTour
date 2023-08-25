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
	#pwd_search_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
		margin-top: -100px;
	}
	.pwd_search_wrap h2{
		text-align: center;
		width: 100%;
		margin-bottom: 20px;
	}
	.pwd_search_wrap input{
        width: 300px;
        height: 30px;
        padding: 0 20px;
        border-radius: 10px;
        outline: none;
        border: 1px solid;
	}
	.pwd_search_input{
		margin-bottom: 20px;
	}
	.pwd_search_btn{
		display: flex;
		justify-content: center;
	}
	.pwd_search_btn button{
		width: 80%;
		padding: 10px 20px;
		border-radius: 20px;
		border: none;
		cursor: pointer;
        background-color: rgb(82, 82, 82);
		color: #fff;
		font-weight: bold;
		font-size: 16px;
	}
	.pwd_search_btn button:hover{
		background: linear-gradient(to right, #ff9900, #ff3333);
	}
	.pwd_search_alert{
		margin : 20px;
	}

</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="pwd_search_container">
			<div class="pwd_search_wrap">
				<h2>��й�ȣ ã��</h2>
				<div v-if="messagePwd == '' || messagePwd == undefined">
					<div class="pwd_search_input"><input type="text" placeholder="���̵� �Է��ϼ���." v-model="userId" value="userId"></div>
					<div class="pwd_search_input"><input type="text" placeholder="�ڵ��� ��ȣ�� �Է��ϼ���." v-model="phone" @keyup.enter="fnPwdSearch"></div>
					<div class="pwd_search_btn"><button @click="fnPwdSearch">��й�ȣ ã��</button></div>
				</div>
				<div v-else>
					<div class="pwd_search_alert">
						<div>������ ��й�ȣ�� {{messagePwd}} �Դϴ�.</div>
						<div>�����Ͻðڽ��ϱ�?</div>
					</div>
					<div class="pwd_search_btn"><button @click="fnPwdChange">�����Ϸ� ����</button></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
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
				alert("���̵� �Է��ϼ���.");
				return;
			}
			if(self.phone == ''){
				alert("�ڵ��� ��ȣ�� �Է��ϼ���.");
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