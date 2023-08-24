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
      ��ǰ ���� ���� ����
      <div id="container">
      <!-- ���� -->
         <table>
            <tr>
               <th>�����ȣ</th>
               <th>���� �̸�</th>
               <th>������</th>
               <th>�����ο�</th>
               <th>�����ݾ�</th>
               <th>üũ��</th>
               <th>üũ�ƿ�</th>
               <th>�������</th>
               <th>�������</th>
            </tr>
            
            <tr v-for="(item, index) in list">
               <!-- <td v-if="item.productKind == ''"> ���� ������ �����ϴ�.</td> --> <!-- cnt�� ���̰� 0���� ������ -->
               <td>{{item.orderNo}}</td>
               <td v-if="item.productKind == 'STAY'">{{item.stayName}} {{item.roomName}}</td>
               <td>{{item.uId}}</td>
               <td>{{item.people}}��</td>
               <td>{{item.payment * item.people}}</td>
               <td>{{item.sReserveDate}}</td>
               <td>{{item.lReserveDate}}</td>
               
               <td v-if="item.useYnc=='N'">
	               	<div>���� �����.</div>
	               	<span><button @click="fnChangeY(item, 'Y')">���� ����</button></span>
	               	<span><button @click="fnChangeN(item, 'N')">���� ����</button></span>
               </td>
               <td v-else-if="item.useYnc=='Y'">
	               	<div>���� ����</div>
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
         </div>
         <!-- ���� -->
         
         <!-- ��Ʈ -->
         <div>
            <span><button @click="">�ڷΰ���</button></span>
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
    	  if(!confirm("���� ������ �����Ͻðڽ��ϱ�?")){
    		  alert("��ҵǾ����ϴ�.");
    		  return;
    	  }
    	 
          var param = {uId : item.uId, useYnc : useYnc};
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
          var param = {uId : item.uId, useYnc : useYnc};
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
          var param = {uId : item.uId, useYnc : useYnc};
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
   
   }, // methods
   created : function() {
      var self = this;
      self.fnGetList();
      
   }// created
});
</script>