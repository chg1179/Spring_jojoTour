<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>1:1 문의 작성</title>
<style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }

    #app {
      margin: 20px auto;
      max-width: 1000px;
      background-color: #fff;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 5px;
    }

    .WritingHeader {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .WritingHeader h2 {
      font-size: 24px;
      color: #333;
    }

    .tool_area button {
      background-color: #007bff;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    .tool_area button:hover {
      background-color: #0056b3;
    }

    input[type="text"] {
      width: 98%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .vue-editor {
      border: 1px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      font-size: 16px;
      height:800px;
    }

    button[disabled] {
      background-color: #ccc;
      cursor: not-allowed;
    }
    .ql-container.ql-snow {
    border: 1px solid #ccc;
    height: 750px;
	}
	.password-input{
	    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
	}
	
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="WritingWrap">
			
			<div class="WritingHeader">
				<h2>1:1문의 글쓰기</h2>
					<div class="tool_area">
						<label v-if="privateYN=='Y'" ><i class="fas fa-regular fa-lock fa-bounce fa-xl" style="color: #7926df;  margin-right: 10px;"></i> 
							<input v-model="info.iPassword" type="password" class="password-input">
						</label>
						<button v-if="answer == 'A'" @click="fnAdd">답변등록</button>					
				        <button v-if="iNo === ''" @click="fnAdd">등록</button>
				        <button v-else-if="iNo !='' && info.answerYn=='N'" @click="fnEdit">수정</button>
			        	<button @click="fnBack">뒤로가기</button>
			        </div>
			 </div>	
			 	<label><input type="checkbox" v-model="fnSecret"> 비밀글</label>
			 	<label><input type="text" v-model="info.iTitle" maxlength="40" @input="handleTitleInput"></label>
				<br><br>
			 	
				<div class="vue-editor">
					<vue-editor v-model="info.iContent" maxlength="500"></vue-editor>
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
				if(self.info.iTitle.trim().length < 5){
					alert("제목을 입력해주세요.");
					return;
				}
			} else if(self.privateYN == "N"){
				if(self.info.iTitle.trim() == ""){
					alert("제목을 입력해주세요.");
					return;
				}
			}
		    if (self.info.iContent.trim().length <1) {
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