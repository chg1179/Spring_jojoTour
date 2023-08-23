<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<meta charset="EUC-KR">
<title>찜목록</title>
<style>
	.pagination {
       margin:24px;
       display: inline-flex;
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
   .pagination li.active {
       background-color : #E7AA8D;
       color:#fff;
   }
   .pagination li.active a {
       color:#fff;
   }

   *{
	margin: 0;
	padding: 0;
   }
	table {
	  border-collapse: collapse;
	  border-spacing: 0;
	}
	section.notice {
	  padding: 80px 0;
	  float:left;
	}
	
	.page-title {
	  margin-bottom: 60px;
	}
	.page-title h3 {
	  font-size: 28px;
	  color: #333333;
	  font-weight: 400;
	  text-align: center;
	}
	
	#board-search .search-window {
	  padding: 15px 0;
	  background-color: #f9f7f9;
	}
	#board-search .search-window .search-wrap {
	  position: relative;
	/*   padding-right: 124px; */
	  margin: 0 auto;
	  width: 80%;
	  max-width: 564px;
	}
	#board-search .search-window .search-wrap input {
	  height: 40px;
	  width: 100%;
	  font-size: 14px;
	  padding: 7px 14px;
	  border: 1px solid #ccc;
	}
	#board-search .search-window .search-wrap input:focus {
	  border-color: #333;
	  outline: 0;
	  border-width: 1px;
	}
	#board-search .search-window .search-wrap .btn {
	  position: absolute;
	  right: 0;
	  top: 0;
	  bottom: 0;
	  width: 108px;
	  padding: 0;
	  font-size: 16px;
	}
	
	.board-table {
	  font-size: 13px;
	  width: 100%;
	  border-top: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	}
	
	.board-table a {
	  color: #333;
	  display: inline-block;
	  line-height: 1.4;
	  word-break: break-all;
	  vertical-align: middle;
	}
	.board-table a:hover {
	  text-decoration: underline;
	}
	.board-table th {
	  text-align: center;
	}
	
	.board-table .th-num {
	  width: 100px;
	  text-align: center;
	}
	
	.board-table .th-date {
	  width: 200px;
	}
	
	.board-table th, .board-table td {
	  padding: 14px 0;
	}
	
	.board-table tbody td {
	  border-top: 1px solid #e7e7e7;
	  text-align: center;
	}
	
	.board-table tbody th {
	  padding-left: 28px;
	  padding-right: 14px;
	  border-top: 1px solid #e7e7e7;
	  text-align: left;
	}
	
	.board-table tbody th p{
	  display: none;
	}
	
	.btn {
	  display: inline-block;
	  padding: 0 30px;
	  font-size: 15px;
	  font-weight: 400;
	  background: transparent;
	  text-align: center;
	  white-space: nowrap;
	  vertical-align: middle;
	  -ms-touch-action: manipulation;
	  touch-action: manipulation;
	  cursor: pointer;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	  user-select: none;
	  border: 1px solid transparent;
	  text-transform: uppercase;
	  -webkit-border-radius: 0;
	  -moz-border-radius: 0;
	  border-radius: 0;
	  -webkit-transition: all 0.3s;
	  -moz-transition: all 0.3s;
	  -ms-transition: all 0.3s;
	  -o-transition: all 0.3s;
	  transition: all 0.3s;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	/* reset */
	
	* {
	  list-style: none;
	  text-decoration: none;
	  padding: 0;
	  margin: 0;
	  box-sizing: border-box;
	}
	.clearfix:after {
	  content: '';
	  display: block;
	  clear: both;
	}
	.container {
	  width: 1100px;
	  margin: 0 auto;
	}
	.blind {
	  position: absolute;
	  overflow: hidden;
	  clip: rect(0 0 0 0);
	  margin: -1px;
	  width: 1px;
	  height: 1px;
	}
	.page-wrap {
	  text-align: center; /* 수평 가운데 정렬 */
	  margin-top: 20px; /* 필요한 여백 추가 */
	}
	.btn1 {
	  display: inline-block;
	  padding: 8px 16px;;
	  font-size: 12px;
	  font-weight: 400;
	border:1px solid #eee;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	}

	.btn1:hover {
	  background: linear-gradient(to right, #ff9900, #ff3333); /* 호박색 (마우스 호버 시 색 변경) */
	  transform: scale(1.05);
	  color: white;
	}
	.btn2 {
	
		margin:10px;
	  display: inline-block;
	  padding: 6px 12px;;
	  font-size: 12px;
	  font-weight: 400;
		border:1px solid #eee;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	}

	.btn2:hover {
	  background: linear-gradient(to right, #ff9900, #ff3333); 
	  transform: scale(1.05);
	  color: white;
	}

	.page-title h2 {
	  font-size: 35px;
	  color: #333333;
	  font-weight: 400;
	  text-align: center;
	  font-weight: 600px;
	}
	.board-tr {
	font-weight: bold;
	background: linear-gradient(to right, #ff9900, #ff3333);
	color:white;
	}
	.font1{
	font-size:18px;
	font-weight:bolder;
	}
	.price{
	text-decoration:line-through;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
      	<section class="notice">
	      	<div class="page-title">
	      		<div class="container">
	    			<h2>찜목록</h2>
	    		</div>
			</div>
			
    	<div id="board-list">
    		<div class="container">
			    <table class="board-table">
			      <tr class="board-tr">
			      	<td scope="col"><input type="checkbox" v-model="selectAll" @change="selectAllItems"></th>
			        <td scope="col">상품정보</th>
			        <td scope="col">찜한제품</th>
			        <td scope="col">할인된 금액</th>
			      </tr>
			      <tr v-for="(item, index) in jjim" :key="index">
			      	<td><input type="checkbox" v-model="selectItem" :value="item.productNo"></td>
			        <td>	          			         
			            <span v-if="item.productKind == 'STAY'">
			            <a @click="fnStayView(item.productNo)" href="javascript:;">
			            {{item.stayName}} {{item.productNo}}번</a>
			            </span>
			            <span v-if="item.productKind == 'RENT'">
			            <a @click="fnRentView(item.productNo)" href="javascript:;"> 
			            {{item.rentName}} {{item.productNo}}번</a>
			            </span>			        
			            <span v-if="item.productKind == 'LEISURE'">
			            <a @click="fnLeisureView(item.productNo)" href="javascript:;"> 
			            {{item.leisureName}} {{item.productNo}}번</a>
			            </span>			       
			        </td>
			        <td>
			          <div v-if="item.productKind == 'STAY'">숙박</div>
			          <div v-if="item.productKind == 'RENT'">렌트카</div>
			          <div v-if="item.productKind == 'LEISURE'">레저</div>
			        </td>
			        <td>
			          <div v-if="item.productKind == 'RENT'">
			          <span class="price">가격 : {{item.rentPrice}}</span>
			          <div class="font1">{{item.rentPrice*item.rentSales}}</div></div>
			          <div v-if="item.productKind == 'STAY'">
			          <span class="price">가격 : {{item.minPrice}}</span>
			          <div class="font1">{{item.minPrice*item.roomSales}}</div></div>
			          <div v-if="item.productKind == 'LEISURE'">
			          <span class="price">가격 : {{item.leisurePrice}}</span>
			          <div class="font1">{{item.leisurePrice*item.leisureSales}}</div></div>
			          <button class="btn2" v-if="item.productKind == 'STAY'" @click="fnStayView(item.productNo)">예약하러가기</button>
			          <button class="btn2" v-if="item.productKind == 'RENT'" @click="fnRentView(item.productNo)">예약하러가기</button>
			          <button class="btn2" v-if="item.productKind == 'LEISURE'" @click="fnLeisureView(item.productNo)">예약하러가기</button>
			        </td>
			      </tr>
			    </table>
   		 <div class="page-wrap">
			      <div> 
			        <button @click="fnRemove" class="btn1">삭제하기</button>
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
		userId : "${sessionId}",
		jjim:[],
		selectItem : [],
		selectAll: false,
		imgList:[],
		selectPage: 1,
		pageCount: 1,
		cnt : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {userId : self.userId,startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "/my/jjim.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                   	self.jjim = data.jjim;
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
			var param = {userId : self.userId, startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "/my/jjim.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.jjim = data.jjim;
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
                url : "removeJjimCheck.dox",
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
		fnRentView : function(rentNo){
				var self = this;
				$.pageChange("/rentcar/view.do", {rentNo : rentNo});
	    },
	    fnStayView : function(stayNo){
		    	var self = this;
		    	console.log(stayNo);
				$.pageChange("/stay/view.do", {stayNo : stayNo});
	    },
	    fnLeisureView : function(leisureNo){
	    	var self = this;
			$.pageChange("/leisure/view.do", {leisureNo : leisureNo});	
	    },
	       selectAllItems: function() {
	            var self = this;
	            if (self.selectAll) {
	                self.selectItem = self.jjim.map(item => item.productNo);
	            } else {
	                self.selectItem = [];
	            }
	        }
		
	}, // methods
	created : function() {
		var self = this;
		self.userId = "${sessionId}";
		self.fnGetList();
	}// created
});
</script>