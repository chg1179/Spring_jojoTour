<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
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
<div id="app">
	<table>
		<tr>	
			<th></th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>구분</th>
			<th>이름</th>
			<th>핸드폰</th>
			<th>이메일</th>
			<th>나이</th>
			<th>주소</th>
			<th>이벤트 수신 여부</th>
			<th>해제</th>
			<th>정지여부</th>
		</tr>
		<tr v-for="(item, index) in list">		
			<td>{{index + 1}}</td>
			<td>{{item.uId}}</td>
			<td>{{item.nickname}}</td>
			<td v-if="item.status == 'U'">유저</td>
			<td v-else="item.status == 'H'">호스트</td>
			<td>{{item.uName}}</td>
			<td>{{item.phone}}</td>
			<td>{{item.email}}</td>
			<td>{{item.birth}}</td>
			<td>{{item.addr}}</td>
			<td v-if="item.eventYn == 'Y'">동의</td>
			<td v-else="item.eventYn == 'N'">거부</td>
			<td></td>
			<td><button v-if="item.cnt >= 5" @click="fnReset(item)">해제</button></td>
			<td v-if="item.banYn == 'N'"><button @click="fnBan(item, 'Y')">정지</button></td>
			<td v-else><button @click="fnBan(item, 'N')">정지해제</button></td>
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
                	alert("해제되었습니다");
                	self.fnGetList();
                }
            }); 
		},
		fnBan : function(item, banYn){
			var self = this;
			 var nparmap = {userId : item.uId, banYn : banYn};
	            $.ajax({
	                url : "/ban.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	alert("수정되었습니다");
	                	self.fnGetList();
	                }
	            }); 
		}	
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		/* if(self.status != 'A'){
			alert("권한 없음");
			location.href="../main.do";
		}  */
		self.fnGetList();
	}// created
});
</script>