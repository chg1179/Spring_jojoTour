<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<meta charset="EUC-KR">
<title>1:1 ���� �ۼ�</title>
<style>
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
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div>
				<label>���� : <input v-model="info.iTitle" maxlength="25" @input="handleTitleInput"></label>
				<label><input type="checkbox" v-model="fnSecret"> ��б�</label>
				<div>
					<vue-editor v-model="info.iContent" maxlength="500"></vue-editor>
				</div>
				<div v-if="privateYN=='Y'">
					<label>��й�ȣ <input v-model="info.iPassword" type="password"></label>
				</div>
				<div class="btns">
					<button v-if="answer == 'A'" @click="fnAdd">�亯���</button>
					<button v-else-if="iNo == ''" @click="fnAdd">���</button>
					<button v-else @click="fnEdit">����</button>
					<button @click="fnBack">�ڷΰ���</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({
	el : '#app',
	data : {
		uId:"${sessionId}",
		iNo : "${map.iNo}", // ���
		maxINo : "",		// ����
		answer : "${map.answer}", //��� �ۼ�
		privateYN : "Y", // Y�� �� �����
		cnt : "${map.cnt}", // �ۼ��� ���� �ϳ��� ������(0�̸�) pk 1���� ����
		maxINo : "",
		info : {
			iTitle : "[���]",
			iContent : "",
			iPassword : ""
		},
		fnSecret : true
	},// data
	components: {VueEditor},
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {iNo : self.iNo, kind : "UPDATE"};
			$.ajax({
				url : "view.dox",
	            dataType:"json",	
	            type : "POST",
	            data : param,
	            success : function(data) { 
	             	self.info = data.info;
	             	console.log(data.info);
				}
			}); 
		},
		fnGetMaxNo : function(){
			var self = this;
			var param = {};
			$.ajax({
				url : "maxINo.dox",
	            dataType:"json",	
	            type : "POST",
	            data : param,
	            success : function(data) {
	            	if(data.cnt == 0){
	            		self.maxINo = 1; //�ۼ��� ���� �ϳ��� ������ pk ��ȣ�� 1���� ����
	            	} else {
		             	self.maxINo = data.maxINo;
	             	}
				}
			}); 
		},
		fnAdd : function(){
			var self = this;
			console.log(self.info.iTitle.length);
			if(self.privateYN == "Y"){
				if(self.info.iTitle.length < 5){
					alert("������ �Է����ּ���.");
					return;
				}
			} else if(self.privateYN == "N"){
				if(self.info.iTitle == ""){
					alert("������ �Է����ּ���.");
					return;
				}
			}
			if(self.info.iContent == ""){
				alert("������ �Է����ּ���.");
				return;
			}
			if(self.privateYN=="Y" && self.info.iPassword==""){
				alert("��й�ȣ�� �Է����ּ���.");
				return;
			}
			
			if(!confirm("���Ǳ��� ����Ͻðڽ��ϱ�?")){
	        	alert("����� ��ҵǾ����ϴ�.");
	          	return;
	        }
			
			if(self.answer=='A'){
				// �Խ����� ��-�亯 ������ �����ϱ� ���� ����� pk+1
				self.maxINo = self.maxINo + 1;
			} else {
				// ���� ����� �� ���̺��� �۾��ϴµ� �����ϱ� ���� MAX PK+2(����� pk+1)
	         	self.maxINo = self.maxINo + 2;
			}
			console.log(self.maxINo);
			var param = {
				iNo : self.maxINo,
				uId : self.uId,
				iTitle : self.info.iTitle,
				iContent : self.info.iContent,
				privateYN : self.privateYN,
				iPassword : self.info.iPassword
			}
			console.log(param);
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("1:1���ǰ� ��ϵǾ����ϴ�.");
					location.href = "list.do";
                }
            }); 
		},
 		fnEdit : function(){
			var self = this;
			var param = self.info;
			$.ajax({
				url : "edit.dox",
				dataType:"json",	
				type : "POST",
				data : param,
				success : function(data) { 
					alert("���� ������ �����Ǿ����ϴ�");
	                location.href = "list.do";
				}
			}); 
		},
		fnBack : function(){
			location.href = "list.do";
		},
		handleTitleInput: function() {
		    var self = this;
		    if (self.fnSecret && !self.info.iTitle.includes('[���]')) {
		        self.info.iTitle = '[���]';
		    }
		}
	}, // methods
	watch : {
	    fnSecret: function(newFnSecret) {
	    	var self = this;
	        if (!newFnSecret) {
	        	self.info.iTitle = "";
	        	self.info.iPassword = "";
	        	self.privateYN = "N";
	        } else {
	        	self.info.iTitle ="[���]";
	        	self.privateYN = "Y";
	        }
	    }
	},
	created : function() {
		var self = this;
		if(self.iNo != ""){
			self.fnGetInfo(); //����
		} else{
			self.fnGetMaxNo(); //���
		}
	}// created
});
</script>