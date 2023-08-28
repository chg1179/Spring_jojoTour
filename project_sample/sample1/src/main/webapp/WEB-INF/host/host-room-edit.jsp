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
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/host-edit-style.css" rel="stylesheet"/>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	table{
		margin : 30px auto;
		border : 1px solid black;
		border-collapse: collapse;
		font-size : 14px;
		padding:5px 10px;
	}

	th, td {
		border : 1px solid gray;
		padding: 30px 12px;
	}
	th{
		background-color:#f2f2f2;
	}
	h3{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
	}
	h2{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
		color:black;
	}
	img {
	  max-width: 600px; /* �ִ� �ʺ� 800px�� ���� */
	  height: auto; /* ���̸� �ڵ����� �����Ͽ� ���� ���� */
	}
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.container{
		width:1100px;
		background-color:white;
		border-radius:6px;
		box-shadow:0px 0px 10px rgba(0, 0, 0, 0.2);
		padding: 5px;
	    margin: 50px auto;
	    
	}
	body{
		background-color:#f2f2f2
	}
	.container input[type="text"]{
		background: none;
	    width: 50%;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    border-radius: 4px;
	    width: 50%;
	    color: #999999;
	}
	.filebox label {
	    display: inline-block;
	    padding: 10px 10px;
	    color: #fff;
	    vertical-align: middle;
	    background-color: #999999;
	    cursor: pointer;
	    height: 20px;
	    margin-left: 5px;
	}
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	select{
		background: none;
	    width: 50%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="container">
		<h3>���� ���� ����</h3>
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
					    <input class="upload-name" id="fileYName" placeholder="÷������" readonly :value="imgInfo.imgName">
					    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
					    <label for="fileY">�̹�������</label> 
					    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
					</div>
				</td>
			</tr>
		</table>
		<div class="btn-con">
			<button @click="fnUpdate" class="btn-dark">����</button>
			<button @click="fnBack" class="btn-red">���</button>
		</div>
	</div>
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
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
        			console.log(self.info);
        			console.log(self.imgInfo);
                }
            }); 
		},
		fnGetImgInfo : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
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
                	$.pageChange("roomView.do", {roomNo : self.roomNo, stayNo : self.stayNo});
                	self.fnGetInfo();
                }
            }); 
		},
		 // ���� ������Ʈ
	    fileChange : function(form){
	    	var self = this;
	         $.ajax({
	             url : "roomFileChange.dox"
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