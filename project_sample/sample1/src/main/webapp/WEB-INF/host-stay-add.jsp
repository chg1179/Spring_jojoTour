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
						<span>
						 	<input disabled type="text" v-model="info.sAddr" placeholder="업체 주소를 입력하세요.">
	                        <button @click="fnSearchAddr">주소 검색</button>
	                        <div><input type="text" v-model="info.sDetailAddr" placeholder="나머지 주소를 입력해주세요."></div>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					숙소 유형				
				</th>
				<td>
					<span>
						<select v-model="selectStayType">
							<option value="">선택하세요</option>
							<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th>
					편의시설
					<br>
					서비스 안내
				</th>
				<td>
					<span>편의시설</span> 서비스 타입 테이블과 조인해서 받아온 값 체크박스에 넣기
				</td>
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
                	alert("숙소가 등록되었습니다.");
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