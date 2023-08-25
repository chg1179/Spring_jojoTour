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
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div>���� : {{info.rTitle}}</div>
		<div>�ۼ��� : {{info.uId}}</div>
		<div>�Խñ� ��ȣ : {{info.rNo}}</div>
		<div>�ۼ� ��¥ : {{info.rWriteTime}}</div>
		<div v-html="info.rContent"></div>
		<div v-if="userId == info.uId"><button @click="fnUpdate">�����ϱ�</button><button>�����ϱ�</button></div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		rNo : "${map.rNo}",
		userId : "${sessionId}",
		info : {}
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {rNo : self.rNo};
			$.ajax({
                url : "info.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(self.info);
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			$.pageChange("/review/edit.do", {rNo : self.rNo});
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>