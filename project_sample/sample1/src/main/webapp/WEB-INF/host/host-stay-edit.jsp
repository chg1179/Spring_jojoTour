<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 정보 수정 페이지</title>
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
	숙소 정보 수정 페이지
		<table>
			<tr>
				<th>No.</th>
				<td><input v-model="info.stayNo" type="text" name="stayNo" id="stayNo" disabled></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input v-model="info.stayName" type="text" name="stayName" id="stayName"></td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					<select v-model="info.stayKind">
						<option v-for="item in typeList" :value="item.cKind">{{item.cName}}</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
					<input v-model="info.sZipno" type="text" name="sZipno" id="sZipno" disabled>
					<button @click="fnSearchAddr">주소 검색</button>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input v-model="info.sAddr" type="text" name="sAddr" id="sAddr" disabled></td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td><input v-model="info.sDetailAddr" type="text" name="sDetailAddr" id="sDetailAddr"></td>
			</tr>
			<tr>
				<th>
					편의시설
					<br>
					서비스 안내
				</th>
				<td>
					<div v-for="item in serviceList">
						<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
					</div>					
				</td>
			</tr>
			<tr>
			<tr>
				<th>파일</th>
				<td><input type="file" accept=".gif, .jpg, .png" id="stayFile" name="file"></td>
			</tr>
		</table>
		<div>
			<button @click="fnUpdate">수정</button>
			<span><button @click="">취소</button></span>
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
		serviceList : [], // 출력을 위한 서비스 리스트
		selectServiceList : [], // 체크한 값을 넣기 위한 서비스 리스트
		info : {
			stayName : "",
			stayKind : "",
			sZipNo : "",
			sAddr : "",
			sDetailAddr : "",
			
		},
		stayNo : "${map.stayNo}",
		typeList : [],
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "stayInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.stayInfo;
                	console.log(self.info);
                	
                }
            }); 
		},
		fnGetOption : function(){
			var self = this;
			var param = {};
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
		fnUpdate : function(){
			var self = this;
			if(!confirm("숙소 정보를 수정하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			
			var noServiceList = JSON.stringify(self.selectServiceList); //문자열 형태로 형변환
			var param = self.info;
			param.stayNo = self.stayNo;
			param.serviceNo = self.serviceNo;
			param.selectServiceList = noServiceList;
			
			console.log(self.selectServiceList);
			console.log(self.selectServiceList[2]); 
			$.ajax({
                url : "stayEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	
                	alert("수정되었습니다.");
                	location.href = "stay.do";
                	
                }
            }); 
		},
		
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("../addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		self.info.sZipno = zipNo;
    		self.info.sAddr = roadAddrPart1;
            self.info.sDetailAddr = addrDetail;
            
            console.log(zipNo);
    	}
	}, // methods
	created : function() {
		var self = this;
		if(self.stayNo != ""){
			self.fnGetInfo();
		}
		self.fnGetOption();
	}// created
});
</script>