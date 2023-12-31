<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>제품 예약 관리 페이지</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	#app{
		height: auto;
	}
	.heading-box h2{
		margin: 60px auto;
		text-align: center;
		margin-bottom: 20px;
	}
	
	table {
		margin : 20px auto;
		width : 1400px;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
	}
	th {
		padding : 5px 10px;
		background-color: #e9ecef;
	}
	tr {
		border-bottom: 1px solid #ccc;
		padding : 20px 10px;
	}
	td {
		padding : 20px 20px;
	}
	.tab-navigation {
	    text-align: center;
	    margin: 20px 0;
	}

	.tab-navigation button {
	    color: white;
	    transform: scale(1.02);
	    margin: 10px;
	}
	.container h3{
		margin: 0px auto;
		text-align: center;
	}
	.btn-container {
		margin: 0px auto;
		text-align: center;
		margin-bottom: 30px;;
	}
	.tab-navigation button.active {
	    background-color: #213555; 
	}
	.tbl-container{
		margin-top: 50px;
	}
	.container{
		height: 100%;
	}
	
}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">

<div class="container">
	<div class="heading-box">
   		<h2>상품 예약 내역 관리</h2>
   	</div>
   	<div class="tab-navigation"  style="text-align: center;">
	  	<button class="btn" :class="{ 'active': activeTab === 'stay' }" @click="activeTab = 'stay'">숙소</button>
	    <button class="btn" :class="{ 'active': activeTab === 'rent' }" @click="activeTab = 'rent'">렌트카</button>
	    <button class="btn" :class="{ 'active': activeTab === 'leisure' }" @click="activeTab = 'leisure'">레저</button>
	</div>
	<div class="tbl-container">
		<h3 v-if="activeTab === 'stay'">[숙소 예약 내역]</h3>
    	<table v-if="activeTab === 'stay'">
			<thead>
				<tr >
					<th>주문번호</th>
					<th>객실 이름</th>
					<th>예약자</th>
					<th>예약인원</th>
					<th>결제금액</th>
					<th>체크인</th>
					<th>체크아웃</th>
					<th>예약상태</th>
					<th>예약취소</th>
				</tr>
			</thead>	
			<tbody>
				<tr v-for="item in list" v-if="item.productKind == 'STAY'">
					<td>{{ item.orderNo }}</td>
					<td>
						<div>{{ item.stayName }}</div>
						<div>{{ item.roomName }}</div>
					</td>
					<td>{{ item.uId }}</td>
					<td>{{ item.people }}명</td>
					<td>{{ item.payment }}</td>
					<td>{{ item.sReserveDate }}</td>
					<td>{{ item.lReserveDate }}</td>
					
					<td v-if="item.useYnc=='N'">
						<div style="margin-bottom: 5px;">승인 대기중</div>
						<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">예약 승인</button></span>
					</td>
					<td v-else-if="item.useYnc=='Y'">
						<div>체크인 완료</div>
						<span><button @click="fnChangeN(item, 'N')" class="btn-red">승인 취소</button></span>
					</td>
					<td v-else>예약 취소</td>
					<td v-if="item.useYnc=='C'">
						<div>예약이 취소된 상품입니다.</div>
					</td>
					<td v-else-if="item.useYnc == 'Y'"> 
						<div>승인상태에서는 예약 취소가 불가능합니다.</div>
					</td>
					<td v-else-if="item.useYnc == 'N'">
						<div><button @click="fnCancel(item, 'C')" class="btn-red">예약취소</button></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="container">
		 <h3 v-if="activeTab === 'rent'">[렌트카 예약 내역]</h3>
   		 <table v-if="activeTab === 'rent'">
			<thead>
				<tr>
					<th>주문번호</th>
					<th>차종</th>
					<th>예약자</th>
					<th>결제금액</th>
					<th>인수일</th>
					<th>반납일</th>
					<th>예약상태</th>
					<th>예약취소</th>
				</tr>
			</thead>  
			<tr v-for="item in list" v-if="item.productKind == 'RENT'">
				<td>{{ item.orderNo }}</td>
				<td>
					<div>{{ item.rentName }}</div>
				</td>
				<td>{{ item.uId }}</td>
				<td>{{ item.payment }}</td>
				<td>{{ item.sReserveDate }}</td>
				<td>{{ item.lReserveDate }}</td>
				
				<td v-if="item.useYnc=='N'">
					<div style="margin-bottom: 5px;">승인 대기중</div>
					<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">사용 승인</button></span>
				</td>
				<td v-else-if="item.useYnc=='Y'">
					<div style="margin-bottom: 5px;">사용 승인 완료</div>
					<span><button @click="fnChangeN(item, 'N')" class="btn-red">승인 취소</button></span>
				</td>
				<td v-else>예약 취소</td>
				<td v-if="item.useYnc=='C'">
					<div>예약이 취소된 상품입니다.</div>
				</td>
				<td v-else-if="item.useYnc == 'Y'"> 
					<div>승인상태에서는 예약 취소가 불가능합니다.</div>
				</td>
				<td v-else-if="item.useYnc == 'N'">
					<div><button @click="fnCancel(item, 'C')" class="btn-red">예약취소</button></div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="container">
		<h3 v-if="activeTab === 'leisure'">[레저 예약 내역]</h3>
    	<table v-if="activeTab === 'leisure'">
			<thead>
				<tr>
					<th>주문번호</th>
					<th>레저이름</th>
					<th>예약자</th>
					<th>결제금액</th>
					<th>예약상태</th>
					<th>예약취소</th>
				</tr>
			</thead>
			<tr v-for="item in list" v-if="item.productKind == 'LEISURE'">
				<td>{{ item.orderNo }}</td>
				<td>
					<div>{{ item.leisureName }}</div>
				</td>
				<td>{{ item.uId }}</td>
				<td>{{ item.payment }}</td>
				<td v-if="item.useYnc=='N'">
					<div style="margin-bottom: 5px;">승인 대기중</div>
					<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">사용 승인</button></span>
				</td>
				<td v-else-if="item.useYnc=='Y'">
					<div style="margin-bottom: 5px;">사용 승인 완료</div>
					<span><button @click="fnChangeN(item, 'N')" class="btn-red">승인 취소</button></span>
				</td>
				<td v-else>예약 취소</td>
				<td v-if="item.useYnc=='C'">
					<div>예약이 취소된 상품입니다.</div>
				</td>
				<td v-else-if="item.useYnc == 'Y'"> 
					<div>승인상태에서는 예약 취소가 불가능합니다.</div>
				</td>
				<td v-else-if="item.useYnc == 'N'">
					<div><button @click="fnCancel(item, 'C')" class="btn-red">예약취소</button></div>
				</td>
			</tr>
		</table>
	</div>
	<div class="btn-container">
		<span><button @click="fnBack" class="btn-red">뒤로가기</button></span>
	</div>
</div>
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
   el : '#app',
   data : {
      status : "${sessionStatus}",
      userId : "${sessionId}",
      list : [],
      useYnc : "",
      productKind : "",
      activeTab : 'stay'
      
   },// data
   methods : {
      fnGetList : function(){
         var self = this;
         var param = {};
         $.ajax({
                url : "orderList.dox",
                dataType:"json",   
                type : "POST",
                data : param,
                success : function(data) { 
                   self.list = data.orderList;
                   console.log(self.list);
                }
            }); 
      },
      fnChangeY : function(item, useYnc){
    	  var self = this;
    	  if(!confirm("고객의 예약을 승인하시겠습니까?")){
    		  alert("취소되었습니다.");
    		  return;
    	  }
    	 
          var param = {productNo : item.productNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("예약이 승인되었습니다.");
                    console.log(useYnc);
                    console.log(item.uId);
                    self.fnGetList();
                    
                 }
             }); 
      },
      fnChangeN : function(item, useYnc){
    	  var self = this;
    	  if(!confirm("예약 승인을 철회하시겠습니까?")){
    		  alert("취소되었습니다.");
    		  return;
    	  }
          var param = {productNo : item.productNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("승인이 철회되었습니다.");
                    self.fnGetList();
                 }
             }); 
      },
      fnCancel : function(item, useYnc){
    	  var self = this;
    	  if(!confirm("예약을 취소하시겠습니까?")){
    		 alert("취소를 철회합니다.");
    		 return;
    	  }
    	  

		  var returnPoint = item.usePoint;
		  // 사용한 포인트가 결제 금액이 많으면 취소하는 제품의 금액만큼만 포인트 차감
		  if(returnPoint > item.payment){
			returnPoint = item.payment;
		  }
			
		  var param = {
			uId : self.userId,
			orderNo : item.orderNo,
			productKind : item.productKind,
			productNo : item.productNo,
			usePoint : returnPoint
		  };
		
          $.ajax({
                 url : "../revokeOrder.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("고객의 예약이 취소되었습니다.");
                    self.fnGetList();
                 }
             }); 
      },
      fnBack : function(){
    	  location.href = "../host/main.do";
      }
   
   }, // methods
   created : function() {
      var self = this;
      if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../main.do";
			
		} else {
			self.fnGetList();
		}
      
      
   }// created
});
</script>