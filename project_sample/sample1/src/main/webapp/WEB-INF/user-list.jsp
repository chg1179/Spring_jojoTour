<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>

<meta charset="EUC-KR">
<title>User List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/paging-style.css" rel="stylesheet"/>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	.custom-table {
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
		padding : 5px 10px;
	}
   .paginate_box{
	display: flex;
	justify-content: center;
	width: 100%;
   }
   .paginate_box a {
       color:#666;
       text-decoration: none;
       width : 100%;
       height : 100%;
       display : block;
   }
	
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="adminbar.jsp" flush="true"></jsp:include>
<div id="app">
<h2 style="color : #f8852a; text-align: center; margin-top: 30px;">���� ���</h2>
	<table class="table custom-table table-striped table-bordered ">
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
		<tbody>
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
	<div class="paginate_box">
		<template>
			<paginate
			:page-count="pageCount"
			:page-range="3"
			:margin-pages="2"
			:click-handler="fnSearch"
			:prev-text="'<'"
			:next-text="'>'"
			:container-class="'pagination'"
			:page-class="'page-item'">
			</paginate>
		</template>
	</div>
	</tbody>	
</div>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		selectPage: 1,
	    pageCount: 1,
	    cnt : 0,
		status : "${sessionStatus}",
		userList : []
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var startNum = ((self.selectPage-1) * 10);
            var lastNum = 10;
            var nparmap = {startNum : startNum, lastNum : lastNum};
            $.ajax({
                url : "/userList.dox",
                dataType:"json",	
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                	 self.cnt = data.cnt;
                     self.pageCount = Math.ceil(self.cnt / 10);
                }
            }); 
		},
		fnSearch : function(pageNum){
	         var self = this;
	         self.selectPage = pageNum;
	         var startNum = ((pageNum-1) * 10);
	         var lastNum = 10;
	         var nparmap = {startNum : startNum, lastNum : lastNum};
	         $.ajax({
	            url : "/userList.dox",
	            dataType : "json",
	            type : "POST",
	            data : nparmap,
	            success : function(data) {
	               self.list = data.list;
	               self.cnt = data.cnt;
	               self.pageCount = Math.ceil(self.cnt / 10);
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