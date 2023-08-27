<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>숙소 상세 페이지</title>
<style>
	body {
        margin: 0;
        padding: 0;
        background-color: #f2f2f2;
    }
     hr {
        width: 700px;
        margin: 20px auto;
        border: none;
        height: 1px; 
        background-color: #ccc; 
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); 
    }
	.stay-view-container {
		display: flex;
		align-items: center;
		justify-content: center;
		max-width: 700px;
		margin: 0px auto;
		padding: 20px;
	}
	.stay-box {
	    display: flex;
	    align-items: center;
	    margin-bottom: 20px;
	}

	.stay-img {
	    width: 400px;
	    height: 100%;
	    margin-top: 30px;
	}
	
	.stay-img img {
	    max-width: 100%;
	    height: auto;
	    border-radius: 5px;
	}
	
	.stay-info {
	    flex: 1;
	}
	.room-container {
		justify-content: center;
		max-width: 700px;
		margin: 0px auto;
		padding: 20px;
	}
	.room-date {
	    margin-top: 20px;
	    margin-bottom: 20px;
	}
	
	.room-list {
	    display: flex;
	    flex-direction: column;
	}
	
	.room-info {
	    display: flex;
	    margin-bottom: 20px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    padding: 15px;
	    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	}
	
	.room-img {
	    width: 300px;
	    margin-right: 20px;
	}
	
	.room-img img {
	    max-width: 100%;
	    height: auto;
	    border-radius: 5px;
	}
	
	.room-detail {
	    flex: 1;
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between;
	}
	
	.cart-button {
	    background-color: #213555;
	    color: #fff;
	    border: none;
	    padding: 5px 10px;
	    border-radius: 3px;
	    cursor: pointer;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="stay-view-container">
		<div class="stay-box">
			<div class="stay-img">
				<img :src="info.imgPath" alt="">
			</div>
			<div class="stay-info">
				<p>{{info.stayName}}</p>
				<p>{{info.sAddr}}</p>
			</div>
		</div>
	</div>
	<hr>
	<div class="room-container">
		<div class="room-date">
			<input type="date" name="checkInDate" v-model="checkInDate"> ~
			<input type="date" name="checkOutDate" v-model="checkOutDate">
		</div>
		<div class="room-list">
			<div class="room-info" v-for="(item, index) in list">
				<div class="room-img">
					<img :src="item.imgPath" alt="객실 사진">
				</div>
				<div class="room-detail">
					<div>{{item.roomName}}</div>
					<div>{{item.roomPrice}}원</div>
					<div>{{salesList[index]}}%</div>
					<div>{{item.roomPrice * item.roomSales}}원</div>
					<button class="cart-button" @click="fnCart(item)">장바구니</button>					
				</div>
			</div>
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
		checkInDate : "",
		checkOutDate : ""
		
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
			if(self.checkInDate == ""){
				alert("체크인 날짜를 선택해주세요");
				return;
			}
			if(self.checkOutDate == ""){
				alert("체크아웃 날짜를 선택해주세요");
				return;
			}
			if(!self.checkInDate || new Date(self.checkInDate) < new Date()){
				alert("유효하지 않은 체크인 날짜입니다. 오늘 이후 날짜를 선택해주세요.");
				location.reload();
				return;
			}
			if (new Date(self.checkInDate) > new Date(self.checkOutDate)) {
			    alert("체크아웃 날짜는 체크인 날짜보다 먼저 올 수 없습니다. 다시 선택해주세요");
			    location.reload();
			    return;
			}
			
			if(!confirm("장바구니에 담으시겠습니까?")){
				alert("취소되었습니다.");
				location.reload();
				return;
			}
			console.log(item.roomNo);
			console.log(item.peopleMax);
		
			var param = {uId : self.uId, roomNo : item.roomNo, peopleMax : item.peopleMax, checkInDate : self.checkInDate , checkOutDate : self.checkOutDate};
			$.ajax({
                url : "addCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("상품이 장바구니에 담겼습니다.");
                	location.reload();
                	self.fnGetList();
                	console.log(self.checkInDate);
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