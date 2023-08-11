<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>��Ʈī ���� ������</title>
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
		����
		<table>
			<tr>
				<th>����</th>
				<th>No.</th>
				<th>���� �̸�</th>
				<th>���� ����</th>
				<th>�ּ�</th>
				<th>�� �ּ�</th>
				<th>���� ����</th>
			</tr>		
			
			<tr v-for="item in list">
				<td><input type="radio"></td>
				<td>{{item.productNo}}</td>
				<td>{{item.productName}}</td>
				<td>{{item.productPrice}}</td>
				<td>{{item.pAddr}}</td>
				<td>{{item.pDetailAddr}}</td>
				<td>{{item.leisureName}}</td>
				
			</tr>
		</table>
		<div>
			<span><button>�߰�</button></span>
			<span><button>����</button></span>
			<span><button>����</button></span>
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
                	self.list = data.LeisureList;
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