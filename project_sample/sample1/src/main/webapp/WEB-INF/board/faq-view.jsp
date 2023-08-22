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
		<jsp:include page="../header.jsp" flush="true"></jsp:include>
		<div>���� : {{info.fTitle}}</div>
		<div>�ۼ��� : {{info.uId}}</div>
		<div>�ۼ���¥ : {{info.fWriteTime}}</div>
		<div>���� :<pre v-html="info.fContent"></pre></div>
		<div>
			<button @click="fnEdit"   v-if="status == 'A'">�����ϱ�</button>
			<button @click="fnBack">�ǵ��ư���</button>
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
		fNo : "${map.fNo}",
		status : "${sessionStatus}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {fNo : self.fNo, fKindNo : "UPDATE"};
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
				$.pageChange("edit.do", {fNo : self.fNo});
	                }

	}, // methods
	created : function() {
		var self = this;
		if(self.fNo != ""){
			self.fnGetList();
		}
	}// created
});
</script>