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
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
    *{
        margin: 0;
        padding: 0;
    }
    #id_search_wrap{
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin-top : -100px;
    }
    .id_search_inner{
        text-align: center;
    }
    .id_search_title{
        margin: 20px 0;
    }
    .id_search_input{
        margin-bottom: 20px;
    }
    .id_search_input input{
        width: 300px;
        height: 30px;
        padding: 0 20px;
        border-radius: 10px;
        outline: none;
        border: 1px solid;
    }
    .id_search_btn_box{
        display: flex;
        justify-content: space-around;
    }
    .id_search_btn_box button{
        width: 120px;
        height: 30px;
        border-radius: 10px;
        outline: none;
        border: none;
        cursor: pointer;
        background-color: rgb(82, 82, 82);
        color: white;
    }
    .id_search_btn_box button:hover{
        background: linear-gradient(to right, #ff9900, #ff3333);
    }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
        <div id="id_search_wrap">
            <div class="id_search_inner">
                <h2 class="id_search_title">���̵� ã��</h2>
                <div v-if="message == ''">
                    <div class="id_search_name id_search_input"><input type="text" placeholder="�̸��� �Է��ϼ���." v-model="name"></div>
                    <div class="id_search_phone id_search_input"><input type="text" placeholder="�ڵ��� ��ȣ�� �Է��ϼ���." v-model="phone"></div>
                    <div class="id_search_btn_box">
                        <button class="id_search_btn" @click="fnIdsearch">���̵� �˻�</button>
                        <button class="id_search_btn" @click="fnPwdSearch">��й�ȣ ã��</button>
                    </div>
                </div>
                <div v-else>
                    <div>ȸ������ ������ ��ġ�ϴ� ���̵� �Դϴ�.</div>
                    <div style="margin-bottom : 20px;">ȸ�� ���̵� : {{message}}</div>
                    <div class="id_search_btn_box">
                        <button class="id_search_btn" @click="fnPwdSearch">��й�ȣ ã��</button>
                        <button class="id_search_btn" @click="fnLogin">�α��� �Ϸ�����</button>
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
		name : "",
		phone : "",
		message : "",
		confirm : ""
	},// data
	methods : {
		fnIdsearch : function(){
			var self = this;
			if(self.name == ''){
				alert("�̸��� �Է��ϼ���.");
				return;
			}
			if(self.phone == ''){
				alert("�ڵ��� ��ȣ�� �Է��ϼ���.");
				return;
			}
			
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
			var self = this;
			$.pageChange("pwd/search.do", {userId : self.message});
		}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>
