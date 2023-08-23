<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
	#container {
		width: 1200px;
		margin: 0px auto;
		text-align: center;
	}
	.box {
		text-align: left;
		border-bottom: 1px solid #ddd;
		padding: 10px;
		margin: 10px;
	}
	.mainTxt {
		width: 100%;
		color: rgb(78, 79, 81);
		font-weight : bold;
		font-size: 22px;
		border-bottom: 1px solid #bbb;
		padding-bottom: 50px;
		margin: 50px auto 10px; 
	}
	.coreTxt {
		width: 100%;
		color: rgb(78, 79, 81);
		font-weight : bold;
		font-size: 18px;
		padding-bottom: 10px;
		text-align: left;
		margin: 30px 0px;
	}
	.bar {
		color: #ff3333;
	}
	table {
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
	.wrap input, textarea {
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    background: none;
	    width: 96%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 10px;
	    border-radius: 4px;
	}
	.wrapPhone {
		width: 100%;
	}
	.wrapPhone input {
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    background: none;
	    width: 30%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 10px;
	    border-radius: 4px;
	}
	input[type=radio] {
		accent-color: #ff3333;
	}
	.btn {
		width: 100px;
		height: 50px;
		color: white;
		background-color: #ff3333;
	   	border: none;
	   	border-radius: 5%;
	   	padding: 7px;
	   	font-size: 12px;
	   	text-align: center;
	   	margin: 10px auto;
	   	cursor: pointer;
	}
		
	.btn:hover{
		color: rgb(50, 50, 50);
		background-color: #ff3333;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div class="mainTxt">����������</div>
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ��ǰ �� ����</div>
				
				
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ��� �� ����</div>
				
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ������ ���� �Է�</div>
				<div>
					<div>
						<label>
							<input type="radio" class="radioBtn" name="infoCheck" @click="infoView('same')" checked="checked">
							�����ڿ� ����� ����
						</label>
						<label>
							<input type="radio" class="radioBtn" name="infoCheck" @click="infoView('notSame')">
							���� �Է�
						</label>
					</div>
					<div>
						<div>����</div>
						<div class="wrap"><input type="text" v-model="userInfo.uName"></div>
					</div>
					<div>
						<div>����ó</div>
						<div>
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3"></span>
						</div>
					</div>
					<div>
						<div>�̸���</div>
						<div class="wrap"><input type="text" v-model="userInfo.email"></div>
					</div>
					<div>
						<div>��û����</div>
						<div class="wrap"><textarea rows="3" cols="50"  v-model="request" maxlength="50" placeholder="��û������ �ִ� ��� �����Ӱ� �Է��� �ּ���."></textarea></div>
					</div>
				</div>
			</div>
			
			
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ����Ʈ ���</div>
				<div>
					<div>
						<div>���� {{userInfo.point}}P</div>
					</div>
					<div>
						<div>���</div>
						<div class="wrap">
							<input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0">
						</div>
						<input type="button" class="btn" @click="allPoint" value="���׻��">
					</div>
					<div>����Ʈ�� ���� ��� ��ǰ�� �켱���� �����˴ϴ�.</div>
				</div>
				
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ���� ���� �ݾ�</div>
				
				
			</div>
			<div class="box">
				<button class="btn" @click="fnRequestPay">�����ϱ�</button>
			</div>
		</div>
	</div>
</body>
</html>
<script>
var IMP = window.IMP;
IMP.init('imp64757785');
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		userInfo : {},
		productlist : [],
		rentlist : [],
		leisurelist : [],
		item : [],		
		phoneSplit : { // OOO-XXXX-XXXX �� ����ϱ� ����
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		usePoint : "",
		request : "", //��û���� �ۼ�
		testList : []
	},// data
/* 	mounted() { // created �������� ȣ���
        this.testList = ${map.list}; // JSON �����͸� �Ҵ�
        console.log(this.testList);
    }, */
	methods : {
		fnGetUserInfo : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "userInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.userInfo = data.userInfo;
                	console.log(self.userInfo);
                	self.phoneSubString();
                	if(self.userInfo.point == null || self.userInfo.point ==''){
                		self.userInfo.point = 0;
                	}
                }
            }); 
		},
		phoneSubString : function(){
			var self = this;
			var middleNum; // �ڵ��� ��ȣ�� 11�ڸ�, 10�ڸ��� �� �߰� ��ȣ�� �ڸ��� ���� ����
			if(self.userInfo.phone.length == 11){ // �ڵ��� ��ȣ�� 11�ڸ��� ��
				middleNum = 7;
			} else if(self.userInfo.phone.length == 10){ // �ڵ��� ��ȣ�� 10�ڸ��� ��
				middleNum = 6;
			}
			
			self.phoneSplit.phone1 = (self.userInfo.phone).substring(0,3);
			self.phoneSplit.phone2 = (self.userInfo.phone).substring(3,middleNum);
			self.phoneSplit.phone3 = (self.userInfo.phone).substring(middleNum);
		},
		pointOverCheck : function(){
			var self = this;
			if(self.usePoint > self.userInfo.point){
				alert("���� ����Ʈ�� Ȯ�����ּ���.");
				self.usePoint = "";
				return;
			}
			if(self.usePoint > 0){
				alert("0���� ū �ݾ��� �Է����ּ���.");
				self.usePoint = "";
				return;
			}
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.usePoint)){
				alert("��� ����Ʈ�� ���ڸ� �Է����ּ���.");
				self.usePoint = "";
				return;
			}
		},
		infoView : function(check){
			var self = this;
			if(check == "same"){
				self.fnGetUserInfo();
			} else{
				// �Է°��� ���� �� �ֵ��� �ʱ�ȭ
				self.userInfo.uName = "";
				self.userInfo.email = "";
				self.phoneSplit.phone1 = "";
				self.phoneSplit.phone2 = "";
				self.phoneSplit.phone3 = "";
			}
		},
		allPoint : function(){
			this.usePoint = this.userInfo.point;
		},
        fnRequestPay : function(){
        	var self = this;
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: 'jojo_'+new Date().getTime(),   // �ֹ���ȣ
                name: "��ǰ��", // ��ǰ�� + �� @�� 
                amount: 64900, // �׽�Ʈ
                buyer_email: self.userInfo.email,
                buyer_name: self.userInfo.uName,
                buyer_tel: self.userInfo.phone
			}, function (rsp) { // callback
					if (rsp.success) {
                		alert("���� ����");
                		location.href="/my/order.do"
					} else {
                    	alert("���� ����");
                    	location.href="/my/order.do"
                    }
			});
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetUserInfo();
	}// created
});
</script>