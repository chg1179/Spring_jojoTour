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
	    position: relative;
	    margin: 30px 0 24px 0;
	    padding: 24px 24px 24px 424px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background: #fff;
	    box-sizing: border-box;
	    
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
	
	.stay-box .stay .left {
		float: left;
		width: 490px;
	}
	
	.stay-box .stay .right {
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
			<div class="left">이미지</div>
			<div class="right">
				<div>{{stayName}}</div>
				<div>{{sAddr}}</div>
			</div>
		</div>
	</div>
	<div class="room-box">
		<div class="room" v-for="item in list">
			<div>방정보 : {{item.roomName}}</div>
			<div>가격 : {{item.roomPrice}}</div>
			
			<button @click="fnJjim">찜</button>
			<button @click="">장바구니</button>					
			<button @click="">예약하기</button>		
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
		stayName : "${map.stayName}",
		sAddr : "${map.sAddr}",
		uId : "${sessionId}",
		
		
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
                	console.log(self.stayName);
                }
            }); 
		},
		/* fnCart : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.roomList;
                	console.log(self.list);
                	console.log(self.stayName);
                }
            }); 
		}, */
		fnJjim : function(){
			var self = this;
			if(!confirm("찜목록에 추가하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {uId : self.uId, roomNo : self.roomNo}; // 룸넘버 넘기기
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에 추가되었습니다.");
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