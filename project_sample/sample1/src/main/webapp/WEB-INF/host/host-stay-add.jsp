<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
<jsp:include page="../header.jsp" flush="true"></jsp:include>
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
						<div>
							<div>�����ȣ<input disabled type="text" v-model="info.sZipno"></div>
						 	<input disabled type="text" v-model="info.sAddr" placeholder="��ü �ּҸ� �Է��ϼ���.">
	                        <button @click="fnSearchAddr">�ּ� �˻�</button>
	                        <div><input type="text" v-model="info.sDetailAddr" placeholder="������ �ּҸ� �Է����ּ���."></div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���� ����				
				</th>
				<td>
					<div>
						<select v-model="selectStayType">
							<option value="">�����ϼ���</option>
							<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���ǽü�
					<br>
					���� �ȳ�
				</th>
				<td>
					<div v-for="item in serviceList">
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
			
			console.log(self.selectServiceList);
			console.log(self.selectServiceList[2]); 
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
            
    		console.log(roadFullAddr);
    		console.log(roadAddrPart1);
    		console.log(addrDetail);
    		console.log(engAddr);
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