<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<div class="container">
		<h3>���� �� ��� ������</h3>
		
	</div>
		<div class="container">
			<table class="host-table">
				<thead>
					<tr>
						<th>����</th>
						<th>No.</th>
						<th>���� Ÿ��</th>
						<th>���� ����</th>
						<th>���� ����</th>
						<th>�ִ� ���� �ο�</th>
						<th>��Ű�� ��û</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(item, index) in list">
						<td>
							<input v-if="index==0" type="radio" :value="item.roomNo" @input="changeRoomNo(item.roomNo)" name="roomNo" checked="checked">
							<input v-else type="radio" :value="item.roomNo" @input="changeRoomNo(item.roomNo)" name="roomNo">
						</td>
						<td>{{item.roomNo}}</td>
						<td>{{item.roomName}}</td>
						<td>{{item.roomPrice}}</td>
						<td>{{item.roomResidue}}</td>
						<td>{{item.peopleMax}}��</td>
						<td>
							<span v-if="item.state=='A'">
								<div>��û�� �Ϸ�Ǿ����ϴ�.</div>
								<div>��Ҵ� 1:1 ���Ǹ� �����ּ���.</div>
							</span>
							<button v-else-if="item.state=='D'" @click="fnPackDel(item.roomNo)">���</button>
							<button v-else @click="fnPackAdd(item.roomNo)">��û</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="container">
			<span><button @click="fnAdd">���� �߰�</button></span>
			<span><button @click="fnView">���� �� ����</button></span>
			<span><button @click="fnRemove">���� ����</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		roomNo : "",
		uId : "${sessionId}",
		stayNo : "${map.stayNo}",
		stayName : "${map.stayName}"
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {stayNo : self.stayNo, uId : self.uId};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.roomList;
                	console.log(self.list);
                	if(self.list.length > 0){ //����Ʈ�� ù ��° ���� ����Ʈ�� üũ�ϰ�, �ش� pk ���� �޾ƿ´�.
                        self.roomNo = self.list[0].roomNo;
                    } 
                }
            }); 
		},
		
		// ���� �߰�
		fnAdd : function(){
			var self = this;
			console.log(self.stayNo);
			$.pageChange("roomAdd.do", {stayNo : self.stayNo});
		},
		
		// ���� �� ����
		fnView : function (){
			var self = this;
			console.log(self.roomNo);
			console.log(self.stayNo);
			$.pageChange("roomView.do", {roomNo : self.roomNo, stayNo : self.stayNo});
			
		},
		
		// ���� ����
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
                	alert("�ش� ������ �����Ǿ����ϴ�.");
                	self.fnGetList();
                	
                }
            }); 
		},
		changeRoomNo : function(roomNo){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.roomNo = roomNo;
        },
        fnPackAdd : function(roomNo){
			var self = this;
			console.log(roomNo);
			if(!confirm("��Ű���� ��û�Ͻðڽ��ϱ�?")){
	        	alert("��û�� ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {roomNo : roomNo};
			$.ajax({
                url : "roomPackAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("��Ű�� ��û�� �Ϸ�Ǿ����ϴ�.");
                	self.fnGetList();
                }
			});
        },
        fnPackDel : function(roomNo){
			var self = this;
			if(!confirm("��Ű�� ��û�� ����Ͻðڽ��ϱ�?")){
	        	alert("������ ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {roomNo : roomNo};
			$.ajax({
                url : "roomPackDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	console.log(roomNo);
                	alert("��Ű�� ��û�� ��ҵǾ����ϴ�.");
                	self.fnGetList();
                }
			});
        },
		
 	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>