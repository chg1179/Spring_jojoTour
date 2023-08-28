<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<link href="../../css/board/board-style.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>공지사항</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	section.notice {
	  padding: 80px 0;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<section class="notice">
		<div class="page-title">
	        <div class="container">
	            <h3>공지사항</h3>
	        </div>
    	</div>
	    <div id="board-search">
	    	<div class="container">
	    		 <div class="search-window">
					<div class="search-wrap">
						<label  for="search" class="blind">공지사항 내용 검색></label>
							<input type="text" v-model="search" @keyup.enter="fnGetList" id="search" type="search" placeholder="검색어를 입력해주세요.">
						<button @click="fnGetList" class="btn btn-dark">검색</button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="board-list">
     	<div class="container">
		<table class="board-table">
				<tr>
					<th v-if="status == 'A'">선택</th>
					<th scope="col" class="th-num">No.</th>
					<th scope="col" class="th-title">제목</th>
					<th scope="col" class="th-date">작성자</th>
					<th scope="col" class="th-date">조회수</th>
					<th scope="col" class="th-date">등록 날짜</th>
				</tr>
			<tbody>
				<tr v-for="(item, index) in list">
					<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.nNo"></th>
					<th>{{item.nNo}}</th>
					<th><a @click="fnView(item.nNo)" href="javascript:;">{{item.nTitle}}</a></th>
					<th>{{item.uId}}</th>
					<th>{{item.nHits}}</th>
					<th>{{item.fWriteTime}}</th>	
				</tr>
			</tbody>
		</table>
		<div class="page-wrap">
				<div v-if="status == 'A'">
					<button @click="fnACheck" class="btn1">전체선택</button>
					<button @click="fnNCheck" class="btn1">전체해제</button>
					<button @click="fnRemove" class="btn2">삭제</button>
					<button @click="fnMove" class="btn1">글쓰기</button>
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
		status : "${sessionStatus}",
		search : "",
		selectItem : [],
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
                url : "/notice/list.dox",
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
				url : "/notice/list.dox",
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
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
        	var noList = JSON.stringify(self.selectItem);
			var param = {selectItem : noList};
            $.ajax({
                url : "removeNoticeCheck.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	self.fnGetList();
                	self.selectItem = [];
                	alert("삭제되었습니다.");

                }
            }); 
		},
		fnMove : function(){
	        	location.href = "add.do";
		},  
		fnView : function(nNo){
 	    	$.pageChange("view.do", {nNo : nNo});	 
	    },
		fnNCheck : function(){
			var self = this;
			self.selectItem = [];
		},
		fnACheck : function(){
			var self = this;
			self.selectItem = [];
			for(var i=0; i<self.list.length; i++){
				self.selectItem.push(self.list[i].nNo);
			}
		}
	}, // methods

	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>