<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		���� ���� ������
		<table>
			<tr>
				<th>No.</th>
				<td><input v-model="info.roomNo" type="text" name="roonNo" id="roonNo" disabled></td>
			</tr>
			<tr>
				<th>���� Ÿ��</th>
				<td><input v-model="info.roomName" type="text" name="roomName" id="roomName"></td>
			</tr>
			<tr>
				<th>���� ����</th>
				<td><input v-model="info.roomPrice" type="text" name="roomPrice" id="roomPrice"></td>
			</tr>
			<tr>
				<th>������</th>
				<td><input v-model="sales" type="text" name="roomSales" id="roomSales"></td>
			</tr>
			<tr>
				<th>���� ����</th>
				<td><input v-model="info.roomResidue" type="text" name="roomResidue" id="roomResidue"></td>
			</tr>
			<tr>
				<th>�ο�</th>
				<td>
					<select v-model="info.peopleMax" >
						<option :key="index" :value="item.value" v-for="(item, index) in selectList">{{item.text}}</option>
					</select>
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
		</table>
		<div>
			<button @click="fnUpdate">����</button>
			<span><button @click="fnBack">���ư���</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		peopleMaxValue : "",
		info : {},
		imgInfo : {},
		roomNo : "${map.roomNo}",
		stayNo : "${map.stayNo}",
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
			{value:"10", text : "10 ��"}
		],
		sales : "",
		fileYFlg : false
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
			
			$.ajax({
                url : "roomInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.roomInfo;
                	self.sales = 100 - (self.info.roomSales * 100);
        			self.fnGetImgInfo();
                }
            }); 
		},
		fnGetImgInfo : function(){
			var self = this;
			var param = {room : self.roomNo};
			$.ajax({
                url : "roomImgInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgInfo = data.imgInfo;
                	self.fileYFlg = true;
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			if(!confirm("���� ������ �����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			if(self.sales==""){
				self.sales = 0;
			}
			self.info.roomSales = 1 - (self.sales / 100);
			var param = {
					roomName : self.info.roomName, 
					roomPrice : self.info.roomPrice,
					peopleMax : self.info.peopleMax,
					roomResidue : self.info.roomResidue,
					roomSales : self.info.roomSales,
					roomNo : self.roomNo
				};
			$.ajax({
                url : "roomEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	var form = new FormData();
        			form.append( "files", $("#fileY")[0].files[0]);
        			form.append( "imgNo", self.imgInfo.imgNo); //���� pk
        			console.log(self.imgInfo.imgNo);
        			self.fileChange(form);
                	
                	alert("�����Ǿ����ϴ�.");
             //   	$.pageChange("roomView.do", {roomNo : self.roomNo, stayNo : self.stayNo});
                	self.fnGetInfo();
                }
            }); 
		},
		 // ���� ������Ʈ
	    fileChange : function(form){
	    	var self = this;
	         $.ajax({
	             url : "stayFileChange.dox"
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
			console.log(self.stayNo);
			var url = "room.do?stayNo=" + encodeURIComponent(self.stayNo);
		    window.location.href = url;
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.roomNo != ""){
			self.fnGetInfo();
		}
	}// created
});
</script>