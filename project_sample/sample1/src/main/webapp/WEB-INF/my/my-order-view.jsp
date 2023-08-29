<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../../css/basic/table custom-table table-striped table-bordered-style.css" rel="stylesheet"/>
<link href="../../css/pay/payment-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>�ֹ���ȣ �� �� ����</title>
<style>
	.order{
		background-color : buttonface;
	}
    .order::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	#page_order_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
		margin-top: 100px;
	}
	.page_order_wrap table{
		margin-top: 30px;
		text-align: center;
	}
	.page_order_wrap table th, .page_order_wrap table td{
		padding : 5px 20px;
	}
    .edit-link {
        position: relative;
    }
    .edit-text {
        position: absolute;
        top: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.7);
        padding: 5px 10px;
        color: white;
        font-size: 12px;
        border-radius: 4px;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .edit-link:hover .edit-text {
        opacity: 1;
    }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="page_order_container">
			<div class="page_order_wrap">
			<h2 style="color : #213555; text-align: center; margin-top: 400px; font-weight : 20;"><span style="font-weight: bold;">��</span> �� ���� ����</h2>
				<div class="coreTxt"><span class="bar">��</span> �ֹ� ��ȣ ��ȸ</div>
				<div class="box">
					<div>
						<div>�ֹ���ȣ</div>
						<div class="wrap"><input type="text" v-model="orderUserInfo.orderNo" disabled></div>
					</div>
				</div>
				
				<div class="box">
					<div>
						<div>
							<div>����</div>
							<div class="wrap"><input type="text" v-model="orderUserInfo.uName"></div>
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
							<div class="wrap"><input type="text" v-model="orderUserInfo.email"></div>
						</div>
					</div>
					<div><input class="btn-dark" type="button" @click="fnEditUserInfo" value="�����ϱ�"></div>
				</div>
				
				<!-- ���� ���� ��ǰ -->
		        <div v-if="roomList.length != 0" class="productBox">
		            <div class="productTxt">���� ��ǰ</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
		                <thead>
		                    <tr>
		                    	<th>���ھ��Ҹ�</th>
		                        <th>���Ҹ�</th>
		                        <th>�Խ�</th>
		                        <th>���</th>
		                        <th>����</th>
		                        <th>��û����</th>
		                        <th>�Ѱ����ݾ�</th>
		                        <th>�������</th>
		                        <th v-if="!roomFlg">����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in roomList" :key="product.productNo">
		                    	<td><a @click="fnStayView(product.stayNo)">{{ product.stayName }}</a></td>
		                        <td>{{ product.roomName }}</td>
		                        <td>{{ product.sReserveDate }} 14:00</td>
		                        <td>{{ product.lReserveDate }} 10:00</td>
		                        <td>{{ product.people }}�� {{ product.people+1 }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">�����ϱ�</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input class="btn-dark" type="button" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>����</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">���Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='N'">����Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='C'">��ҿϷ�</span>
		                        </td>
		                        <td v-if="!roomFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input class="btn-red" type="button" value="�������" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- ��Ʈī ��ǰ -->
		        <div v-if="rentList.length != 0" class="productBox">
		            <div class="productTxt">��Ʈī ��ǰ</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
		                <thead>
		                    <tr>
		                        <th>��Ʈ��</th>
		                        <th>�μ���</th>
		                        <th>�ݳ���</th>
		                        <th>�� �뿩��</th>
		                        <th>��û����</th>
		                        <th>�Ѱ����ݾ�</th>
		                        <th>�������</th>
		                        <th v-if="!rentFlg">����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td><a @click="fnRentView(product.productNo)">{{ product.rentName }}</a></td>
		                        <td>{{ product.sReserveDate }} 12:00</td>
		                        <td>{{ product.lReserveDate }} 12:00</td>
		                        <td>{{ product.people }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">�����ϱ�</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input type="button" class="btn-dark" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>����</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">���Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='N'">����Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='C'">��ҿϷ�</span>
		                        </td>
		                        <td v-if="!rentFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input type="button" class="btn-red" value="�������" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- ���� ��ǰ -->
		        <div v-if="leisureList.length != 0" class="productBox">
		            <div class="productTxt">���� ��ǰ</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
		                <thead>
		                    <tr>
		                        <th>������</th>
		                        <th>���Ⱓ</th>
		                        <th>�̿�� ��</th>
		                        <th>��û����</th>
		                        <th>�Ѱ����ݾ�</th>
		                        <th>�������</th>
		                        <th v-if="!leisureFlg">����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in leisureList" :key="product.productNo">
		                        <td><a @click="fnLeisureView(product.productNo, product.leisureKind)">{{ product.leisureName }}</a></td>
		                        <td>{{ product.sReserveDate }} ~ {{ product.lReserveDate }}</td>
		                        <td>{{ product.people }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">�����ϱ�</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input class="btn-dark" type="button" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>����</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">���Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='N'">����Ϸ�</span>
		                        	<span v-else-if="product.useYnc=='C'">��ҿϷ�</span>
		                        </td>
		                        <td v-if="!leisureFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input class="btn-red" type="button" value="�������" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <div class="box">
					<div>
						<div>
							<div>�� ��ǰ �ݾ� : {{ totalPrice }} ��</div>
							<div>��ǰ ��� �ݾ� : - {{ cancelPrice }} ��</div>
							<div>����Ʈ ��� �ݾ� : - {{ orderUserInfo.usePoint}} ��</div>
							<div class="productTxt">�� ���� �ݾ� : {{ realPrice }} ��</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%-- <jsp:include page="../footer.jsp" flush="true"></jsp:include> --%>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		orderNo : "${map.orderNo}",
		userId : "${sessionId}",
		orderUserInfo : {}, // �̸�, ����ó, �̸��� ��
		orderInfoList : [], // �ֹ� ��ǰ ���� ���
		phoneSplit : { // OOO-XXXX-XXXX �� ����ϱ� ���� ����
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		totalPrice : 0, // �� ���� �ݾ�
		cancelPrice : 0, // ����� �ݾ� (useYnc == C)
		realPrice : 0, // ����Ʈ, ��� �ݾ��� ������ ���� ���� �ݾ�
		// ���� ��� ��ư�� ����ϱ� ���� flg ����. 3������ ������ ���� ����ϱ� ���� 3�� ���� ����
		roomFlg : false,
		rentFlg : false,
		leisureFlg : false
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {orderNo : self.orderNo};
			$.ajax({
                url : "/orderList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.orderUserInfo = data.orderUserInfo;
                	self.orderInfoList = data.orderInfoList;
                	console.log(self.orderUserInfo);
                	console.log(self.orderInfoList);
                	
                	self.priceCalculator(); // �� ���� �ݾ� ������ ����
                	self.phoneSubString(); // �ڵ��� ��ȣ�� XXX-XXXX-XXXX ó�� ������ ���
                	
                	// �ش� ����Ʈ�� �� �׸��̶� useYnx�� ���� N�� ���ٸ� ����� ��ǰ�� ���� ������ ��� �÷��� ����
                	self.roomFlg = !self.roomList.some(product => product.useYnc === 'N');
                    self.rentFlg = !self.rentList.some(product => product.useYnc === 'N');
                    self.leisureFlg = !self.leisureList.some(product => product.useYnc === 'N');
                }
            }); 
		},
		priceCalculator : function(){
			var self = this;
			
			// ��� �� fnGetList �� �� ��쿡 ���� += �Ǳ� ������ 0���� �ʱ�ȭ
			self.totalPrice = 0;
			self.cancelPrice = 0;
			self.realPrice = 0;
			
			for(var i = 0 ; i < self.orderInfoList.length ; i++){
        		self.totalPrice += self.orderInfoList[i].payment;
        		if(self.orderInfoList[i].useYnc == "C"){
        			self.cancelPrice += self.orderInfoList[i].payment;
        		}
        	}
        	// �� ���� �ݾ� = �� ��ǰ �ݾ� - ��� �ݾ� - ����Ʈ ��� �ݾ� 
        	self.realPrice = self.totalPrice - self.cancelPrice - self.orderUserInfo.usePoint;
		},
		phoneSubString : function(){
			var self = this;
			var middleNum; // �ڵ��� ��ȣ�� 11�ڸ�, 10�ڸ��� �� �߰� ��ȣ�� �ڸ��� ���� ����
			if(self.orderUserInfo.phone.length == 11){ // �ڵ��� ��ȣ�� 11�ڸ��� ��
				middleNum = 7;
			} else if(self.orderUserInfo.phone.length == 10){ // �ڵ��� ��ȣ�� 10�ڸ��� ��
				middleNum = 6;
			}
			
			self.phoneSplit.phone1 = (self.orderUserInfo.phone).substring(0,3);
			self.phoneSplit.phone2 = (self.orderUserInfo.phone).substring(3,middleNum);
			self.phoneSplit.phone3 = (self.orderUserInfo.phone).substring(middleNum);
		},
		// �ֹ��� ���� ����
		fnEditUserInfo : function(){
			
			var self = this;
			if(self.orderUserInfo.uName == ""){
				alert("������ �̸��� �Է����ּ���.");
				return;
			}
        	
        	//�Է��� �ڵ��� ��ȣ ��ġ��
        	self.orderUserInfo.phone = self.phoneSplit.phone1;
        	self.orderUserInfo.phone += self.phoneSplit.phone2;
        	self.orderUserInfo.phone += self.phoneSplit.phone3;
        	console.log(self.orderUserInfo.phone);
        	
        	if(self.orderUserInfo.phone.length < 10){
				alert("����ó�� ��Ȯ�ϰ� �Է����ּ���.");
				return;
			}
        	
        	var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.orderUserInfo.phone)){
				alert("����ó�� ���ڸ� �Է����ּ���.");
				return;
			}
			
			if(self.orderUserInfo.email == ""){
				alert("�̸����� �Է����ּ���.");
				return;
			}
			
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if(!regex.test(self.orderUserInfo.email)){
				alert("�̸��� �ּҸ� ��Ȯ�ϰ� �Է��ϼ���.");
				return;
			}
			
			if(!confirm("������ ������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {
					orderNo : self.orderNo,
					uName : self.orderUserInfo.uName,
					phone :self.orderUserInfo.phone,
					email :self.orderUserInfo.email
			};
			$.ajax({
                url : "/editUserInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("������ �Ϸ�Ǿ����ϴ�.");
                	self.fnGetList();
                }
            }); 
		},
		// �䱸���� ����
		fnChangeRequest : function(productKind, productNo, request){
			var popWidth = 650;
		    var popHeight = 380;
		    
		    // ȭ�� �� �߾ӿ� ���� ���� ����
		    var screenWidth = window.screen.width;
		    var screenHeight = window.screen.height;
		    
		    var left = (screenWidth - popWidth) / 2;
		    var top = ((screenHeight - popHeight) / 2) - 100; // ���� ���̴� �� �߾Ӻ��� ���� ���� ��ġ�� ���� ���� -100 �Ͽ���.
		    
		    var popSize = "width=" + popWidth + ", height=" + popHeight + ", top=" + top + ", left=" + left;
		    
		    // �ѱ��� ���ڵ�
		    var encodedRequest = encodeURIComponent(request);
		    
		    window.open("changeRequest.do?productKind=" + productKind + "&productNo=" + productNo + "&request=" + encodedRequest, "request", popSize);
		},
		// ���� ���
		fnOrderCancle : function(productKind, productNo, payment){
			var self = this;
			if(!confirm("�ش� ������ ����Ͻðڽ��ϱ�?")){
				return;
			}
			
			var returnPoint = self.orderUserInfo.usePoint;
			// ����� ����Ʈ�� ���� �ݾ��� ������ ����ϴ� ��ǰ�� �ݾ׸�ŭ�� ����Ʈ ����
			if(returnPoint > payment){
				returnPoint = payment;
			}
			
			var param = {
					uId : self.userId,
					orderNo : self.orderNo,
					productKind : productKind,
					productNo : productNo,
					usePoint : returnPoint
			};
			$.ajax({
                url : "/revokeOrder.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("��Ұ� �Ϸ�Ǿ����ϴ�.");
            		self.fnGetList();
                }
            });
		},
		// ��ǰ �������� �̵�
		fnRentView : function(rentNo){
			var self = this;
			$.pageChange("/rentcar/view.do", {rentNo : rentNo});
	    },
	    fnStayView : function(stayNo){
		    var self = this;
			$.pageChange("/stay/view.do", {stayNo : stayNo});
	    },
	    fnLeisureView : function(leisureNo, leisureKind){
	    	var self = this;
	    	// ���� ���� ����
	    	if(leisureKind == "ATV" || leisureKind == "CLIDER" || leisureKind == "HORSE"){
	    		$.pageChange("/ground/leisure/view.do", {leisureNo : leisureNo});
	    	} else{
	    		$.pageChange("/water/leisure/view.do", {leisureNo : leisureNo});	    		
	    	}
	    },
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}, // created
	// productList ���� ���� �� ����Ʈ �з�. �� ���Ҵ� X
	computed: {
	    roomList: function() {
	        return this.orderInfoList.filter(product => product.productKind === "STAY");
	    },
	    rentList: function() {
	        return this.orderInfoList.filter(product => product.productKind === "RENT");
	    },
	    leisureList: function() {
	        return this.orderInfoList.filter(product => product.productKind === "LEISURE");
	    }
	}
});
</script>