<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����ī ���� ������</title>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../css/basic/custom-table-style.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	.custom-table{
		margin-top: 60px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<table class=" table custom-table table-striped table-bordered " >
				<tr>
					<th>����</th>
					<th>No.</th>
					<th>����ī��</th>
					<th>�з�</th>
					<th>��Ʈ�ݾ�</th>
					<th>�Ǹż���</th>
					<th>�����</th>
					<th>��Ű����û</th>
				</tr>
				
				<tr v-for="(item, index) in list">
					<td>
						<input v-if="index==indexNo" type="radio" :value="item.rentNo" @input="changeRentNo(item, index)" name="rentNo" checked="checked">
						<input v-else type="radio" :value="item.rentNo" @input="changeRentNo(item, index)" name="rentNo">
					</td>
					<td>{{item.rentNo}}</td>
					<td>{{item.rentName}}</td>
					<td>{{item.cName}}</td>
					<td>{{item.rentPrice * item.rentSales}}��</td>
					<td>{{item.rResidue}}</td>
					<td>{{item.rInsertTime}}</td>
					<td>
						<span v-if="item.state=='A'">
							<div>��û�� �Ϸ�Ǿ����ϴ�.</div>
							<div>��Ҵ� 1:1 ���Ǹ� �����ּ���.</div>
						</span>
						<button v-else-if="item.state=='D'" @click="fnPackDel(item.rentNo)" class="btn-red">���</button>
						<button v-else @click="fnPackAdd(item.rentNo)" class="btn-dark">��û</button>
					</td>
				</tr>
			</table>
			<template>
			  <paginate
			    :page-count="pageCount"
			    :page-range="3"
			    :margin-pages="2"
			    :click-handler="fnSearch"
			    :prev-text="'<'"
			    :next-text="'>'"
			    :container-class="'pagination'"
			    :page-class="'page-item'">
			  </paginate>
			</template>
			<div class="btn-con">
				<span><button @click="fnAdd" class="btn-dark">��ǰ���</button></span>
				<span><button @click="fnView" class="btn-dark">����������</button></span>
				<span><button @click="fnRemove" class="btn-red">����</button></span>
				<span><button @click="fnBack" class="btn-dark">�ڷΰ���</button></span>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		status : "${sessionStatus}",
		list : [],
		rentNo : "",
		rCnt : "",
		selectPage: 1,
		pageCount: 1,
		cnt : 0,
		indexNo : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
    		var lastNum = 10;
			var param = {uId : self.uId, startNum : startNum, lastNum : lastNum};
			console.log(param);
			$.ajax({
                url : "rentcar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.list = data.carList;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
            		console.log(self.list);
                	if(data.carList.length > 0){
                		self.rentNo = self.list[0].rentNo; //����Ʈ�� ù ��° ���� ����Ʈ�� üũ�ϰ�, �ش� pk ���� �޾ƿ´�.
                		self.rCnt = self.list[0].rCnt;
                	}
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 10;
			var param = {uId : self.uId, startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "rentcar.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.carList;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					
					// ����� �ε��� ������ ���� ��ư ����
		            if (self.indexNo >= 0 && self.list[self.indexNo]) {
		                self.rentNo = self.list[self.indexNo].rentNo;
		            } else if (self.list.length -1 < self.indexNo) {
		            	//������ ����Ʈ�� 10�� �̸��� ���� ����ִٸ� �ֻ�� ���� ����
		                self.rentNo = self.list[0].rentNo; 
		            }
				}
			});
		},
		fnAdd : function(){
			location.href = "rentcar/edit.do"; 
        },
        fnView : function(){
        	var self = this;
			$.pageChange("rentcar/view.do", {rentNo : self.rentNo, rCnt : self.rCnt}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("�ش� ����ī�� �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
	        
	        //�ش� ����ī�� ��Ű�� ��û�� �Ǿ��ִٸ� ���� �Ұ���
	        if(self.rCnt != 0){
	        	alert("��Ű�� ��û�� ����ī�� ������ ������ �Ұ����մϴ�.");
	        	return;
	        }
	        
			var param = {rentNo : self.rentNo};
            $.ajax({
                url : "rentcar/carRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("�ش� ����ī�� ������ �����Ǿ����ϴ�.");
                	self.fnGetList();
                }
            });
        },
        changeRentNo : function(item, index){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.rentNo = item.rentNo;
        	self.rCnt = item.rCnt;
        	self.indexNo = index; // �ε��� ���� ������Ʈ
        },
        fnPackAdd : function(rentNo){
			var self = this;
			console.log(rentNo);
			if(!confirm("��Ű���� ��û�Ͻðڽ��ϱ�?")){
	        	alert("��û�� ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {rentNo : rentNo};
			$.ajax({
                url : "rentPackAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("��Ű�� ��û�� �Ϸ�Ǿ����ϴ�.");
                	self.fnGetList();
                }
			});
        },
        fnPackDel : function(rentNo){
			var self = this;
			if(!confirm("��Ű�� ��û�� ����Ͻðڽ��ϱ�?")){
	        	alert("������ ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {rentNo : rentNo};
			$.ajax({
                url : "rentPackDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("��Ű�� ��û�� ��ҵǾ����ϴ�.");
                	self.fnGetList();
                }
			});
        },
        fnBack : function(){
        	location.href = "main.do"; 
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