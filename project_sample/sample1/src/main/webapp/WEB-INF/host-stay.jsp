<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
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
	a {
		
	}
</style>
</head>
<body>
	<div id="app">
		
		<table>
			<tr>
				<th>No.</th>
				<th>업체명</th>
				<th>주소</th>
				<th>상세 주소</th>
				<th>숙소타입</th>
			</tr>
			
			<tr v-for="item in list">
				<td>{{item.stayNo}}</td>
				<td><a @click="fnMove(item)" href="javascript:;">{{item.stayName}}</a></td>
				<td>{{item.sAddr}}</td>
				<td>{{item.sDetailAddr}}</td>
				<td>{{item.cName}}</td>
			</tr>
		</table>
		<div>
			<span><button @click="fnAdd">숙박 업체 추가</button></span>
			<!-- <span><button @click="">업체 정보 수정</button></span>
			<span><button @click="fnRemove">업체 정보 삭제</button></span> -->
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
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                }
            }); 
		},
		fnMove : function(item){
			$.pageChange("/host/room.do", {stayNo : item.stayNo});
		},
		fnAdd : function(){
			location.href = "/host/stayAdd.do"
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>