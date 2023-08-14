<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��Ʈī ������ ������</title>
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
		<div>No.</div>
		<table>
			<tr>
				<th>No.</th>
				<th>{{info.rentNo}}</th>
			</tr>
			<tr>
				<th>�̸�</th>
				<th>{{info.rentName}}</th>
			</tr>
			<tr>
				<th>�з�</th>
				<th>{{info.cName}}</th>
			</tr>
			<tr>
				<th>�����ȣ</th>
				<th>{{info.rZipno}}</th>
			</tr>
			<tr>
				<th>�ּ�</th>
				<th>{{info.rAddr}}</th>
			</tr>
			<tr>
				<th>���ּ�</th>
				<th>{{info.rDetailAddr}}</th>
			</tr>
			<tr>
				<th>��Ʈ�ݾ�</th>
				<th>{{info.rentPrice}}</th>
			</tr>
			<tr>
				<th>���αݾ�</th>
				<th>{{info.rentPrice * info.rentSales}}</th>
			</tr>
			<tr>
				<th>������</th>
				<th>{{sales}}%</th>
			</tr>
			<tr>
				<th>�Ǹż���</th>
				<th>{{info.rResidue}}</th>
			</tr>
			<tr>
				<th>��ȸ��</th>
				<th>{{info.rRead}}</th>
			</tr>
			<tr>
				<th>�����</th>
				<th>{{info.rInsertTime}}</th>
			</tr>
			<tr>
				<th>������</th>
				<th>{{info.rUpdateTime}}</th>
			</tr>
		</table>
		<div>
			<span><button @click="fnUpdate">����������</button></span>
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
		rentNo : "${map.rentNo}",
		sales : 0,
		discount : 0 
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.carInfo;
                	self.sales = 100 - (self.info.rentSales * 100);
                }
            }); 
		},
		fnUpdate : function(){
			$.pageChange("rentcar/edit.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("�ش� ��Ʈī�� �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
            var param = {rentNo : self.rentNo};
            
            $.ajax({
                url : "carRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("�ش� ��Ʈī�� ������ �����Ǿ����ϴ�.");
                	location.href = "../rentcar.do"; 
                }
            });  
        },
        changeRentNo : function(rentNo){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.rentNo = rentNo;
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>