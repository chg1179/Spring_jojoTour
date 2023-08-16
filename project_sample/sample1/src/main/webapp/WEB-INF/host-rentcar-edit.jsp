<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��Ʈī ��ǰ �߰� �� ���� ������</title>
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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<table>
			<tr>
				<th>�з�</th>
				<td>
					<select v-model="info.rentKind">
						<option value="SMALL">������</option>
						<option value="MIDDLE">������</option>
						<option value="LARGE">������</option>
						<option value="VAN">������</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>�̸�</th>
				<td><input v-model="info.rentName" type="text" name="rentName" id="rentName"></td>
			</tr>
			<tr>
				<th>�����ȣ</th>
				<td>
					<input v-model="info.rZipno" type="text" name="rZipno" id="rZipno" disabled>
					<button @click="fnSearchAddr">�ּ� �˻�</button>
				</td>
			</tr>
			<tr>
				<th>�ּ�</th>
				<td><input v-model="info.rAddr" type="text" name="rAddr" id="rAddr" disabled></td>
			</tr>
			<tr>
				<th>���ּ�</th>
				<td><input v-model="info.rDetailAddr" type="text" name="rDetailAddr" id="rDetailAddr"></td>
			</tr>
			<tr>
				<th>��Ʈ�ݾ�</th>
				<td><input v-model="info.rentPrice" type="text" name="rentPrice" id="rentPrice"></td>
			</tr>
			<tr>
				<th>������(%)</th>
				<td><input v-model="sales" type="text" name="rentSales" id="rentSales" @keyup="fnPercent"></td>
			</tr>
			<tr>
				<th>�Ǹż���</th>
				<td><input v-model="info.rResidue" type="text" name="rResidue" id="rResidue"></td>
			</tr>
			<tr>
				<th>���������</th>
				<td>
					<input type="file" accept=".gif, .jpg, .png" id="rentFile" name="file">
					<input type="button" value="���ϻ������ǳֱ�">
				</td>
			</tr>
			<tr>
				<th>����</th>
				<td>
					<input type="file" accept=".gif, .jpg, .png" id="rentFile" name="file">
					<input type="button" value="���ϻ������ǳֱ�">
					<input type="button" value="�����߰����ǳֱ�">
				</td>
			</tr>
		</table>
		<div>
			<button v-if="rentNo == ''" @click="fnAdd">���</button>
			<button v-else @click="fnEdit">����</button>
			<span><button @click="fnBack">���</button></span>
		</div>
	</div>
</body>
</html>
<script>
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	app.fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo);
}
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		rentNo : "${map.rentNo}",
		info : {
			rentKind : "SMALL",
			rentName : "",
			rZipno : "",
			rAddr : "",
			rDetailAddr : "",
			rentPrice : "",
			rentSales : "",
			rResidue : ""
		},
		sales : 0,
		fileFlg : false
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
                }
            }); 
		},
		fnAdd : function(){
			var self = this;
			if(!confirm("��Ʈī�� �߰��Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			
			self.info.rentSales = 1 - (self.sales / 100);
			var param = self.info;
			param.uId = self.uId;
			
			$.ajax({
                url : "addRentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("��Ʈī ����� �Ϸ�Ǿ����ϴ�.");
                	location.href = "../rentcar.do"; 
                	/*
                	���� ���ε�
                	var form = new FormData();
	       	        form.append( "file1",  $("#file1")[0].files[0] );
	       	     	form.append( "idx",  data.idx); // pk
	           		self.upload(form);  */
                }
            });
		},
		fnEdit : function(){
			var self = this;
			if(!confirm("�ش� ������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			
			self.info.rentSales = 1 - (self.sales / 100);
			console.log(self.info);
			var param = self.info;
			param.rentNo = self.rentNo;
			
			$.ajax({
                url : "editRentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("���� ������ �Ϸ�Ǿ����ϴ�.");
                	$.pageChange("view.do", {rentNo : self.rentNo, rCnt : self.rCnt}); 
                	/*
                	���� ���ε�
                	var form = new FormData();
	       	        form.append( "file1",  $("#file1")[0].files[0] );
	       	     	form.append( "idx",  data.idx); // pk
	           		self.upload(form);  */ 
                }
            });
		},
		fnBack : function(){
			location.href = "../rentcar.do"; 
		},
		fnPercent : function(){ // ������ 0~100 ����
			var self = this;
			if(self.sales >= 100){
				alert("100���� ���� ���ڸ� �Է����ּ���.");
				self.sales = 0;
			} else if(self.sales < 0){
				alert("0���� ū ���ڸ� �Է����ּ���.");
				self.sales = 0;
			}
		},
		// �ּ� �˻�
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("addr.do", "carAddr", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.info.rZipno = zipNo;
    		self.info.rAddr = roadAddrPart1;
    		self.info.rDetailAddr = addrDetail;
    	},
		// ���� ���ε�
		upload : function(form){
			var self = this;
			$.ajax({
			url : "/fileUpload.dox"
				, type : "POST"
				, processData : false
				, contentType : false
				, data : form
				, success:function(response) {  
				}
	       });
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.rentNo != ""){
			self.fnGetInfo();
		}
	}// created
});
</script>