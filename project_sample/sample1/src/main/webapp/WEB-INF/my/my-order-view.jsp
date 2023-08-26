<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
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
		margin-top: -200px;
	}
	.page_order_booking_box{
		display: flex;
		justify-content: space-around;
		text-align: center;
	}
	.page_order_booking_box{
		border-top: 1px solid;
		border-bottom: 1px solid #ccc;
	}
	.page_order_booking_box>div{
		padding: 0 70px;
	}
	.page_order_booking_box>div:nth-child(2){
		border-right: 1px solid #ccc;
		border-left: 1px solid #ccc;

	}
	.page_order_booking_box div div{
		margin: 20px 0;
	}
	.page_order_booking_box span{
		font-size: 30px;
		font-weight: bold;
	}
	table, tr, th, td{
		border: 1px solid;
		border-collapse: collapse;
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
							<div class="wrap"><input type="text" v-model="orderUserInfo.uName" disabled></div>
						</div>
						<div>
							<div>����ó</div>
							<div>
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1" maxlength="3" disabled></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2" maxlength="4" disabled></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3" maxlength="4" disabled></span>
							</div>
						</div>
						<div>
							<div>�̸���</div>
							<div class="wrap"><input type="text" v-model="orderUserInfo.email" disabled></div>
						</div>
					</div>
				</div>
				
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
		                        <th>����</th>
		                        <th>��û����</th>
		                        <th>�Ѱ����ݾ�</th>
		                        <th>�������</th>
		                        <th v-if="!roomFlg">����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in roomList" :key="product.productNo">
		                    	<td>{{ product.stayName }}</td>
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
		                        			<input type="button" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input type="button" value="�������" @click="">
		                        	</span>
		                        </td>
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
		                        <th>�� �뿩��</th>
		                        <th>��û����</th>
		                        <th>�Ѱ����ݾ�</th>
		                        <th>�������</th>
		                        <th v-if="!rentFlg">����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td>{{ product.rentName }}</td>
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
		                        			<input type="button" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input type="button" value="�������" @click="">
		                        	</span>
		                        </td>
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
		                        <td>{{ product.leisureName }}</td>
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
		                        			<input type="button" value="��û�����ۼ��ϱ�" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input type="button" value="�������" @click="">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <div class="box">
					<div>
						<div class="productTxt">��� �ݾ��� ������ �� ���� �ݾ�</div>
						<div class="wrap"><input type="text" disabled>{{ totalAmount }}</div>
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
		orderInfoList : [],
		phoneSplit : { // OOO-XXXX-XXXX �� ����ϱ� ���� ����
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
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
                	self.phoneSubString();
                	var i = 0;
                	
                	// �ش� ����Ʈ�� �� �׸��̶� useYnx�� ���� N�� ���ٸ� ����� ��ǰ�� ���� ������ ��� �÷��� ���ش�.
                	self.roomFlg = !self.roomList.some(product => product.useYnc === 'N');
                    self.rentFlg = !self.rentList.some(product => product.useYnc === 'N');
                    self.leisureFlg = !self.leisureList.some(product => product.useYnc === 'N');
                }
            }); 
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
		// �䱸���� ����
		fnChangeRequest : function(productKind, productNo, request){
			var popWidth = 800;
		    var popHeight = 500;
		    
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
		bookingCancel : function(productNo){
			var self = this;
			if(!confirm("���� ����Ͻðڽ��ϱ�?")){
				return;
			}
			var param = {userId : self.userId, productNo : productNo};
			$.ajax({
                url : "/bookingCancel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("��ҵǾ����ϴ�.");
            		self.fnGetList();
                }
            }); 
		}
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
	    },
	    totalAmount() {
	        const roomTotal = this.roomList.reduce((total, product) => total + (product.roomPrice * product.roomSales * product.people), 0);
	        const rentTotal = this.rentList.reduce((total, product) => total + (product.rentPrice * product.rentSales * product.people), 0);
	        const leisureTotal = this.leisureList.reduce((total, product) => total + (product.leisurePrice * product.leisureSales * product.people), 0);

	        return roomTotal + rentTotal + leisureTotal;
	    }
	}
});
</script>