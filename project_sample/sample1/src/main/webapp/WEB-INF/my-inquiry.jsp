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
	.inquiry{
		background-color : buttonface;
	}
    .inquiry::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right : 0;
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		1:1 문의내역
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : []
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
                	console.log(self.list);
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>