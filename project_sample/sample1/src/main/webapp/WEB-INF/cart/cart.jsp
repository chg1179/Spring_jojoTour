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
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
	#tbl {
		text-align : center;
		margin : auto;
		width : 1200px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1 style="color : #f8852a; text-align: center; margin-top: 30px;">장바구니</h1>
	
		<div id="tbl">
			<table style="margin : auto;">
				<thead>
					<tr>
						<th>품목</th>
						<th style="width: 400px;" colspan="2">상품정보</th>
						<th>가격</th>
						<th>수량</th>
						<th>최종금액</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(item, index) in roomlist">
						<td v-if="index ==0" :rowspan="roomlist.length">숙박</td>
						<td>{{item.stayName}}</td>
						<td>{{item.roomName}}</td>
						<td>{{item.roomPrice}}</td>
						<td><input type="number" v-model="item.roomQuantity" @input="calculateRoom(item)" style="width: 40px;" min="1" max="10"></td>
						<td>{{item.roomPrice * item.roomQuantity}}</td>
					</tr>
					<tr v-for="(item, index) in rentlist">
						<td v-if="index ==0" :rowspan="rentlist.length">렌트카</td>
						<td>{{item.rentName}}</td>
						<td>{{item.rentKind}}</td>
						<td>{{item.rentPrice}}</td>
						<td><input type="number" v-model="item.rentQuantity" @input="calculateRent(item)" style="width: 40px;" min="1" max="10"></td>
						<td>{{item.rentPrice * item.rentQuantity}}</td>
					</tr>
					<tr v-for="(item, index) in leisurelist">
						<td v-if="index ==0" :rowspan="leisurelist.length">레저</td>
						<td>{{item.leisureName}}</td>
						<td>{{item.leisureKind}}</td>
						<td>{{item.leisurePrice}}</td>
						<td><input type="number" v-model="item.leisureQuantity" @input="calculateLeisure(item)" style="width: 40px;" min="1" max="10"></td>
						<td>{{item.leisurePrice * item.leisureQuantity}}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
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
		self.roomlist[0].roomQuantity = 1;
	}// created
});
</script>