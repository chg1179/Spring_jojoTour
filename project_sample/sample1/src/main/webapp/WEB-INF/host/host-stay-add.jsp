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
<title>���� ���� ������</title>
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
		<h3>���� ��ü ���</h3>
		<table>
		<tbody>
			<tr>
				<th>�����̸�</th>
				<td>
					<input type="text" v-model="info.stayName" name="stayName">
				</td>
			</tr>
			<tr>
				<th>�����ȣ</th>	
				<td><input disabled type="text" v-model="info.sZipno"></td>
			<tr>		
			<tr>
				<th>�ּ�</th>	
				<td>
					<input disabled type="text" v-model="info.sAddr" placeholder="��ü �ּҸ� �Է��ϼ���.">
                    <button @click="fnSearchAddr" class="btn-dark">�ּ� �˻�</button>
                </td>
			<tr>		
			<tr>
				<th>���ּ�</th>
				<td><input type="text" v-model="info.sDetailAddr" placeholder="������ �ּҸ� �Է����ּ���."></td>
			</tr>	 	
			<tr>
				<th>
					���� ����				
				</th>
				<td>
					<select v-model="selectStayType">
						<option value="">�����ϼ���</option>
						<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>���ǽü�</th>
				<td>
					<div v-for="item in serviceList" class="service-checkbox">
						<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
					</div>					
				</td>
			</tr>
			<tr>
				<th>�������̹���</th>
				<td>
					<div class="filebox">
					    <input class="upload-name" id="fileYName" placeholder="÷������" readonly>
					    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
					    <label for="fileY">�̹�������</label> 
					    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
					</div>
				</td>
			</tr>
		</tbody>
		</table>
		<div class="btnbtn">
			<span><button @click="fnStayAdd" class="btn-dark">���� ���</button></span>
			<span><button @click="fnBack" class="btn-red">�ǵ��ư���</button></span>
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
		serviceList : [], // ����� ���� ���� ����Ʈ
		selectServiceList : [], // üũ�� ���� �ֱ� ���� ���� ����Ʈ
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
				alert("���� �̸��� �Է����ּ���.");
				return;
			}
			if(self.info.sAddr == ""){
				alert("���� �ּҸ� �Է����ּ���.");
				return;
			}
			if(!confirm("���Ҹ� ����Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			
			var noServiceList = JSON.stringify(self.selectServiceList); //���ڿ� ���·� ����ȯ
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
	       	     	form.append( "stayNo",  data.stayNo); // ��ǰ pk
	       	     	console.log(data.stayNo);
	           		self.upload(form);
	       	     	
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
            
            self.$nextTick(function() {
                console.log(roadFullAddr);
                console.log(roadAddrPart1);
                console.log(addrDetail);
                console.log(engAddr);
            });
    	},
    	
		// ���� ���ε�
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
		fnBack : function(){
			location.href = "../host/stay.do";        	
        }
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("ȣ��Ʈ�� ������ �� �ֽ��ϴ�.");
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