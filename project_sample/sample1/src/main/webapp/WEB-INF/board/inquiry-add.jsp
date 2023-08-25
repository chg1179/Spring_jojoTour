<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>1:1 ���� �ۼ�</title>
<style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }

    #app {
      margin: 20px auto;
      max-width: 1000px;
      background-color: #fff;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 5px;
    }

    .WritingHeader {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .WritingHeader h2 {
      font-size: 24px;
      color: #333;
    }

    .tool_area button {
      background-color: #007bff;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    .tool_area button:hover {
      background-color: #0056b3;
    }

    input[type="text"] {
      width: 98%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .vue-editor {
      border: 1px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      font-size: 16px;
      height:800px;
    }

    button[disabled] {
      background-color: #ccc;
      cursor: not-allowed;
    }
    .ql-container.ql-snow {
    border: 1px solid #ccc;
    height: 750px;
	}
	.password-input{
	    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
	}
	
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="WritingWrap">
			
			<div class="WritingHeader">
				<h2>1:1���� �۾���</h2>
					<div class="tool_area">
						<label v-if="privateYN=='Y'" ><i class="fas fa-regular fa-lock fa-bounce fa-xl" style="color: #7926df;  margin-right: 10px;"></i> 
							<input v-model="info.iPassword" type="password" class="password-input">
						</label>
						<button v-if="answer == 'A'" @click="fnAdd">�亯���</button>					
				        <button v-if="iNo === ''" @click="fnAdd">���</button>
				        <button v-else-if="iNo !='' && info.answerYn=='N'" @click="fnEdit">����</button>
			        	<button @click="fnBack">�ڷΰ���</button>
			        </div>
			 </div>	
			 	<label><input type="checkbox" v-model="fnSecret"> ��б�</label>
			 	<label><input type="text" v-model="info.iTitle" maxlength="40" @input="handleTitleInput"></label>
				<br><br>
			 	
				<div class="vue-editor">
					<vue-editor v-model="info.iContent" maxlength="500"></vue-editor>
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
		answer : "${map.answer}", //�����ڸ� ��� �ۼ� ����
		privateYN : "Y", // Y�� �� �����
		cnt : "${map.cnt}", // �ۼ��� ���� �ϳ��� ������(0�̸�) pk 1���� ����
		maxINo : "",
		info : {
			iTitle : "[���]",
			iContent : "",
			iPassword : "",
			answerYn : "" //������ �亯�� ������ �� ���� �Ұ���
		},
		anYn : "N",
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
	             	
	             	if(self.answer=='A'){
	             		self.info.iTitle += "�ۿ� �亯�帳�ϴ�!";
	             		self.info.iContent += "<br>-----------------------------------<br>�ȳ��ϼ���.<br>������� �̿����ּż� ����帳�ϴ�.<br>";
	             	}
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
			if(self.privateYN == "Y"){
				if(self.info.iTitle.trim().length < 5){
					alert("������ �Է����ּ���.");
					return;
				}
			} else if(self.privateYN == "N"){
				if(self.info.iTitle.trim() == ""){
					alert("������ �Է����ּ���.");
					return;
				}
			}
		    if (self.info.iContent.trim().length <1) {
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
			
			if(self.answer=='A'){ // ���Ǳۿ� ���� �������� �亯
				// �Խ����� ��-�亯 ������ �����ϱ� ���� ����� pk+1
				self.maxINo = parseInt(self.iNo) + 1;
				self.anYn = "A"; //�������� �亯�� A�� ǥ��
			} else { // ���� ��� ��
				// ���� ����� �� ���̺��� �۾��ϴµ� �����ϱ� ���� MAX PK+2(����� pk+1)
	         	self.maxINo = parseInt(self.maxINo) + 2;
			}
			console.log(self.maxINo);
			var param = {
				iNo : self.maxINo,
				uId : self.uId,
				iTitle : self.info.iTitle,
				iContent : self.info.iContent,
				privateYN : self.privateYN,
				iPassword : self.info.iPassword,
				answerYn : self.anYn
			}
			console.log(param);
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					if(self.answer=='A'){
						self.maxINo = parseInt(self.maxINo) - 1;
						self.fnAnswerY(self.maxINo); //�����ڰ� �亯�� ����ϸ� �ش� ���� �亯�Ϸ� ���·� ����
					}

					alert("1:1 ���Ǳ��� ��ϵǾ����ϴ�.");
					location.href = "list.do";
                }
            }); 
		},
		fnAnswerY : function(maxINo){
			var self = this;
			var param = {iNo : maxINo, answerYn : "Y"};
			$.ajax({
				url : "editAnswer.dox",
				dataType:"json",	
				type : "POST",
				data : param,
				success : function(data) { 
				}
			}); 
		},
 		fnEdit : function(){
			var self = this;
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
			
			if(!confirm("���Ǳ��� �����Ͻðڽ��ϱ�?")){
	        	alert("������ ��ҵǾ����ϴ�.");
	          	return;
	        }
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