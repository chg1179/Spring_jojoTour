<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
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
		<h2>���� �Խ���</h2>
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
				<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.freeNo"></th>
				<th>{{item.freeNo}}</th>
				<th>
					<a @click="fnView(item.freeNo)" href="javascript:;">{{item.freeTitle}}</a>
					<span v-if="item.commCnt > 0">({{item.commCnt}})</span>
				</th>
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
	<div><button @click="fnMove" v-if="status == 'A'||status == 'U'||status == 'H'">�۾���</button></div>
	</div>
	
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		search : "",
		status : "${sessionStatus}",
		selectItem:[]
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {search : self.search};
			console.log(param);
			$.ajax({
                url : "/free/list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	console.log(self.list);
                	self.list = data.freeList;
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
                url : "removeFreeCheck.dox",
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
	        
 	     fnView : function(freeNo){
 	    	$.pageChange("view.do", {freeNo : freeNo});	 
	     	},
	     	
		fnNCheck : function(){
				var self = this;
				 self.selectItem = [];
			},
		fnACheck : function(){
		    var self = this;
		    self.selectItem = [];
		    for(var i=0; i<self.list.length; i++){
		        self.selectItem.push(self.list[i].freeNo);
				}
			}
	      
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>