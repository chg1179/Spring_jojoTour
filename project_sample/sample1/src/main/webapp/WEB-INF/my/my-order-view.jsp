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
<title>주문번호 별 상세 내역</title>
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
				<div class="coreTxt"><span class="bar">ㅣ</span> 주문 번호 조회</div>
				<div class="box">
					<div>
						<div>주문번호</div>
						<div class="wrap"><input type="text" v-model="orderUserInfo.orderNo" disabled></div>
					</div>
				</div>
				
				<div class="box">
					<div>
						<div>
							<div>성명</div>
							<div class="wrap"><input type="text" v-model="orderUserInfo.uName" disabled></div>
						</div>
						<div>
							<div>연락처</div>
							<div>
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1" maxlength="3" disabled></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2" maxlength="4" disabled></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3" maxlength="4" disabled></span>
							</div>
						</div>
						<div>
							<div>이메일</div>
							<div class="wrap"><input type="text" v-model="orderUserInfo.email" disabled></div>
						</div>
					</div>
				</div>
				
				<!-- 숙박 업소 상품 -->
		        <div v-if="roomList.length != 0" class="productBox">
		            <div class="productTxt">숙소 상품</div>
		            <table>
		                <thead>
		                    <tr>
		                    	<th>숙박업소명</th>
		                        <th>숙소명</th>
		                        <th>입실</th>
		                        <th>퇴실</th>
		                        <th>일정</th>
		                        <th>요청사항</th>
		                        <th>총결제금액</th>
		                        <th>예약상태</th>
		                        <th v-if="!roomFlg">취소하기</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in roomList" :key="product.productNo">
		                    	<td>{{ product.stayName }}</td>
		                        <td>{{ product.roomName }}</td>
		                        <td>{{ product.sReserveDate }} 14:00</td>
		                        <td>{{ product.lReserveDate }} 10:00</td>
		                        <td>{{ product.people }}박 {{ product.people+1 }}일</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">수정하기</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input type="button" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>없음</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}원</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">사용완료</span>
		                        	<span v-else-if="product.useYnc=='N'">예약완료</span>
		                        	<span v-else-if="product.useYnc=='C'">취소완료</span>
		                        </td>
		                        <td v-if="!roomFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input type="button" value="예약취소" @click="">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- 렌트카 상품 -->
		        <div v-if="rentList.length != 0" class="productBox">
		            <div class="productTxt">렌트카 상품</div>
		            <table>
		                <thead>
		                    <tr>
		                        <th>렌트명</th>
		                        <th>인수일</th>
		                        <th>반납일</th>
		                        <th>총 대여일</th>
		                        <th>요청사항</th>
		                        <th>총결제금액</th>
		                        <th>예약상태</th>
		                        <th v-if="!rentFlg">취소하기</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td>{{ product.rentName }}</td>
		                        <td>{{ product.sReserveDate }} 12:00</td>
		                        <td>{{ product.lReserveDate }} 12:00</td>
		                        <td>{{ product.people }}일</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">수정하기</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input type="button" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>없음</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}원</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">사용완료</span>
		                        	<span v-else-if="product.useYnc=='N'">예약완료</span>
		                        	<span v-else-if="product.useYnc=='C'">취소완료</span>
		                        </td>
		                        <td v-if="!rentFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input type="button" value="예약취소" @click="">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- 레저 상품 -->
		        <div v-if="leisureList.length != 0" class="productBox">
		            <div class="productTxt">레저 상품</div>
		            <table>
		                <thead>
		                    <tr>
		                        <th>레저명</th>
		                        <th>사용기간</th>
		                        <th>이용권 수</th>
		                        <th>요청사항</th>
		                        <th>총결제금액</th>
		                        <th>예약상태</th>
		                        <th v-if="!leisureFlg">취소하기</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in leisureList" :key="product.productNo">
		                        <td>{{ product.leisureName }}</td>
		                        <td>{{ product.sReserveDate }} ~ {{ product.lReserveDate }}</td>
		                        <td>{{ product.people }}매</td>
		                        <td>
		                        	<span v-if="product.useYnc=='N'">
		                        		<span v-if="product.request != null && product.request != ''">
		                        			<a class="edit-link" @click="fnChangeRequest(product.productKind, product.productNo, product.request)" href="javascript:;">
		                        				{{ product.request }}
		                        				<span class="edit-text">수정하기</span>
		                        			</a>
		                        		</span>
		                        		<span v-else>
		                        			<input type="button" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
		                       			</span>
		                       		</span>
		                        	<span v-else>
		                        		<span v-if="product.request != null && product.request != ''">
		                        			{{ product.request }}
		                        		</span>
		                        		<span v-else>없음</span>
		                        	</span>
		                        </td>
		                        <td>{{ product.payment }}원</td>
		                        <td>
		                        	<span v-if="product.useYnc=='Y'">사용완료</span>
		                        	<span v-else-if="product.useYnc=='N'">예약완료</span>
		                        	<span v-else-if="product.useYnc=='C'">취소완료</span>
		                        </td>
		                        <td v-if="!leisureFlg">
		                        	<span v-if="product.useYnc == 'N'">
		                        		<input type="button" value="예약취소" @click="">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <div class="box">
					<div>
						<div class="productTxt">취소 금액을 제외한 총 결제 금액</div>
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
		orderUserInfo : {}, // 이름, 연락처, 이메일 등
		orderInfoList : [],
		phoneSplit : { // OOO-XXXX-XXXX 로 출력하기 위한 변수
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
                	
                	// 해당 리스트에 한 항목이라도 useYnx의 값이 N이 없다면 취소할 제품이 없기 때문에 취소 컬럼을 없앤다.
                	self.roomFlg = !self.roomList.some(product => product.useYnc === 'N');
                    self.rentFlg = !self.rentList.some(product => product.useYnc === 'N');
                    self.leisureFlg = !self.leisureList.some(product => product.useYnc === 'N');
                }
            }); 
		},
		phoneSubString : function(){
			var self = this;
			var middleNum; // 핸드폰 번호가 11자리, 10자리일 때 중간 번호를 자르기 위한 변수
			if(self.orderUserInfo.phone.length == 11){ // 핸드폰 번호가 11자리일 때
				middleNum = 7;
			} else if(self.orderUserInfo.phone.length == 10){ // 핸드폰 번호가 10자리일 때
				middleNum = 6;
			}
			
			self.phoneSplit.phone1 = (self.orderUserInfo.phone).substring(0,3);
			self.phoneSplit.phone2 = (self.orderUserInfo.phone).substring(3,middleNum);
			self.phoneSplit.phone3 = (self.orderUserInfo.phone).substring(middleNum);
		},
		// 요구사한 변경
		fnChangeRequest : function(productKind, productNo, request){
			var popWidth = 800;
		    var popHeight = 500;
		    
		    // 화면 정 중앙에 띄우기 위한 변수
		    var screenWidth = window.screen.width;
		    var screenHeight = window.screen.height;
		    
		    var left = (screenWidth - popWidth) / 2;
		    var top = ((screenHeight - popHeight) / 2) - 100; // 세로 높이는 정 중앙보다 조금 높은 위치에 띄우기 위해 -100 하였다.
		    
		    var popSize = "width=" + popWidth + ", height=" + popHeight + ", top=" + top + ", left=" + left;
		    
		    // 한국어 인코딩
		    var encodedRequest = encodeURIComponent(request);
		    
		    window.open("changeRequest.do?productKind=" + productKind + "&productNo=" + productNo + "&request=" + encodedRequest, "request", popSize);
		},
		bookingCancel : function(productNo){
			var self = this;
			if(!confirm("정말 취소하시겠습니까?")){
				return;
			}
			var param = {userId : self.userId, productNo : productNo};
			$.ajax({
                url : "/bookingCancel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("취소되었습니다.");
            		self.fnGetList();
                }
            }); 
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}, // created
	// productList 변경 감지 후 리스트 분류. 값 재할당 X
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