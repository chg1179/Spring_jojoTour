<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
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
			<h3>숙박 업체 등록</h3>
		</div>
		<!-- stay list area -->
		<div id="host-list">
			<div class="container">
				<table class="host-table">
					<thead>
						<tr>
							<th>No.</th>
							<th>업체명</th>
							<th>주소</th>
							<th>상세 주소</th>
							<th>숙소타입</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="item in list">
							<td>{{item.stayNo}}</td>
							<td><a @click="fnMove" href="javascript:;" v-model="stayNo">{{item.stayName}}</a></td>
							<td>{{item.sAddr}}</td>
							<td>{{item.sDetailAddr}}</td>
							<td>{{item.cName}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="container">
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
		status : "${sessionStatus}",
		stayNo : ""
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
		fnMove : function(){
			var self = this;
			$.pageChange("room.do", {stayNo : self.stayNo});
		},
		fnAdd : function(){
			location.href = "/host/stayAdd.do"
		}
		
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		/*  if(self.status != 'H'){
			alert("권한 없음");
			location.href="../main.do";
		} */
		self.fnGetList();
	}// created
});
</script>