<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
<style>
	.container {
		display: flex;
		justify-content: center;
		margin-top: 30px;
	}
	.container h3{
		text-align: center;
		padding: 14px;
	}
	.host-table{
		width: 1000px;
		border-top: 1px solid black;
		border-botton: 1px solid black;
		border-collapse: collapse;
	}
	
	.host-table a {
		color: #333;
		display: inline-block;
		line-height : 1.4;
	}
	.host-table a:hover{
		text-decoration: underline;
	}
	
	.host-table th, .host-table td{
		text-align: center;
		padding: 14px 0;
		border-bottom: 1px solid black;
		border-left: 1px solid #ccc; 
		border-right: 1px solid #ccc; 
	}
	.host-table th:first-child,
	.host-table td:first-child {
		border-left: none;
	}

	.host-table th:last-child,
	.host-table td:last-child {
		border-right: none;
	}
	
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<h3>���� ��ü ���</h3>
		</div>
		<!-- stay list area -->
		<div id="host-list">
			<div class="container">
				<table class="host-table">
					<thead>
						<tr>
							<th>����</th>
							<th>No.</th>
							<th>��ü��</th>
							<th>�ּ�</th>
							<th>�� �ּ�</th>
							<th>����Ÿ��</th>
							<th>�����</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(item, index) in list">
							<td>
								<input v-if="index==0" type="radio" :value="item.stayNo" @input="changeStayNo(item.stayNo)" name="stayNo" checked="checked">
								<input v-else type="radio" :value="item.stayNo" @input="changeStayNo(item.stayNo)" name="stayNo">
							</td>
							<td>{{item.stayNo}}</td>
							<td><a @click="fnMove(item.stayNo)" href="javascript:;">{{item.stayName}}</a></td>
							<td>{{item.sAddr}}</td>
							<td>{{item.sDetailAddr}}</td>
							<td>{{item.cName}}</td>
							<td>{{item.sInsertTime}}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="container">
			<span><button @click="fnAdd">���� ��ü �߰�</button></span>
			<span><button @click="fnUpdate">��ü ���� ����</button></span>
			<span><button @click="fnRemove">��ü ���� ����</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}",
		uId : "${sessionId}",
		stayNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	if(self.list.length > 0){
                		self.stayNo = self.list[0].stayNo; //����Ʈ�� ù ��° ���� ����Ʈ�� üũ�ϰ�, �ش� pk ���� �޾ƿ´�.
                		console.log(self.list);
                	}
                	
                	
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			console.log(self.stayNo);
			$.pageChange("stayEdit.do", {stayNo : self.stayNo});
		},
		fnRemove : function(){
			var self = this;
			if(!confirm("�ش� ���Ҹ� �����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "stayRemove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�ش� ������ �����Ǿ����ϴ�.");
                	self.fnGetList();
                }
            }); 
		},
		fnMove : function(stayNo){
			var self = this;
		//	console.log(item.stayName);
  			$.pageChange("room.do", {stayNo : stayNo});
		},
		fnAdd : function(){
			location.href = "stayAdd.do"
		},
		changeStayNo : function(stayNo){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.stayNo = stayNo;
        }
		
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		if(self.status != 'H'){
			alert("���� ����");
			location.href="../main.do";
		}
		if(self.uId){
			
		}
		self.fnGetList();
	}// created
});
</script>