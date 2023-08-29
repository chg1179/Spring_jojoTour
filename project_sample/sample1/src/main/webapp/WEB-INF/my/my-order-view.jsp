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
			<h2 style="color : #213555; text-align: center; margin-top: 400px; font-weight : 20;"><span style="font-weight: bold;">ㅣ</span> 상세 예약 내역</h2>
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
							<div class="wrap"><input type="text" v-model="orderUserInfo.uName"></div>
						</div>
						<div>
							<div>연락처</div>
							<div>
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1" maxlength="3"></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2" maxlength="4"></span>-
								<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3" maxlength="4"></span>
							</div>
						</div>
						<div>
							<div>이메일</div>
							<div class="wrap"><input type="text" v-model="orderUserInfo.email"></div>
						</div>
					</div>
					<div><input class="btn-dark" type="button" @click="fnEditUserInfo" value="수정하기"></div>
				</div>
				
				<!-- 숙박 업소 상품 -->
		        <div v-if="roomList.length != 0" class="productBox">
		            <div class="productTxt">숙소 상품</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
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
		                    	<td><a @click="fnStayView(product.stayNo)">{{ product.stayName }}</a></td>
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
		                        			<input class="btn-dark" type="button" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input class="btn-red" type="button" value="예약취소" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- 렌트카 상품 -->
		        <div v-if="rentList.length != 0" class="productBox">
		            <div class="productTxt">렌트카 상품</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
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
		                        <td><a @click="fnRentView(product.productNo)">{{ product.rentName }}</a></td>
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
		                        			<input type="button" class="btn-dark" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input type="button" class="btn-red" value="예약취소" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- 레저 상품 -->
		        <div v-if="leisureList.length != 0" class="productBox">
		            <div class="productTxt">레저 상품</div>
		            <table class="table custom-table table-striped table-bordered" style="width: 1000px;">
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
		                        <td><a @click="fnLeisureView(product.productNo, product.leisureKind)">{{ product.leisureName }}</a></td>
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
		                        			<input class="btn-dark" type="button" value="요청사항작성하기" @click="fnChangeRequest(product.productKind, product.productNo, product.request)">
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
		                        		<input class="btn-red" type="button" value="예약취소" @click="fnOrderCancle(product.productKind, product.productNo, product.payment)">
		                        	</span>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <div class="box">
					<div>
						<div>
							<div>총 제품 금액 : {{ totalPrice }} 원</div>
							<div>제품 취소 금액 : - {{ cancelPrice }} 원</div>
							<div>포인트 사용 금액 : - {{ orderUserInfo.usePoint}} 원</div>
							<div class="productTxt">총 결제 금액 : {{ realPrice }} 원</div>
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
		orderUserInfo : {}, // 이름, 연락처, 이메일 등
		orderInfoList : [], // 주문 제품 정보 출력
		phoneSplit : { // OOO-XXXX-XXXX 로 출력하기 위한 변수
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		totalPrice : 0, // 총 결제 금액
		cancelPrice : 0, // 취소한 금액 (useYnc == C)
		realPrice : 0, // 포인트, 취소 금액을 제외한 실제 결제 금액
		// 예약 취소 버튼을 출력하기 위한 flg 변수. 3가지의 종류에 따라 출력하기 위해 3개 따로 선언
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
                	
                	self.priceCalculator(); // 총 결제 금액 변수에 저장
                	self.phoneSubString(); // 핸드폰 번호를 XXX-XXXX-XXXX 처럼 나눠서 출력
                	
                	// 해당 리스트에 한 항목이라도 useYnx의 값이 N이 없다면 취소할 제품이 없기 때문에 취소 컬럼을 없앰
                	self.roomFlg = !self.roomList.some(product => product.useYnc === 'N');
                    self.rentFlg = !self.rentList.some(product => product.useYnc === 'N');
                    self.leisureFlg = !self.leisureList.some(product => product.useYnc === 'N');
                }
            }); 
		},
		priceCalculator : function(){
			var self = this;
			
			// 취소 시 fnGetList 를 할 경우에 값이 += 되기 때문에 0으로 초기화
			self.totalPrice = 0;
			self.cancelPrice = 0;
			self.realPrice = 0;
			
			for(var i = 0 ; i < self.orderInfoList.length ; i++){
        		self.totalPrice += self.orderInfoList[i].payment;
        		if(self.orderInfoList[i].useYnc == "C"){
        			self.cancelPrice += self.orderInfoList[i].payment;
        		}
        	}
        	// 총 결제 금액 = 총 제품 금액 - 취소 금액 - 포인트 사용 금액 
        	self.realPrice = self.totalPrice - self.cancelPrice - self.orderUserInfo.usePoint;
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
		// 주문자 정보 수정
		fnEditUserInfo : function(){
			
			var self = this;
			if(self.orderUserInfo.uName == ""){
				alert("예약자 이름을 입력해주세요.");
				return;
			}
        	
        	//입력한 핸드폰 번호 합치기
        	self.orderUserInfo.phone = self.phoneSplit.phone1;
        	self.orderUserInfo.phone += self.phoneSplit.phone2;
        	self.orderUserInfo.phone += self.phoneSplit.phone3;
        	console.log(self.orderUserInfo.phone);
        	
        	if(self.orderUserInfo.phone.length < 10){
				alert("연락처를 정확하게 입력하주세요.");
				return;
			}
        	
        	var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.orderUserInfo.phone)){
				alert("연락처는 숫자만 입력해주세요.");
				return;
			}
			
			if(self.orderUserInfo.email == ""){
				alert("이메일을 입력해주세요.");
				return;
			}
			
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if(!regex.test(self.orderUserInfo.email)){
				alert("이메일 주소를 정확하게 입력하세요.");
				return;
			}
			
			if(!confirm("예약자 정보를 수정하시겠습니까?")){
	        	alert("취소되었습니다.");
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
                	alert("수정이 완료되었습니다.");
                	self.fnGetList();
                }
            }); 
		},
		// 요구사항 변경
		fnChangeRequest : function(productKind, productNo, request){
			var popWidth = 650;
		    var popHeight = 380;
		    
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
		// 예약 취소
		fnOrderCancle : function(productKind, productNo, payment){
			var self = this;
			if(!confirm("해당 예약을 취소하시겠습니까?")){
				return;
			}
			
			var returnPoint = self.orderUserInfo.usePoint;
			// 사용한 포인트가 결제 금액이 많으면 취소하는 제품의 금액만큼만 포인트 차감
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
                	alert("취소가 완료되었습니다.");
            		self.fnGetList();
                }
            });
		},
		// 제품 페이지로 이동
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
	    	// 추후 수정 예정
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
	    }
	}
});
</script>