<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>���� �� ����</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	table{
		margin : 30px auto;
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
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

</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="container">
		<h2>���� ������</h2>
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.roomNo}}</td>
				</tr>
				<tr>
					<th>����Ÿ��</th>
					<td>{{info.roomName}}</td>
				</tr>
				<tr>
					<th>�����ο�</th>
					<td>�ִ� {{info.peopleMax}}��</td>
				</tr>
				<tr>
					<th>���Ǳݾ�</th>
					<td>{{info.roomPrice}}</td>
				</tr>
				<tr>
					<th>��������</th>
					<td>{{info.roomResidue}}</td>
				</tr>
				<tr>
					<th>���αݾ�</th>
					<td>{{info.roomPrice * info.roomSales}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>�Ǹż���</th>
					<td>{{info.roomResidue}}</td>
				</tr>
				<tr>
					<th>�����</th>
					<td>{{info.roomInsertTime}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{info.roomUpdateTime}}</td>
				</tr>
				<tr>
					<th>������ �̹���</th>
					<td>
						<div>{{imgInfo.imgName}}</div>
						<img :src="imgInfo.imgPath" :style="{ width: '500px'}">
					</td>
				</tr>
			</table>
		
		<div class="btnbtn">
			<span><button @click="fnEdit" class="btn-dark">����</button></span>
			<span><button @click="fnRemove" class="btn-red">����</button></span>
			<span><button @click="fnBack" class="btn-dark">���ư���</button></span>
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
		info : {},
		roomNo : "${map.roomNo}",
		stayNo : "${map.stayNo}",
		sales : 0,
		discount : 0,
		imgInfo : {}
		
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
                	console.log(self.info);
              	 	self.sales = 100 - (self.info.roomSales * 100);
              	 	console.log(self.sales);
              	 	self.fnGetImgList();
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomImgInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgInfo = data.imgInfo;
                	console.log(self.imgInfo);
                }
            }); 			
		},
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
                	alert("�����Ǿ����ϴ�.");
                	$.pageChange("room.do", {stayNo : self.stayNo});
                }
            }); 
		},
		fnEdit : function(){
			var self = this;
			$.pageChange("roomEdit.do", {roomNo : self.roomNo , stayNo : self.stayNo});
		},
		fnBack : function(){
			var self = this;
			var url = "room.do?stayNo=" + encodeURIComponent(self.stayNo);
		    window.location.href = url;
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>