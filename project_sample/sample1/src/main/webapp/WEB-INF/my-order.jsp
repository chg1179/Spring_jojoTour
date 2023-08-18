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
	.order{
		background-color : buttonface;
	}
    .order::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	*{
		margin: 0;
		padding: 0;
	}
	#my_order_container{
		margin: 50px 50px;
	}
	.my_order_box{
		display: flex;
		justify-content: center;
		width: 1000px;
		margin-top : 50px;
	}
	.my_order_box > div{
		width: 25%;
		border-top : 1px solid #686868;
		border-bottom : 1px solid #686868;
		border-right : 1px solid #ccc;
		height : 150px;
	}
	.my_order_box > div:last-child{
		border-right: none;
	}
	.my_order_box > div > p{
		text-align: center;
		margin-top: 20px;
		font-weight: bold;
		font-size: 20px;
		color: #414141;
	}
	.my_order_box > div > div{
		text-align: center;
		margin-top: 10px;
		font-weight: bold;
		margin-top: 60px;
		color : #5c5c5c;
	}
	@media (max-width : 1400px){
		.my_order_box{
			width: 600px;
		}
	}
	
	@media (max-width : 1000px){
		.my_order_box{
			width: 500px;
		}
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="my_order_container">
			<h2>예약 내역</h2>
			<div class="my_order_box">
				<div class="order_date">
					<p>결제날짜</p>
					<div>{{order.paymentDate}}</div>
				</div>
				<div class="order_booking">
					<p>예약내역</p>
					<div v-if="order.useYnc == 'N'">사용전</div>
					<div v-if="order.useYnc == 'Y'">사용완료</div>
					<div v-if="order.useYnc == 'C'">예약취소</div>
				</div>
				<div class="order_num">
					<p>주문번호</p> 
					<div>{{order.productNo}}번</div>
				</div>
				<div class="order_product">
					<p>주문제품</p>
					<div v-if="order.productKind == 'STAY'">숙박</div>
					<div v-if="order.productKind == 'RENT'">렌트카</div>
					<div v-if="order.productKind == 'LEISURE'">레저</div>
				</div>
				<div class="order_pay">
					<p>결제금액</p>
					<div>100{{order.payment}}</div>
				</div>
			</div>
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