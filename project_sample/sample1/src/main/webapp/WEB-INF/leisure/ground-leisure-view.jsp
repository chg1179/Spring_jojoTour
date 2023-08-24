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
		<img :src="info.imgPath">
		<div>No : {{info.leisureNo}}</div>
		<div>종류 : {{info.cName}}</div>
		<div>상품명 : {{info.leisureName}}</div>
		<div>할인율 : {{100-info.leisureSale*100}}%</div>
		<div>가격 : {{info.leisurePrice}}</div>
		<div>위치 : {{info.lAddr}}{{info.lDetailAddr}}</div>
		<div>등록날짜 : {{info.lInsertTime}}</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		leisureNo : "${map.leisureNo}",
		info : {}
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	self.info.imgPath = "../"+self.info.imgPath; 
                	console.log(self.info);
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