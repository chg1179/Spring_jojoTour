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
	
	.tbl {
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
	
	.tbl tr:hover {
		    background-color: #EEEEEE;
		    color : black;
		  }

	#delBtn {
		margin : 5px auto;
		border-radius : 20px;
		border : 1px solid #0FABBC;
		width : 60px;
		height: 30px;
		background-color: #0FABBC;
		color : white;
	} 
	#delBtn:hover {
		border : 1px solid #FA163F;
	    background-color: #FA163F;
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
	    background-color: #324666;
	    padding: 16px;
	    box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
	    display: flex;
   		justify-content: space-between;
   		align-items: center;
	}
	#bottom-txt {
		margin-left: 300px;
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
		<h1 style="color: #999; text-align: center; margin-top: 30px; margin-bottom: 20px;">장바구니</h1>

		<div class="tbl">
		
			<table class="tbl" v-if=" roomlist.length === 0" style="margin-bottom : 30px;">
				<thead>
					<tr>
						<td style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							숙박
						</td>
					</tr>
					<tr>
						<th style="width: 400px;">장바구니에 담긴 숙박 상품이 없습니다.</th>
					</tr>
				</thead>
			</table>
			
			<table v-else style="margin: 30px auto;" class="tbl">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							숙소
						</td>
					</tr>
					<tr>
						<th style="width: 1000px;" colspan="3" style="width: 40px;">상품정보</th>
						<th style="width: 100px;">인원</th>
						<th style="width: 100px;">선택</th>
						<th style="width: 200px;">결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in roomlist">
						<td style="width: 50px;">
							<input type="checkbox" name="room" v-model="selectRoom" :value="item" >
						</td>
						<td style="border-right: 1px solid #999; width: 450px;">
							<div style="font-weight: bold; margin: 5px;">{{item.stayName}}</div>
							<div>{{item.roomName}}</div>
						</td>
						<td  v-if="item.sReserveDate == item.lReserveDate">
							예약일 : {{item.sReserveDate}}
						</td>
						<td style=" margin: 5px;" v-else>
							<div style=" margin: 5px;">입실 : {{item.sReserveDate}}</div> 
							<div>퇴실 : {{item.lReserveDate}}</div> 
						</td>
						<td>
							{{item.peopleMax}}명
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
			
			
			<table class="tbl" v-if=" rentlist.length === 0" style="margin-bottom : 30px;">
				<thead>
					<tr>
						<td style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							렌트카
						</td>
					</tr>
					<tr>
						<th >장바구니에 담긴 렌트카 상품이 없습니다.</th>
					</tr>
				</thead>
			</table>
			
			<table v-else style="margin: 30px auto;" class="tbl">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							렌트카
						</td>
					</tr>
					<tr>
						<th style="width:1100px;" colspan="3">상품정보</th>
						<th style="width: 100px;">선택</th>
						<th style="width: 200px;">결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in rentlist">
						<td style="width: 50px;">
							<input type="checkbox" name="rent" v-model="selectRent" :value="item">
						</td>
						<td style="border-right: 1px solid #999; width: 450px;">
							<div style="font-weight: bold; margin: 5px; ">{{item.rentName}}</div>
							<div>{{item.rentKind}}</div>
						</td>
						<td v-if="item.sReserveDate == item.lReserveDate">
							예약일 : {{item.sReserveDate}}
						</td>
						<td style=" margin: 5px;" v-else>
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
			
			<table class="tbl" v-if=" leisurelist.length === 0">
				<thead>
					<tr>
						<td style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							레저
						</td>
					</tr>
					<tr>
						<th >장바구니에 담긴 레저 상품이 없습니다.</th>
					</tr>
				</thead>
			</table>
			
			<table v-else style="margin: 30px auto;" class="tbl">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #999; border-bottom: 2px solid #999;">
							레저
						</td>
					</tr>
					<tr>
						<th style="width: 600px;" colspan="2">상품정보</th>
						<th style="width: 500px;">인원</th>
						<th style="width: 100px;">선택</th>
						<th style="width: 200px;">결제금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in leisurelist">
						<td>
							<input type="checkbox" name="leisure" v-model="selectLeisure" :value="item">
						</td>
						<td style="border-right: 1px solid #999; width: 450px;">
							<div style="font-weight: bold; margin: 5px; ">{{item.leisureName}}</div>
							<div>{{item.leisureKind}}</div>
						</td>
						<td>
							<input type="number" min="1" max="10" style="width: 80px;" v-model="item.people">
						</td>
						<td><input type="button" value="삭 제" id="delBtn" @click="fnRemove(item)"></td>
						
						<td v-if="item.leisureSales == 1">
							<div>{{ (item.leisurePrice*item.people).toLocaleString() }}원</div>
						</td>
						<td v-else-if="item.leisureSales != 1">
							<div id="deline">{{ (item.leisurePrice * item.people).toLocaleString() }}원</div>
							<div style="font-weight: bold; font-size: 16px;">{{( item.leisurePrice * item.leisureSales * item.people).toLocaleString() }}원</div>
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
				<input type="button" @click="fnPayment()" value="결제하기" id="pbtn"></div>
			</div>
	</div>
	<%-- <jsp:include page="../footer.jsp" flush="true"></jsp:include> --%>
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
                	for (const item of self.leisurelist) {
                        item.people = 1;
                    }
                }
            }); 
		},
		fnRemove : function(item){
			var self = this;
			var param = {uId : item.uId, productNo : item.productNo, productKind : item.productKind};
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
		},		
		// 장바구니에서 결제 선택한 상품을 결제 페이지로 보내주는 함수
		fnPayment: function () {
		    var self = this;
		    // 테스트 데이터
		    var productData = [
		    ];

		    productData = productData.concat(self.selectRoom, self.selectRent, self.selectLeisure);
			
		    if(productData.length == 0){
		    	alert("결제할 제품을 선택해주세요.");
		    	return;
		    }
		    
		    // AJAX 통신
		    $.ajax({
		        url: "/goPayment.dox",
		        type: "POST",
		        data: JSON.stringify(productData),
		        contentType: "application/json",
		        success: function (response) {
		        	//payment.do로 이동
		            var redirectUrl = response.redirectUrl;
		            window.location.href = redirectUrl;
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
                
                for (const index in this.selectRoom) {
                    const item = this.selectRoom[index];
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var sprice =  0;
                    if(daysDiff == 0 && item.roomSales == 1){
                    	sprice = item.roomPrice;
                    }else if(daysDiff == 0 && item.roomSales != 1){
                    	sprice = item.roomPrice * item.roomSales;
                    }else{
                    	sprice = item.roomPrice * daysDiff * item.roomSales;
                    }
                    this.selectRoom[index].roomDaysDiff = daysDiff;
                    this.selectRoom[index].sprice = sprice;
                    totalPrice = totalPrice + sprice;
                    
                }
                
                for (const index in this.selectRent) {
                    const item = this.selectRent[index];
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var rprice =  0;
                    if(daysDiff == 0 && item.rentSales == 1){
                    	rprice = item.rentPrice;
                    }else if(daysDiff == 0 && item.rentSales != 1){
                    	rprice = item.rentPrice * item.rentSales;
                    }else{
                    	rprice = item.rentPrice * daysDiff * item.rentSales;
                    }
                    this.selectRent[index].rentDaysDiff = daysDiff;
                    this.selectRent[index].rprice = rprice;
                    totalPrice = totalPrice + rprice;
                }
                
                for (const index in this.selectLeisure) {
                    const item = this.selectLeisure[index];
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var lprice =  0;
                    if(daysDiff == 0 && item.leisureSales == 1){
                    	lprice = item.leisurePrice * item.people;
                    }else if(daysDiff == 0 && item.leisureSales != 1){
                    	lprice = item.leisurePrice * item.leisureSales * item.people;
                    }else{
                    	lprice = item.leisurePrice * item.leisureSales * item.people;
                    }
                    this.selectLeisure[index].people = item.people;
                    totalPrice = totalPrice + lprice;
                }
                
                return totalPrice;
            };
        },
        originalTotalPrice() {
            return () => {
                let originalPrice = 0;
                
                for (const item of this.selectRoom) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var qprice =  0;
                    if(daysDiff == 0){
                    	qprice = parseInt(item.roomPrice);
                    }else{
                    	qprice = parseInt(item.roomPrice) * daysDiff;
                    }
                    originalPrice = originalPrice + qprice;
                }
                
                for (const item of this.selectRent) {
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
                for (const item of this.selectLeisure) {
                    const daysDiff = this.dateDifference(item.sReserveDate, item.lReserveDate);
                    var eprice =  0;
                    if(daysDiff == 0){
                    	eprice = parseInt(item.leisurePrice) * item.people;
                    }else{
                    	eprice = parseInt(item.leisurePrice) * item.people;
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