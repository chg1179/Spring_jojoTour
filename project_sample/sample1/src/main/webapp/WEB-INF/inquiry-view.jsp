<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>게시글 상세 페이지</title>
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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div v-if="!showApp">비밀번호 입력 : <input v-model="enteredPwd" @keyup.enter="fnPwd"><button @click="fnPwd">비밀번호 확인</button></div>
			<div v-if="showApp">
				<div>제목 : {{info.iTitle}}</div>
				<div>작성자 : {{info.uId}}</div>
				<div>작성날짜 : {{info.iWriteTime}}</div>
				<div>내용 :<pre v-html="info.iContent"></pre></div>
				<div>
					<button @click="fnEdit" v-if="uId == info.uId" >수정하기</button>
					<button @click="fnAnswer" v-if="status == 'A'" >답변하기</button>
					<button @click="fnBack">되돌아가기</button>
				</div> 
			</div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		info : {},
		iNo : "${map.iNo}",
		status : "${sessionStatus}",
		uId : "${sessionId}",
		iPassword: "${map.iPassword}",      
		enteredPwd: "",
        showApp: false
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {iNo : self.iNo, categoryNo : "UPDATE"};
			$.ajax({
                url : "view.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(self.info);
                	// 공개글이거나, 관리자거나 본인이 작성한 글 일 때 열람 가능
                	if (self.status === 'A' || (self.uId === self.info.uId) || self.iPassword == "") {
                        self.showApp = true;
                    }
                }
            }); 
		},
		 fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {iNo : self.iNo});
	        },
	    fnAnswer : function(iNo,iTitle){
	    	var self = this;
	    	location.href = "answer.do?iNo=" + self.iNo + "&iTitle=" + self.info.iTitle;
	    },

	    //입력한 비밀번호가 같은지 체크
	    fnPwd: function() {
	    	var self = this;
	        if (self.enteredPwd === self.info.iPassword) {
	        	self.showApp = true;
	        	return;
	        } else {
	    		alert("비밀번호가 일치하지 않습니다.");
	        }
		}
	}, // methods

	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>