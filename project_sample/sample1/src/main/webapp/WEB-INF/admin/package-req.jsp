<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Package Request Page</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	table {
		margin : 30px auto;
		width: 1200px;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
    	border-radius: 5px;
    	background-color: #f4f4f4;
  	 	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	th {
		 padding : 5px 10px;
		 border: 1px solid #ddd;
		 color : white;
		 background-color: #213555;
	}
	tr {
		border-bottom: 1px solid white;
		padding : 5px 10px;
	}
	td {
		padding : 5px 10px;
		border-left-width: 2px;
		
	}
	tr:hover {
	    background-color: #EEEEEE;
	    color : black;
	  }
	#abtn {
		margin : 5px auto;
		border-radius : 20px;
		border : 1px solid #213555;
		width : 80px;
		height: 40px;
		background-color: #213555;
		color : white;
	} 
	#abtn:hover {
	    background-color: grey;
	  }
	#bbtn {
		margin : 5px auto;
		border-radius : 15px;
		border : 1px solid #213555;
		width : 50px;
		height: 20px;
		background-color: #213555;
		color : white;
	} 
	#bbtn:hover {
	    background-color: grey;
	  }
	.packreq{
		background-color : #213555;
		color : white;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="adminbar.jsp" flush="true"></jsp:include>
<div id="app">
	<div style="text-align : center; margin: 20px auto;">
		<h1 style="color : #213555; text-align: center; margin: 50px; font-weight : 20;">��Ű�� ��û ���</h1>
	</div>
	<table>
		<thead>
			<tr > 
				<td colspan="4" style="text-align:left; padding-left: 30px; font-size: 20px; color:#213555;">����</td>
			</tr>
			<tr>	
				<th>����</th>
				<th>ȣ��Ʈ</th>	
				<th>���Ҹ�</th>
				<th>��</th>
				<th>����</th>
				<th>��Ȳ</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="(item,index) in roomList">		
				<td v-if="item.state =='A'" name="room" style="width : 80px">
					<input type="radio" name="room" :value="item.roomNo" @input="changeRoomNo(item, index)">
				</td>
				<td v-else style="width : 80px"> <input type="button" @click="fnState(item)" value="�� ��" id="bbtn"> </td>
				
				<td style="width : 120px">{{item.uId}}</td>
				
			    <td><a href="javascript:;" @click="fnStayView">{{item.stayName}}</a></td>
			    
			    <td style="width : 300px"><a href="javascript:;" @click="fnRoomView">{{item.roomName}}</a></td>
			    
			    <td style="width : 100px">{{item.roomPrice*item.roomSales}}</td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> �� �� �� </div>
			    </td>
			    <td v-else style="width : 80px">
			  	  <div style="color : #f8852a"> �� �� </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	
	<table>
		<thead>
			<tr > 
				<td colspan="4" style="text-align:left; padding-left: 30px; font-size: 20px; color:#213555;">����</td>
			</tr>
			<tr>	
				<th>����</th>
				<th>ȣ��Ʈ</th>
				<th>������</th>
				<th>��������</th>
				<th>����</th>
				<th>��Ȳ</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="(item,index) in leisureList">		
				<td v-if="item.state =='A'" name="leisure" style="width : 80px">
					<input type="radio" :value="item.leisureNo" @input="changeLeisureNo(item, index)" name="leisure">
				</td>
				<td v-else style="width : 80px"> <input type="button" @click="fnState(item)" value="�� ��" id="bbtn"> </td>
				
				<td style="width : 120px">{{item.uId}}</td>
			
			    <td><a href="javascript:;" @click="fnleisureView">{{item.leisureName}}</a></td>
			    
			    <td style="width : 300px">{{item.leisureKind}}</td>
			    
			    <td style="width : 100px">{{item.leisurePrice*item.leisureSales}}</td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> �� �� �� </div>
			    </td>
			    <td v-else style="width : 80px">
			  	  <div style="color : #f8852a"> �� �� </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	
	
	<table>
		<thead>
			<tr> 
				<td colspan="4" style="text-align:left; padding-left: 30px; font-size: 20px; color:#213555;">��Ʈī</td>
			</tr>
			<tr>	
				<th>����</th>
				<th>ȣ��Ʈ</th>	
				<th>����</th>
				<th>����</th>
				<th>����</th>
				<th>��Ȳ</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="(item,index) in rentList">		
				<td v-if="item.state =='A'" name="rent" style="width : 80px">
					<input type="radio" :value="item.rentNo" @input="changeRentNo(item, index)" name="rent">
				</td>
				<td v-else style="width : 80px"> <input type="button" @click="fnState(item)" value="�� ��" id="bbtn"> </td>
				
				<td style="width : 120px">{{item.uId}}</td>
				
			    <td><a href="javascript:;" @click="fnRentView">{{item.rentName}}</a></td>
			    
			    <td style="width : 300px">{{item.rentKind}}</td>
			    
			    <td style="width : 100px">{{item.rentPrice*item.rentSales}}</td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> �� �� �� </div>
			    </td>
			    <td v-else style="width : 80px">
			  	  <div style="color : #f8852a"> �� �� </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	<div style="text-align : center;">
		<input style="width : 150px; " type="button" value="�� Ű �� �� ��" id="abtn" @click="fnYbtn(selectRoom, selectRent, selectLeisure)">
	</div>
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		item : [],
		rentList : [],
		roomList : [],
		leisureList : [],
		selectRoom : "",
		selectLeisure : "",
		selectRent : "",
		status : "${sessionStatus}",
		state : "${state}",
		rentIndex : "",
		roomIndex : "",
		leisureIndex : ""
	},// data
	methods : {
		fnRentList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/packageRentList.dox",
                dataType:"json",
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.rentList = data.list;
                }
            }); 
		},
		fnRoomList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/packageRoomList.dox",
                dataType:"json",
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.roomList = data.list;
                }
            }); 
		},
		fnLeisureList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/packageLeisureList.dox",
                dataType:"json",
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.leisureList = data.list;
                }
            }); 
		},
		fnYbtn : function(selectRoom, selectRent, selectLeisure, selectItem){
			var self = this;
			
			if(selectRoom == ""|| selectRoom == null || selectRent == "" ||  selectRent == null || selectLeisure == "" || selectLeisure == null){
				alert("����, ����, ��Ʈī�� ��� �������ּ���.");
				return;
			}
			
			var sPrice = (self.roomList[self.roomIndex].roomPrice*self.roomList[self.roomIndex].roomSales);
			var rPrice = (self.rentList[self.rentIndex].rentPrice*self.rentList[self.rentIndex].rentSales);
			var lPrice = (self.leisureList[self.leisureIndex].leisurePrice*self.leisureList[self.leisureIndex].leisureSales);
			var pPrice = sPrice + rPrice + lPrice;
			
			var packageName = prompt("��Ű�� �̸��� �Է����ּ���.");
			if (packageName == null || packageName == "") {
				alert("�̸��� �Է����ּ���.");
				return;
			}
			
			var nparmap = {selectRoom : self.selectRoom, selectRent : self.selectRent, selectLeisure : self.selectLeisure, packageName : packageName, pPrice : pPrice};
			console.log(nparmap);
			
			 $.ajax({
	                url : "/requestInsert.dox",
	                dataType:"json",
	                type : "POST",
	                data : nparmap,
	                success : function(data) { 
	                	alert("��Ű�� ����� �Ϸ�Ǿ����ϴ�.");
	                	self.fnRentList();
	            		self.fnRoomList();
	            		self.fnLeisureList();
	                }
	            }); 
		},
		fnState : function(item){
			var self = this;
            var nparmap = {productNo : item.productNo};
            $.ajax({
                url : "/stateChange.dox",
                dataType:"json",
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	alert("���Ǿ����ϴ�.");
                	self.fnRentList();
            		self.fnRoomList();
            		self.fnLeisureList();
                }
            }); 
		},
		fnStayView : function(){
        	var self = this;
			$.pageChange("../host/stay/view.do", {stayNo : self.stayNo}); 
        },
		fnRentView : function(){
        	var self = this;
			$.pageChange("../host/rentcar/view.do", {rentNo : self.rentNo}); 
        },
        fnRoomView : function(){
        	var self = this;
			$.pageChange("../host/room/view.do", {roomNo : self.roomNo}); 
        },
        fnleisureView : function(){
        	var self = this;
			$.pageChange("../host/leisure/view.do", {leisureNo : self.leisureNo}); 
        },
        changeRoomNo : function(item, index){
        	var self = this;
        	self.selectRoom = item.roomNo;
        	self.roomIndex = index;
        },
        changeRentNo : function(item, index){
        	var self = this;
        	self.selectRent = item.rentNo;
        	self.rentIndex = index;
        },
        changeLeisureNo : function(item, index){
        	var self = this;
        	self.selectLeisure = item.leisureNo;
        	self.leisureIndex = index;
        }
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		
		 if(self.status != 'A'){
			alert("���� ����");
			location.href="../main.do";
		}  
		self.fnRentList();
		self.fnRoomList();
		self.fnLeisureList();
	}// created
});
</script>