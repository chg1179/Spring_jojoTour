<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<meta charset="EUC-KR">
<title>1:1 문의 작성</title>
<style>
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
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div>
				<label>제목 : <input v-model="info.iTitle" maxlength="40" @input="handleTitleInput"></label>
				<label><input type="checkbox" v-model="fnSecret"> 비밀글</label>
				<div>
					<vue-editor v-model="info.iContent" maxlength="500"></vue-editor>
				</div>
				<div v-if="privateYN=='Y'">
					<label>비밀번호 <input v-model="info.iPassword" type="password"></label>
				</div>
				<div class="btns">
					<button v-if="answer == 'A'" @click="fnAdd">답변등록</button>
					<button v-else-if="iNo == ''" @click="fnAdd">등록</button>
					<button v-else-if="iNo !='' && info.answerYn=='N'" @click="fnEdit">수정</button>
					<button @click="fnBack">뒤로가기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({
	el : '#app',
	data : {
		uId:"${sessionId}",
		iNo : "${map.iNo}", // 등록
		maxINo : "",		// 수정
		answer : "${map.answer}", //관리자만 답글 작성 가능
		privateYN : "Y", // Y면 글 비공개
		cnt : "${map.cnt}", // 작성된 글이 하나도 없으면(0이면) pk 1부터 시작
		maxINo : "",
		info : {
			iTitle : "[비밀]",
			iContent : "",
			iPassword : "",
			answerYn : "" //기존에 답변을 했으면 글 수정 불가능
		},
		anYn : "N",
		fnSecret : true
	},// data
	components: {VueEditor},
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {iNo : self.iNo, kind : "UPDATE"};
			$.ajax({
				url : "view.dox",
	            dataType:"json",	
	            type : "POST",
	            data : param,
	            success : function(data) { 
	             	self.info = data.info;
	             	console.log(data.info);
	             	
	             	if(self.answer=='A'){
	             		self.info.iTitle += "글에 답변드립니다!";
	             		self.info.iContent += "<br>-----------------------------------<br>안녕하세요.<br>조조투어를 이용해주셔서 감사드립니다.<br>";
	             	}
				}
			}); 
		},
		fnGetMaxNo : function(){
			var self = this;
			var param = {};
			$.ajax({
				url : "maxINo.dox",
	            dataType:"json",	
	            type : "POST",
	            data : param,
	            success : function(data) {
	            	if(data.cnt == 0){
	            		self.maxINo = 1; //작성된 글이 하나도 없으면 pk 번호는 1부터 시작
	            	} else {
		             	self.maxINo = data.maxINo;
	             	}
				}
			}); 
		},
		fnAdd : function(){
			var self = this;
			if(self.privateYN == "Y"){
				if(self.info.iTitle.length < 5){
					alert("제목을 입력해주세요.");
					return;
				}
			} else if(self.privateYN == "N"){
				if(self.info.iTitle == ""){
					alert("제목을 입력해주세요.");
					return;
				}
			}
			if(self.info.iContent == ""){
				alert("내용을 입력해주세요.");
				return;
			}
			if(self.privateYN=="Y" && self.info.iPassword==""){
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if(!confirm("문의글을 등록하시겠습니까?")){
	        	alert("등록이 취소되었습니다.");
	          	return;
	        }
			
			if(self.answer=='A'){ // 문의글에 대한 관리자의 답변
				// 게시판을 글-답변 순으로 정렬하기 위해 답글은 pk+1
				self.maxINo = parseInt(self.iNo) + 1;
				self.anYn = "A"; //관리자의 답변은 A로 표기
			} else { // 문의 등록 시
				// 문의 답글을 한 테이블에서 작업하는데 정렬하기 위해 MAX PK+2(답글은 pk+1)
	         	self.maxINo = parseInt(self.maxINo) + 2;
			}
			console.log(self.maxINo);
			var param = {
				iNo : self.maxINo,
				uId : self.uId,
				iTitle : self.info.iTitle,
				iContent : self.info.iContent,
				privateYN : self.privateYN,
				iPassword : self.info.iPassword,
				answerYn : self.anYn
			}
			console.log(param);
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					if(self.answer=='A'){
						self.maxINo = parseInt(self.maxINo) - 1;
						self.fnAnswerY(self.maxINo); //관리자가 답변을 등록하면 해당 글을 답변완료 상태로 변경
					}

					alert("1:1 문의글이 등록되었습니다.");
					location.href = "list.do";
                }
            }); 
		},
		fnAnswerY : function(maxINo){
			var self = this;
			var param = {iNo : maxINo, answerYn : "Y"};
			$.ajax({
				url : "editAnswer.dox",
				dataType:"json",	
				type : "POST",
				data : param,
				success : function(data) { 
				}
			}); 
		},
 		fnEdit : function(){
			var self = this;
			if(self.privateYN == "Y"){
				if(self.info.iTitle.length < 5){
					alert("제목을 입력해주세요.");
					return;
				}
			} else if(self.privateYN == "N"){
				if(self.info.iTitle == ""){
					alert("제목을 입력해주세요.");
					return;
				}
			}
			if(self.info.iContent == ""){
				alert("내용을 입력해주세요.");
				return;
			}
			if(self.privateYN=="Y" && self.info.iPassword==""){
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if(!confirm("문의글을 수정하시겠습니까?")){
	        	alert("수정이 취소되었습니다.");
	          	return;
	        }
			var param = self.info;
			$.ajax({
				url : "edit.dox",
				dataType:"json",	
				type : "POST",
				data : param,
				success : function(data) { 
					alert("문의 내용이 수정되었습니다");
	                location.href = "list.do";
				}
			}); 
		},
		fnBack : function(){
			location.href = "list.do";
		},
		handleTitleInput: function() {
		    var self = this;
		    if (self.fnSecret && !self.info.iTitle.includes('[비밀]')) {
		        self.info.iTitle = '[비밀]';
		    }
		}
	}, // methods
	watch : {
	    fnSecret: function(newFnSecret) {
	    	var self = this;
	        if (!newFnSecret) {
	        	self.info.iTitle = "";
	        	self.info.iPassword = "";
	        	self.privateYN = "N";
	        } else {
	        	self.info.iTitle ="[비밀]";
	        	self.privateYN = "Y";
	        }
	    }
	},
	created : function() {
		var self = this;
		if(self.iNo != ""){
			self.fnGetInfo(); //수정
		} else{
			self.fnGetMaxNo(); //등록
		}
	}// created
});
</script>