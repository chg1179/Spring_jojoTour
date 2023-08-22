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
	section.inquiry {
	  padding: 80px 0;
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
	  font-size: 14px;
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
	  background-color : #E7AA8D; /* 호박색 (마우스 호버 시 색 변경) */
	  transform: scale(1.05);
	  color: white;
	}
	.board-tr{
	 background-color: #f9f7f9; 

	}

 
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<section class="inquiry">
			<div class="page-title">
				<div id="container">
					<h3>1:1 문의 게시판</h3>
				</div>
			</div>
				<div id="board-list">
					<div class="container">
						<table class="board-table">
							<tr class="board-tr">
								<th v-if="status == 'A'" scope="col">선택</th>
								<th scope="col">No.</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">조회수</th>
								<th scope="col">등록 날짜</th>
								<th scope="col">답변 상태</th>
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
								<th>
									<span v-if="item.answerYn=='A'">답변</span>
									<span v-else-if="item.answerYn=='Y'">답변완료</span>
									<span v-else-if="item.answerYn=='N'">답변대기</span>
								</th>
							</tr>
						</table>
						<div class="page-wrap">
							<div v-if="status == 'A'"><button @click="fnRemove" class="btn1">삭제</button>
								<button @click="fnACheck" class="btn1">전체선택</button>
								<button @click="fnNCheck" class="btn1">전체해제</button>
							</div>
							<div v-if="status == 'U'|| status == 'H'"><button @click="fnMove" class="btn1">문의하기</button></div>
						
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
			var param = {startNum : startNum, lastNum : lastNum};
			console.log(self.selectPage);
			$.ajax({
				url : "/inquiry/list.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.inquiryList;
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