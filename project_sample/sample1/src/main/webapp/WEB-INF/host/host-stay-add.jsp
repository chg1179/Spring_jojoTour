<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/host-edit-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	table{
		margin : 30px auto;
		border : 1px solid black;
		border-collapse: collapse;
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
	  max-width: 600px; /* 최대 너비를 800px로 설정 */
	  height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
	}
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.container{
		width:1100px;
		background-color:white;
		border-radius:6px;
		box-shadow:0px 0px 10px rgba(0, 0, 0, 0.2);
		padding: 5px;
	    margin: 50px auto;
	    
	}
	body{
		background-color:#f2f2f2
	}
	.container input[type="text"]{
		background: none;
	    width: 50%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	.service-checkbox input[type="checkbox"]{
		background: none;
	    margin-top: 5px;
	    font-size: 16px;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    border-radius: 4px;
		
	}
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 50%;
	    color: #999999;
	}
	.filebox label {
	    display: inline-block;
	    padding: 10px 10px;
	    color: #fff;
	    vertical-align: middle;
	    background-color: #999999;
	    cursor: pointer;
	    height: 20px;
	    margin-left: 5px;
	}
	
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	select{
		background: none;
	    width: 50%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="container">
		<h3>숙소 업체 등록</h3>
		<table>
		<tbody>
			<tr>
				<th>숙소이름</th>
				<td>
					<input type="text" v-model="info.stayName" name="stayName">
				</td>
			</tr>
			<tr>
				<th>우편번호</th>	
				<td><input disabled type="text" v-model="info.sZipno"></td>
			<tr>		
			<tr>
				<th>주소</th>	
				<td>
					<input disabled type="text" v-model="info.sAddr" placeholder="업체 주소를 입력하세요.">
                    <button @click="fnSearchAddr" class="btn-dark">주소 검색</button>
                </td>
			<tr>		
			<tr>
				<th>상세주소</th>
				<td><input type="text" v-model="info.sDetailAddr" placeholder="나머지 주소를 입력해주세요."></td>
			</tr>	 	
			<tr>
				<th>
					숙소 유형				
				</th>
				<td>
					<select v-model="selectStayType">
						<option value="">선택하세요</option>
						<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>편의시설</th>
				<td>
					<div v-for="item in serviceList" class="service-checkbox">
						<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
					</div>					
				</td>
			</tr>
			<tr>
				<th>상세정보이미지</th>
				<td>
					<div class="filebox">
					    <input class="upload-name" id="fileYName" placeholder="첨부파일" readonly>
					    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
					    <label for="fileY">이미지선택</label> 
					    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
					</div>
				</td>
			</tr>
		</tbody>
		</table>
		<div class="btnbtn">
			<span><button @click="fnStayAdd" class="btn-dark">숙소 등록</button></span>
			<span><button @click="fnBack" class="btn-red">되돌아가기</button></span>
		</div>
	</div>
</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
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
		status : "${sessionStatus}",
		serviceList : [], // 출력을 위한 서비스 리스트
		selectServiceList : [], // 체크한 값을 넣기 위한 서비스 리스트
		selectStayType : "",
		serviceNo : 0,
		typeList : [],
		info : {},
		fileYFlg : false
	},// data
	methods : {
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
		
		fnStayAdd : function(){
			var self = this;
			if(self.info.stayName == ""){
				alert("숙소 이름을 입력해주세요.");
				return;
			}
			if(self.info.sAddr == ""){
				alert("숙소 주소를 입력해주세요.");
				return;
			}
			if(!confirm("숙소를 등록하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			
			var noServiceList = JSON.stringify(self.selectServiceList); //문자열 형태로 형변환
			var param = self.info;
			param.uId = self.uId;
			param.type = self.selectStayType;
			param.serviceNo = self.serviceNo;
			param.selectServiceList = noServiceList;
			
			$.ajax({
                url : "stayAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	var form = new FormData();
	       	        form.append( "files",  $("#fileY")[0].files[0]);
	       	     	form.append( "stayNo",  data.stayNo); // 제품 pk
	       	     	console.log(data.stayNo);
	           		self.upload(form);
	       	     	
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
            
            self.$nextTick(function() {
                console.log(roadFullAddr);
                console.log(roadAddrPart1);
                console.log(addrDetail);
                console.log(engAddr);
            });
    	},
    	
		// 파일 업로드
		upload : function(form){
		   	var self = this;
		        $.ajax({
		            url : "stayFileUpload.dox"
		          , type : "POST"
		          , processData : false
		          , contentType : false
		          , data : form
		          , success:function(response) { 
		       	   
		          }
		      });
		},
		//파일이 선택됐는지 확인 (선택됐다면 x버튼이 나온다.)
		fnFlgChange : function(){
			var self = this;
			var fileCheck = document.getElementById("fileY").value;
			
			if(!fileCheck){
				document.getElementById("fileYName").value = "";
				self.fileYFlg = false;
				return;
			} else{
				document.getElementById("fileYName").value = $("#fileY")[0].files[0].name;
				self.fileYFlg = true;
				return;
			}
			
		},
		// 파일 삭제
		
		fnDelFile : function(){
			var self = this;
			document.getElementById("fileY").value = "";
			document.getElementById("fileYName").value = "";
		}, 
		fnBack : function(){
			location.href = "../host/stay.do";        	
        }
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../../main.do";
		} else {
			if(self.stayNo != ""){
				self.fnGetOption();
			}
		}
		
	//	self.fnGetList();
	}// created
});
</script>