<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ���� ������</title>
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
	<h3>���� ���� ����</h3>
		<table>
			<tr>
				<th>No.</th>
				<td><input v-model="info.stayNo" type="text" name="stayNo" id="stayNo" disabled></td>
			</tr>
			<tr>
				<th>�̸�</th>
				<td><input v-model="info.stayName" type="text" name="stayName" id="stayName"></td>
			</tr>
			<tr>
				<th>�з�</th>
				<td>
					<select v-model="info.stayKind">
						<option v-for="item in typeList" :value="item.cKind">{{item.cName}}</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>�����ȣ</th>
				<td>
					<input v-model="info.sZipno" type="text" name="sZipno" id="sZipno" disabled>
					<button @click="fnSearchAddr" class="btn-dark">�ּ� �˻�</button>
				</td>
			</tr>
			<tr>
				<th>�ּ�</th>
				<td><input v-model="info.sAddr" type="text" name="sAddr" id="sAddr" disabled></td>
			</tr>
			<tr>
				<th>���ּ�</th>
				<td><input v-model="info.sDetailAddr" type="text" name="sDetailAddr" id="sDetailAddr"></td>
			</tr>
			<tr>
				<th>
					���ǽü�
					<br>
					���� �ȳ�
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
				<th>�������̹���</th>
				<td>
					<div class="filebox">
					    <input class="upload-name" id="fileYName" placeholder="÷������" readonly :value="imgInfo.imgName">
					    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
					    <label for="fileY" class="btn-dark">�̹�������</label> 
					    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
					</div>
				</td>
			</tr>
		</table>
		<div>
			<div class="btnbtn">
				<span><button @click="fnUpdate" class="btn-dark">����</button></span>
				<span><button @click="fnBack" class="btn-red">�ǵ��ư���</button></span>
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
		serviceList : [], // ����� ���� ���� ����Ʈ
		checkList : [], // DB�� �ִ� üũ ����Ʈ�� �ֱ� ���� ���� ����Ʈ
		selectServiceList : [], // ���Ӱ� ������ üũ ����Ʈ�� ��� ����Ʈ
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
		
		//�ش� ���ھ����� üũ�Ǿ��� ���ǽü� ����Ʈ�� ������
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
                	// ���õ� ���� ����Ʈ�� �ʱ�ȭ
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
			if(!confirm("���� ������ �����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			
			var noServiceList = JSON.stringify(self.selectServiceList); //���ڿ� ���·� ����ȯ
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
        			form.append( "imgNo", self.imgInfo.imgNo); //���� pk
        			console.log(self.info.imgNo);
        			self.fileChange(form);
        			
                	alert("�����Ǿ����ϴ�.");
                	location.href = "stay.do";
                	
                }
            }); 
		},
		 // ���� ������Ʈ
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
		//������ ���õƴ��� Ȯ�� (���õƴٸ� x��ư�� ���´�.)
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
		
		// ���� ����
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
    	// DB�� �ִ� �� ����
    	isServiceChecked(service) {
            return this.checkList.some(item => item.serviceNo === service.serviceNo);
        },
        // ���Ӱ� ���õ� üũ�ڽ� ����Ʈ
        updateCheck(event, service) {
        	var self = this;
            if (event.target.checked) {
                // üũ�ڽ��� ���õǾ��� ��
                self.selectServiceList.push(service.serviceNo);
            } else {
                // üũ�ڽ��� �����Ǿ��� ��
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