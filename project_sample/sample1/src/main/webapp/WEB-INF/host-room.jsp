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
		���� �� ��� ������
		<table>
			<tr>
				<th>����</th>
				<th>No.</th>
				<th>���� Ÿ��</th>
				<th>���� ����</th>
				<th>�ִ� ���� �ο�</th>
			</tr>
			
			<tr v-for="item in list">
				<td>
					<input type="radio" v-model="roomNo" :value="item.roomNo" name="roomNo">
				</td>
				<td>{{item.roomNo}}</td>
				<td>{{item.roomName}}</td>
				<td>{{item.roomPrice}}</td>
				<td>{{item.peopleMax}}��</td>
			</tr>
		</table>
		<div>
			<span><button>���� �߰�</button></span>
			<span><button>���� ����</button></span>
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
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>