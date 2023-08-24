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
      ��ǰ ���� ���� ����
      <div id="container">
		<select v-model="productKind">
			<option value="" selected disabled hidden>==��ǰ ������ �����ϼ���==</option>
			<option value="STAY">����</option>
			<option value="LEISURE">����</option>
			<option value="RENT">��Ʈ</option>
		</select>
		
      <!-- ���� -->
         <table class="tbl">
            <tr  v-if="productKind != ''">
               <th>�����ȣ</th>
               <th v-if="productKind == 'STAY'">���� �̸�</th>
               <th v-else-if="productKind == 'LEISURE'">���� �̸�</th>
               <th v-else>��Ʈī �̸�</th>
               <th>������</th>
               <th v-if="productKind == 'STAY'|| productKind == 'LEISURE'">�����ο�</th>
               <th>�����ݾ�</th>
               <th v-if="productKind == 'STAY'">üũ��</th>
               <th v-else-if="productKind == 'RENT'">�μ���¥</th>
               <th v-if="productKind == 'STAY'">üũ�ƿ�</th>
               <th v-else-if="productKind == 'RENT'">�ݳ���¥</th>
               <th>�������</th>
               <th>�������</th>
            </tr>
            
            <tr v-for="item in list" v-if="item.productKind == productKind">
               <!-- <td v-if="item.productKind == ''"> ���� ������ �����ϴ�.</td> --> <!-- cnt�� ���̰� 0���� ������ -->
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
               <td v-if="productKind == 'STAY'|| productKind == 'LEISURE'">{{item.people}}��</td>
               <td>{{item.payment}}</td>
               <td v-if="productKind == 'STAY'|| productKind == 'RENT'">{{item.sReserveDate}}</td>
               <td v-if="productKind == 'STAY'|| productKind == 'RENT'">{{item.lReserveDate}}</td>
               
               <td v-if="item.useYnc=='N'">
	               	<div>���� �����</div>
	               	<span><button @click="fnChangeY(item, 'Y')">���� ����</button></span>
               </td>
               <td v-else-if="item.useYnc=='Y'">
	               	<div v-if="productKind == 'STAY'">üũ��</div>
	               	<div v-else>�������</div>
	               	<span><button @click="fnChangeN(item, 'N')">���� ���</button></span>
               	</td>
               <td v-else>���� ���</td>
               
               <td v-if="item.useYnc=='C'">
               		<div>������ ��ҵ� ��ǰ�Դϴ�.</div>
               </td>
               <td v-else-if="item.useYnc == 'Y'"> 
               		<div>���λ��¿����� ��Ұ� �Ұ����մϴ�.</div>
               </td>
               <td v-else-if="item.useYnc == 'N'">
               		<div><button @click="fnCancel(item, 'C')">�������</button></div>
               </td>
            </tr>
         </table>
        
         <div>
            <span><button @click="fnBack">�ڷΰ���</button></span>
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
    	  if(!confirm("���� ������ �����Ͻðڽ��ϱ�?")){
    		  alert("��ҵǾ����ϴ�.");
    		  return;
    	  }
    	 
          var param = {orderNo : item.orderNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("������ ���εǾ����ϴ�.");
                    console.log(useYnc);
                    console.log(item.uId);
                    self.fnGetList();
                    
                 }
             }); 
      },
      fnChangeN : function(item, useYnc){
    	  var self = this;
    	  if(!confirm("���� ������ öȸ�Ͻðڽ��ϱ�?")){
    		  alert("��ҵǾ����ϴ�.");
    		  return;
    	  }
          var param = {orderNo : item.orderNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("������ öȸ�Ǿ����ϴ�.");
                    self.fnGetList();
                 }
             }); 
      },
      fnCancel : function(item, useYnc){
    	  var self = this;
    	  if(!confirm("������ ����Ͻðڽ��ϱ�?")){
    		 alert("��Ҹ� öȸ�մϴ�.");
    		 return;
    	  }
          var param = {orderNo : item.orderNo, useYnc : useYnc};
          $.ajax({
                 url : "signUpdate.dox",
                 dataType:"json",   
                 type : "POST",
                 data : param,
                 success : function(data) { 
                    alert("���� ������ ��ҵǾ����ϴ�.");
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
			alert("ȣ��Ʈ�� ������ �� �ֽ��ϴ�.");
			location.href="../main.do";
			
		} else {
			self.fnGetList();
		}
      
      
   }// created
});
</script>