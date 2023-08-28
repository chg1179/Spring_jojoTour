<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<!-- <link href="../css/basic/custom-table-style.css" rel="stylesheet"/> -->
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.heading-box h2{
		margin: 50px 10px auto; 
		text-align: center;
		width: 1400px;
	}
	
	h3{
		margin: 30px 0px auto; 
		text-align: center;
		width : 1400px;
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
		padding : 5px 10px;
	}
	td {
		padding : 5px 10px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="heading-box">
   		<h2>��ǰ ���� ���� ����</h2>
   	</div>
	<div class="container">
		<h3>[���� ���� ����]</h3>
		<table>
			<thead>
				<tr>
					<th>�ֹ���ȣ</th>
					<th>���� �̸�</th>
					<th>������</th>
					<th>�����ο�</th>
					<th>�����ݾ�</th>
					<th>üũ��</th>
					<th>üũ�ƿ�</th>
					<th>�������</th>
					<th>�������</th>
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
					<td>{{ item.people }}��</td>
					<td>{{ item.payment }}</td>
					<td>{{ item.sReserveDate }}</td>
					<td>{{ item.lReserveDate }}</td>
					
					<td v-if="item.useYnc=='N'">
						<div>���� �����</div>
						<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">���� ����</button></span>
					</td>
					<td v-else-if="item.useYnc=='Y'">
						<div>üũ�� �Ϸ�</div>
						<span><button @click="fnChangeN(item, 'N')" class="btn-red">���� ���</button></span>
					</td>
					<td v-else>���� ���</td>
					<td v-if="item.useYnc=='C'">
						<div>������ ��ҵ� ��ǰ�Դϴ�.</div>
					</td>
					<td v-else-if="item.useYnc == 'Y'"> 
						<div>���λ��¿����� ���� ��Ұ� �Ұ����մϴ�.</div>
					</td>
					<td v-else-if="item.useYnc == 'N'">
						<div><button @click="fnCancel(item, 'C')" class="btn-red">�������</button></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="container">
		<h3>[��Ʈī ���� ����]</h3>
		<table>
			<thead>
				<tr>
					<th>�ֹ���ȣ</th>
					<th>����</th>
					<th>������</th>
					<th>�����ݾ�</th>
					<th>�μ���</th>
					<th>�ݳ���</th>
					<th>�������</th>
					<th>�������</th>
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
					<div>���� �����</div>
					<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">��� ����</button></span>
				</td>
				<td v-else-if="item.useYnc=='Y'">
					<div>��� ���� �Ϸ�</div>
					<span><button @click="fnChangeN(item, 'N')" class="btn-red">���� ���</button></span>
				</td>
				<td v-else>���� ���</td>
				<td v-if="item.useYnc=='C'">
					<div>������ ��ҵ� ��ǰ�Դϴ�.</div>
				</td>
				<td v-else-if="item.useYnc == 'Y'"> 
					<div>���λ��¿����� ���� ��Ұ� �Ұ����մϴ�.</div>
				</td>
				<td v-else-if="item.useYnc == 'N'">
					<div><button @click="fnCancel(item, 'C')" class="btn-red">�������</button></div>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="container">
		<h3>[���� ���� ����]</h3>
		<table>
			<thead>
				<tr>
					<th>�ֹ���ȣ</th>
					<th>�����̸�</th>
					<th>������</th>
					<th>�����ݾ�</th>
					<th>�������</th>
					<th>�������</th>
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
					<div>���� �����</div>
					<span><button @click="fnChangeY(item, 'Y')" class="btn-dark">��� ����</button></span>
				</td>
				<td v-else-if="item.useYnc=='Y'">
					<div>��� ���� �Ϸ�</div>
					<span><button @click="fnChangeN(item, 'N')" class="btn-red">���� ���</button></span>
				</td>
				<td v-else>���� ���</td>
				<td v-if="item.useYnc=='C'">
					<div>������ ��ҵ� ��ǰ�Դϴ�.</div>
				</td>
				<td v-else-if="item.useYnc == 'Y'"> 
					<div>���λ��¿����� ���� ��Ұ� �Ұ����մϴ�.</div>
				</td>
				<td v-else-if="item.useYnc == 'N'">
					<div><button @click="fnCancel(item, 'C')" class="btn-red">�������</button></div>
				</td>
			</tr>
		</table>
	</div>
	<div>
		<span><button @click="fnBack" class="btn">�ڷΰ���</button></span>
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
    	 
          var param = {productNo : item.productNo, useYnc : useYnc};
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
          var param = {productNo : item.productNo, useYnc : useYnc};
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
          var param = {productNo : item.productNo, useYnc : useYnc};
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