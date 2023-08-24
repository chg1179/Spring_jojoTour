<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>호텔 상세 페이지</title>
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
	.room-box, .stay-box{
   		width: 956px;
    	margin: 0px auto
	}
	.room-box .room{
	    overflow: hidden;
	    margin: 30px 0 24px 0;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background: #fff;
	    
	}
	.stay-box .stay {
		overflow: hidden;
	    margin: 30px 0 24px 0;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background: #fff;
	}
	.stay-box .stay{
		overflow : hidden;
	}
	
	.stay-box .stay .left  {
		float: left;
		width: 490px;
	}
	
	.room-box .room .left {
		float: left;
		width: 490px;
	}
	
	
	.stay-box .stay .right {
		float: right;
		width: 450px;
	}
	
	 .room-box .room .right {
	 	float: right;
		width: 450px;
	 }
	
</style>
 
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="stay-box">
		<div class="stay">
			<div class="left">
				<img :src="info.imgPath" alt="">
			</div>
			<div class="right">
				<p>{{info.stayName}}</p>
				<p>{{info.sAddr}}</p>
			</div>
		</div>
	</div>
	<div class="room-box">
		<div class="room" v-for="(item, index) in list">
			<div class="left">
				<img :src="item.imgPath" alt="">
			</div>
			<div class="right">
				<div>방번호: {{item.roomNo}}</div>
				<div>방정보 : {{item.roomName}}</div>
				<div>가격 : {{item.roomPrice}}</div>
				<div>할인율 : {{salesList[index]}}%</div>
				<div>할인된 가격 : {{item.roomPrice * item.roomSales}}원</div>
				
				<button @click="fnCart(item)">장바구니</button>					
				<button @click="">예약하기</button>
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
		stayNo : "${map.stayNo}",
		uId : "${sessionId}",
		info : {
			stayName : "",
			sAddr : "",
			cKind : ""
		},
		roomNo : "",
		salesList : [],
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.roomList;
                	console.log(self.list);
                	
               		self.salesList = self.list.map(item => 100 - (item.roomSales * 100));
               		console.log(self.salesList);
                	
                	self.info = data.stayInfo;
                	console.log(self.info);
                	
                	
                }
            }); 
		},
		fnGetImgList : function(){
		var self = this;
		var param = {stayNo : self.stayNo};
		$.ajax({
	          url : "stayImgList.dox",
	          dataType:"json",	
	          type : "POST",
	          data : param,
	          success : function(data) { 
	          	self.imgList = data.imgList;
	          	console.log(self.imgList);
	          }
	      }); 
		},
		fnCart : function(item){
			var self = this;
			if(self.uId == ""){
				alert("로그인 후 이용 가능한 서비스입니다.");
				return;
			}
			
			if(!confirm("장바구니에 담으시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			console.log(item.roomNo);
			console.log(item.peopleMax);
			var param = {uId : self.uId, roomNo : item.roomNo, peopleMax : item.peopleMax};
			$.ajax({
                url : "addCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("상품이 장바구니에 담겼습니다.");
                	self.fnGetList();
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