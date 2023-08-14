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
<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div>객실 상세정보 페이지</div>
		<table>
			<tr>
				<td>No.</td>
				<td>{{info.roomNo}}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>{{info.roomName}}</td>
			</tr>
			<tr>
				<th>객실금액</th>
				<td>{{info.roomPrice}}</td>
			</tr>
			<tr>
				<th>할인금액</th>
				<td>{{info.roomPrice * info.roomSales}}</td>
			</tr>
			<tr>
				<th>할인율</th>
				<td>{{sales}}%</td>
			</tr>
			<tr>
				<th>판매수량</th>
				<td>{{info.roomResidue}}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>{{info.roomInsertTime}}</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td>{{info.roomUpdateTime}}</td>
			</tr>
		</table>
		<div>
			<span><button @click="">수정</button></span>
			<span><button @click="fnRemove">삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		info : {},
		roomNo : "${map.roomNo}",
		sales : 0,
		discount : 0
		
	},// data
	methods : {
		fnGetList : function(){
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
              	 	self.sales = 100 - (self.info.roomSales * 100);
                }
            }); 
		},
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
                	alert("삭제되었습니다.");
                	
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
	//	self.fnGetList();
	}// created
});
</script>