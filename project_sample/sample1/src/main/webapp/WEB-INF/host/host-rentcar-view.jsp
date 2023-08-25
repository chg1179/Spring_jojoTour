<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����ī ������ ������</title>
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
		<div id="container">
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
					<td>{{info.rentPrice}}</td>
				</tr>
				<tr>
					<th>��������ݾ�</th>
					<td>{{info.rentPrice * info.rentSales}}</td>
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
			<div>
				<span v-if="rCnt == 0">
					<span><button @click="fnUpdate">����</button></span>
					<span><button @click="fnRemove">����</button></span>
				</span>
				<span><button @click="fnBack">�ڷΰ���</button></span>
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