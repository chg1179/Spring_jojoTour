<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.stay-box, .rent-box, .leisure-box, .btn {
		display: flex;
		justify-content: center;
		margin-top: 30px;
	}
	table {
	    width: 1000px;
	    border-collapse: collapse;
	}
	th, td{
		text-align: center;
		padding: 14px 0;
		border-bottom: 1px solid black;
		border-left: 1px solid #ccc;
	}
	
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="heading-box">
   		<h3>��ǰ ���� ���� ����</h3>
   	</div>
	<div class="stay-box">
		<table>
			<thead>
				<th colspan="9">
					<h3 class="table-heading">���� ���� ����</h3>
				</th>
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
	
	<div class="rent-box">
		<table>
			<th colspan="9">
				<h3 class="table-heading">��Ʈ ���� ����</h3>
			</th>
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
	
	<div class="leisure-box">
		<table>
			<th colspan="9">
				<h3 class="table-heading">��Ʈ ���� ����</h3>
			</th>
			<tr>
				<th>�ֹ���ȣ</th>
				<th>�����̸�</th>
				<th>������</th>
				<th>�����ݾ�</th>
				<th>�������</th>
				<th>�������</th>
			</tr>
				  
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