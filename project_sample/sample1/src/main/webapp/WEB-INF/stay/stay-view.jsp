<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>ȣ�� �� ������</title>
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
	.room-box, .stay-box, .check-date{
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
	
	<div class="check-date">
		<div>
			<input type="date" name="checkInDate" v-model="checkInDate"> ~
			<input type="date" name="checkOutDate" v-model="checkOutDate">
		</div>
		<div><button @click="">�˻�</button></div>
	</div>
	<div class="room-box">
		<div class="room" v-for="(item, index) in list">
			<div class="left">
				<img :src="item.imgPath" alt="">
			</div>
			<div class="right">
				<div>{{item.roomName}}</div>
				<div>{{item.roomPrice}}��</div>
				<div>{{salesList[index]}}%</div>
				<div>{{item.roomPrice * item.roomSales}}��</div>
				<button @click="fnCart(item)">��ٱ���</button>					
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
				alert("�α��� �� �̿� ������ �����Դϴ�.");
				return;
			}
			if(self.checkInDate == ""){
				alert("üũ�� ��¥�� �������ּ���");
				return;
			}
			if(self.checkOutDate == ""){
				alert("üũ�ƿ� ��¥�� �������ּ���");
				return;
			}
			if(!self.checkInDate || new Date(self.checkInDate) < new Date()){
				alert("��ȿ���� ���� üũ�� ��¥�Դϴ�. ���� ���� ��¥�� �������ּ���.");
				location.reload();
				return;
			}
			if (new Date(self.checkInDate) > new Date(self.checkOutDate)) {
			    alert("üũ�ƿ� ��¥�� üũ�� ��¥���� ���� �� �� �����ϴ�. �ٽ� �������ּ���");
			    location.reload();
			    return;
			}
			
			if(!confirm("��ٱ��Ͽ� �����ðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
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
                	alert("��ǰ�� ��ٱ��Ͽ� �����ϴ�.");
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