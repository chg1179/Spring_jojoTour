<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������ ������</title>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
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
			<h2>���� �� ����</h2>
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.leisureNo}}</td>
				</tr>
				<tr>
					<th>�з�</th>
					<td>
						<span v-if='info.cType=="WATER"'>����</span>
						<span v-else-if='info.cType=="GROUND"'>����</span>
					</td>
				</tr>
				<tr>
					<th>�о�</th>
					<td>{{info.cName}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{info.leisureName}}</td>
				</tr>
				<tr>
					<th>�����ȣ</th>
					<td>{{info.lZipno}}</td>
				</tr>
				<tr>
					<th>�ּ�</th>
					<td>{{info.lAddr}}</td>
				</tr>
				<tr>
					<th>���ּ�</th>
					<td>{{info.lDetailAddr}}</td>
				</tr>
				<tr>
					<th>�����ݾ�</th>
					<td>{{info.leisurePrice}}</td>
				</tr>
				<tr>
					<th>��������ݾ�</th>
					<td>{{info.leisurePrice * info.leisureSales}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>�Ǹż���</th>
					<td>{{info.lResidue}}</td>
				</tr>
				<tr>
					<th>��ȸ��</th>
					<td>{{info.lRead}}</td>
				</tr>
				<tr>
					<th>�����</th>
					<td>{{info.lInsertTime}}</td>
				</tr>
				<tr>
					<th>������</th>
					<td>{{info.lUpdateTime}}</td>
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
				<span v-if="lCnt == 0">
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
var app = new Vue({
	el : '#app',
	data : {
		status : "${sessionStatus}",
		info : {
			cType : "",
			leisureKind : "",
			leisureName : "",
			lZipno : "",
			lAddr : "",
			lDetailAddr : "",
			lentPrice : "",
			lentSales : "",
			lResidue : "",
			leisureNo : ""
		},
		leisureNo : "${map.leisureNo}",
		lCnt : "${map.lCnt}",
		sales : 0,
		imgList : []
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.leisureInfo;
                	self.sales = 100 - (self.info.leisureSales * 100);
                	self.fnGetImgList();
                	console.log(self.info);
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureImgList.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.leisureImgList;
                	// �� ��η� ��� ��� ����
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath; 
                	}
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			$.pageChange("edit.do", {leisureNo : self.leisureNo}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("�ش� ������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
	        
            var param = {leisureNo : self.leisureNo};
            
            $.ajax({
                url : "leisureRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("�ش� ������ ������ �����Ǿ����ϴ�.");
                	location.href = "../leisure.do"; 
                }
            });  
        },
        changeLeisureNo : function(leisureNo){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.leisureNo = leisureNo;
        },
        fnBack : function(){
        	location.href = "../leisure.do"; 
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