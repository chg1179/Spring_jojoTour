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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>FAQ �Խ���</h2>
		<div>
			<label><input v-model="search" placeholder="Ű����˻�"  @keyup.enter="fnGetList">
				<button @click="fnGetList">�˻�</button>
			</label>
		</div>
		<table>
			<tr>
				<th v-if="status == 'A'">����</th>
				<th>No.</th>
				<th>����</th>
				<th>�ۼ���</th>
				<th>��ȸ��</th>
				<th>��� ��¥</th>
			</tr>
			<tr v-for="(item, index) in list">
				<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.fNo"></th>
				<th>{{item.fNo}}</th>
				<th><a @click="fnView(item.fNo)" href="javascript:;">{{item.fTitle}}</a></th>
				<th>{{item.uId}}</th>
				<th>{{item.fHits}}</th>
				<th>{{item.fWriteTime}}</th>	
			</tr>
		</table>
	<div  v-if="status == 'A'">
		<button @click="fnRemove">����</button>
		<button @click="fnACheck">��ü����</button>
		<button @click="fnNCheck">��ü����</button>
	</div>
	<div v-if="status == 'A'"><button @click="fnMove">�۾���</button></div>
	</div>
	
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		search:"",
		status : "${sessionStatus}",
		selectItem:[]
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {search : self.search};
			$.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	console.log(data);
                	self.list = data.faqList;
                }
            }); 
		},

		fnRemove : function(){
			var self = this;
        	if(!confirm("���� �����Ͻðڽ��ϱ�?")){
        		return;
        	}
        	var fList = JSON.stringify(self.selectItem);
			var param = {selectItem : fList};
            $.ajax({
                url : "removeFaqCheck.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	self.fnGetList();
                	self.selectItem = [];
                	alert("�����Ǿ����ϴ�.");
                	
                }
            }); 
		},
		
 		 fnMove : function(){
	        	location.href = "add.do";
	        }, 
	        
 	     fnView : function(fNo){
 	    	$.pageChange("view.do", {fNo : fNo});	 
	     	},
	     	
		fnNCheck : function(){
				var self = this;
				self.fNo = [];
			},
		fnACheck : function(){
				var self = this;
				self.fNo = [];
				for(var i=0; i<self.list.length; i++){
					self.fNo.push(self.list[i].fNo);
				}
			}
	      
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>