<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<link href="../../css/pay/payment-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
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
				
				<!-- ���� ���� ��ǰ -->
		        <div v-if="roomList.length != 0" class="productBox">
		            <div class="productTxt">���� ��ǰ</div>
		            <table>
		                <thead>
		                    <tr>
		                    	<th>���ھ��Ҹ�</th>
		                        <th>���Ҹ�</th>
		                        <th>�Խ�</th>
		                        <th>���</th>
		                        <th>�ݾ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in roomList" :key="product.productNo">
		                    	<td>{{ product.stayName }}</td>
		                        <td>{{ product.roomName }}</td>
		                        <td>{{ product.sReserveDate }} 14:00</td>
		                        <td>{{ product.lReserveDate }} 10:00</td>
		                        <td>{{ product.sprice }}��</td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- ��Ʈī ��ǰ -->
		        <div v-if="rentList.length != 0" class="productBox">
		            <div class="productTxt">��Ʈī ��ǰ</div>
		            <table>
		                <thead>
		                    <tr>
		                        <th>��Ʈ��</th>
		                        <th>�μ���</th>
		                        <th>�ݳ���</th>
		                        <th>�ݾ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td>{{ product.rentName }}</td>
		                        <td>{{ product.sReserveDate }} 12:00</td>
		                        <td>{{ product.lReserveDate }} 12:00</td>
		                        <td>{{ product.rprice }}��</td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- ���� ��ǰ -->
		        <div v-if="leisureList.length != 0" class="productBox">
		            <div class="productTxt">���� ��ǰ</div>
		            <table>
		                <thead>
		                    <tr>
		                        <th>������</th>
		                        <th>�̿�Ǽ�</th>
		                        <th>�ݾ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in leisureList" :key="product.productNo">
		                        <td>{{ product.leisureName }}</td>
		                        <td>{{ product.people }}��</td>
		                        <td>{{ product.leisurePrice * product.leisureSales * product.people }}��</td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
			</div>
			
			<div class="box">
			    <div class="coreTxt"><span class="bar">��</span> ��� �� ����</div>
			    <div>
			        <table>
			            <thead>
			                <tr>
			                    <th>��ǰ��</th>
			                    <th>�ݾ�</th>
			                </tr>
			            </thead>
			            <tbody>
			                <!-- ���� ��ǰ -->
			                <tr v-if="roomList.length != 0">
			                    <td>���� ��ǰ</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in roomList" :key="product.productNo">
			                                {{ product.roomName }} - {{ parseInt(product.sprice) }}��
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			                <!-- ��Ʈī ��ǰ -->
			                <tr v-if="rentList.length != 0">
			                    <td>��Ʈī ��ǰ</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in rentList" :key="product.productNo">
			                                {{ product.rentName }} - {{ parseInt(product.rprice) }}��
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			                <!-- ���� ��ǰ -->
			                <tr  v-if="leisureList.length != 0">
			                    <td>���� ��ǰ</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in leisureList" :key="product.productNo">
			                                {{ product.leisureName }} - {{ product.leisurePrice * product.leisureSales * product.people }}��
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			            </tbody>
			            <!-- �� �հ� -->
		                <tfoot>
		                    <tr>
		                        <th>�� �հ�</th>
		                        <td>{{ totalAmount.toLocaleString() }}��</td>
		                    </tr>
		                </tfoot>
			        </table>
			    </div>
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
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1" maxlength="3"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2" maxlength="4"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3" maxlength="4"></span>
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
						<div>
							<span class="wrapPhone"><input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0"></span>
							<input type="button" class="btn" @click="allPoint" value="���׻��">
						</div>
					</div>
				</div>
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">��</span> ���� ���� �ݾ�(VAT����)</div>
	            <div>
	                <p>�� ���� �ݾ�: {{ (totalAmount - usePoint).toLocaleString() }}��</p>
	            </div>
				<ul>
					<li>�ش� ���ǰ��� ����, ����ᰡ ���Ե� �ݾ��Դϴ�.</li>
					<li>���� �Ϸ� �� <span class="redTxt">������ �̸�</span>�� <span class="redTxt">�ڵ��� ��ȣ</span>�� �ٷ� <span class="redTxt">üũ��</span> �Ͻø� �˴ϴ�.</li>
				</ul>
			</div>
			<div class="box">
				<div><label><input type="checkbox" v-model="allCheck" @click="toggleAllCheck">��ü ����</label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="1">�����̿��Ģ �� ���/ȯ�ұ��� ���� <span class="redTxt">(�ʼ�)</span></label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="2">�������� ���� �� �̿� ���� <span class="redTxt">(�ʼ�)</span></label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="3">�������� �� 3�� ���� ���� <span class="redTxt">(�ʼ�)</span></label></div>
			</div>
			<div class="box">
				<button class="btn" @click="fnRequestPay">�����ϱ�</button>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var IMP = window.IMP;
IMP.init('imp64757785');
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		productList: [], // ��ٱ��Ͽ��� ������ ��ǰ�� �������� ����Ʈ
		userInfo : {}, // �����ϴ� ������ ������ ����
		phoneSplit : { // OOO-XXXX-XXXX �� ����ϱ� ���� ����
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		usePoint : "", // ����ڰ� ���� �� ����� ����Ʈ
		request : "", // ��û���� �ۼ�
		clauseCheck : [], // ����� ��� �����ߴ��� Ȯ��
		allCheck : false // ��� ��ü ����
	},// data
	methods : {
		//��ٱ��Ͽ��� ������ ��ǰ�� �ִ� �ڵ�
		fnGetProductList : function(){
			axios.get('/api/getProductList')
            .then(response => {
                this.productList = response.data; // productList�� ������ ��ǰ�� �Ҵ�
            })
            .catch(error => {
                console.error('Error fetching product list:', error);
            });
		},
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
			if(self.usePoint < 0){
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
        // ��� ���� ��ü ����
        toggleAllCheck: function() {
		    if (this.allCheck) {
		        this.clauseCheck = []; // ��� ��� üũ�ڽ��� ����
		    } else {
		        this.clauseCheck = [1, 2, 3]; // ��� ��� üũ�ڽ��� ����
		    }
		},
        fnRequestPay : function(){
        	var self = this;
        	var orderNo = 'jojo_'+new Date().getFullYear()+(new Date().getMonth()+1)+new Date().getDate()+"_"+new Date().getTime();
        	console.log(orderNo);
        	if(self.userInfo.uName == ""){
				alert("������ �̸��� �Է����ּ���.");
				return;
			}
        	
        	//�Է��� �ڵ��� ��ȣ ��ġ��
        	self.userInfo.phone = self.phoneSplit.phone1;
        	self.userInfo.phone += self.phoneSplit.phone2;
        	self.userInfo.phone += self.phoneSplit.phone3;
        	console.log(self.userInfo.phone);
        	
        	if(self.userInfo.phone.length < 10){
				alert("����ó ����� Ȯ�����ּ���.");
				return;
			}
        	
        	var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.userInfo.phone)){
				alert("����ó�� ���ڸ� �Է����ּ���.");
				return;
			}
			
			if(self.userInfo.email == ""){
				alert("�̸����� �Է����ּ���.");
				return;
			}
			
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if(!regex.test(self.userInfo.email)){
				alert("�̸��� ����� Ȯ�����ּ���.");
				return;
			}
			
			if(self.clauseCheck.length < 3){
				alert("��� ����� �����ؾ߸� ������ �����մϴ�.");
				return;
			}
        	
			// ����Ʈ�� �Է����� ������ 0���� �����Ѵ�.
			if(self.usePoint == ""){
				self.usePoint = 0;
			}
			
			// ��ǰ�� ã��
			var orderName = "";
			if(self.roomList.length != 0){
				orderName = self.roomList[0].stayName +" "+self.roomList[0].roomName; 
			} else if(self.rentList.length != 0){
				orderName = self.rentList[0].rentName; 
			} else if(self.leisureList.length != 0){
				orderName = self.leisureList[0].leisureName; 
			}
			if((self.productList.length-1) != 0){
				orderName += " �� " + (self.productList.length-1)+"��"; 
			}
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: orderNo,   // �ֹ���ȣ
                name: orderName, // ��ǰ�� + �� @�� 
                amount: self.totalAmount - self.usePoint, // �׽�Ʈ
                buyer_email: self.userInfo.email,
                buyer_name: self.userInfo.uName,
                buyer_tel: self.userInfo.phone
			}, function (rsp) { // callback
					if (rsp.success) {
                		alert("�ֹ��� �Ϸ�Ǿ����ϴ�.");
                		self.fnOrder(orderNo);
					} else {
						//�׽�Ʈ��
                    	alert("�ֹ��� �Ϸ�Ǿ����ϴ�.");
                    	self.fnOrder(orderNo);
                    }
			});
        },
        // �ֹ� ���� �߰�(insert), ����Ʈ ���, ��ٱ��� ����
        fnOrder : function(orderNo){
			var self = this;
			var param = {
					orderNo : orderNo,
					uId : self.uId, 
					usePoint : self.usePoint,
					uName : self.userInfo.uName,
					phone :self.userInfo.phone,
					email :self.userInfo.email,
					request : self.request
				};
			
			$.ajax({
                url : "addOrder.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	location.href="/my/order.do";
                }
            });
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetProductList(); //������Ʈ ���� �� ���� ������ ��������
		self.fnGetUserInfo();
	}, // created
	// productList ���� ���� �� ����Ʈ �з�. �� ���Ҵ� X
	computed: {
	    roomList: function() {
	        return this.productList.filter(product => product.productKind === "STAY");
	    },
	    rentList: function() {
	        return this.productList.filter(product => product.productKind === "RENT");
	    },
	    leisureList: function() {
	        return this.productList.filter(product => product.productKind === "LEISURE");
	    },
	    totalAmount() {
            const roomTotal = this.roomList.reduce((total, product) => total + (parseInt(product.sprice)), 0);
            const rentTotal = this.rentList.reduce((total, product) => total + (parseInt(product.rprice)), 0);
            const leisureTotal = this.leisureList.reduce((total, product) => total + (product.leisurePrice * product.leisureSales * product.people), 0);

            return roomTotal + rentTotal + leisureTotal;
        }
	} // computed
});
</script>