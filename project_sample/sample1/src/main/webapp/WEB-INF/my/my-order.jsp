<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../css/my/my-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>예약내역</title>
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
	#page_order_container{
		display: flex;
		justify-content: center;
		margin-top: 50px;
		margin-bottom: 346px;
	}
	.page_order_booking_box{
		display: flex;
		justify-content: space-around;
		text-align: center;
	}
	.page_order_booking_box{
		border-top: 1px solid;
		border-bottom: 1px solid #ccc;
	}
	.page_order_booking_box>div{
		padding: 0 70px;
	}
	.page_order_booking_box>div:nth-child(2){
		border-right: 1px solid #ccc;
		border-left: 1px solid #ccc;

	}
	.page_order_booking_box div div{
		margin: 20px 0;
	}
	.page_order_booking_box span{
		font-size: 30px;
		font-weight: bold;
	}
	table, tr, th, td{
		border: 1px solid;
		border-collapse: collapse;
	}
	.page_order_wrap table{
		margin-top: 30px;
		text-align: center;
	}
	.page_order_wrap table th, .page_order_wrap table td{
		padding : 5px 20px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="page_order_container">
			<div class="page_order_wrap">
				<div class="coreTxt"><span class="bar">ㅣ</span> 예약내역</div>
				<div class="page_order_booking_box">
					<div class="page_order_accept">
						<div>예약완료</div>
						<div><span>{{orderAccept}}건</span></div>
					</div>
					<div class="page_order_completion">
						<div>사용완료</div>
						<div><span>{{orderCompletion}}건</span></div>
					</div>
					<div class="page_order_cancel">
						<div>예약취소</div>
						<div><span>{{orderCancel}}건</span></div>
					</div>
				</div>
				<table v-if="orderList != ''">
					<tr>
						<th>주문번호</th>
						<th>주문일</th>
						<th>제품금액</th>
						<th>상세내역</th>
					</tr>
					<tr v-for="item in orderList">
						<td><a @click="fnView(item.orderNo)" href="javascript:;">{{item.orderNo}}</a></td>
						<td>{{ item.paymentDate }}</td>
						<td>{{ item.totalPay }}원</td>
						<td><input type="button" value="상세보기" @click="fnView(item.orderNo)"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		userId : "${sessionId}",
		orderList : [],
		orderAccept : 0, //예약완료.N(사용전)
		orderCompletion : 0, //사용완료.Y
		orderCancel : 0 //취소.C
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
                	self.orderList = data.orderList;
                	for(var i=0;i<self.orderList.length;i++){
						if(self.orderList[i].useN != null){
							self.orderAccept += self.orderList[i].useN;
						}
						if(self.orderList[i].useY != null){
							self.orderCompletion += self.orderList[i].useY;
						}
                		if(self.orderList[i].useC != null){
                			self.orderCancel += self.orderList[i].useC;
                		}
                	}
                	console.log(self.orderList);
                }
            }); 
		},
		fnView : function(orderNo){
        	var self = this;
        	$.pageChange("order/view.do", {orderNo : orderNo});
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>