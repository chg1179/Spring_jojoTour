<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌트카 관리 페이지</title>
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
		레저
		<table>
			<tr>
				<th>선택</th>
				<th>No.</th>
				<th>레저 이름</th>
				<th>레저 가격</th>
				<th>주소</th>
				<th>상세 주소</th>
				<th>레저 종류</th>
			</tr>		
			
			<tr v-for="item in list">
				<td><input type="radio"></td>
				<td>{{item.leisureNo}}</td>
				<td>{{item.leisureName}}</td>
				<td>{{item.leisurePrice}}</td>
				<td>{{item.lAddr}}</td>
				<td>{{item.lDetailAddr}}</td>
				<td>{{item.cName}}</td>
			</tr>
		</table>
		<div>
			<span><button>추가</button></span>
			<span><button @click="fnEdit">수정</button></span>
			<span><button>삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : []
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "leisure.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.leisureList;
                	console.log(self.list);
                }
            }); 
		},
		fnEdit : function(){
			$pageChange("");
		},
		/* fnAdd : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "leisureEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	
                }
            }); 
		} */
		
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>