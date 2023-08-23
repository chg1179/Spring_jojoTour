<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����������</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div>
				<div>����������</div>
			</div>
			<div>
				<div>--��ǰ �� ����</div>
				
				
			</div>
			
			<div>
				<div>--��� �� ����</div>
				
			</div>
			
			<div>
				<div>--������ ���� �Է�</div>
				<div>
					<div>
						
						<label>
							<input type="radio" name="infoCheck" @click="infoView('same')" checked="checked">
							�����ڿ� ����� ����
						</label>
						<label>
							<input name="infoCheck" type="radio" @click="infoView('notSame')">
							���� �Է�
						</label>
					</div>
					<div>
						<label>������<input type="text" v-model="userInfo.uName"></label>
					</div>
					<div>
						<label>����ó
							<input type="text" v-model="phoneSplit.phone1">-
							<input type="text" v-model="phoneSplit.phone2">-
							<input type="text" v-model="phoneSplit.phone3">
						</label>
					</div>
					<div>
						<label>�̸���<input type="text" v-model="userInfo.email"></label>
					</div>
					<div>
						<label>��û����<input type="text" v-model="request" placeholder="��ǰ �̿�� �����Ͽ� ��û������ �ִ� ��� �����Ӱ� �Է��� �ּ���."></label>
					</div>
				</div>
			</div>
			
			
			<div>
				<div>--����Ʈ ���</div>
				<div>
					<div>
						<label>���� ����Ʈ<input type="text" v-model="userInfo.point" placeholder="0"></label>
					</div>
					<div>
						<label>��� <input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0"></label>
						<input type="button" @click="allPoint" value="���׻��">
					</div>
					<div>����Ʈ�� ���� ��� ��ǰ���� �켱������ �����˴ϴ�.</div>
				</div>
				
			</div>
			
			<div>
				<div>���� ���� �ݾ�</div>
				
				
			</div>
			<div>
				<button @click="fnRequestPay">�����ϱ�</button>
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
	mounted() { // created �������� ȣ���
        //this.testList = ${map.list}; // JSON �����͸� �Ҵ�
        //console.log(this.testList);
    },
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