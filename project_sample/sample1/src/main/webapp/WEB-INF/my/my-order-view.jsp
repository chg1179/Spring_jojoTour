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
		                        <th>����ϱ�</th>
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
		                        	<span v-if="product.request != null && product.request != ''">{{ product.request }}</span>
		                        	<span v-else><input type="button" value="��û�����ۼ��ϱ�" @click=""></span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>{{ product.useYnc }}</td>
		                        <td v-if="product.useYnc == 'N'"><input type="button" value="�������" @click=""></td>
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
		                        <th>����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td>{{ product.rentName }}</td>
		                        <td>{{ product.sReserveDate }} 12:00</td>
		                        <td>{{ product.lReserveDate }} 12:00</td>
		                        <td>{{ product.people }}��</td>
		                        <td>
		                        	<span v-if="product.request != null && product.request != ''">{{ product.request }}</span>
		                        	<span v-else><input type="button" value="��û�����ۼ��ϱ�" @click=""></span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>{{ product.useYnc }}</td>
		                        <td v-if="product.useYnc == 'N'"><input type="button" value="�������" @click=""></td>
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
		                        <th>����ϱ�</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in leisureList" :key="product.productNo">
		                        <td>{{ product.leisureName }}</td>
		                        <td>{{ product.sReserveDate }} ~ {{ product.lReserveDate }}</td>
		                        <td>{{ product.people }}��</td>
		                        <td>
		                        	<span v-if="product.request != null && product.request != ''">{{ product.request }}</span>
		                        	<span v-else><input type="button" value="��û�����ۼ��ϱ�" @click=""></span>
		                        </td>
		                        <td>{{ product.payment }}��</td>
		                        <td>{{ product.useYnc }}</td>
		                        <td v-if="product.useYnc == 'N'"><input type="button" value="�������" @click=""></td>
		                    </tr>
		                </tbody>
		            </table>
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
		roomFlg : false
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
                	for(i=0;i<self.list.length;i++){
                		if(self.list[i].useYnc == 'N'){
                			self.flg = true;
                			return;
                		}
                	}
                	if(i == self.list.length){
             			self.flg = false;
             		}
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
            const roomTotal = this.roomList.reduce((total, product) => total + (parseInt(product.sprice)), 0);
            const rentTotal = this.rentList.reduce((total, product) => total + (parseInt(product.rprice)), 0);
            const leisureTotal = this.leisureList.reduce((total, product) => total + (product.leisurePrice * product.leisureSales * product.people), 0);

            return roomTotal + rentTotal + leisureTotal;
        }
	}
});
</script>