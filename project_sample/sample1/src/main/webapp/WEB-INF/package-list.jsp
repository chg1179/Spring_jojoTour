<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>User List</title>
<style>
	table {
		margin : 30px auto;
		width : 1400px;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
	}
	th {
		padding : 5px 10px;
	}
	tr {
		border-bottom: 1px solid black;
		padding : 5px 10px;
	}
	td {
		border : 1px solid black;
		padding : 5px 10px;
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div id="app">
	<table>
		<thead>
			<tr>	
				<th>��ȣ</th>
				<th>ȣ��Ʈ</th>
				<th>�з�</th>
				<th>��ü��</th>
				<th>��ư</th>
			<tr>
		</thead>
		<tbody>
			<tr >		
				<td rowspan="3">��ȣ</td>
				<td rowspan="3">ȣ��Ʈ</td>
				<td>����</td>
			    <td>����</td>
			    <td rowspan="3">
			    	<div><input type="button" value="���"></div>
			    	<div><input type="button" value="����"></div>
			    </td>
			</tr>
			<tr>
				<td>����</td>
				<td>����</td>
			</tr>
			<tr>
				
				<td>����ī</td>
				<td>����ī</td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}"
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/packageList.dox",
                dataType:"json",	
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                }
            }); 
		}
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		 if(self.status != 'A'){
			alert("���� ����");
			location.href="../main.do";
		}  
		self.fnGetList();
	}// created
});
</script>