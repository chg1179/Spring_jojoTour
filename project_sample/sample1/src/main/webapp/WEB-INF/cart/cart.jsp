<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<meta charset="EUC-KR">
<title>Cart</title>
<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
		font-weight: lighter;
	}
	
	#tbl1 {
			margin : 30px auto;
			width : 1400px;
			border-collapse: collapse;
			text-align : center;
			font-size : 14px;
	    	border-radius: 20px;
	    	background-color: #fafafa;
	  	 	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
	}
	
	th {
		font-size : 18px;
		font-weight : 60;
		padding: 5px 10px;
		height: 30px;
	}
	td {
		padding: 5px 10px;
		height: 30px;
	}
	
	#tbl1 {
		text-align: center;
		margin: auto;
		width: 1400px;
	}
	#tbl1 tr:hover {
		    background-color: #EEEEEE;
		    color : black;
		  }
	#tbl2 {
		color : white;
		margin : 30px auto;
		width : 900px;
		border-collapse: collapse;
		text-align : center;
		font-size : 20px;
		border-radius: 5px;
	    background-color: #f8852a;
	  	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
	}
	#delBtn {
		margin : 5px auto;
		border-radius : 20px;
		border : 1px solid #f8852a;
		width : 60px;
		height: 30px;
		background-color: #f8852a;
		color : white;
	} 
	#delBtn:hover {
	    background-color: #f89552;
	  }
	#deline {
		text-decoration : line-through;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1
			style="color: #f8852a; text-align: center; margin-top: 40px; margin-bottom: 60px;">장바구니</h1>

		<div id="tbl">
			<table style="margin: 30px auto;" id="tbl1">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #F86F03; border-bottom: 2px solid #F86F03;">
							숙소
						</td>
					</tr>
					<tr>
						<th style="width: 400px;" colspan="2">상품정보</th>
						<th>선택</th>
						<th>결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in roomlist">
						<td style="border-right: 1px solid #F86F03; width : 350px;">
							<div style="font-weight: bold; margin: 5px;">{{item.stayName}}</div>
							<div>{{item.roomName}}</div>
						</td>
						<td style="width : 400px;" v-if="item.sReserveDate == item.lReserveDate">
							예약일 : {{item.sReserveDate}}
						</td>
						<td style="width : 400px; margin: 5px;" v-else>
							<div style=" margin: 5px;">입실 : {{item.sReserveDate}}</div> 
							<div>퇴실 : {{item.lReserveDate}}</div> 
						</td>
						<td><input type="button" value="삭 제" id="delBtn"></td>
						<td v-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.roomSales == 1">
							<div style="font-weight: bold; font-size: 16px;">{{item.roomPrice.toLocaleString()}}원</div>
						</td>
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.roomSales != 1">
							<div id="deline">{{item.roomPrice.toLocaleString()}}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{(item.roomPrice*item.roomSales).toLocaleString()}}원</div>
						</td>
							
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) != 0 && item.roomSales == 1">
							<div style="font-weight: bold; font-size: 16px;">{{ (item.roomPrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
						<td v-else>
							<div id="deline">{{ (item.roomPrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{ (item.roomPrice*item.roomSales*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
					</tr>
				</tbody>
			</table >
			
			<table style="margin: 30px auto;" id="tbl1">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #F86F03; border-bottom: 2px solid #F86F03;">
							렌트카
						</td>
					</tr>
					<tr>
						<th style="width: 400px;" colspan="2">상품정보</th>
						<th>선택</th>
						<th>결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in rentlist">
						<td style="border-right: 1px solid #F86F03; width : 350px;">
							<div style="font-weight: bold; margin: 5px;">{{item.rentName}}</div>
							<div>{{item.rentKind}}</div>
						</td>
						<td style="width : 400px;" v-if="item.sReserveDate == item.lReserveDate">
							예약일 : {{item.sReserveDate}}
						</td>
						<td style="width : 400px; margin: 5px;" v-else>
							<div style=" margin: 5px;">인수 : {{item.sReserveDate}}</div> 
							<div>반납 : {{item.lReserveDate}}</div> 
						</td>
						<td><input type="button" value="삭 제" id="delBtn"></td>
						<td v-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.rentSales == 1">
							<div>{{item.rentPrice.toLocaleString()}}원</div>
						</td>
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.rentSales != 1">
							<div id="deline">{{item.rentPrice.toLocaleString()}}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{(item.rentPrice*item.rentSales).toLocaleString()}}원</div>
						</td>
							
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) != 0 && item.rentSales == 1">
							<div style="font-weight: bold; font-size: 16px;">{{ (item.rentPrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
						<td v-else>
							<div id="deline">{{ (item.rentPrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{ (item.rentPrice*item.rentSales*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
					</tr>
				</tbody>
			</table >
			
			<table style="margin: 30px auto;" id="tbl1">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #F86F03; border-bottom: 2px solid #F86F03;">
							레저
						</td>
					</tr>
					<tr>
						<th style="width: 400px;" colspan="2">상품정보</th>
						<th>선택</th>
						<th>결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in leisurelist">
						<td style="border-right: 1px solid #F86F03; width : 350px;">
							<div style="font-weight: bold; margin: 5px;">{{item.leisureName}}</div>
							<div>{{item.leisureKind}}</div>
						</td>
						<td style="width : 400px;" v-if="item.sReserveDate == item.lReserveDate">
							예약일 : {{item.sReserveDate}}
						</td>
						<td style="width : 400px; margin: 5px;" v-else>
							<div style=" margin: 5px;">예약일 : {{item.sReserveDate}} ~ {{item.lReserveDate}}</div>
						</td>
						<td><input type="button" value="삭 제" id="delBtn"></td>
						<td v-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.leisureSales == 1">
							<div>{{item.leisurePrice.toLocaleString()}}원</div>
						</td>
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) == 0 && item.leisureSales != 1">
							<div id="deline">{{item.leisurePrice.toLocaleString()}}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{(item.leisurePrice*item.leisureSales).toLocaleString()}}원</div>
						</td>
							
						<td v-else-if="dateDifference(item.sReserveDate, item.lReserveDate) != 0 && item.leisureSales == 1">
							<div style="font-weight: bold; font-size: 16px;">{{ (item.leisurePrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
						<td v-else>
							<div id="deline">{{ (item.leisurePrice*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{ (item.leisurePrice*item.leisureSales*dateDifference(item.sReserveDate, item.lReserveDate)).toLocaleString() }}원</div>
						</td>
					</tr>
				</tbody>
			</table >
			
			<table id="tbl2">
				<tr>
					<td colspan="2" style="text-align: left; padding-left: 30px; font-size: 20px; border-bottom: 2px solid white; text-align: center;">
							최종결제금액
					</td>	
				</tr>
				<tr>
					<td>
						<div style="text-align: center;">{{ calculateTotalPrice() | numberWithCommas }}</div>
					</td>
					
				</tr>
			
			</table>
			<div style="text-align: center;"><input type="button" @click="fnPayment" value="결제하기" id="delBtn"></div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		selectRoom : [],
		selectRent : [],
		selectLeisure : [],
		roomlist : [],
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
		fnPayment : function (){
			var self = this;
			var param = {};
		//	$.pageChangeList("payment.do", {list : self});
                }
		
	}, // methods
	computed: {
        // 계산된 속성 추가
        dateDifference() {
            return function(start, end) {
                const startDate = new Date(start);
                const endDate = new Date(end);

                const timeDiff = endDate.getTime() - startDate.getTime();
                const daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

                return daysDiff;
            };
        },
        calculateTotalPrice() {
            return () => {
                let totalPrice = 0;
                
                for (const item of this.roomlist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var sprice =  0;
                    if(daysDiff == 0 && item.roomSales == 1){
                    	sprice = item.roomPrice;
                    }else if(daysDiff == 0 && item.roomSales != 1){
                    	sprice = item.roomPrice * item.roomSales;
                    }else{
                    	sprice = item.roomPrice * daysDiff * item.roomSales;
                    }
                    totalPrice = totalPrice + sprice;
                }
                
                for (const item of this.rentlist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var rprice =  0;
                    if(daysDiff == 0 && item.rentSales == 1){
                    	rprice = item.rentPrice;
                    }else if(daysDiff == 0 && item.rentSales != 1){
                    	rprice = item.rentPrice * item.rentSales;
                    }else{
                    	rprice = item.rentPrice * daysDiff * item.rentSales;
                    }
                    totalPrice = totalPrice + rprice;
                }
                
                for (const item of this.leisurelist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var lprice =  0;
                    if(daysDiff == 0 && item.leisureSales == 1){
                    	lprice = item.leisurePrice;
                    }else if(daysDiff == 0 && item.leisureSales != 1){
                    	lprice = item.leisurePrice * item.leisureSales;
                    }else{
                    	lprice = item.leisurePrice * daysDiff * item.leisureSales;
                    }
                    totalPrice = totalPrice + lprice;
                }
                
                return totalPrice;
            };
        }
    },
    filters: {
        // 숫자에 쉼표 추가하는 필터
        numberWithCommas(value) {
            return value.toLocaleString();
        }
    },
	created : function() {
		var self = this;
		self.fnRoomList();
		self.fnRentList();
		self.fnLeisureList();
	}// created
});
</script>