<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
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
	.pagination {
        margin:24px;
        display: inline-flex;
    }
    ul {
    }
    .pagination li {
	    min-width:32px;
	    padding:2px 6px;
	    text-align:center;
	    margin:0 3px;
	    border-radius: 6px;
	    border:1px solid #eee;
	    color:#666;
	    display : inline;
	}
	.pagination li:hover {
	    background: #E4DBD6;
	}
	.page-item a {
	    color:#666;
	    text-decoration: none;
	}
	.pagination li.active {
	    background-color : #E7AA8D;
	    color:#fff;
	}
	.pagination li.active a {
	    color:#fff;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<table>
				<tr>
					<th>����</th>
					<th>No.</th>
					<th>������</th>
					<th>�з�</th>
					<th>�о�</th>
					<th>�����ݾ�</th>
					<th>�Ǹż���</th>
					<th>�����</th>
					<th>��Ű����û</th>
				</tr>
				
				<tr v-for="(item, index) in list">
					<td>
						<input v-if="index==indexNo" type="radio" :value="item.leisureNo" @input="changeLeisureNo(item, index)" name="leisureNo" checked="checked">
						<input v-else type="radio" :value="item.leisureNo" @input="changeLeisureNo(item, index)" name="leisureNo">
					</td>
					<td>{{item.leisureNo}}</td>
					<td>{{item.leisureName}}</td>
					<td>
						<span v-if='item.type="WATER"'>����</span>
						<span v-else-if='item.type="GROUND"'>����</span>
					</td>
					<td>{{item.cName}}</td>
					<td>{{item.leisurePrice * item.leisureSales}}��</td>
					<td>{{item.lResidue}}</td>
					<td>{{item.lInsertTime}}</td>
					<td>
						<span v-if="item.state=='A'">
							<div>��û�� �Ϸ�Ǿ����ϴ�.</div>
							<div>��Ҵ� 1:1 ���Ǹ� �����ּ���.</div>
						</span>
						<button v-else-if="item.state=='D'" @click="fnPackDel(item.leisureNo)">���</button>
						<button v-else @click="fnPackAdd(item.leisureNo)">��û</button>
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
			<div>
				<span><button @click="fnAdd">��ǰ���</button></span>
				<span><button @click="fnView">����������</button></span>
				<span><button @click="fnRemove">����</button></span>
				<span><button @click="fnBack">�ڷΰ���</button></span>
			</div>
		</div>
	</div>
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
		leisureNo : "",
		lCnt : "",
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
                url : "leisure.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.list = data.leisureList;
                	console.log(data.leisureList);
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
                	if(data.leisureList.length > 0){
                		self.leisureNo = self.list[0].leisureNo; //����Ʈ�� ù ��° ���� ����Ʈ�� üũ�ϰ�, �ش� pk ���� �޾ƿ´�.
                		self.lCnt = self.list[0].lCnt;
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
				url : "leisure.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.leisureList;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					
					// ����� �ε��� ������ ���� ��ư ����
		            if (self.indexNo >= 0 && self.list[self.indexNo]) {
		                self.leisureNo = self.list[self.indexNo].leisureNo;
		            } else if (self.list.length -1 < self.indexNo) {
		            	//������ ����Ʈ�� 10�� �̸��� ���� ����ִٸ� �ֻ�� ���� ����
		                self.leisureNo = self.list[0].leisureNo; 
		            }
				}
			});
		},
		fnAdd : function(){
			location.href = "leisure/edit.do"; 
        },
        fnView : function(){
        	var self = this;
			$.pageChange("leisure/view.do", {leisureNo : self.leisureNo, lCnt : self.lCnt}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("�ش� ������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
	        
	        //�ش� ������ ��Ű�� ��û�� �Ǿ��ִٸ� ���� �Ұ���
	        if(self.lCnt != 0){
	        	alert("��Ű�� ��û�� ������ ������ ������ �Ұ����մϴ�.");
	        	return;
	        }
	        
			var param = {leisureNo : self.leisureNo};
            $.ajax({
                url : "leisure/leisureRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("�ش� ������ ������ �����Ǿ����ϴ�.");
                	self.fnGetList();
                }
            });
        },
        changeLeisureNo : function(item, index){ //�����ڽ��� ������ �� ���� pk �� ����
        	var self = this;
        	self.leisureNo = item.leisureNo;
        	self.lCnt = item.lCnt;
        	self.indexNo = index; // �ε��� ���� ������Ʈ
        },
        fnPackAdd : function(leisureNo){
			var self = this;
			console.log(leisureNo);
			if(!confirm("��Ű���� ��û�Ͻðڽ��ϱ�?")){
	        	alert("��û�� ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {leisureNo : leisureNo};
			$.ajax({
                url : "leisurePackAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("��Ű�� ��û�� �Ϸ�Ǿ����ϴ�.");
                	self.fnGetList();
                }
			});
        },
        fnPackDel : function(leisureNo){
			var self = this;
			if(!confirm("��Ű�� ��û�� ����Ͻðڽ��ϱ�?")){
	        	alert("������ ��ҵǾ����ϴ�.");
	          	return;
	        }
			var param = {leisureNo : leisureNo};
			$.ajax({
                url : "leisurePackDel.dox",
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