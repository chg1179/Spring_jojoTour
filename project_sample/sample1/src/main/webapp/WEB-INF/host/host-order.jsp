<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
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
      상품 예약 내역 관리
      <div id="container">
		<select v-model="productKind">
			<option value="" selected disabled hidden>==상품 유형을 선택하세요==</option>
			<option value="STAY">숙소</option>
			<option value="LEISURE">레저</option>
			<option value="RENT">렌트</option>
		</select>
		
      <!-- 숙소 -->
         <table class="tbl">
            <tr  v-if="productKind != ''">
               <th>예약번호</th>
               <th v-if="productKind == 'STAY'">객실 이름</th>
               <th v-else-if="productKind == 'LEISURE'">레저 이름</th>
               <th v-else>렌트카 이름</th>
               <th>예약자</th>
               <th v-if="productKind == 'STAY'|| productKind == 'LEISURE'">예약인원</th>
               <th>결제금액</th>
               <th v-if="productKind == 'STAY'">체크인</th>
               <th v-else-if="productKind == 'RENT'">인수날짜</th>
               <th v-if="productKind == 'STAY'">체크아웃</th>
               <th v-else-if="productKind == 'RENT'">반납날짜</th>
               <th>예약상태</th>
               <th>예약취소</th>
            </tr>
            
            <tr v-for="item in list" v-if="item.productKind == productKind">
               <!-- <td v-if="item.productKind == ''"> 예약 내역이 없습니다.</td> --> <!-- cnt가 길이가 0보다 작을때 -->
               <td>{{item.orderNo}}</td>
               <td v-if="item.productKind == 'STAY'">
               		<div>{{item.stayName}}</div>
               		<div>{{item.roomName}}</div>
               </td>
               <td v-else-if="item.productKind == 'LEISURE'">
	               	<div>{{item.leisureKind}}</div>
	               	<div>{{item.leisureName}}</div>
               	</td>
               <td v-else>{{item.rentName}}</td>
               <td>{{item.uId}}</td>
               <td v-if="productKind == 'STAY'|| productKind == 'LEISURE'">{{item.people}}명</td>
               <td>{{item.payment}}</td>
               <td v-if="productKind == 'STAY'|| productKind == 'RENT'">{{item.sReserveDate}}</td>
               <td v-if="productKind == 'STAY'|| productKind == 'RENT'">{{item.lReserveDate}}</td>
               
               <td v-if="item.useYnc=='N'">
	               	<div>승인 대기중</div>
	               	<span><button @click="fnChangeY(item, 'Y')">예약 승인</button></span>
               </td>
               <td v-else-if="item.useYnc=='Y'">
	               	<div v-if="productKind == 'STAY'">체크인</div>
	               	<div v-else>예약승인</div>
	               	<span><button @click="fnChangeN(item, 'N')">승인 취소</button></span>
               	</td>
               <td v-else>예약 취소</td>
               
               <td v-if="item.useYnc=='C'">
               		<div>예약이 취소된 상품입니다.</div>
               </td>
               <td v-else-if="item.useYnc == 'Y'"> 
               		<div>승인상태에서는 취소가 불가능합니다.</div>
               </td>
               <td v-else-if="item.useYnc == 'N'">
               		<div><button @click="fnCancel(item, 'C')">예약취소</button></div>
               </td>
            </tr>
         </table>
        
         <div>
            <span><button @click="fnBack">뒤로가기</button></span>
         </div>
      </div>
   </div>
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
      productKind : ""
      
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
    	 
          var param = {orderNo : item.orderNo, useYnc : useYnc};
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
          var param = {orderNo : item.orderNo, useYnc : useYnc};
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
          var param = {orderNo : item.orderNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
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