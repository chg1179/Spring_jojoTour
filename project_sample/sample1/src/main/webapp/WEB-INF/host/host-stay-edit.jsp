<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 정보 수정 페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/host-edit-style.css" rel="stylesheet"/>
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
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    border-radius: 4px;
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
	<h3>숙소 정보 수정</h3>
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
					<button @click="fnSearchAddr" class="btn-dark">주소 검색</button>
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
					    <label>
					        <input type="checkbox" :value="item.serviceNo" :checked="isServiceChecked(item)" @change="updateCheck($event, item)">
					        {{ item.serviceName }}
					    </label>
					</div>			
				</td>
			</tr>
			<tr>
			<tr>
				<th>상세정보이미지</th>
				<td>
					<div class="filebox">
					    <input class="upload-name" id="fileYName" placeholder="첨부파일" readonly :value="imgInfo.imgName">
					    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
					    <label for="fileY" class="btn-dark">이미지선택</label> 
					    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
					</div>
				</td>
			</tr>
		</table>
		<div>
			<div class="btnbtn">
				<span><button @click="fnUpdate" class="btn-dark">수정</button></span>
				<span><button @click="fnBack" class="btn-red">되돌아가기</button></span>
			</div>
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
		typeList : [],
		serviceList : [], // 출력을 위한 서비스 리스트
		checkList : [], // DB에 있는 체크 리스트를 넣기 위한 서비스 리스트
		selectServiceList : [], // 새롭게 선택한 체크 리스트를 담는 리스트
		imgList : [],
		stayNo : "${map.stayNo}",
		info : {
			stayName : "",
			stayKind : "",
			sZipNo : "",
			sAddr : "",
			sDetailAddr : ""
		},
		imgInfo : {
			imgName : ""
		},
		fileYFlg : false
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
                	self.fnGetCheckList();
                }
            }); 
		},
		fnGetImgInfo : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "stayImgInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgInfo = data.imgInfo;
                	self.fileYFlg = true;
                	console.log(self.imgInfo);
                	//console.log(self.imgInfo.imgPath);
                }
            }); 
		},
		
		//해당 숙박업소의 체크되었던 편의시설 리스트를 가져옴
		fnGetCheckList : function(){
			var self = this;
			var param = {stayNo : self.stayNo};
			$.ajax({
                url : "checkList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.checkList = data.checkList;
                	// 선택된 서비스 리스트에 초기화
                	self.checkList.forEach(item => {
            	        self.selectServiceList.push(item.serviceNo);
            	    });
                	console.log(self.checkList);
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
			param.checkList = noServiceList;
			
			$.ajax({
                url : "stayEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	var form = new FormData();
        			form.append( "files", $("#fileY")[0].files[0]);
        			form.append( "imgNo", self.imgInfo.imgNo); //사진 pk
        			console.log(self.info.imgNo);
        			self.fileChange(form);
        			
                	alert("수정되었습니다.");
                	location.href = "stay.do";
                	
                }
            }); 
		},
		 // 파일 업데이트
	    fileChange : function(form){
	    	var self = this;
	         $.ajax({
	             url : "stayFileChange.dox"
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
		
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("../addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		self.info.sZipno = zipNo;
    		self.info.sAddr = roadAddrPart1;
            self.info.sDetailAddr = addrDetail;
    	},
    	// DB에 있는 값 선택
    	isServiceChecked(service) {
            return this.checkList.some(item => item.serviceNo === service.serviceNo);
        },
        // 새롭게 선택된 체크박스 리스트
        updateCheck(event, service) {
        	var self = this;
            if (event.target.checked) {
                // 체크박스가 선택되었을 때
                self.selectServiceList.push(service.serviceNo);
            } else {
                // 체크박스가 해제되었을 때
                var index = self.selectServiceList.indexOf(service.serviceNo);
                if (index !== -1) {
                	self.selectServiceList.splice(index, 1);
                }
            }
        },
        fnBack : function(){
			location.href = "../host/stay.do";        	
        }
		
	}, // methods
	created : function() {
		var self = this;
		if(self.stayNo != ""){
			self.fnGetOption();
			self.fnGetInfo();
			self.fnGetImgInfo();
		}
		
	}// created
});
</script>