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
		font-family: Arial, sans-serif;
  		border: 1px solid #ccc;
   		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    	border-radius: 5px;
	}
	th {
		padding : 5px 10px;
		 background-color: #3498db;
    	color: white;
	}
	tr {
		border-bottom: 1px solid black;
		padding : 5px 10px;
	}
	td {
		border : 1px solid black;
		padding : 5px 10px;
		border-bottom: 1px solid #ddd;
	}
	tr:nth-child(even) {
	    background-color: #f2f2f2;
	}
	
	td:hover {
	    background-color: #ddd;
	}
	#abtn {
	margin : 5px auto;
		width : 60px;
		height: 30px;
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
				<th>��Ȳ</th>
			<tr>
		</thead>
		<tbody v-for="(item, index) in list">
			<tr >		
				<td rowspan="3" style="width : 80px; font-size : 20px;">{{index + 1}}</td>
				
				<td rowspan="3" style="width : 120px">{{item.uId}}</td>
				
				<td style="width : 60px; font-weight : bold;">����</td>
				
			    <td v-if="item.roomName == null || item.roomName == ''"> - </td>
			    <td v-else>{{item.roomName}}</td>
			    
			    <td rowspan="3" v-if="item.state == 'D'" style="width : 80px">
			    	<div> �� �� �� </div>
			    	<div><input type="button" value="�� ��" id="abtn" @click="fnYbtn(item.roomNo, item.rentNo, item.leisureNo)"></div>
			    	     
			    </td>
			    <td rowspan="3" v-else>
			  	  <div > ��û�Ϸ� </div>
			  	</td>
			</tr>
			
			<tr>
				<td style="width : 60px; font-weight : bold;">����</td>
				
				<td v-if="item.leisureName == null || item.leisureName == ''"> - </td>
				<td v-else>{{item.leisureName}}</td>
			</tr>
			
			<tr>
				
				<td style="width : 60px; font-weight : bold;">����ī</td>
				<td>{{item.rentName}}</td>
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
		},
		fnYbtn : function(roomNo, rentNo, leisureNo){
			var self = this;
			var nparmap = {roomNo : roomNo, rentNo : rentNo, leisureNo : leisureNo};
			 $.ajax({
	                url : "/requestApp.dox",
	                dataType:"json",
	                type : "POST",
	                data : nparmap,
	                success : function(data) { 
	                	alert("���Ǿ����ϴ�.");
	                	self.info = data.info;
	                	self.fnGetList();
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