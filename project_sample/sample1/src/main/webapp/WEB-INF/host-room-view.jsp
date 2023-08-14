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
		<div>���� ������ ������</div>
		<table>
			<tr>
				<th>No.</th>
				<th>{{info.roomNo}}</th>
			</tr>
			<tr>
				<th>�̸�</th>
				<th>{{info.roomName}}</th>
			</tr>
			<tr>
				<th>���Ǳݾ�</th>
				<th>{{info.roomPrice}}</th>
			</tr>
			<tr>
				<th>���αݾ�</th>
				<th>{{info.roomPrice * info.roomSales}}</th>
			</tr>
			<tr>
				<th>������</th>
				<th>{{sales}}%</th>
			</tr>
			<tr>
				<th>�Ǹż���</th>
				<th>{{info.roomResidue}}</th>
			</tr>
			<tr>
				<th>�����</th>
				<th>{{info.roomInsertTime}}</th>
			</tr>
			<tr>
				<th>������</th>
				<th>{{info.roomUpdateTime}}</th>
			</tr>
		</table>
		<div>
			<span><button @click="">����</button></span>
			<span><button @click="fnRemove">����</button></span>
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
			if(!confirm("�ش� ������ �����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomRemove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�����Ǿ����ϴ�.");
                	
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