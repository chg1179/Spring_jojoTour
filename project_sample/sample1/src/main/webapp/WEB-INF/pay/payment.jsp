<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제페이지</title>
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
				<div>결제페이지</div>
			</div>
			<div>
				<div>--상품 상세 정보</div>
				
				
			</div>
			
			<div>
				<div>--요금 상세 정보</div>
				
			</div>
			
			<div>
				<div>--예약자 정보 입력</div>
				<div>
					<div>
						
						<label>
							<input type="radio" name="infoCheck" @click="infoView('same')" checked="checked">
							예약자와 사용자 동일
						</label>
						<label>
							<input name="infoCheck" type="radio" @click="infoView('notSame')">
							새로 입력
						</label>
					</div>
					<div>
						<label>성　명<input type="text" v-model="userInfo.uName"></label>
					</div>
					<div>
						<label>연락처
							<input type="text" v-model="phoneSplit.phone1">-
							<input type="text" v-model="phoneSplit.phone2">-
							<input type="text" v-model="phoneSplit.phone3">
						</label>
					</div>
					<div>
						<label>이메일<input type="text" v-model="userInfo.email"></label>
					</div>
					<div>
						<label>요청사항<input type="text" v-model="request" placeholder="상품 이용과 관련하여 요청사항이 있는 경우 자유롭게 입력해 주세요."></label>
					</div>
				</div>
			</div>
			
			
			<div>
				<div>--포인트 사용</div>
				<div>
					<div>
						<label>보유 포인트<input type="text" v-model="userInfo.point" placeholder="0"></label>
					</div>
					<div>
						<label>사용 <input type="text" v-model="usePoint" @input="pointOverCheck" placeholder="0"></label>
						<input type="button" @click="allPoint" value="전액사용">
					</div>
					<div>포인트는 가장 비싼 상품에서 우선적으로 차감됩니다.</div>
				</div>
				
			</div>
			
			<div>
				<div>최종 결제 금액</div>
				
				
			</div>
			<div>
				<button @click="fnRequestPay">결제하기</button>
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
		phoneSplit : { // OOO-XXXX-XXXX 로 출력하기 위함
			phone1 : "",
			phone2 : "",
			phone3 : ""
		},
		usePoint : "",
		request : "", //요청사항 작성
		testList : []
	},// data
	mounted() { // created 다음으로 호출됨
        //this.testList = ${map.list}; // JSON 데이터를 할당
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
                    	alert("결제 성공");
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