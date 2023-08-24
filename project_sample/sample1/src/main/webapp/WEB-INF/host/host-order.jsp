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
</style>
</head>
<body>
   <jsp:include page="../header.jsp" flush="true"></jsp:include>
   <div id="app">
      상품 예약 내역 관리
      <div id="container">
      <!-- 숙소 -->
         <table>
            <tr>
               <th>예약번호</th>
               <th>객실 이름</th>
               <th>예약자</th>
               <th>예약인원</th>
               <th>결제금액</th>
               <th>체크인</th>
               <th>체크아웃</th>
               <th>예약상태</th>
               <th>예약취소</th>
            </tr>
            
            <tr v-for="(item, index) in list">
               <!-- <td v-if="item.productKind == ''"> 예약 내역이 없습니다.</td> --> <!-- cnt가 길이가 0보다 작을때 -->
               <td>{{item.orderNo}}</td>
               <td v-if="item.productKind == 'STAY'">{{item.stayName}} {{item.roomName}}</td>
               <td>{{item.uId}}</td>
               <td>{{item.people}}명</td>
               <td>{{item.payment * item.people}}</td>
               <td>{{item.sReserveDate}}</td>
               <td>{{item.lReserveDate}}</td>
               
               <td v-if="item.useYnc=='N'">
	               	<div>승인 대기중.</div>
	               	<span><button @click="fnChangeY(item, 'Y')">예약 승인</button></span>
	               	<span><button @click="fnChangeN(item, 'N')">예약 거절</button></span>
               </td>
               <td v-else-if="item.useYnc=='Y'">
	               	<div>예약 승인</div>
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
         </div>
         <!-- 레저 -->
         
         <!-- 렌트 -->
         <div>
            <span><button @click="">뒤로가기</button></span>
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
      list : [],
      useYnc : ""
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
    	 
          var param = {uId : item.uId, useYnc : useYnc};
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
          var param = {uId : item.uId, useYnc : useYnc};
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
          var param = {uId : item.uId, useYnc : useYnc};
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
   
   }, // methods
   created : function() {
      var self = this;
      self.fnGetList();
      
   }// created
});
</script>