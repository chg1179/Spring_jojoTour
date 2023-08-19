<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	table{
		border : 1px solid black;
		border-collapse: collapse;
		/* text-align : center; */
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
		객실 추가 페이지
		<table>
			<tbody>
				<tr>
					<th>
						객실 정보
					</th>
					<td>
						<div>
							<span>객실유형</span>
							<span>
								<input type="text" v-model="info.roomName" name="roomName" id="roomName">
							</span>
						</div>
						<div>
							<span>가격</span>
							<span>
								<input type="text" v-model="info.roomPrice" name="roomPrice" id="roomPrice">
							</span>
						</div>
						<div>
							<span>할인율</span>
							<span>
								<input type="text" v-model="info.roomSales" name="roomSales" id="roomSales">
							</span>
						</div>
						<div>
							<span>인원</span>
							<span>
								<select v-model="peopleMaxValue" >
									<option :key="index" :value="item.value" v-for="(item, index) in selectList">{{item.text}}</option>
								</select>
							</span>
						</div>
					</td>
				</tr>
				
				<tr>
					<th>파일</th>
					<td><input type="file" accept=".gif, .jpg, .png" id="stayFile" name="file"></td>
				</tr>
			</tbody>
		</table>
		<button @click="fnRoomAdd">객실 등록</button>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		peopleMaxValue : "",
		uId : "${sessionId}",
		stayNo : "${map.stayNo}",
		serviceNo : 0,
		info : {
			roomNo : 0,
			roomName : "",
			roomPrice : "",
			roomSales : "",
			peopleMax : 0,
		},
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
		// 룸서비스 리스트
		fnRoomAdd : function(){
			var self = this;
			if(!confirm("객실을 등록하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {
				roomName : self.info.roomName,
				roomPrice : self.info.roomPrice,
				peopleMax : self.peopleMaxValue,
				stayNo : self.stayNo,
				uId : self.uId,
				roomNo : self.info.roomNo,
				
			};
			$.ajax({
                url : "roomAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
            		alert("객실이 등록되었습니다.");
            		location.href="/host/stay.do";
            		self.selectServiceList = [];
            	//	console.log(self.roomNo);
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetOption();
	}// created
});
</script>