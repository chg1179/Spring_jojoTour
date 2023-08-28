<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
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
		margin-top: 50px;
	}
	.container {
		height: 1000px;
	}
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.pagination {
	    display: flex;
	    justify-content: center; 
	    margin-top: 20px; 
	}

	.page-item {
	    margin: 0 5px; 
	}
	h3{
		margin-top: 100px;
		margin-bottom: 0px;
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
		<h3>���� ���</h3>
			<table class=" table custom-table table-striped table-bordered ">
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
						<span v-if='item.cType=="WATER"'>����</span>
						<span v-else-if='item.cType=="GROUND"'>����</span>
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
						<button v-else-if="item.state=='D'" @click="fnPackDel(item.leisureNo)" class="btn-red">���</button>
						<button v-else @click="fnPackAdd(item.leisureNo)" class="btn-dark">��û</button>
					</td>
				</tr>
			</table>
			<div class="pagination">
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
			</div>
			<div class="btnbtn">
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