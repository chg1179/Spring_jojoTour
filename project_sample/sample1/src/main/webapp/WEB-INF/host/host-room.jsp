<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../css/basic/custom-table-style.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	#app{
		display: flex;
	    flex-direction: column;
	    min-height: 80vh;
	}
	.container {
		flex: 1;
		margin-top: 60px;
		margin-bottom: 60px;
	}
	.container h3{
		text-align: center;
	}
	tr, td, th{
		padding: 20px;
	}
	h3{
		margin-top: 100px;
		margin-bottom: 0px;
		text-align: center;
	}
	.btn-con{
		margin-bottom: 300px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<h3>���� ���</h3>
			<table class=" table custom-table table-striped table-bordered ">
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
						<td>{{item.roomPrice}}��</td>
						<td>{{item.roomResidue}}</td>
						<td>{{item.peopleMax}}��</td>
						<td>
							<span v-if="item.state=='A'">
								<div>��û�� �Ϸ�Ǿ����ϴ�.</div>
								<div>��Ҵ� 1:1 ���Ǹ� �����ּ���.</div>
							</span>
							<button v-else-if="item.state=='D'" @click="fnPackDel(item.roomNo)" class="btn-red">���</button>
							<button v-else @click="fnPackAdd(item.roomNo)" class="btn-dark">��û</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="btn-con">
			<span><button @click="fnAdd" class="btn-dark">���� �߰�</button></span>
			<span><button @click="fnView" class="btn-dark">���� �� ����</button></span>
			<span><button @click="fnRemove" class="btn-red">���� ����</button></span>
			<span><button @click="fnBack" class="btn-dark">�ǵ��ư���</button></span>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
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
        fnBack : function(){
        	location.href = "../host/stay.do";
        }
        
		
 	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>