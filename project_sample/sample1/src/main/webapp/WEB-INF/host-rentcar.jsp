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
		��Ʈī
		<table>
			<tr>
				<th>����</th>
				<th>No.</th>
				<th>�� �̸�</th>
				<th>�� ����</th>
				<th>�ּ�</th>
				<th>���ּ�</th>
				<th>��Ʈ �ݾ�</th>
			</tr>		
			
			<tr v-for="item in list">
				<td>
					<input type="radio" v-model="productNo" :value="item.productNo" name="productNo">
				</td>
				<td>{{item.productNo}}</td>
				<td>{{item.productName}}</td>
				<td>{{item.carType}}</td>
				<td>{{item.pAddr}}</td>
				<td>{{item.pDetailAddr}}</td>
				<td>{{item.productPrice}}</td>
			</tr>
		</table>
		<div>
			<span><button>�߰�</button></span>
			<span><button>����</button></span>
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
		productNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "rentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.carList;
                }
            }); 
		},
		fnRemove : function(){
            var self = this;
            
            console.log(self.productNo);
	        if(!confirm("�ش� ��Ʈī�� �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
            var param = {productNo : self.productNo};
            
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
		
		
		
        /* $.pageChange("edit.do", {bNo : self.bNo}); */
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>