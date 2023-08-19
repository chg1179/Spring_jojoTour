<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		객실 수정 페이지
		<table>
			<tr>
				<th>No.</th>
				<td><input v-model="info.roomNo" type="text" name="roonNo" id="roonNo" disabled></td>
			</tr>
			<tr>
				<th>객실 타입</th>
				<td><input v-model="info.roomName" type="text" name="roomName" id="roomName"></td>
			</tr>
			<tr>
				<th>객실 가격</th>
				<td><input v-model="info.roomPrice" type="text" name="roomPrice" id="roomPrice"></td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input v-model="info.roomSales" type="text" name="roomSales" id="roomSales"></td>
			</tr>
			<tr>
				<th>남은 객실</th>
				<td><input v-model="info.roomResidue" type="text" name="roomResidue" id="roomResidue"></td>
			</tr>
			<tr>
				<th>인원</th>
				<td>
					<select v-model="info.peopleMax" >
						<option :key="index" :value="item.value" v-for="(item, index) in selectList">{{item.text}}</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>파일</th>
				<td><input type="file" accept=".gif, .jpg, .png" id="stayFile" name="file"></td>
			</tr>
		</table>
		<div>
			<button @click="fnUpdate">수정</button>
			<span><button @click="fnBack">돌아가기</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		peopleMaxValue : "",
		info : {},
		roomNo : "${map.roomNo}",
		stayNo : "${map.stayNo}",
		selectList : [
			{value:"1", text : "1 명"},			
			{value:"2", text : "2 명"},			
			{value:"3", text : "3 명"},			
			{value:"4", text : "4 명"},			
			{value:"5", text : "5 명"},			
			{value:"6", text : "6 명"},			
			{value:"7", text : "7 명"},			
			{value:"8", text : "8 명"},			
			{value:"9", text : "9 명"},			
			{value:"10", text : "10 명"},			
				
		]
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.roomInfo;
                	console.log(self.info);
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			if(!confirm("객실 정보를 수정하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {
					roomName : self.info.roomName, 
					roomPrice : self.info.roomPrice,
					peopleMax : self.info.peopleMax,
					roomResidue : self.info.roomResidue,
					roomSales : self.info.roomSales,
					roomNo : self.roomNo
				};
			$.ajax({
                url : "roomEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("수정되었습니다.");
                	self.fnGetInfo();
                }
            }); 
		},
		fnBack : function(){
			var self = this;
			console.log(self.stayNo);
			var url = "room.do?stayNo=" + encodeURIComponent(self.stayNo);
		    window.location.href = url;
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>