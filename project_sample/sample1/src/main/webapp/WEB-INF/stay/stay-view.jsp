<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<link href="../css/stay/stay-view.css" rel="stylesheet"/>
<title>���� �� ������</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
        padding: 0;
        background-color: #f2f2f2;
    }
    .room-date input{
    	font-family: 'Jeju Gothic', sans-serif;
    }
    .cart-button{
    	font-family: 'Jeju Gothic', sans-serif;
    }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="view-container">
		<div class="stay-view-container">
			<div class="stay-img">
				<img :src="info.imgPath" alt="">
			</div>
			<div class="stay-info">
				<p class="stay-name">{{info.stayName}}</p>
				<p class="stay-addr">
					<span style="color: black; font-weight: bold;">�ּ� </span> 
					<span style="margin-left:4px;">{{info.sAddr}}</span>
				</p>
				<p class="stay-type">
					<span style="color: black; font-weight: bold;">��������</span> 
					<span style="margin-left:4px;">{{info.cName}}</span>
				</p>
				<p class="stay-checkIn">
					<span style="color: black; font-weight: bold;">üũ��</span> 
					<span style="margin-left:4px;">14:00����</span>
				</p>
				<p class="stay-checkOut">
					<span style="color: black; font-weight: bold;">üũ�ƿ�</span>
					<span style="margin-left:4px;">10:00����</span> 
				</p>
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
						<img :src="item.imgPath" alt="���� ����">
					</div>
					<div class="room-detail">
						<div class="room-name">{{item.roomName}}</div>
						<div>
							<span style="color: red; font-weight: bold; font-size: 20px;">{{salesList[index]}}%</span> 
							<span style="text-decoration:line-through;">{{item.roomPrice | comma }}��</span>
						</div>
						<div class="room-salesPrice">
							<span>{{item.roomPrice * item.roomSales  | comma }}��</span>
						</div>
						<button class="cart-button" @click="fnCart(item)">��ٱ���</button>					
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
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