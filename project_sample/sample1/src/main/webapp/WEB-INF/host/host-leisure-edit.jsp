<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ��ǰ �߰� �� ���� ������</title>
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
	  max-width: 600px; /* �ִ� �ʺ� 800px�� ���� */
	  height: auto; /* ���̸� �ڵ����� �����Ͽ� ���� ���� */
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
	select{
      background: none;
       width: 20%;
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
	
	body{
		background-color:#f2f2f2
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
		<div class="container">
			<div v-if="leisureNo == ''">
				<h3>���� ���</h3>
			</div>
			<table>
				<tr>
					<th>�з�</th>
					<td>
						<select v-model="info.cType" @change="changeType(info.cType)">
							<option value="WATER">����</option>
							<option value="GROUND">����</option>
						</select>
						<select v-if='info.cType=="WATER"' v-model="info.leisureKind">
							<option value="SNORKE">������</option>
							<option value="SURFING">����</option>
							<option value="YACHT">��Ʈ</option>
							<option value="JETSKI">��Ʈ��Ű</option>
						</select>
						<select v-if='info.cType=="GROUND"' v-model="info.leisureKind">
							<option value="ATV">ATV</option>
							<option value="GLIDER">�з��۶��̵�</option>
							<option value="HORSE">�¸�</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>������</th>
					<td><input v-model="info.leisureName" type="text" maxlength="15" name="leisureName" id="leisureName"></td>
				</tr>
				<tr>
					<th>�����ȣ</th>
					<td>
						<input v-model="info.lZipno" type="text" name="lZipno" id="lZipno" disabled>
						<button @click="fnSearchAddr" class="btn-dark">�ּ� �˻�</button>
					</td>
				</tr>
				<tr>
					<th>�ּ�</th>
					<td><input v-model="info.lAddr" type="text" name="lAddr" id="lAddr" disabled></td>
				</tr>
				<tr>
					<th>���ּ�</th>
					<td><input v-model="info.lDetailAddr" type="text" maxlength="50" name="lDetailAddr" id="lDetailAddr"></td>
				</tr>
				<tr>
					<th>�����ݾ�</th>
					<td><input v-model="info.leisurePrice" type="text" maxlength="10" name="leisurePrice" id="leisurePrice"></td>
				</tr>
				<tr>
					<th>������(%)</th>
					<td><input v-model="sales" type="text" name="leisureSales" maxlength="2" placeholder="0" id="leisureSales" @keyup="fnPercent"></td>
				</tr>
				<tr>
					<th>�Ǹż���</th>
					<td><input v-model="info.lResidue" type="text" maxlength="10" name="lResidue" id="lResidue"></td>
				</tr>
				<tr>
					<th>������̹���</th>
					<td>
						<div class="filebox">
						    <input class="upload-name" id="fileYName" placeholder="÷������" readonly>
						    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
						    <label for="fileY">�̹�������</label> 
						    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
						</div>
					</td>
				</tr>
				<tr>
					<th>�������̹���</th>
					<td>
						<div class="filebox">
						    <input class="upload-name" id="fileNName" placeholder="÷������" readonly>
						    <a href="javascript:;" v-if="fileNFlg" @click="fnDelFile('N')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
						    <label for="fileN">�̹�������</label> 
						    <input type="file" accept=".gif, .jpg, .png" id="fileN" name="fileN" @change="fnFlgChange('N')">
						</div>
					</td>
				</tr>
			</table>
			<div class="btnbtn">
				<button v-if="leisureNo == ''" @click="fnAdd" class="btn-dark">���</button>
				<button v-else @click="fnEdit" class="btn-dark">����</button>
				<span><button @click="fnBack" class="btn-red">���</button></span>
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
		leisureNo : "${map.leisureNo}",
		info : {
			cType : "WATER",
			leisureKind : "SNORKE",
			leisureName : "",
			lZipno : "",
			lAddr : "",
			lDetailAddr : "",
			lentPrice : "",
			lentSales : "",
			lResidue : ""
		},
		sales : "",
		fileYFlg : false,
		fileNFlg : false,
		imgList : []
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.leisureInfo;
                	self.sales = 100 - (self.info.leisureSales * 100);
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureImgList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.leisureImgList;
                	// �ʼ��� ÷�������� ����߱� ������ �����ÿ��� X(���ϻ���) ���
        			self.fileYFlg = true;
        			self.fileNFlg = true;
                	// ��� ��� ���� (�� ĭ �� ���� ���)
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
			if(self.info.leisureName==""){
				alert("�������� �Է����ּ���.");
				return;
			}
			if(self.info.lAddr=="" || self.info.lDetailAddr==""){
				alert("�ּҸ� �Է����ּ���.");
				return;
			}
			
			var regex = new RegExp(/^[0-9]+$/);
			if(self.info.leisurePrice==""){
				alert("���� �ݾ��� �Է����ּ���.");
				return;
			}
			if(!regex.test(self.info.leisurePrice)){
				alert("���� �ݾ��� ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.leisurePrice < 1000){
				alert("���� �ݾ��� 1000�� �̻����� �Է����ּ���.");
				return;
			}
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("�������� ���ڸ� �Է����ּ���.");
					return;
				}
			}
			if(self.sales < 0 || self.sales >= 100){
				alert("�������� 0~99 ������ ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.lResidue==""){
				alert("�Ǹ��Ͻ� ������ �Է����ּ���.");
				return;
			}
			if(!regex.test(self.info.lResidue)){
				alert("�Ǹ��Ͻ� ������ ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.lResidue <= 0){
				alert("�Ǹż����� 0���� ū ���ڷ� �Է����ּ���.");
				return;
			}
			
			var fileCheck = document.getElementById("fileY").value;
			if(!fileCheck){
				alert("����Ͽ� �̹����� ÷���� �ּ���");
				return;
			}
			fileCheck = document.getElementById("fileN").value;
			if(!fileCheck){
				alert("������ �̹����� ÷���� �ּ���");
				return;
			}
			
			if(!confirm("������ �߰��Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			
			//�������� �Է����� ������ �ڵ����� 0���� �Ǵ�.
			if(self.sales==""){
				self.sales = 0;
			}
			self.info.leisureSales = 1 - (self.sales / 100);
			var param = self.info;
			param.uId = self.uId;
			
			$.ajax({
                url : "addLeisure.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	var form = new FormData();
	       	        form.append( "files",  $("#fileY")[0].files[0]);
	       	     	form.append( "leisureNo",  data.leisureNo); // ��ǰ pk
	       	     	form.append( "mainYN",  "Y");
	           		self.upload(form);
	           		
	           		setTimeout(self.waiting("wait"), 3000);
	           		
	           		var form2 = new FormData();
	       	        form2.append( "files",  $("#fileN")[0].files[0]);
	       	     	form2.append( "leisureNo",  data.leisureNo); // ��ǰ pk
	       	     	form2.append( "mainYN",  "N");
	           		self.upload(form2);
	           		
	           		alert("����� �Ϸ�Ǿ����ϴ�.");
                	location.href = '../leisure.do'; 
                }
            });
		},
		// ���� ���ε�
	    upload : function(form){
	    	var self = this;
	         $.ajax({
	             url : "leisureFileUpload.dox"
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
			if(self.info.leisureName==""){
				alert("�������� �Է����ּ���.");
				return;
			}
			if(self.info.lAddr=="" || self.info.lDetailAddr==""){
				alert("�ּҸ� �Է����ּ���.");
				return;
			}
			
			var regex = new RegExp(/^[0-9]+$/);
			if(self.info.leisurePrice==""){
				alert("���� �ݾ��� �Է����ּ���.");
				return;
			}
			if(!regex.test(self.info.leisurePrice)){
				alert("���� �ݾ��� ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.leisurePrice < 1000){
				alert("���� �ݾ��� 1000�� �̻����� �Է����ּ���.");
				return;
			}
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("�������� ���ڸ� �Է����ּ���.");
					return;
				}
			}
			if(self.sales < 0 || self.sales >= 100){
				alert("�������� 0~99 ������ ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.lResidue==""){
				alert("�Ǹ��Ͻ� ������ �Է����ּ���.");
				return;
			}
			if(!regex.test(self.info.lResidue)){
				alert("�Ǹ��Ͻ� ������ ���ڸ� �Է����ּ���.");
				return;
			}
			if(self.info.lResidue <= 0){
				alert("�Ǹż����� 0���� ū ���ڷ� �Է����ּ���.");
				return;
			}
			
			var fileCheck = document.getElementById("fileY").value;
			if(!fileCheck && !self.fileYFlg){
				alert("����Ͽ� �̹����� ÷���� �ּ���");
				return;
			}
			fileCheck = document.getElementById("fileN").value;
			if(!fileCheck && !self.fileNFlg){
				alert("������ �̹����� ÷���� �ּ���");
				return;
			}
			if(!confirm("�ش� ������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			
			//�������� �Է����� ������ �ڵ����� 0���� �Ǵ�.
			if(self.sales==""){
				self.sales = 0;
			}
			self.info.leisureSales = 1 - (self.sales / 100);
			var param = self.info;
			param.leisureNo = self.leisureNo;
			
			$.ajax({
                url : "editLeisure.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	//������ �������� �ʾҴٸ� ����X
                	for(var i=0;i< self.imgList.length;i++){
                		if(self.imgList[i].mainYN == 'Y' && $("#fileY")[0].files[0]){
                			var form = new FormData();
                			form.append( "files", $("#fileY")[0].files[0]);
                			form.append( "imgNo", self.imgList[i].imgNo); //���� pk
                			self.fileChange(form);
                			setTimeout(self.waiting("wait"), 3000);
                		} else if(self.imgList[i].mainYN == 'N' && $("#fileN")[0].files[0]){
                			var form2 = new FormData();
        	       	        form2.append( "files", $("#fileN")[0].files[0]);
        	       	     	form2.append( "imgNo", self.imgList[i].imgNo); //���� pk
        	       	     	self.fileChange(form2);
        	       	     	setTimeout(self.waiting("wait"), 3000);
                		}
                	}
	           		alert("���� ������ �Ϸ�Ǿ����ϴ�.");
                	$.pageChange("view.do", {leisureNo : self.leisureNo, rCnt : 0});
                }
            });
		},
		// ���� ������Ʈ
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
			location.href = "../leisure.do"; 
		},
		fnPercent : function(){ // ������ 0~100 ����
			var self = this;
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("�������� ���ڸ� �Է����ּ���.");
					self.sales = 0;
					return;
				}
			}
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
    		window.open("addr.do", "leisureAddr", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.info.lZipno = zipNo;
    		self.info.lAddr = roadAddrPart1;
    		self.info.lDetailAddr = addrDetail;
    	},
		//������ ���õƴ��� Ȯ�� (���õƴٸ� x��ư�� ���´�.)
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
		},
		changeType : function (cType) {
			var self = this;
			if(cType == "WATER"){
				self.info.leisureKind = "SNORKE";
			} else if(cType == "GROUND"){
				self.info.leisureKind = "ATV";
			}
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("ȣ��Ʈ�� ������ �� �ֽ��ϴ�.");
			location.href="../../main.do";
		} else {
			if(self.leisureNo != ""){
				self.fnGetInfo();
				self.fnGetImgList();
			}
		}
	}// created
});
</script>