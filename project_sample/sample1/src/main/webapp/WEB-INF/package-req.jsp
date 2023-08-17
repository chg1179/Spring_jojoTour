<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>User List</title>
<style>
	table {
		margin : 30px auto;
		width : 1400px;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
		font-family: Arial, sans-serif;
   		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    	border-radius: 5px;
	}
	th {
		padding : 5px 10px;
	}
	tr {
		border-bottom: 1px solid black;
		padding : 5px 10px;
	}
	td {
		border : 1px solid black;
		padding : 5px 10px;
		border-bottom: 1px solid #ddd;
	}

	#abtn {
	margin : 5px auto;
		width : 60px;
		height: 30px;
	} 
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div id="app">
	<div style="text-align : center; margin: 20px auto;">
		<h2>패키지 신청 목록</h2>
		<hr style="width: 1000px; margin: 2px auto;">
	</div>
	<table>
		<thead>
			<tr>	
				<th>선택</th>
				<th>호스트</th>	
				<th>숙소명</th>
				<th>현황</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="item in roomList">		
				<td name="room" style="width : 80px"><input type="radio" :value="item.roomNo" v-model="selectRoom"></td>
				
				<td style="width : 120px">{{item.uId}}</td>
				
			    <td><a href="javascript:;" @click="fnRoomView">{{item.roomName}}</a></td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> 보 류 중 </div>
			    </td>
			    <td v-else>
			  	  <div > 신청완료 </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	
	
	<table>
		<thead>
			<tr>	
				<th>선택</th>
				<th>호스트</th>
				<th>레저명</th>
				<th>현황</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="item in leisureList">		
				<td name="leisure" style="width : 80px"><input type="radio" :value="item.leisuretNo" v-model="selectLeisure"></td>
				
				<td style="width : 120px">{{item.uId}}</td>
				
			    <td><a href="javascript:;" @click="fnleisureView">{{item.leisureName}}</a></td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> 보 류 중 </div>
			    </td>
			    <td v-else>
			  	  <div > 신청완료 </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	
	<table>
		<thead>
			<tr>	
				<th>선택</th>
				<th>호스트</th>	
				<th>렌트카</th>
				<th>현황</th>
			<tr>
		</thead>
		<tbody >
			<tr v-for="item in rentList">		
				<td name="rent" style="width : 80px"><input type="radio" :value="item.rentNo" v-model="selectRent"></td>
				
				<td style="width : 120px">{{item.uId}}</td>
				
			    <td><a href="javascript:;" @click="fnRentView">{{item.rentName}}</a></td>
			    
			    <td v-if="item.state == 'D'" style="width : 80px">
			    	<div> 보 류 중 </div>
			    </td>
			    <td v-else>
			  	  <div > 신청완료 </div>
			  	</td>
			</tr>
		</tbody>
	</table>
	<div style="text-align : center;"><input type="button" value="허 용" id="abtn" @click="fnYbtn(item.roomNo, item.rentNo, item.leisureNo)"></div>
</div>
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
		status : "${sessionStatus}"
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
		fnYbtn : function(roomNo, rentNo, leisureNo){
			var self = this;
			var nparmap = {roomNo : roomNo, rentNo : rentNo, leisureNo : leisureNo};
			 $.ajax({
	                url : "/requestApp.dox",
	                dataType:"json",
	                type : "POST",
	                data : nparmap,
	                success : function(data) { 
	                	alert("허용되었습니다.");
	                	self.info = data.info;
	                	self.fnRentList();
	            		self.fnRoomList();
	            		self.fnLeisureList();
	                }
	            }); 
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
        }
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		
		 if(self.status != 'A'){
			alert("권한 없음");
			location.href="../main.do";
		}  
		self.fnRentList();
		self.fnRoomList();
		self.fnLeisureList();
	}// created
});
</script>