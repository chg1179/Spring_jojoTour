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
	<div id="app">
		<div id="container">
			<div>
				<label>제목 : <input v-model="info.iTitle" @input="handleTitleInput"></label>
				<label><input type="checkbox" v-model="fnSecret"> 비밀글</label>
			<div>
			<br>
				<vue-editor v-model="info.iContent"></vue-editor>
			</div>
			<br>
			<button v-if="iNo == ''" @click="fnAdd">등록</button>
			<button v-else @click="fnEdit">수정</button>
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
		cnt : "${map.cnt}", // 작성된 글이 하나도 없으면(0이면) pk 1부터 시작
		maxINo : "",
		info : {
			iTitle : "[비밀]",
			iContent : ""
		},
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
		            	//문의 답글을 한 테이블에서 작업하는데 정렬하기 위해 MAX PK+2(답글은 pk+1)
		             	self.maxINo = data.maxINo + 2;
	             	}
				}
			}); 
		},
		fnAdd : function(){
			var self = this;
			var param = self.info;
			param.uId = self.uId;
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("등록 완료");
					location.href = "list.do";
                }
            }); 
		},
 		fnEdit : function(){
			var self = this;
			var param = self.info;
			$.ajax({
				url : "edit.dox",
				dataType:"json",	
				type : "POST",
				data : param,
				success : function(data) { 
					alert("수정되었습니다");
	                location.href = "list.do";
				}
			}); 
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
	        } else {
	        	self.info.iTitle ="[비밀]"; 
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