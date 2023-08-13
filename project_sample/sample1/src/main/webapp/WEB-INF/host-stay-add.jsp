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
						<span>
						 	<input disabled type="text" v-model="info.sAddr" placeholder="��ü �ּҸ� �Է��ϼ���.">
	                        <button @click="fnSearchAddr">�ּ� �˻�</button>
	                        <div><input type="text" v-model="info.sDetailAddr" placeholder="������ �ּҸ� �Է����ּ���."></div>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���� ����				
				</th>
				<td>
					<span>
						<select v-model="selectStayType">
							<option value="">�����ϼ���</option>
							<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th>
					���ǽü�
					<br>
					���� �ȳ�
				</th>
				<td>
					<span>���ǽü�</span> ���� Ÿ�� ���̺�� �����ؼ� �޾ƿ� �� üũ�ڽ��� �ֱ�
				</td>
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
		selectStayType : "",
		typeList : [],
		info : {
			stayName : "",
			sAddr : "",               
			sDetailAddr : "",
		},
		
	},// data
	methods : {
		fnStayAdd : function(){
			var self = this;
			var param = {
				stayName: self.info.stayName,
				sAddr: self.info.sAddr,
				sDetailAddr: self.info.sDetailAddr,
				type: self.selectStayType
			}
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
		fnGetOption : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "stayTypeList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.typeList = data.stayTypeList;
                	console.log(self.stayTypes);
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