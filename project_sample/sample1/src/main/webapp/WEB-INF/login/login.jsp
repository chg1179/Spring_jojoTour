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
    *{
        margin: 0;
        padding: 0;
    }
    a{
        text-decoration: none;
        color: inherit;
    }
    #login_container{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .login_box{
        background-color: #FFA41B;
        width: 500px;
        border: 1px solid;
    }
    .login_tab{
        display: flex;
    }
    .login_tab label{
        display: block;
        cursor: pointer;
        box-sizing: border-box;
        margin-bottom: 20px;
        width: 33.333%;
        text-align: center;
        padding: 10px 0;
		border-right : 1px solid;
    }
    .login_tab label:last-child{
    	border-right : none;
    }
    .login_tab input{
        display: none;
    }
    .login_tab label{
        background-color: #ccc;
    }
    .login_tab input:checked + label{
        background-color: #FFA41B;
    }
    .login_background{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .login_num, .login_id, .login_pwd{
        margin: 10px 0;
    }
    .login_back_inner div input{
        width: 300px;
        height: 30px;
        padding: 0 20px;
        border-radius: 10px;
        border: 1px solid;
        outline: none;
    }
    .login_button{
    	display : flex;
    	justify-content: center;
    }
    .login_button button{
        width: 300px;
        background-color: rgb(82, 82, 82);
        border: none;
        color: white;
        height: 30px;
        border-radius: 10px;
        font-weight: 700;
        margin: 20px 0;
        cursor: pointer;
    }
    .login_a{
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
        margin-bottom: 30px;
    }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	    <div id="login_container">
	        <div class="login_box">
	            <div class="login_tab">
	                <input type="radio" name="selectLogin" id="user" @input="checkStatus('U')" checked="checked">
	                <label for="user">일반회원</label>
	                <input type="radio" name="selectLogin" id="host" @input="checkStatus('H')">
	                <label for="host">호스트</label>
	                <input type="radio" name="selectLogin" id="admin" @input="checkStatus('A')">
	                <label for="admin">관리자</label>
	            </div>
	            <div class="login_background">
	                <div class="login_back_inner">
	                    <div class="login_id">
	                        <label><input v-model="userId" placeholder="아이디"></label>
	                    </div>
	                    <div class="login_pwd">
	                        <label><input type="password" v-model="pwd" placeholder="패스워드"  @keyup.enter="fnLogin"></label>
	                    </div>
	                    <div class="login_button">
	                        <button @click="fnLogin">로그인</button>
	                    </div>
	                    <div class="login_a">
	                        <a href="javascript:;" @click="fnSearch">아이디/비밀번호 찾기</a>
	                        <a href="javascript:;" @click="fnJoin">회원가입</a>
	                    </div>
	                </div>
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
		userId : "",
		pwd : "",
		status: "",
		user : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "loginCheck.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.status = "U";
                }
            }); 
		},
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
			location.href='join/select.do';
		},
		checkStatus : function(status){ //라디오박스를 선택할 때 마다 status 값 변경
        	var self = this;
        	self.status = status;
        }
	}, // methods
	created : function() {
		var self = this;
	    self.fnGetList();
	}// created
});
</script>