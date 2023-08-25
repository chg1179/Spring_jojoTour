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
		<table>
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록날짜</th>
			</tr>
			<tr v-for="item in list">
				<th>{{item.rNo}}</th>
				<th><a href="javascript:;" @click="fnRContent(item.rNo)">{{item.rTitle}}</a></th>
				<th>{{item.uId}}</th>
				<th>{{item.rHits}}</th>
				<th>{{item.rWriteTime}}</th>
			</tr>
		</table>
		<div v-if="userId != '' && userId != null"><button @click="fnWrite">후기작성</button></div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		rNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	console.log(data);
                	if(data.list.length > 0){
                		self.rNo = self.list[0].rNo;
                	}
                }
            }); 
		},
		fnRContent : function(rNo){
			$.pageChange("../review/view.do", {rNo : rNo});
		},
		fnWrite : function(){
			var self = this;
			$.pageChange("../review/add.do", {userId : self.userId});
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>