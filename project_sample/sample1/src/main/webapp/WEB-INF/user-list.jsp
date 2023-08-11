<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>User List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.custom-table {
		margin : 30px auto;
		width : 1400px;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
	}
	th {}
		padding : 5px 10px;
	}
	tr {
		border-bottom: 1px solid black;
		padding : 5px 10px;
	}
	td {
		padding : 5px 10px;
	}
</style>
</head>
<body>
<div id="app">
	<table class="table custom-table table-striped table-bordered">
	<thead class="thead-dark">
		<tr>	
			
			<th>���̵�</th>
			<th>�г���</th>
			<th>�̸�</th>
			<th>�ڵ���</th>
			<th>�̸���</th>
			<th>�������</th>
			<th>�ּ�</th>
			<th>�̺�Ʈ ����</th>
			<th>����</th>
			<th>��������</th>
		</tr>
		</thead>
		<tr v-for="(item, index) in list"  v-if="item.status =='U'">		
			
			<td>{{item.uId}}</td>
			<td>{{item.nickname}}</td>
			<td>{{item.uName}}</td>
			<td>{{item.phone}}</td>
			<td>{{item.email}}</td>
			<td>{{item.birth}}</td>
			<td>{{item.addr}} {{item.addrDetail}}</td>
			<td v-if="item.eventyn == 'Y'">����</td>
			<td v-else="item.eventyn == 'N'">�ź�</td>
			<td><button v-if="item.loginCnt >= 5" @click="fnReset(item)" style="border-radius: 4px;">����</button></td>
			<td v-if="item.banyn == 'N'"><button @click="fnBan(item, 'Y')" style="border-radius: 4px;">����</button></td>
			<td v-else><button @click="fnBan(item, 'N')" style="border-radius: 4px;">��������</button></td>
		</tr>
	</table>
	
		
		
	
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}",
		userList : []
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/userList.dox",
                dataType:"json",	
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                }
            }); 
		},
		 pageChange : function(url, param) {
				var target = "_self";
				if(param == undefined){
					return;
				}
				var form = document.createElement("form"); 
					form.name = "dataform";
					form.action = url;
					form.method = "post";
					form.target = target;
				for(var name in param){
					var item = name;
					var val = "";
					if(param[name] instanceof Object){
						val = JSON.stringify(param[name]);
					} else {
						val = param[name];
					}
					var input = document.createElement("input");
					input.type = "hidden";
					input.name = item;
					input.value = val;
					form.insertBefore(input, null);
				}
				document.body.appendChild(form);
				form.submit();
				document.body.removeChild(form);
			},
		fnReset : function(item){
            var self = this;
            var nparmap = {userId : item.uId};
            $.ajax({
                url : "/reset.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	alert("�����Ǿ����ϴ�");
                	self.fnGetList();
                }
            }); 
		},
		fnBan : function(item, banyn){
			var self = this;
			 var nparmap = {userId : item.uId, banyn : banyn};
	            $.ajax({
	                url : "/ban.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	alert("�����Ǿ����ϴ�");
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