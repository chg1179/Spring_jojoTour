<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제 페이지</title>
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
			<div class="mainTxt">결제페이지</div>
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 상품 상세 정보</div>
				
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
		                        <th>금액</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in roomList" :key="product.productNo">
		                    	<td>{{ product.stayName }}</td>
		                        <td>{{ product.roomName }}</td>
		                        <td>{{ product.sReserveDate }} 14:00</td>
		                        <td>{{ product.lReserveDate }} 10:00</td>
		                        <td>{{ product.sprice }}원</td>
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
		                        <th>금액</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in rentList" :key="product.productNo">
		                        <td>{{ product.rentName }}</td>
		                        <td>{{ product.sReserveDate }} 12:00</td>
		                        <td>{{ product.lReserveDate }} 12:00</td>
		                        <td>{{ product.rprice }}원</td>
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
		                        <th>이용권수</th>
		                        <th>금액</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr v-for="product in leisureList" :key="product.productNo">
		                        <td>{{ product.leisureName }}</td>
		                        <td>{{ product.people }}매</td>
		                        <td>{{ product.leisurePrice * product.leisureSales * product.people }}원</td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
			</div>
			
			<div class="box">
			    <div class="coreTxt"><span class="bar">ㅣ</span> 요금 상세 정보</div>
			    <div>
			        <table>
			            <thead>
			                <tr>
			                    <th>상품명</th>
			                    <th>금액</th>
			                </tr>
			            </thead>
			            <tbody>
			                <!-- 숙소 상품 -->
			                <tr v-if="roomList.length != 0">
			                    <td>숙소 상품</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in roomList" :key="product.productNo">
			                                {{ product.roomName }} - {{ parseInt(product.sprice) }}원
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			                <!-- 렌트카 상품 -->
			                <tr v-if="rentList.length != 0">
			                    <td>렌트카 상품</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in rentList" :key="product.productNo">
			                                {{ product.rentName }} - {{ parseInt(product.rprice) }}원
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			                <!-- 레저 상품 -->
			                <tr  v-if="leisureList.length != 0">
			                    <td>레저 상품</td>
			                    <td>
			                        <ul>
			                            <li v-for="product in leisureList" :key="product.productNo">
			                                {{ product.leisureName }} - {{ product.leisurePrice * product.leisureSales * product.people }}원
			                            </li>
			                        </ul>
			                    </td>
			                </tr>
			            </tbody>
			            <!-- 총 합계 -->
		                <tfoot>
		                    <tr>
		                        <th>총 합계</th>
		                        <td>{{ totalAmount.toLocaleString() }}원</td>
		                    </tr>
		                </tfoot>
			        </table>
			    </div>
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 예약자 정보 입력</div>
				<div>
					<div>
						<label>
							<input type="radio" class="radioBtn" name="infoCheck" @click="infoView('same')" checked="checked">
							예약자와 사용자 동일
						</label>
						<label>
							<input type="radio" class="radioBtn" name="infoCheck" @click="infoView('notSame')">
							새로 입력
						</label>
					</div>
					<div>
						<div>성명</div>
						<div class="wrap"><input type="text" v-model="userInfo.uName"></div>
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
						<div class="wrap"><input type="text" v-model="userInfo.email"></div>
					</div>
					<div>
						<div>요청사항</div>
						<div class="wrap"><textarea rows="3" cols="50"  v-model="request" maxlength="50" placeholder="요청사항이 있는 경우 자유롭게 입력해 주세요."></textarea></div>
					</div>
				</div>
			</div>
			
			
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 포인트 사용</div>
				<div>
					<div>
						<div>보유 {{userInfo.point}}P</div>
					</div>
					<div>
						<div>사용</div>
						<div>
							<span class="wrapPhone"><input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0"></span>
							<input type="button" class="btn" @click="allPoint" value="전액사용">
						</div>
					</div>
				</div>
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 최종 결제 금액(VAT포함)</div>
	            <div>
	                <p>총 결제 금액: {{ (totalAmount - usePoint).toLocaleString() }}원</p>
	            </div>
				<ul>
					<li>해당 객실가는 세금, 봉사료가 포함된 금액입니다.</li>
					<li>결제 완료 후 <span class="redTxt">예약자 이름</span>과 <span class="redTxt">핸드폰 번호</span>로 바로 <span class="redTxt">체크인</span> 하시면 됩니다.</li>
				</ul>
			</div>
			<div class="box">
				<div><label><input type="checkbox" v-model="allCheck" @click="toggleAllCheck">전체 동의</label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="1">숙소이용규칙 및 취소/환불규정 동의 <span class="redTxt">(필수)</span></label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="2">개인정보 수집 및 이용 동의 <span class="redTxt">(필수)</span></label></div>
				<div><label><input type="checkbox" v-model="clauseCheck" :value="3">개인정보 제 3자 제공 동의 <span class="redTxt">(필수)</span></label></div>
			</div>
			<div class="box">
				<button class="btn" @click="fnRequestPay">결제하기</button>
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
		productList: [], // 장바구니에서 결제할 제품을 가져오는 리스트
		userInfo : {}, // 결제하는 유저의 정보를 담음
		phoneSplit : { // OOO-XXXX-XXXX 로 출력하기 위한 변수
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		usePoint : "", // 사용자가 결제 시 사용할 포인트
		request : "", // 요청사항 작성
		clauseCheck : [], // 약관을 모두 동의했는지 확인
		allCheck : false // 약관 전체 선택
	},// data
	methods : {
		//장바구니에서 결제할 제품을 넣는 코드
		fnGetProductList : function(){
			axios.get('/api/getProductList')
            .then(response => {
                this.productList = response.data; // productList에 결제할 제품을 할당
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
			var middleNum; // 핸드폰 번호가 11자리, 10자리일 때 중간 번호를 자르기 위한 변수
			if(self.userInfo.phone.length == 11){ // 핸드폰 번호가 11자리일 때
				middleNum = 7;
			} else if(self.userInfo.phone.length == 10){ // 핸드폰 번호가 10자리일 때
				middleNum = 6;
			}
			
			self.phoneSplit.phone1 = (self.userInfo.phone).substring(0,3);
			self.phoneSplit.phone2 = (self.userInfo.phone).substring(3,middleNum);
			self.phoneSplit.phone3 = (self.userInfo.phone).substring(middleNum);
		},
		pointOverCheck : function(){
			var self = this;
			if(self.usePoint > self.userInfo.point){
				alert("보유 포인트를 확인해주세요.");
				self.usePoint = "";
				return;
			}
			if(self.usePoint < 0){
				alert("0보다 큰 금액을 입력해주세요.");
				self.usePoint = "";
				return;
			}
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.usePoint)){
				alert("사용 포인트는 숫자만 입력해주세요.");
				self.usePoint = "";
				return;
			}
		},
		infoView : function(check){
			var self = this;
			if(check == "same"){
				self.fnGetUserInfo();
			} else{
				// 입력값을 받을 수 있도록 초기화
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
        // 약관 동의 전체 선택
        toggleAllCheck: function() {
		    if (this.allCheck) {
		        this.clauseCheck = []; // 모든 약관 체크박스를 해제
		    } else {
		        this.clauseCheck = [1, 2, 3]; // 모든 약관 체크박스를 선택
		    }
		},
        fnRequestPay : function(){
        	var self = this;
        	var orderNo = 'jojo_'+new Date().getFullYear()+(new Date().getMonth()+1)+new Date().getDate()+"_"+new Date().getTime();
        	console.log(orderNo);
        	if(self.userInfo.uName == ""){
				alert("예약자 이름을 입력해주세요.");
				return;
			}
        	
        	//입력한 핸드폰 번호 합치기
        	self.userInfo.phone = self.phoneSplit.phone1;
        	self.userInfo.phone += self.phoneSplit.phone2;
        	self.userInfo.phone += self.phoneSplit.phone3;
        	console.log(self.userInfo.phone);
        	
        	if(self.userInfo.phone.length < 10){
				alert("연락처 양식을 확인해주세요.");
				return;
			}
        	
        	var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.userInfo.phone)){
				alert("연락처는 숫자만 입력해주세요.");
				return;
			}
			
			if(self.userInfo.email == ""){
				alert("이메일을 입력해주세요.");
				return;
			}
			
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if(!regex.test(self.userInfo.email)){
				alert("이메일 양식을 확인해주세요.");
				return;
			}
			
			if(self.clauseCheck.length < 3){
				alert("모든 약관을 동의해야만 결제가 가능합니다.");
				return;
			}
        	
			// 포인트를 입력하지 않으면 0으로 생각한다.
			if(self.usePoint == ""){
				self.usePoint = 0;
			}
			
			// 상품명 찾기
			var orderName = "";
			if(self.roomList.length != 0){
				orderName = self.roomList[0].stayName +" "+self.roomList[0].roomName; 
			} else if(self.rentList.length != 0){
				orderName = self.rentList[0].rentName; 
			} else if(self.leisureList.length != 0){
				orderName = self.leisureList[0].leisureName; 
			}
			if((self.productList.length-1) != 0){
				orderName += " 외 " + (self.productList.length-1)+"건"; 
			}
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: orderNo,   // 주문번호
                name: orderName, // 상품명 + 외 @건 
                amount: self.totalAmount - self.usePoint, // 테스트
                buyer_email: self.userInfo.email,
                buyer_name: self.userInfo.uName,
                buyer_tel: self.userInfo.phone
			}, function (rsp) { // callback
					if (rsp.success) {
                		alert("주문이 완료되었습니다.");
                		self.fnOrder(orderNo);
					} else {
						//테스트용
                    	alert("주문이 완료되었습니다.");
                    	self.fnOrder(orderNo);
                    }
			});
        },
        // 주문 내역 추가(insert), 포인트 사용, 장바구니 제거
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
		self.fnGetProductList(); //컴포넌트 생성 시 세션 데이터 가져오기
		self.fnGetUserInfo();
	}, // created
	// productList 변경 감지 후 리스트 분류. 값 재할당 X
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