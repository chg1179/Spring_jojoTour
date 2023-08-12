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
		<div>제목 : {{info.nTitle}}</div>
		<div>작성자 : {{info.uId}}</div>
		<div>작성날짜 : {{info.fWriteTime}}</div>
		<div>내용 :<pre v-html="info.nContent"></pre></div>
	<div>
		<button @click="fnEdit" >수정하기</button>
		<button @click="fnBack">되돌아가기</button>
	</div> 
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		info : {},
		nNo : "${map.nNo}",
		status : "${sessionStatus}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {nNo : self.nNo, nKindNo : "UPDATE"};
			$.ajax({
                url : "view.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(data);
                }
            }); 
		},
		 fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {nNo : self.nNo});
	                }

	}, // methods
	created : function() {
		var self = this;
		if(self.nNo != ""){
			self.fnGetList();
		}
	}// created
});
</script>