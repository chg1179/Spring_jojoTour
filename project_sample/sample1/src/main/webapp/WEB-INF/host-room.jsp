<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.container {
		display: flex;
		justify-content: center;
		margin-top: 30px;
	}
	.container h3{
		text-align: center;
		padding: 14px;
	}
	.host-table{
		width: 1000px;
		border-top: 1px solid black;
		border-botton: 1px solid black;
		border-collapse: collapse;
	}
	
	.host-table a {
		color: #333;
		display: inline-block;
		line-height : 1.4;
	}
	.host-table a:hover{
		text-decoration: underline;
	}
	
	.host-table th, .host-table td{
		text-align: center;
		padding: 14px 0;
		border-bottom: 1px solid black;
		border-left: 1px solid #ccc; 
		border-right: 1px solid #ccc; 
	}
	.host-table th:first-child,
	.host-table td:first-child {
		border-left: none;
	}

	.host-table th:last-child,
	.host-table td:last-child {
		border-right: none;
	}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
	<div class="container">
		<h3>숙소 방 등록 페이지</h3>
	</div>
		<div class="container">
			<table class="host-table">
				<thead>
					<tr>
						<th>선택</th>
						<th>No.</th>
						<th>객실 타입</th>
						<th>객실 가격</th>
						<th>최대 수용 인원</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in list">
						<td>
							<input type="radio" v-model="roomNo" :value="item.roomNo" name="roomNo" checked="checked">
						</td>
						<td>{{item.roomNo}}</td>
						<td>{{item.roomName}}</td>
						<td>{{item.roomPrice}}</td>
						<td>{{item.peopleMax}}명</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="container">
			<span><button @click="fnAdd">객실 추가</button></span>
			<span><button @click="fnUpdate">객실 수정</button></span>
			<span><button @click="fnRemove">객실 삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		roomNo : ""
	},// data
	methods : {
		fnGetList : function(){
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
                }
            }); 
		},
		
		// 객실 추가
		fnAdd : function(){
			location.href = "roomAdd.do";
		},
		
		// 객실 수정
		fnUpdate : function (){
			var self = this;
			$.pageChange("roomEdit.do", {roomNo : self.roomNo});
			
		},
		
		// 객실 삭제
		fnRemove : function(){
			var self = this;
			if(!confirm("해당 객실을 삭제하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomRemove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("해당 객실이 삭제되었습니다.");
                	self.fnGetList();
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