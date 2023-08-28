<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����ī ������ ������</title>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<style>
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
	box-shadow:1px 1px 2px darkgray;
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
			<h2>����ī �� ����</h2>
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.rentNo}}</td>
				</tr>
				<tr>
					<th>�з�</th>
					<td>{{info.cName}}</td>
				</tr>
				<tr>
					<th>����ī��</th>
					<td>{{info.rentName}}</td>
				</tr>
				<tr>
					<th>�����ȣ</th>
					<td>{{info.rZipno}}</td>
				</tr>
				<tr>
					<th>�ּ�</th>
					<td>{{info.rAddr}}</td>
				</tr>
				<tr>
					<th>���ּ�</th>
					<td>{{info.rDetailAddr}}</td>
				</tr>
				<tr>
					<th>��Ʈ�ݾ�</th>
					<td>{{info.rentPrice | comma }}</td>
				</tr>
				<tr>
					<th>��������ݾ�</th>
					<td>{{info.rentPrice * info.rentSales | comma }}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>�Ǹż���</th>
					<td>{{info.rResidue}}</td>
				</tr>
				<tr>
					<th>��ȸ��</th>
					<td>{{info.rRead}}</td>
				</tr>
				<tr>
					<th>�����</th>
					<td>{{info.rInsertTime}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{info.rUpdateTime}}</td>
				</tr>
				<tr>
					<th>����� �̹���</th>
					<td v-for="(item, index) in imgList" v-if="item.mainYN =='Y'">
						<div>{{item.imgName}}</div>
						<img :src="item.imgPath">
					</td>
					<td v-if="imgList.length == 0"></td>
				</tr>
				<tr>
					<th>������ �̹���</th>
					<td v-for="(item, index) in imgList" v-if="item.mainYN =='N'">
						<div>{{item.imgName}}</div>
						<img :src="item.imgPath">
					</td>
					<td v-if="imgList.length == 0"></td>
				</tr>
			</table>
			<div class="btnbtn">
				<span v-if="rCnt == 0">
					<span><button @click="fnUpdate" class="btn-dark">����</button></span>
					<span><button @click="fnRemove" class="btn-red">����</button></span>
				</span>
				<span><button @click="fnBack" class="btn-dark">�ڷΰ���</button></span>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
var app = new Vue({
	el : '#app',
	data : {
		status : "${sessionStatus}",
		info : {},
		rentNo : "${map.rentNo}",
		rCnt : "${map.rCnt}",
		sales : 0,
		imgList : []
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.carInfo;
                	self.sales = 100 - (self.info.rentSales * 100);
                	self.fnGetImgList();
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carImgList.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.carImgList;
                	// �� ��η� ��� ��� ����
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath; 
                	}
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			$.pageChange("edit.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("�ش� ����ī�� �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
	        
            var param = {rentNo : self.rentNo};
            
            $.ajax({
                url : "carRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("�ش� ����ī�� ������ �����Ǿ����ϴ�.");
                	location.href = "../rentcar.do"; 
                }
            });  
        },
        changeRentNo : function(rentNo){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.rentNo = rentNo;
        },
        fnBack : function(){
        	location.href = "../rentcar.do"; 
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("ȣ��Ʈ�� ������ �� �ֽ��ϴ�.");
			location.href="../../main.do";
		} else {
			self.fnGetInfo();
		}
	}// created
});
</script>