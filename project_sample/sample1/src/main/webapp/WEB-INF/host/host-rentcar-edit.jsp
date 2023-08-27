<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌터카 제품 추가 및 수정 페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
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
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<table>
				<tr>
					<th>분류</th>
					<td>
						<select v-model="info.rentKind">
							<option value="SMALL">소형차</option>
							<option value="MIDDLE">중형차</option>
							<option value="LARGE">대형차</option>
							<option value="VAN">승합차</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>렌터카명</th>
					<td><input v-model="info.rentName" type="text" maxlength="15" name="rentName" id="rentName"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>
						<input v-model="info.rZipno" type="text" name="rZipno" id="rZipno" disabled>
						<button @click="fnSearchAddr" class="btn-dark">주소 검색</button>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input v-model="info.rAddr" type="text" name="rAddr" id="rAddr" disabled></td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td><input v-model="info.rDetailAddr" type="text" maxlength="50" name="rDetailAddr" id="rDetailAddr"></td>
				</tr>
				<tr>
					<th>렌트금액</th>
					<td><input v-model="info.rentPrice" type="text" maxlength="10" name="rentPrice" id="rentPrice"></td>
				</tr>
				<tr>
					<th>할인율(%)</th>
					<td><input v-model="sales" type="text" name="rentSales" maxlength="2" placeholder="0" id="rentSales" @keyup="fnPercent"></td>
				</tr>
				<tr>
					<th>판매수량</th>
					<td><input v-model="info.rResidue" type="text" maxlength="10" name="rResidue" id="rResidue"></td>
				</tr>
				<tr>
					<th>썸네일이미지</th>
					<td>
						<div class="filebox">
						    <input class="upload-name" id="fileYName" placeholder="첨부파일" readonly>
						    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
						    <label for="fileY">이미지선택</label> 
						    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
						</div>
					</td>
				</tr>
				<tr>
					<th>상세정보이미지</th>
					<td>
						<div class="filebox">
						    <input class="upload-name" id="fileNName" placeholder="첨부파일" readonly>
						    <a href="javascript:;" v-if="fileNFlg" @click="fnDelFile('N')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
						    <label for="fileN">이미지선택</label> 
						    <input type="file" accept=".gif, .jpg, .png" id="fileN" name="fileN" @change="fnFlgChange('N')">
						</div>
					</td>
				</tr>
			</table>
			<div>
				<button v-if="rentNo == ''" @click="fnAdd" class="btn-dark">등록</button>
				<button v-else @click="fnEdit" class="btn-dark">수정</button>
				<span><button @click="fnBack" class="btn-red">취소</button></span>
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
		sales : "",
		fileYFlg : false,
		fileNFlg : false,
		imgList : []
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
		fnGetImgList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carImgList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.carImgList;
                	// 필수로 첨부파일을 등록했기 때문에 수정시에는 X(파일삭제) 출력
        			self.fileYFlg = true;
        			self.fileNFlg = true;
                	// 상대 경로 수정 (한 칸 더 이전 경로)
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath;
                		if(self.imgList[i].mainYN == 'Y'){
                			document.getElementById("fileYName").value = self.imgList[i].imgName;
                		} else if(self.imgList[i].mainYN == 'N'){
                			document.getElementById("fileNName").value = self.imgList[i].imgName;
                		}
                	}
                }
            }); 
		},
		fnAdd : function(){
			var self = this;
			if(self.info.rentName==""){
				alert("이름을 입력해주세요.");
				return;
			}
			if(self.info.rAddr=="" || self.info.rDetailAddr==""){
				alert("주소를 입력해주세요.");
				return;
			}
			
			var regex = new RegExp(/^[0-9]+$/);
			if(self.info.rentPrice==""){
				alert("렌트 금액을 입력해주세요.");
				return;
			}
			if(!regex.test(self.info.rentPrice)){
				alert("렌트 금액은 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rentPrice < 1000){
				alert("렌트 금액은 1000원 이상으로 입력해주세요.");
				return;
			}
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("할인율은 숫자만 입력해주세요.");
					return;
				}
			}
			if(self.sales < 0 || self.sales >= 100){
				alert("할인율은 0~99 사이의 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rResidue==""){
				alert("판매하실 수량을 입력해주세요.");
				return;
			}
			if(!regex.test(self.info.rResidue)){
				alert("판매하실 수량은 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rResidue <= 0){
				alert("판매수량은 0보다 큰 숫자로 입력해주세요.");
				return;
			}
			
			var fileCheck = document.getElementById("fileY").value;
			if(!fileCheck){
				alert("썸네일용 이미지를 첨부해 주세요");
				return;
			}
			fileCheck = document.getElementById("fileN").value;
			if(!fileCheck){
				alert("상세정보 이미지를 첨부해 주세요");
				return;
			}
			
			if(!confirm("렌터카를 추가하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
			
			//할인율을 입력하지 않으면 자동으로 0으로 판단.
			if(self.sales==""){
				self.sales = 0;
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
                	var form = new FormData();
	       	        form.append( "files",  $("#fileY")[0].files[0]);
	       	     	form.append( "rentNo",  data.rentNo); // 제품 pk
	       	     	form.append( "mainYN",  "Y");
	           		self.upload(form);
	           		
	           		setTimeout(self.waiting("wait"), 3000);
	           		
	           		var form2 = new FormData();
	       	        form2.append( "files",  $("#fileN")[0].files[0]);
	       	     	form2.append( "rentNo",  data.rentNo); // 제품 pk
	       	     	form2.append( "mainYN",  "N");
	           		self.upload(form2);
	           		
	           		alert("등록이 완료되었습니다.");
                	location.href = '../rentcar.do'; 
                }
            });
		},
		// 파일 업로드
	    upload : function(form){
	    	var self = this;
	         $.ajax({
	             url : "fileUpload.dox"
	           , type : "POST"
	           , processData : false
	           , contentType : false
	           , data : form
	           , success:function(response) { 
	        	   
	           }
	       });
		},
		fnEdit : function(){
			var self = this;
			if(self.info.rentName==""){
				alert("이름을 입력해주세요.");
				return;
			}
			if(self.info.rAddr=="" || self.info.rDetailAddr==""){
				alert("주소를 입력해주세요.");
				return;
			}
			
			var regex = new RegExp(/^[0-9]+$/);
			if(self.info.rentPrice==""){
				alert("렌트 금액을 입력해주세요.");
				return;
			}
			if(!regex.test(self.info.rentPrice)){
				alert("렌트 금액은 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rentPrice < 1000){
				alert("렌트 금액은 1000원 이상으로 입력해주세요.");
				return;
			}
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("할인율은 숫자만 입력해주세요.");
					return;
				}
			}
			if(self.sales < 0 || self.sales >= 100){
				alert("할인율은 0~99 사이의 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rResidue==""){
				alert("판매하실 수량을 입력해주세요.");
				return;
			}
			if(!regex.test(self.info.rResidue)){
				alert("판매하실 수량은 숫자만 입력해주세요.");
				return;
			}
			if(self.info.rResidue <= 0){
				alert("판매수량은 0보다 큰 숫자로 입력해주세요.");
				return;
			}
			
			var fileCheck = document.getElementById("fileY").value;
			if(!fileCheck && !self.fileYFlg){
				alert("썸네일용 이미지를 첨부해 주세요");
				return;
			}
			fileCheck = document.getElementById("fileN").value;
			if(!fileCheck && !self.fileNFlg){
				alert("상세정보 이미지를 첨부해 주세요");
				return;
			}
			if(!confirm("해당 정보를 수정하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
			
			//할인율을 입력하지 않으면 자동으로 0으로 판단.
			if(self.sales==""){
				self.sales = 0;
			}
			self.info.rentSales = 1 - (self.sales / 100);
			var param = self.info;
			param.rentNo = self.rentNo;
			
			$.ajax({
                url : "editRentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	//파일을 수정하지 않았다면 변경X
                	for(var i=0;i< self.imgList.length;i++){
                		if(self.imgList[i].mainYN == 'Y' && $("#fileY")[0].files[0]){
                			var form = new FormData();
                			form.append( "files", $("#fileY")[0].files[0]);
                			form.append( "imgNo", self.imgList[i].imgNo); //사진 pk
                			self.fileChange(form);
                			setTimeout(self.waiting("wait"), 3000);
                		} else if(self.imgList[i].mainYN == 'N' && $("#fileN")[0].files[0]){
                			var form2 = new FormData();
        	       	        form2.append( "files", $("#fileN")[0].files[0]);
        	       	     	form2.append( "imgNo", self.imgList[i].imgNo); //사진 pk
        	       	     	self.fileChange(form2);
        	       	     	setTimeout(self.waiting("wait"), 3000);
                		}
                	}
	           		alert("정보 수정이 완료되었습니다.");
                	$.pageChange("view.do", {rentNo : self.rentNo, rCnt : 0});
	       	     	
                }
            });
		},
		// 파일 업데이트
	    fileChange : function(form){
	    	var self = this;
	         $.ajax({
	             url : "fileChange.dox"
	           , type : "POST"
	           , processData : false
	           , contentType : false
	           , data : form
	           , success:function(response) { 
	        	   
	           }
	       });
		},
		fnBack : function(){
			location.href = "../rentcar.do"; 
		},
		fnPercent : function(){ // 할인율 0~100 제한
			var self = this;
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("할인율은 숫자만 입력해주세요.");
					self.sales = 0;
					return;
				}
			}
			if(self.sales >= 100){
				alert("100보다 낮은 숫자를 입력해주세요.");
				self.sales = 0;
			} else if(self.sales < 0){
				alert("0보다 큰 숫자를 입력해주세요.");
				self.sales = 0;
			}
		},
		// 주소 검색
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
		// 파일 업로드
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
		},
		//파일이 선택됐는지 확인 (선택됐다면 x버튼이 나온다.)
		fnFlgChange : function(mainYN){
			var self = this;
			if(mainYN == 'Y'){
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
			} else if(mainYN == 'N'){
				var fileCheck = document.getElementById("fileN").value;
				if(!fileCheck){
					document.getElementById("fileNName").value = "";
					self.fileNFlg = false;
					return;
				} else{
					document.getElementById("fileNName").value = $("#fileN")[0].files[0].name;
					self.fileNFlg = true;
					return;
				}
			}
		},
		fnDelFile : function(mainYN){
			var self = this;
			if(mainYN == 'Y'){
				document.getElementById("fileY").value = "";
				document.getElementById("fileYName").value = "";
				self.fileYFlg = false;
			} else if(mainYN == 'N'){
				document.getElementById("fileN").value = "";
				document.getElementById("fileNName").value = "";
				self.fileNFlg = false;
			}
		},
		waiting : function (wait) {
			console.log(wait);
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../../main.do";
		} else {
			if(self.rentNo != ""){
				self.fnGetInfo();
				self.fnGetImgList();
			}
		}
	}// created
});
</script>