<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>ȣ�� �� ������</title>
<style>
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
	.room-box, .stay-box{
   		width: 956px;
    	margin: 0px auto
	}
	.room-box .room{
	    overflow: hidden;
	    position: relative;
	    margin: 30px 0 24px 0;
	    padding: 24px 24px 24px 424px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background: #fff;
	    box-sizing: border-box;
	    
	}
	.stay-box .stay {
		overflow: hidden;
	    margin: 30px 0 24px 0;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    background: #fff;
	}
	.stay-box .stay{
		overflow : hidden;
	}
	
	.stay-box .stay .left {
		float: left;
		width: 490px;
	}
	
	.stay-box .stay .right {
		float: right;
		width: 450px;
	}
	
</style>

</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="stay-box">
		<div class="stay">
			<div class="left">�̹���</div>
			<div class="right">
				<div>{{info.stayName}}</div>
				<div>{{info.sAddr}}</div>
			</div>
		</div>
	</div>
	<div class="room-box">
		<div class="room" v-for="item in list">
			<div>�� ��ȣ: {{item.roomNo}}</div>
			<div>������ : {{item.roomName}}</div>
			<div>���� : {{item.roomPrice}}</div>
			<div>���αݾ� : {{item.sales}}</div>
			
			<button @click="fnJjim(item.roomNo)">��</button>
			<button @click="fnCart(item)">��ٱ���</button>					
			<button @click="">�����ϱ�</button>		
		</div>
	</div>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		stayNo : "${map.stayNo}",
		uId : "${sessionId}",
		info : {
			stayName : "",
			sAddr : "",
			cKind : ""
		},
		roomNo : ""
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.roomList;
                	console.log(self.list);
                	
                	self.info = data.stayInfo;
                	console.log(data.stayInfo);
                }
            }); 
		},
		fnJjim : function(roomNo){
			var self = this;
			if(self.uId == ""){
				alert("�α��� �� �̿� ������ �����Դϴ�.");
				return;
			}
			if(!confirm("���Ͽ� �߰��Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var param = {roomNo : roomNo, uId : self.uId};
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ� �߰��Ǿ����ϴ�.");
                	console.log(roomNo);
                	self.fnGetList();
                }
            }); 
		},
		fnCart : function(item){
			var self = this;
			if(self.uId == ""){
				alert("�α��� �� �̿� ������ �����Դϴ�.");
				return;
			}
			
			if(!confirm("��ٱ��Ͽ� �����ðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			console.log(item.roomNo);
			console.log(item.peopleMax);
			var param = {uId : self.uId, roomNo : item.roomNo, peopleMax : item.peopleMax};
			$.ajax({
                url : "addCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("��ǰ�� ��ٱ��Ͽ� �����ϴ�.");
                	self.fnGetList();
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>