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
				<th>No.</th>
				<td><input v-model="info.rentNo" type="text" name="rentNo" id="rentCarNo" disabled></td>
			</tr>
			<tr>
				<th>�̸�</th>
				<td><input v-model="info.rentName" type="text" name="rentName" id="rentName"></td>
			</tr>
			<tr>
				<th>�з�</th>
				<td><input v-model="info.cName" type="text" name="cName" id="cName"></td>
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
				<td><input v-model="info.rentPrice" type="text" name="rentPrice" id="rentPrice" @keyup="fnCalculator"></td>
			</tr>
			<tr>
				<th>���αݾ�</th>
				<td><input v-model="discount" type="text" name="rDiscount" id="rDiscount" disabled></td>
			</tr>
			<tr>
				<th>������(%)</th>
				<td><input v-model="sales" type="text" name="rentSales" id="rentSales" @keyup="fnCalculator"></td>
			</tr>
			<tr>
				<th>�Ǹż���</th>
				<td><input v-model="info.rResidue" type="text" name="rResidue" id="rResidue" disabled></td>
			</tr>
			<tr>
				<th>����</th>
				<td><input type="file" accept=".gif, .jpg, .png" id="rentFile" name="file"></td>
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
		info : {},
		rentNo : "${map.rentNo}",
		sales : 0,
		discount : ""
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
                	console.log(self.info);
                	self.sales = 100 - (self.info.rentSales * 100);
                	self.discount = self.info.rentPrice * self.info.rentSales;
                }
            }); 
		},
		fnCalculator : function(){
			var self = this;
			//nan �� ����
			self.sales = 100 - (self.info.rentSales * 100);
        	self.discount = self.info.rentPrice * self.info.rentSales;
        	console.log(self.info.rentSales+"/"+self.info.rentPrice);        	
		},
		fnAdd : function(){
			location.href = "../rentcar.do";
		},
		fnEdit : function(){
			 
		},
		fnBack : function(){
			location.href = "../rentcar.do"; 
		},
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