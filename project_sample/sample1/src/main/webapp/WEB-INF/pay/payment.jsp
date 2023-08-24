<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제 페이지</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link href="../../css/pay/payment-style.css" rel="stylesheet"/>
<link href="../../css/btn-style.css" rel="stylesheet"/>
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
		        <div>
		            uId: ${sessionId}
		            <br>
		            Product List:
		            <ul>
		                <li v-for="product in productList">
		                    {{ product.productKind }} - {{ product.productNo }}
		                </li>
		            </ul>
		            
		        </div>
				
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 요금 상세 정보</div>
				
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
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone1"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone2"></span>-
							<span class="wrapPhone"><input type="text" v-model="phoneSplit.phone3"></span>
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
						<div class="wrap">
							<input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0">
						</div>
						<input type="button" class="btn" @click="allPoint" value="전액사용">
					</div>
					<div>포인트는 가장 비싼 상품을 우선으로 차감됩니다.</div>
				</div>
				
			</div>
			
			<div class="box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 최종 결제 금액(VAT포함)</div>
				<ul>
					<li>해당 객실가는 세금, 봉사료가 포함된 금액입니다.</li>
					<li>결제완료 후 <span>예약자 이름</span>과 <span>핸드폰 번호</span>로 바로 <span>체크인</span> 하시면 됩니다.</li>
				</ul>
			</div>
			<div class="box"><!-- 수정 중 -->
				<div><label><input type="checkbox">전체 동의</label></div>
				<div><label><input type="checkbox">숙소이용규칙 및 취소/환불규정 동의<span>(필수)</span></label></div>
				<div><label><input type="checkbox">개인정보 수집 및 이용 동의<span>(필수)</span></label></div>
				<div><label><input type="checkbox">개인정보 제 3자 제공 동의<span>(필수)</span></label></div>
			</div>
			<div class="box">
				<button class="btn" @click="fnRequestPay">결제하기</button>
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
		productList: [], // 장바구니에서 결제할 제품을 가져오는 리스트
		userInfo : {}, // 결제하는 유저의 정보를 담음
		phoneSplit : { // OOO-XXXX-XXXX 로 출력하기 위한 변수
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		usePoint : "", //사용자가 결제 시 사용할 포인트
		request : "" //요청사항 작성
	},// data
	methods : {
		//장바구니에서 결제할 제품을 넣는 코드
		fnGetProductList : function(){
			axios.get('/api/getProductList')
            .then(response => {
                this.productList = response.data; // productList에 결제할 제품을 할당
                this.fnGetProductInfoList(); // 결제할 제품의 정보를 담는 함수
            })
            .catch(error => {
                console.error('Error fetching product list:', error);
            });
		},
		fnGetProductInfoList : function(){
			var self = this;
			console.log(self.productList);
			for(var i=0; i<self.productList.length;i++){
				if(self.productList[i].productKind == "STAY"){
					console.log(self.productList[i].productNo);
				} else if(self.productList[i].productKind == "RENT"){
					console.log(self.productList[i].productNo);
				} else if(self.productList[i].productKind == "LEISURE"){
					console.log(self.productList[i].productNo);
				}
			}
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
			if(self.usePoint > 0){
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
        fnRequestPay : function(){
        	var self = this;
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: 'jojo_'+new Date().getTime(),   // 주문번호
                name: "상품명", // 상품명 + 외 @건 
                amount: 64900, // 테스트
                buyer_email: self.userInfo.email,
                buyer_name: self.userInfo.uName,
                buyer_tel: self.userInfo.phone
			}, function (rsp) { // callback
					if (rsp.success) {
                		alert("결제 성공");
                		location.href="/my/order.do"
					} else {
						//테스트용
                    	alert("결제 성공");
                    	location.href="/my/order.do"
                    }
			});
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetProductList(); //컴포넌트 생성 시 세션 데이터 가져오기
		self.fnGetUserInfo();
	}// created
});
</script>