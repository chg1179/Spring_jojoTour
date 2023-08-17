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
<title>Insert title here</title>
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
		<label>제목 : <input v-model="info.iTitle"></label>
		<input type="checkbox"v-model="fnSecret"> 비밀글
	<div>
	<br>
		<vue-editor v-model="info.iContent"></vue-editor>
	</div>
	<br>
	<button v-if="iNo == ''" @click="fnAdd">등록</button>
	<button v-else @click="fnEdit">수정</button>
	</div>
</body>
</html>
<script>
console.log(Vue);
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		uId:"${sessionId}",
		iNo : "${map.iNo}",
		info : {
			iTitle : "<비밀>",
			iContent : ""
		},
		fnSecret : true
	},// data
	components: {VueEditor},
	methods : {
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
	     fnGetList : function(){
				var self = this;
				var param = {iNo : self.iNo, kind : "UPDATE"};
				$.ajax({
	                url : "view.dox",
	                dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	self.info = data.info;
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
		
	}, // methods
	watch: {
	    fnSecret: function(newFnSecret) {
	    	var self = this;
	        if (!newFnSecret) {
	        	self.info.iTitle = "";
	        } else {
	        	self.info.iTitle = "<비밀>";
	        }
	    }
	},
	created : function() {
		var self = this;
		if(self.iNo != ""){
			self.fnGetList();
		}

	}// created
});
</script>