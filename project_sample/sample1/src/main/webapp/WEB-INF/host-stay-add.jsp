<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
<style>
	table{
		border : 1px solid black;
		border-collapse: collapse;
		
	}
	th, td {
		border : 1px solid black;
		padding : 10px 20px;
	}
	a {
		
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
	���� ��ü �߰� ������
		<table>
		<tbody>
			<tr>
				<th>
					��ü 
					<br>
					�⺻ ����
				</th>
				<td>
					<div>
						<span>��ü��</span>
						<span>
							<input type="text" v-model="info.stayName" name="stayName">
						</span>
					</div>
					<div>
						<span>��ü �ּ�</span>
						<div>
							<div>�����ȣ<input disabled type="text" v-model="info.sZipno"></div>
						 	<input disabled type="text" v-model="info.sAddr" placeholder="��ü �ּҸ� �Է��ϼ���.">
	                        <button @click="fnSearchAddr">�ּ� �˻�</button>
	                        <div><input type="text" v-model="info.sDetailAddr" placeholder="������ �ּҸ� �Է����ּ���."></div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���� ����				
				</th>
				<td>
					<div>
						<select v-model="selectStayType">
							<option value="">�����ϼ���</option>
							<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���ǽü�
					<br>
					���� �ȳ�
				</th>
				<td>
					<div v-for="item in serviceList" :key="item.serviceNo">
						<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
					</div>					
				</td>
			</tr>
			<tr>
				<th>����</th>
				<td><input type="file" accept=".gif, .jpg, .png" id="stayFile" name="file"></td>
			</tr>
		</tbody>
		</table>
		<button @click="fnStayAdd">���� ���</button>
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
		serviceList : [], // ����� ���� ���� ����Ʈ
		selectServiceList : [], // üũ�� ���� �ֱ� ���� ���� ����Ʈ
		selectStayType : "",
		serviceNo : 0,
		typeList : [],
		info : {
			stayNo : 0,
			stayName : "",
			sAddr : "",               
			sDetailAddr : "",
		},
		uId : "${sessionId}"
		
	},// data
	methods : {

		fnGetOption : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "stayOption.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.typeList = data.stayTypeList;
                	console.log(self.typeList);
                	
                	self.serviceList = data.stayServiceList;
                	console.log(self.serviceList);
                }
            }); 
		},
		
		fnStayAdd : function(){
			var self = this;
			if(!confirm("���Ҹ� ����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var sList = JSON.stringify(self.selectServiceList);
			var param = {
				stayNo : self.info.stayNo,
				stayName: self.info.stayName,
				sAddr: self.info.sAddr,
				sDetailAddr: self.info.sDetailAddr,
				sZipno: self.info.sZipno,
				type: self.selectStayType,
				uId : self.uId,
				serviceNo : self.serviceNo,
				selectServiceList : sList
			}
			console.log(self.selectServiceList);
			console.log(sList); 
			$.ajax({
                url : "stayAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("���Ұ� ��ϵǾ����ϴ�.");
                	location.href="/host/stay.do";
                	
                }
            }); 
		},
	
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("../addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.info.sZipno = zipNo;
    		self.info.sAddr = roadAddrPart1;
            self.info.sDetailAddr = addrDetail;
    		// �ܼ� ���� �� ���� �� ���� �ʿ��Ѱ� ������ ���� �˴ϴ�.
    		console.log(roadFullAddr);
    		console.log(roadAddrPart1);
    		console.log(addrDetail);
    		console.log(engAddr);
    	}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetOption();
	//	self.fnGetList();
	}// created
});
</script>