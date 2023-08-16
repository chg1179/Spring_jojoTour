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
	<div id="app">
		<div>예약내역
			<div v-if="order.useYnc == 'N'">사용전</div>
			<div v-if="order.useYnc == 'Y'">사용완료</div>
			<div v-if="order.useYnc == 'C'">예약취소</div>
		</div>
		<div>결제날짜{{order.paymentDate}}</div>
		<div>주문번호 {{order.productNo}}</div>
		<div>결제금액 {{order.payment}}</div>
		<div>주문제품
			<div v-if="order.productKind == 'STAY'">숙박</div>
			<div v-if="order.productKind == 'RENT'">렌트카</div>
			<div v-if="order.productKind == 'LEISURE'">레저</div>
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
		order : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "/order.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.order = data.order;
                	console.log(self.order);
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