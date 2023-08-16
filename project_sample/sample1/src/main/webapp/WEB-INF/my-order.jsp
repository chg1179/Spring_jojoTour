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
		<div>���೻��
			<div v-if="order.useYnc == 'N'">�����</div>
			<div v-if="order.useYnc == 'Y'">���Ϸ�</div>
			<div v-if="order.useYnc == 'C'">�������</div>
		</div>
		<div>������¥{{order.paymentDate}}</div>
		<div>�ֹ���ȣ {{order.productNo}}</div>
		<div>�����ݾ� {{order.payment}}</div>
		<div>�ֹ���ǰ
			<div v-if="order.productKind == 'STAY'">����</div>
			<div v-if="order.productKind == 'RENT'">��Ʈī</div>
			<div v-if="order.productKind == 'LEISURE'">����</div>
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