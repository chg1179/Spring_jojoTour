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
	#bottom-bar {
	    position: fixed;
	    bottom: 0;
	    left: 0;
	    height : 50px;
	    width: 100%;
	    background-color: #ff9f52;
	    padding: 16px;
	    box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
	    display: flex;
   		justify-content: space-between;
   		align-items: center;
	}
	#bottom-txt {
		margin-left: 720px;
		color : white;
		float : center;
	}

	#pbtn {
	    background-color: white;
	    color: black;
	    border: none;
	    border-radius: 10px;
	    font-size: 18px;
	    font-weight: bold;
	    cursor: pointer;
	    float: right;
	    margin-right : 300px;
	    width : 200px;
	    height: 50px;
	}
	#pbtn:hover {
	    background-color: #f1f1f1;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1
			style="color: #f8852a; text-align: center; margin-top: 30px; margin-bottom: 4px;">장바구니</h1>

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
						<td><input type="button" value="삭 제" id="delBtn" @click="fnRemove(item)"></td>
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
						<td><input type="button" value="삭 제" id="delBtn" @click="fnRemove(item)"></td>
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
						<td><input type="button" value="삭 제" id="delBtn" @click="fnRemove(item)"></td>
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
			
			<div id="bottom-bar">
				<span id="bottom-txt">
					<span>총 금액 : </span>
					<span style="font-size: 24px;">{{ originalTotalPrice() | numberWithCommas }} </span>
					<span> - 할인 금액 : </span>
					<span style="font-size: 24px;">{{ originalTotalPrice()-calculateTotalPrice() | numberWithCommas }} </span>
					<span> =  최종 결제 금액 : </span>
					<span style="font-size: 24px;">{{ calculateTotalPrice() | numberWithCommas }}</span>
				</span>
				<input type="button" @click="fnPayment" value="결제하기" id="pbtn"></div>
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
			var roomlistJSON = JSON.stringify(self.roomlist);
			$.pageChangeList("payment.do", {list : roomlistJSON});
			
		},
		fnRemove : function(item){
			var self = this;
			var param = {uId : item.uId, productNo : item.productNo};
			if(!confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?")){
				return;
			}
			$.ajax({
                url : "/delCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	self.fnRoomList();
            		self.fnRentList();
            		self.fnLeisureList();
                }
            }); 
			
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
                console.log(rprice);
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
        },
        originalTotalPrice() {
            return () => {
                let originalPrice = 0;
                
                for (const item of this.roomlist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var qprice =  0;
                    if(daysDiff == 0){
                    	qprice = parseInt(item.roomPrice);
                    }else{
                    	qprice = parseInt(item.roomPrice) * daysDiff;
                    }
                    originalPrice = originalPrice + qprice;
                }
                
                for (const item of this.rentlist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var wprice =  0;
                    if(daysDiff == 0){
                    	wprice = parseInt(item.rentPrice);
                    }else{
                    	wprice = parseInt(item.rentPrice) * daysDiff;
                    }
                    originalPrice = originalPrice + wprice;
                }
                console.log(wprice);
                for (const item of this.leisurelist) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var eprice =  0;
                    if(daysDiff == 0){
                    	eprice = parseInt(item.leisurePrice);
                    }else{
                    	eprice = parseInt(item.leisurePrice) * daysDiff;
                    }
                    originalPrice = originalPrice + eprice;
                }
                
                return originalPrice;
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