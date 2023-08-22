<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>1:1 문의 게시판</title>
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
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<h2>1:1 문의 게시판</h2>
			<table>
				<tr>
					<th v-if="status == 'A'">선택</th>
					<th>No.</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>등록 날짜</th>
				</tr>
				<tr v-for="(item, index) in list">
					<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.iNo"></th>
					<th>{{item.iNo}}</th>
					<th>
						<a @click="handleTitleClick(item.uId, item.iNo, item.iTitle)" href="javascript:;">		
							{{ item.iTitle }}
						</a>
					</th>
					<th>{{item.uId}}</th>
					<th>{{item.iHits}}</th>
					<th>{{item.iWriteTime}}</th>	
				</tr>
			</table>
			<div>
				<div v-if="status == 'A'"><button @click="fnRemove">삭제</button>
					<button @click="fnACheck">전체선택</button>
					<button @click="fnNCheck">전체해제</button>
				</div>
				<div v-if="status == 'U'|| status == 'H'"><button @click="fnMove">문의하기</button></div>
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
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}",
		selectItem : [],
		uId : "${sessionId}",
		selectPage: 1,
		pageCount: 1,
		cnt : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
    		var lastNum = 10;
			var param = {startNum : startNum, lastNum : lastNum};
			console.log(param);
			$.ajax({
                url : "/inquiry/list.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.inquiryList;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
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
                url : "removeInquiryCheck.dox",
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
		handleTitleClick(uId, iNo, iTitle) {
		    var self = this;
		    if ((self.status === 'A' || self.uId === uId) || iTitle !== '[비밀]') {
		        $.pageChange("view.do", { iNo: iNo });
		    } else {
		        alert("권한 없음");
		    }
		},
		fnNCheck : function(){
			var self = this;
			self.selectItem = [];
		},
		fnACheck : function(){
			var self = this;
			self.selectItem = [];
			for(var i=0; i<self.list.length; i++){
				self.selectItem.push(self.list[i].iNo);
			}
		},
		fnMove : function(){
			var self = this;
			$.pageChange("add.do", { iNo: "", cnt : self.cnt });
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>