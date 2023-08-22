<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
	table{
		border : 1px solid black;
		border-collapse: collapse;
		/* text-align : center; */
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		���� �߰� ������
		<table>
			<tbody>
				<tr>
					<th>
						���� ����
					</th>
					<td>
						<div>
							<span>��������</span>
							<span>
								<input type="text" v-model="info.roomName" name="roomName" id="roomName">
							</span>
						</div>
						<div>
							<span>����</span>
							<span>
								<input type="text" v-model="info.roomPrice" name="roomPrice" id="roomPrice">
							</span>
						</div>
						<div>
							<span>������</span>
							<span>
								<input type="text" v-model="info.roomSales" name="roomSales" id="roomSales">
							</span>
						</div>
						<div>
							<span>�ο�</span>
							<span>
								<select v-model="peopleMaxValue" >
									<option :key="index" :value="item.value" v-for="(item, index) in selectList">{{item.text}}</option>
								</select>
							</span>
						</div>
					</td>
				</tr>
				
				<tr>
					<th>�������̹���</th>
					<td>
						<div class="filebox">
						    <input class="upload-name" id="fileYName" placeholder="÷������" readonly>
						    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
						    <label for="fileY">�̹�������</label> 
						    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<button @click="fnRoomAdd(info.roomNo)">���� ���</button>
		<button @click="fnBack">�ǵ��ư���</button>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		peopleMaxValue : "",
		uId : "${sessionId}",
		status : "${sessionStatus}",
		stayNo : "${map.stayNo}",
		status : "${sessionStatus}",
		serviceNo : 0,
		info : {},
		selectList : [
			{value:"1", text : "1 ��"},			
			{value:"2", text : "2 ��"},			
			{value:"3", text : "3 ��"},			
			{value:"4", text : "4 ��"},			
			{value:"5", text : "5 ��"},			
			{value:"6", text : "6 ��"},			
			{value:"7", text : "7 ��"},			
			{value:"8", text : "8 ��"},			
			{value:"9", text : "9 ��"},			
			{value:"10", text : "10 ��"},			
				
		],
		fileYFlg : false
	},// data
	methods : {
		
		// �� �߰�
		fnRoomAdd : function(roomNo){
			var self = this;
			if(!confirm("������ ����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var param = self.info;
			var param = {
				roomName : self.info.roomName,
				roomPrice : self.info.roomPrice,
				peopleMax : self.peopleMaxValue,
				stayNo : self.stayNo,
				uId : self.uId,
				roomNo : roomNo,
			};
			$.ajax({
                url : "roomAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	var form = new FormData();
	       	        form.append( "files",  $("#fileY")[0].files[0]);
	       	     	form.append( "roomNo",  data.roomNo); // ��ǰ pk
	       	     	console.log(data.roomNo);
	           		self.upload(form);
	           		
            		alert("������ ��ϵǾ����ϴ�.");
            		$.pageChange("../host/room.do", {stayNo : self.stayNo});
            		self.selectServiceList = [];
                }
            }); 
		},

		// ���� ���ε�
		upload : function(form){
		   	var self = this;
		        $.ajax({
		            url : "roomFileUpload.dox"
		          , type : "POST"
		          , processData : false
		          , contentType : false
		          , data : form
		          , success:function(response) { 
		       	   
		          }
		      });
		},
		
		//������ ���õƴ��� Ȯ�� (���õƴٸ� x��ư�� ���´�.)
		fnFlgChange : function(){
			var self = this;
			var fileCheck = document.getElementById("fileY").value;
			
			if(!fileCheck){
				document.getElementById("fileYName").value = "";
				self.fileYFlg = false;
				return;
			} else{
				document.getElementById("fileYName").value = $("#fileY")[0].files[0].name;
				self.fileYFlg = true;
				return;
			}
			
		},
		// ���� ����
		
		fnDelFile : function(){
			var self = this;
			document.getElementById("fileY").value = "";
			document.getElementById("fileYName").value = "";
		}, 
		fnBack : function(){
        	var self = this;
			$.pageChange("../host/room.do", {stayNo : self.stayNo}); 
        },
		
		
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("ȣ��Ʈ�� ������ �� �ֽ��ϴ�.");
			location.href="../../main.do";
		} 
		
	}// created
});
</script>