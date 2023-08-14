<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		��Ʈī
		<table>
			<tr>
				<th>����</th>
				<th>No.</th>
				<th>�̸�</th>
				<th>�з�</th>
				<th>��Ʈ�ݾ�</th>
				<th>�Ǹż���</th>
				<th>�����</th>
			</tr>		
			
			<tr v-for="(item, index) in list">
				<td>
					<input v-if="index==0" type="radio" :value="item.rentNo" @input="changeRentNo(item.rentNo)" name="rentNo" checked="checked">
					<input v-else type="radio" :value="item.rentNo" @input="changeRentNo(item.rentNo)" name="rentNo">
				</td>
				<td>{{item.rentNo}}</td>
				<td>{{item.rentName}}</td>
				<td>{{item.cName}}</td>
				<td>{{item.rentPrice}}</td>
				<td>{{item.rResidue}}</td>
				<td>{{item.rInsertTime}}</td>
			</tr>
		</table>
		<div>
			<span><button @click="fnAdd">��ǰ���</button></span>
			<span><button @click="fnView">����������</button></span>
			<span><button @click="fnRemove">����</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		rentNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "rentcar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.carList;
                	self.rentNo = self.list[0].rentNo; //����Ʈ�� ù ��° ���� ����Ʈ�� üũ�ϰ�, �ش� pk ���� �޾ƿ´�.
                }
            }); 
		},
		fnAdd : function(){
			location.href = "rentcar/edit.do"; 
        },
        fnView : function(){
        	var self = this;
			$.pageChange("rentcar/view.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
            console.log(self.rentNo);
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
                	self.fnGetList();
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
		self.fnGetList();
	}// created
});
</script>