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
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		상품 예약 내역 관리
		<div id="container">
			<table>
				<tr>
					<th>예약번호</th>
					<th>예약자</th>
					<th>결제금액</th>
					<th>사용기간</th>
					<th>예약승인</th>
				</tr>
				
				<tr v-for="item in list">
					<td>{{item.orderNo}}</td>
					<td>{{item.uId}}</td>
					<td>{{item.payment}}</td>
					<td>{{item.sReserveDate}}~{{item.lReserveDate}}</td>
					<td><button>승인</button></td>
				</tr>
			</table>
			<div>
				<span><button @click="">뒤로가기</button></span>
			</div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		status : "${sessionStatus}",
		list : []
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "orderList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.orderList;
                	console.log(self.list);
                }
            }); 
		},
	
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>