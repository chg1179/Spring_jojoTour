<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
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
	숙소 업체 추가 페이지
		<table>
		<tbody>
			<tr>
				<th>
					업체 
					<br>
					기본 정보
				</th>
				<td>
					<div>
						<span>업체명</span>
						<span>
							<input type="text" v-model="info.stayName" name="stayName">
						</span>
					</div>
					<div>
						<span>업체 주소</span>
						<div>
							<div>우편번호<input disabled type="text" v-model="info.sZipno"></div>
						 	<input disabled type="text" v-model="info.sAddr" placeholder="업체 주소를 입력하세요.">
	                        <button @click="fnSearchAddr">주소 검색</button>
	                        <div><input type="text" v-model="info.sDetailAddr" placeholder="나머지 주소를 입력해주세요."></div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					숙소 유형				
				</th>
				<td>
					<div>
						<select v-model="selectStayType">
							<option value="">선택하세요</option>
							<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					편의시설
					<br>
					서비스 안내
				</th>
				<td>
					<div v-for="item in serviceList" :key="item.serviceNo">
						<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
					</div>					
				</td>
			</tr>
			<tr>
				<th>파일</th>
				<td><input type="file" accept=".gif, .jpg, .png" id="stayFile" name="file"></td>
			</tr>
		</tbody>
		</table>
		<button @click="fnStayAdd">숙소 등록</button>
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
			if(!confirm("숙소를 등록하시겠습니까?")){
				alert("취소되었습니다.");
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
                	alert("숙소가 등록되었습니다.");
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
    		// 콘솔 통해 각 변수 값 찍어보고 필요한거 가져다 쓰면 됩니다.
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