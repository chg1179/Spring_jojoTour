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
	
	th, td {
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
						<th style="width: 400px;" colspan="3">상품정보</th>
						<th>가격</th>
						<th>수량</th>
						<th>상품금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in roomlist">
					<td style="width : 30px"><input type="radio" name="selectRoom"></td>
						<td style="border-right: 1px solid #F86F03; width : 350px;">{{item.stayName}}</td>
						<td style="width : 350px;">{{item.roomName}}</td>
						<td style="width : 200px;">{{item.roomPrice}}원</td>
						<td><input type="number" v-model="item.roomQuantity"
							@input="calculateRoom(item)" style="width: 40px;" min="1"
							max="10"></td>
						<td>{{item.roomPrice * item.roomQuantity}}원</td>
					</tr>
				</tbody>
			</table >
			<table style="margin: 30px auto;" id="tbl1">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #F86F03; border-bottom: 2px solid #F86F03;">
							렌트카</td>
					</tr>
					<tr>
						<th style="width: 400px;" colspan="3">상품정보</th>
						<th>가격</th>
						<th>수량</th>
						<th>상품금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in rentlist">
					<td style="width : 30px"><input type="radio" name="selectRent"></td>
						<td style="border-right: 1px solid #F86F03; width : 350px;">{{item.rentName}}</td>
						<td style="width : 350px;">{{item.rentKind}}</td>
						<td style="width : 200px;">{{item.rentPrice}}</td>
						<td><input type="number" v-model="item.rentQuantity"
							@input="calculateRent(item)" style="width: 40px;" min="1"
							max="10"></td>
						<td>{{item.rentPrice * item.rentQuantity}}</td>
					</tr>
				</tbody>
			</table>
			<table style="margin: 30px auto;" id="tbl1">
				<thead>
					<tr>
						<td colspan="6"
							style="text-align: left; padding-left: 30px; font-size: 20px; color: #F86F03; border-bottom: 2px solid #F86F03;">
							레저</td>
					</tr>
					<tr>
						<th style="width: 400px;" colspan="3">상품정보</th>
						<th>가격</th>
						<th>수량</th>
						<th>상품금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in leisurelist">
					<td style="width : 30px"><input type="radio" name="selectLeisure"></td>
						<td style="border-right: 1px solid #F86F03; width : 350px;">{{item.leisureName}}</td>
						<td style="width : 350px;">{{item.leisureKind}}</td>
						<td style="width : 200px;">{{item.leisurePrice}}</td>
						<td><input type="number" v-model="item.leisureQuantity"
							@input="calculateLeisure(item)" style="width: 40px;" min="1"
							max="10"></td>
						<td>{{item.leisurePrice * item.leisureQuantity}}</td>
					</tr>
				</tbody>
			</table>
			
			<table id="tbl2">
				<tr>
					<td colspan="2" style="text-align: left; padding-left: 30px; font-size: 20px; border-bottom: 2px solid white;;">
							최 종 가 격
					</td>	
				</tr>
				<tr>
					<td>
					
					</td>
				</tr>
			
			</table>
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
		calculateRoom(item) {
	        item.roomTotal = item.roomPrice * item.roomQuantity;
	    },
	    calculateRent(item) {
	        item.rentTotal = item.rentPrice * item.rentQuantity;
	    },
	    calculateLeisure(item) {
	        item.leisureTotal = item.leisurePrice * item.leisureQuantity;
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