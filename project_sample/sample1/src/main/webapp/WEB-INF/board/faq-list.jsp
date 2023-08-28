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
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<link href="../../css/board/board-style.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>FAQ �Խ���</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<section class="faq">
			<div class="page-title">
				 <div class="container">
					<h3>FAQ �Խ���</h3>
				</div>
			</div>
			
			
		<div id="board-search">
			<div class="container">
				<div class="search-window">
				
					<div class="search-wrap">
						
						<select id="mySelect" v-model="mySelect" @click="fnGetList">
							<option value="">:: ��ü ::</option>
							<option value="[����]">����</option>
							<option value="[��Ʈ]">��Ʈ</option>
							<option value="[����]">����</option>
							<option value="[��Ű��]">��Ű��</option>
							<option value="[����Ʈ]">����Ʈ</option>
							<option value="[��Ÿ����]">��Ÿ����</option>
						</select>
						
							<label for="search" class="blind">FAQ ���� �˻�</label>
							<input v-model="search" placeholder="�˻�� �Է����ּ���."  @keyup.enter="fnGetList" id="search">
							<button @click="fnGetList" class="btn btn-dark">�˻�</button>							
					</div>
				
				</div>
			</div>
		</div>
	    <div id="board-list">
		<div class="container">
			<table class="board-table">
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
			<div class="page-wrap">
					<div  v-if="status == 'A'">
						<button @click="fnACheck" class="btn1">��ü����</button>
						<button @click="fnNCheck" class="btn1">��ü����</button>
						<button @click="fnRemove" class="btn2">����</button>
						<button @click="fnMove" class="btn1">�۾���</button>
					</div>
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

				</div>
			</div>
		</div>

	
		</section>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		search:"",
		status : "${sessionStatus}",
		selectItem:[],
		category:"",
		mySelect:"",
		selectPage: 1,
		pageCount: 1,
		cnt : 0,
		indexNo : 0
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {search : self.search, category : self.mySelect, startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "/faq/list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                   	self.list = data.list;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
                	console.log(self.list);
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 10;
			var param = {search: self.search,startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "list.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					
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
				 self.selectItem = [];
			},
		fnACheck : function(){
		    var self = this;
		    self.selectItem = [];
		    for(var i=0; i<self.list.length; i++){
		        self.selectItem.push(self.list[i].fNo);
				}
			}
	      
		
	}, // methods
	mounted: function() {
	      const selectElement = document.getElementById('mySelect');
	      const inputElement = document.getElementById('search');

	      selectElement.addEventListener('change', function() {
	          inputElement.value = this.value;
	      });
	   },
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>