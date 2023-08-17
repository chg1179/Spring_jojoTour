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
	.point{
		background-color : buttonface;
	}
    .point::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>포인트</h2>
		<div>
			<p>내 포인트</p>
			<h3>{{point.point}}</h3>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		point : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "/my/userPoint.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.point = data.point;
                	console.log(self.point);
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