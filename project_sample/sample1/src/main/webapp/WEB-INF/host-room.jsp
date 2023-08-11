<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
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
	<div id="app">
		숙소 방 등록 페이지
		<table>
			<tr>
				<th>No.</th>
				<th>객실 타입</th>
				<th>객실 가격</th>
				<th>최대 수용 인원</th>
			</tr>
			
			<tr v-for="item in list">
				<td>{{item.roomNo}}</td>
				<td>{{item.roomName}}</td>
				<td>{{item.roomPrice}}</td>
				<td>{{item.peopleMax}}명</td>
			</tr>
		</table>
		<div>
			<span><button>객실 추가</button></span>
			<span><button>객실 삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
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
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>