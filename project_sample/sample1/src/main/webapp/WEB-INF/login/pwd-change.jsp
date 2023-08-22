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
	#pwd_change_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
		margin-top: -100px;
	}
	.pwd_change_wrap input{
        width: 300px;
        height: 30px;
        padding: 0 20px;
        border-radius: 10px;
        outline: none;
        border: 1px solid;
	}
	.pwd_change_id{
		margin-bottom: 20px;
		text-align: center;
	}
	.pwd_change_input{
		margin-bottom: 20px;
	}
	.pwd_change_btn{
		display: flex;
		justify-content: center;
	}
	.pwd_change_btn button{
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
	.pwd_change_btn button:hover{
		background: linear-gradient(to right, #ff9900, #ff3333);
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="pwd_change_container">
			<div class="pwd_change_wrap">
				<div class="pwd_change_id">아이디 : {{userId}}</div>
				<div class="pwd_change_input"><input type="password" v-model="pwd1" placeholder="비밀번호"></div>
				<div class="pwd_change_input"><input type="password" v-model="pwd2" placeholder="비밀번호 확인"></div>
				<div class="pwd_change_btn"><button @click="fnPwdChange">변경하기</button></div>
			</div>
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