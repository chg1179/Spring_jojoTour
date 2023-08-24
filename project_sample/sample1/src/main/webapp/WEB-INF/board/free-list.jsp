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
<link href="../../css/paging-style.css" rel="stylesheet"/>
<link href="../../css/board-style.css" rel="stylesheet"/>
<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>���� �Խ���</title>
<style>
	section.free {
	  padding: 80px 0;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<section class="free">
	
	<div class="page-title">
        <div class="container">
            <h3>�����Խ���</h3>
        </div>
    </div>
    <div id="board-search">
        <div class="container">
            <div class="search-window">    
				<div class="search-wrap">
					<label for="search" class="blind">�����Խ��� ���� �˻�</label>
					<input v-model="search" placeholder="�˻�� �Է����ּ���."  @keyup.enter="fnGetList">
						<button @click="fnGetList" class="btn btn-dark"	>�˻�</button>
				</div>	
            </div>
        </div>
    </div>	
    	<div id="board-list">
        	<div class="container">
				<table class="board-table">
					<tr>
						<th v-if="status == 'A'">����</th>
						<th scope="col">No.</th>
						<th scope="col">����</th>
						<th scope="col">�ۼ���</th>
						<th scope="col">��ȸ��</th>
						<th scope="col">��õ��</th>
						<th scope="col">��� ��¥</th>
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
						<th>{{item.recommend}}</th>
						<th>{{item.fWriteTime}}</th>	
					</tr>	
				</table>
				
					<div class="page-wrap">
						<div>
							<button @click="fnRemove" class="btn1" v-if="status == 'A'">����</button>
							<button @click="fnACheck" class="btn1" v-if="status == 'A'">��ü����</button>
							<button @click="fnNCheck" class="btn1" v-if="status == 'A'">��ü����</button>
							<button @click="fnMove"  class="btn1">�۾���</button>
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
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		search : "",
		status : "${sessionStatus}",
		selectItem:[],
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
			var param = {search : self.search, startNum : startNum, lastNum : lastNum};
			console.log(param);
			$.ajax({
                url : "/free/list.dox",
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
				url : "/free/list.dox",
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
 			var self = this;
 			if (self.status !== 'A' && self.status !== 'U' && self.status !== 'H'){
	            if (confirm("�α��� �� �̿����ּ���. �α��� �������� �̵��Ͻðڽ��ϱ�?")) {
	                window.location.href = "/login.do";
	            }	    
 			}else{
				location.href = "add.do";
			
 			}	
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