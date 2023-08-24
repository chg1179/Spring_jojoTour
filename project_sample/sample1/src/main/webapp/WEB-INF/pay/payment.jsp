<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<link href="../../css/pay/payment-style.css" rel="stylesheet"/>
<link href="../../css/btn-style.css" rel="stylesheet"/>
<style>
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div class="mainTxt">����������</div>
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ��ǰ �� ����</div>
				<table>
				    <thead>
				        <tr>
				            <th>��ǰ ��ȣ</th>
				            <th>��ǰ ����</th>
				            <!-- �ʿ��� �� �߰� -->
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${productList}" var="product">
				            <tr>
				                <td>${product.productNo}</td>
				                <td>${product.productKind}</td>
				                <!-- �ʿ��� �� ������ ��� -->
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
				
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
				<div class="coreTxt"><span class="bar">��</span> ���� ���� �ݾ�(VAT����)</div>
				<ul>
					<li>�ش� ���ǰ��� ����, ����ᰡ ���Ե� �ݾ��Դϴ�.</li>
					<li>�����Ϸ� �� <span>������ �̸�</span>�� <span>�ڵ��� ��ȣ</span>�� �ٷ� <span>üũ��</span> �Ͻø� �˴ϴ�.</li>
				</ul>
			</div>
			<div class="box"><!-- ���� �� -->
				<div><label><input type="checkbox">��ü ����</label></div>
				<div><label><input type="checkbox">�����̿��Ģ �� ���/ȯ�ұ��� ����<span>(�ʼ�)</span></label></div>
				<div><label><input type="checkbox">�������� ���� �� �̿� ����<span>(�ʼ�)</span></label></div>
				<div><label><input type="checkbox">�������� �� 3�� ���� ����<span>(�ʼ�)</span></label></div>
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