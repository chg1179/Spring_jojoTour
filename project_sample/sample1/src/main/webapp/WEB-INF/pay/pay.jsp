<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제페이지</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div>
				<div>결제페이지</div>
			</div>
			<div>
				<div>상품상세정보</div>
				
				
			</div>
			
			<div>
				<div>요금상세정보</div>
				
			</div>
			
			<div>
				<div>예약자정보입력</div>
				
			</div>
			
			
			<div>
				<div>포인트사용</div>
				
				
			</div>
			
			<div>
				<div>최종결제금액</div>
				
				
			</div>
			<div>
				<button @click="fnRequestPay">결제하기</button>
			</div>
		</div>
	</div>
</body>
</html>
<script>
var IMP = window.IMP;
IMP.init('imp64757785');
var app = new Vue({
	el : '#app',
	data : {
		productlist : [],
		rentlist : [],
		leisurelist : [],
		item : [],		
		uId : "${sessionId}"
	},// data
	methods : {
		fnRoomList : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.roomlist = data.list;
                }
            }); 
		},
		fnRentList : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "rentList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.rentlist = data.list;
                }
            }); 
		},
		fnLeisureList : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "leisureList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.leisurelist = data.list;
                }
            }); 
		},
		calculateRoom(item) {
	        item.roomTotal = item.roomPrice * item.roomQuantity;
	    },
	    calculateRent(item) {
	        item.rentTotal = item.rentPrice * item.rentQuantity;
	    },
	    calculateLeisure(item) {
	        item.leisureTotal = item.leisurePrice * item.leisureQuantity;
	    },
        fnRequestPay : function(){
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: 'merchant_'+new Date().getTime(),   // 주문번호
                name: "결제테스트",
                amount: 64900,                         // 숫자 타입
                buyer_email: "gildong@gmail.com",
                buyer_name: self.uName,
                buyer_tel: "010-4242-4242",
                buyer_addr: "서울특별시 강남구 신사동",
				buyer_postcode: "01181"
			}, function (rsp) { // callback
					if (rsp.success) {
                		alert("결제 성공");
					} else {
						console.log(rsp);
                    	alert("결제 성공");
                    	location.href="/my/order.do"
                    }
			});
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnRoomList();
		self.fnRentList();
		self.fnLeisureList();
	}// created
});
</script>